# encoding : utf-8 
#libs
require 'sequel'
require 'pg'

puts "Vou conectar no banco"
#DB connection string!!!!!!!!!!!!!!!!!
DB = Sequel.connect 'postgres://{DBUSER}:{DBPASS}@{DBHOST}/{DATABASE}' 
puts "Conectado"

def fazInserts(inserts)
	if (inserts != nil)
		begin
			DB[$tabela].multi_insert(inserts)
		rescue => e 
			inserts.each do |i|
				begin
					DB[$tabela].insert(i)
				rescue => e2
					$contaErro = $contaErro + 1
					$file.puts "#{e2.message.strip.delete("\n")}: #{i}"
					$file.flush
					next
				end
			end
		end
	end
end

def insere(arquivo) 
	first4 = arquivo[0,4] #pegando os 4 primeiro chars do nome do arquivo
	$file = File.open(__dir__+File::SEPARATOR+"saida-#{first4}.log", 'w')
	first = true #pra saber quando for a primeira linha com o cabecalho
	headers = nil
	puts "Vou comecar a ler o arquivo #{arquivo}"
	tam = File.readlines(arquivo).size
	puts "O arquivo #{arquivo} tem #{tam} linhas"
	porcentInc = tam/100
	porcentI = 0
	i = 0
	inserts = nil
	multTam = 1000 #numero de tuplas por insert
	$tabela = nil
	$contaErro = 0
	File.readlines(arquivo).each do |line|
		if ((i % multTam) == 0)
			fazInserts(inserts)
			inserts = Array.new
		end
		if ((i % porcentInc) == 0)
			puts "#{DateTime.now.strftime('%H:%M:%S')} #{porcentI}%"
			porcentI = porcentI + 1
		end
		if (first)
			headers = line.strip.split("$")
			first = false
		else
			aux = line.strip.split("$")
			auxHash = Hash.new
			for auxi in 0..aux.length-1
				if (aux[auxi] == "")
					aux[auxi] = nil
				end
				auxHash[headers[auxi]] = aux[auxi]
			end
			
			if (first4 == "DEMO")
				$tabela = :demographic
			elsif (first4 == "DRUG")
				$tabela = :drug
			elsif (first4 == "INDI")
				$tabela = :indications
			elsif (first4 == "OUTC")
				$tabela = :outcome
			elsif (first4 == "REAC")
				$tabela = :reaction
			elsif (first4 == "RPSR")
				$tabela = :report
			elsif (first4 == "THER")
				$tabela = :therapy
			end
			inserts.push(auxHash)	
		end
		i = i + 1
	end
	if ( (tam % multTam) != 0 )#vai faltar o ultimo insert
		fazInserts(inserts)
	end
	$file.puts "Teve um total de #{$contaErro} erros em #{arquivo}"
	$file.close
end

Dir.glob("*.txt").each do |arq|
	insere(arq.strip)
	puts "Vou fechar o arquivo"
end

puts "Fim"

