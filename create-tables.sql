create table IF NOT EXISTS DEMOGRAPHIC(
	PRIMARYID 			numeric(1000) PRIMARY KEY,
	CASEID				numeric(500),
	CASEVERSION			numeric(10),
	I_F_CODE			char(1),
	EVENT_DT			varchar(8),
	MFR_DT				varchar(8),
	INIT_FDA_DT			varchar(8),
	FDA_DT				varchar(8),
	REPT_COD			varchar(9),
	AUTH_NUM			varchar(500),
	MFR_NUM				varchar(500),
	MFR_SNDR			varchar(300),
	LIT_REF				varchar(500),
	AGE					numeric(12,2),
	AGE_COD				varchar(7),
	AGE_GRP				varchar(15),
	SEX					varchar(5),
	E_SUB				char(1),
	WT					numeric(14,5),
	WT_COD				varchar(20),
	REPT_DT				varchar(8),
	TO_MFR				char(100),
	OCCP_COD			varchar(300),
	REPORTER_COUNTRY	varchar(500),
	OCCR_COUNTRY		char(2)	
);

create table IF NOT EXISTS DRUG(
	ID 					serial PRIMARY KEY,
	PRIMARYID 			numeric(1000),
	CASEID				numeric(500),
	DRUG_SEQ			numeric(10),
	ROLE_COD			varchar(22),
	DRUGNAME			varchar(500),
	PROD_AI				varchar(500),
	VAL_VBM				numeric(22),
	ROUTE				varchar(500),
	DOSE_VBM			varchar(300),
	CUM_DOSE_CHR		varchar(15),
	CUM_DOSE_UNIT		varchar(50),
	DECHAL				varchar(20),
	RECHAL				varchar(20),
	LOT_NUM				varchar(1000),
	EXP_DT				varchar(1000),
	NDA_NUM				numeric(100),
	DOSE_AMT			varchar(15),
	DOSE_UNIT			varchar(50),
	DOSE_FORM			varchar(50),
	DOSE_FREQ			varchar(50),
	FOREIGN KEY(PRIMARYID) REFERENCES DEMOGRAPHIC(PRIMARYID)
);
create index on drug(primaryid);

create table IF NOT EXISTS REACTION(
	ID 					serial PRIMARY KEY,
	PRIMARYID 			numeric(1000),
	CASEID				numeric(500),
	PT					varchar(500),
	DRUG_REC_ACT		varchar(500),
	UNIQUE(PRIMARYID,PT),
	FOREIGN KEY(PRIMARYID) REFERENCES DEMOGRAPHIC(PRIMARYID)
);
create index on reaction(primaryid);

create table IF NOT EXISTS OUTCOME(
	ID 					serial PRIMARY KEY,
	PRIMARYID 			numeric(1000),
	CASEID				numeric(500),
	OUTC_COD			varchar(4000),
	FOREIGN KEY(PRIMARYID) REFERENCES DEMOGRAPHIC(PRIMARYID)
);
create index on OUTCOME(primaryid);

create table IF NOT EXISTS REPORT(
	ID 					serial PRIMARY KEY,
	PRIMARYID 			numeric(1000),
	CASEID				numeric(500),
	RPSR_COD			varchar(32),
	FOREIGN KEY(PRIMARYID) REFERENCES DEMOGRAPHIC(PRIMARYID)
);
create index on REPORT(primaryid);

create table IF NOT EXISTS THERAPY(
	ID 					serial PRIMARY KEY,
	PRIMARYID 			numeric(1000),
	CASEID				numeric(500),
	DSG_DRUG_SEQ		numeric(10),
	START_DT			varchar(8),
	END_DT				varchar(8),
	DUR					numeric(150),
	DUR_COD				varchar(500),
	FOREIGN KEY(PRIMARYID) REFERENCES DEMOGRAPHIC(PRIMARYID)
);
create index on THERAPY(primaryid);

create table IF NOT EXISTS INDICATIONS(
	ID 					serial PRIMARY KEY,
	PRIMARYID 			numeric(1000),
	CASEID				numeric(500),
	INDI_DRUG_SEQ		numeric(10),
	INDI_PT				varchar(1000),
	FOREIGN KEY(PRIMARYID) REFERENCES DEMOGRAPHIC(PRIMARYID)
);
create index on INDICATIONS(primaryid);







