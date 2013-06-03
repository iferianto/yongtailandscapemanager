
CREATE TABLE OC_PRESTATIONS (
    OC_PRESTATION_SERVERID   	int NULL,
    OC_PRESTATION_OBJECTID   	int NULL,
    OC_PRESTATION_CODE       	varchar(255) NULL,
    OC_PRESTATION_DESCRIPTION	varchar(255) NULL,
    OC_PRESTATION_PRICE      	float NULL,
    OC_PRESTATION_REFTYPE    	varchar(255) NULL,
    OC_PRESTATION_REFUID     	varchar(255) NULL,
    OC_PRESTATION_CREATETIME 	smalldatetime NULL,
    OC_PRESTATION_UPDATETIME 	smalldatetime NULL,
    OC_PRESTATION_UPDATEUID  	varchar(255) NULL,
    OC_PRESTATION_VERSION    	int NULL,
    OC_PRESTATION_TYPE       	varchar(255) NULL
)

CREATE TABLE OC_PRESCRIPTION_SCHEMA (
	OC_PRESCR_SERVERID int NOT NULL ,
	OC_PRESCR_OBJECTID int NOT NULL ,
	OC_SCHEMA_TIME int NULL ,
	OC_SCHEMA_QUANTITY int NULL
)

CREATE TABLE OC_PRESCRIPTION_ADMINISTRATION (
	OC_PRESCR_SERVERID int NOT NULL ,
	OC_PRESCR_OBJECTID int NOT NULL ,
	OC_SCHEMA_TIME int NULL ,
	OC_SCHEMA_QUANTITY int NULL ,
	OC_SCHEMA_DATE datetime NULL
)

create table OC_LABELS(
  OC_LABEL_TYPE varchar(255),
  OC_LABEL_ID varchar(255),
  OC_LABEL_LANGUAGE varchar(255),
  OC_LABEL_VALUE varchar(255),
  OC_LABEL_SHOWLINK int,
  OC_LABEL_UPDATETIME smalldatetime,
  OC_LABEL_UPDATEUSERID int
)

create table OC_UNKNOWNLABELS(
  OC_LABEL_TYPE varchar(255),
  OC_LABEL_ID varchar(255),
  OC_LABEL_LANGUAGE varchar(255),
  OC_LABEL_VALUE varchar(255),
  OC_LABEL_UNKNOWNDATETIME smalldatetime,
  OC_LABEL_UPDATETIME smalldatetime,
  OC_LABEL_UPDATEUSERID int
)

CREATE TABLE OC_Config (
  oc_key varchar(255) NOT NULL,
  updateuserid int NULL,
  updatetime smalldatetime NULL,
  deletetime smalldatetime NULL,
  comment text NULL,
  deletedate datetime NULL,
  override int NULL,
  defaultvalue varchar(255) NULL,
  oc_value text NULL,
  sql_value text NULL,
  synchronize	char(1) NULL
)

create table OC_CHRONICMEDICATIONS(
  OC_CHRONICMED_SERVERID int,
  OC_CHRONICMED_OBJECTID int,
  OC_CHRONICMED_PATIENTUID varchar(255),
  OC_CHRONICMED_PRESCRIBERUID varchar(255),
  OC_CHRONICMED_PRODUCTUID varchar(255),
  OC_CHRONICMED_BEGIN smalldatetime null,
  OC_CHRONICMED_TIMEUNIT varchar(255),
  OC_CHRONICMED_TIMEUNITCOUNT int,
  OC_CHRONICMED_UNITSPERTIMEUNIT float,
  OC_CHRONICMED_CREATETIME smalldatetime,
  OC_CHRONICMED_UPDATETIME smalldatetime,
  OC_CHRONICMED_UPDATEUID varchar(255),
  OC_CHRONICMED_VERSION int
)

create table OC_PRESCRIPTIONS(
  OC_PRESCR_SERVERID int,
  OC_PRESCR_OBJECTID int,
  OC_PRESCR_PATIENTUID varchar(255),
  OC_PRESCR_PRESCRIBERUID varchar(255),
  OC_PRESCR_PRODUCTUID varchar(255),
  OC_PRESCR_BEGIN smalldatetime null,
  OC_PRESCR_END smalldatetime null,
  OC_PRESCR_TIMEUNIT varchar(255),
  OC_PRESCR_TIMEUNITCOUNT int,
  OC_PRESCR_UNITSPERTIMEUNIT float,
  OC_PRESCR_SUPPLYINGSERVICEUID varchar(255) null,
  OC_PRESCR_SERVICESTOCKUID varchar(255) null,
  OC_PRESCR_REQUIREDPACKAGES int,
  OC_PRESCR_CREATETIME smalldatetime,
  OC_PRESCR_UPDATETIME smalldatetime,
  OC_PRESCR_UPDATEUID varchar(255),
  OC_PRESCR_VERSION int
)

create table OC_PRODUCTS(
  OC_PRODUCT_SERVERID int,
  OC_PRODUCT_OBJECTID int,
  OC_PRODUCT_NAME varchar(255),
  OC_PRODUCT_UNIT varchar(255),
  OC_PRODUCT_UNITPRICE float,
  OC_PRODUCT_PACKAGEUNITS int,
  OC_PRODUCT_MINORDERPACKAGES int null,
  OC_PRODUCT_SUPPLIERUID varchar(255) null,
  OC_PRODUCT_TIMEUNIT varchar(255) null,
  OC_PRODUCT_TIMEUNITCOUNT int null,
  OC_PRODUCT_UNITSPERTIMEUNIT float null,
  OC_PRODUCT_CREATETIME smalldatetime,
  OC_PRODUCT_UPDATETIME smalldatetime,
  OC_PRODUCT_UPDATEUID varchar(255),
  OC_PRODUCT_VERSION int
)

create table OC_PRODUCTS_HISTORY(
  OC_PRODUCT_SERVERID int,
  OC_PRODUCT_OBJECTID int,
  OC_PRODUCT_NAME varchar(255),
  OC_PRODUCT_UNIT varchar(255),
  OC_PRODUCT_UNITPRICE float,
  OC_PRODUCT_PACKAGEUNITS int,
  OC_PRODUCT_MINORDERPACKAGES int null,
  OC_PRODUCT_SUPPLIERUID varchar(255) null,
  OC_PRODUCT_TIMEUNIT varchar(255) null,
  OC_PRODUCT_TIMEUNITCOUNT int null,
  OC_PRODUCT_UNITSPERTIMEUNIT float null,
  OC_PRODUCT_CREATETIME smalldatetime,
  OC_PRODUCT_UPDATETIME smalldatetime,
  OC_PRODUCT_UPDATEUID varchar(255),
  OC_PRODUCT_VERSION int
)

create table OC_USERPRODUCTS(
  OC_PRODUCT_USERID varchar(255) null,
  OC_PRODUCT_PRODUCTUID varchar(255) null,
  OC_PRODUCT_PRODUCTSTOCKUID varchar(255) null
)

create table OC_PRODUCTSTOCKS(
  OC_STOCK_SERVERID int,
  OC_STOCK_OBJECTID int,
  OC_STOCK_SERVICESTOCKUID varchar(255),
  OC_STOCK_PRODUCTUID varchar(255),
  OC_STOCK_LEVEL int,
  OC_STOCK_MINIMUMLEVEL int,
  OC_STOCK_MAXIMUMLEVEL int null,
  OC_STOCK_ORDERLEVEL int null,
  OC_STOCK_BEGIN smalldatetime null,
  OC_STOCK_END smalldatetime null,
  OC_STOCK_DEFAULTIMPORTANCE varchar(255),
  OC_STOCK_SUPPLIERUID varchar(255) null,
  OC_STOCK_CREATETIME smalldatetime,
  OC_STOCK_UPDATETIME smalldatetime,
  OC_STOCK_UPDATEUID varchar(255),
  OC_STOCK_VERSION int
)

create table OC_PRODUCTSTOCKOPERATIONS(
  OC_OPERATION_SERVERID int,
  OC_OPERATION_OBJECTID int,
  OC_OPERATION_DESCRIPTION varchar(255),
  OC_OPERATION_SRCDESTTYPE varchar(255),
  OC_OPERATION_SRCDESTUID varchar(255),
  OC_OPERATION_DATE smalldatetime,
  OC_OPERATION_PRODUCTSTOCKUID varchar(255),
  OC_OPERATION_UNITSCHANGED int,
  OC_OPERATION_CREATETIME smalldatetime,
  OC_OPERATION_UPDATETIME smalldatetime,
  OC_OPERATION_UPDATEUID varchar(255),
  OC_OPERATION_VERSION int
)

create table OC_SERVICESTOCKS(
  OC_STOCK_SERVERID int,
  OC_STOCK_OBJECTID int,
  OC_STOCK_NAME varchar(255),
  OC_STOCK_SERVICEUID varchar(255),
  OC_STOCK_BEGIN smalldatetime null,
  OC_STOCK_END smalldatetime null,
  OC_STOCK_STOCKMANAGERUID varchar(255),
  OC_STOCK_AUTHORIZEDUSERS varchar(255) null,
  OC_STOCK_DEFAULTSUPPLIERUID varchar(255) null,
  OC_STOCK_ORDERPERIODINMONTHS int,
  OC_STOCK_CREATETIME smalldatetime,
  OC_STOCK_UPDATETIME smalldatetime,
  OC_STOCK_UPDATEUID varchar(255),
  OC_STOCK_VERSION int
)

create table OC_PRODUCTORDERS(
  OC_ORDER_SERVERID int,
  OC_ORDER_OBJECTID int,
  OC_ORDER_DESCRIPTION varchar(255),
  OC_ORDER_PRODUCTSTOCKUID varchar(255),
  OC_ORDER_PACKAGESORDERED int,
  OC_ORDER_PACKAGESDELIVERED int null,
  OC_ORDER_DATEORDERED smalldatetime null,
  OC_ORDER_DATEDELIVERYDUE smalldatetime null,
  OC_ORDER_DATEDELIVERED smalldatetime null,
  OC_ORDER_IMPORTANCE varchar(255),
  OC_ORDER_CREATETIME smalldatetime,
  OC_ORDER_UPDATETIME smalldatetime,
  OC_ORDER_UPDATEUID varchar(255),
  OC_ORDER_VERSION int
)

CREATE TABLE OC_EXTERNALCONTACTS(
  serviceid       	varchar(255) NOT NULL,
  address         	varchar(255) NULL,
  city            	varchar(255) NULL,
  zipcode         	varchar(10) NULL,
  country         	char(2) NULL,
  telephone       	varchar(255) NULL,
  fax             	varchar(255) NULL,
  comment         	varchar(255) NULL,
  updatetime      	datetime NULL,
  email           	varchar(255) NULL,
  parentid        	varchar(255) NULL,
  serviceparentid 	varchar(255) NULL,
  inscode         	varchar(255) NULL,
  serviceorder    	varchar(255) NULL,
  servicelanguage 	varchar(255) NULL,
  updateuserid    	int NULL,
  parentserviceid 	varchar(50) NULL,
  code1           	varchar(50) NULL,
  code2           	varchar(50) NULL,
  code3           	varchar(50) NULL,
  code4           	varchar(50) NULL,
  code5           	varchar(50) NULL,
  contract        	varchar(255) NULL,
  contracttype    	varchar(255) NULL,
  contactperson   	varchar(255) NULL,
  contractdate    	datetime NULL,
  portal_email    	varchar(255) NULL,
  contactaddress  	varchar(255) NULL,
  contactzipcode  	varchar(255) NULL,
  contactcity     	varchar(255) NULL,
  contactcountry  	varchar(255) NULL,
  contacttelephone	varchar(255) NULL,
  contactfax      	varchar(255) NULL,
  contactemail    	varchar(255) NULL,
  ssn             	varchar(255) NULL,
  code6           	varchar(255) NULL
)

create table OC_DIAGNOSES (
    OC_DIAGNOSIS_SERVERID   int null,
    OC_DIAGNOSIS_OBJECTID   int null,
    OC_DIAGNOSIS_DATE   datetime    null,
    OC_DIAGNOSIS_ENCOUNTERUID   varchar(255)    null,
    OC_DIAGNOSIS_AUTHORUID  varchar(255)    null,
    OC_DIAGNOSIS_CODE   varchar(255)    null,
    OC_DIAGNOSIS_CERTAINTY  int null,
    OC_DIAGNOSIS_GRAVITY    int null,
    OC_DIAGNOSIS_CREATETIME datetime    null,
    OC_DIAGNOSIS_UPDATETIME datetime    null,
    OC_DIAGNOSIS_UPDATEUID  varchar(255)    null,
    OC_DIAGNOSIS_VERSION    int null,
    OC_DIAGNOSIS_LATERALISATION text    null,
    OC_DIAGNOSIS_CODETYPE   varchar(255)    null,
    OC_DIAGNOSIS_ENDDATE    datetime    null
)

create table OC_DIAGNOSES_HISTORY (
    OC_DIAGNOSIS_SERVERID   int null,
    OC_DIAGNOSIS_OBJECTID   int null,
    OC_DIAGNOSIS_DATE   datetime    null,
    OC_DIAGNOSIS_ENCOUNTERUID   varchar(255)    null,
    OC_DIAGNOSIS_AUTHORUID  varchar(255)    null,
    OC_DIAGNOSIS_CODE   varchar(255)    null,
    OC_DIAGNOSIS_CERTAINTY  int null,
    OC_DIAGNOSIS_GRAVITY    int null,
    OC_DIAGNOSIS_CREATETIME datetime    null,
    OC_DIAGNOSIS_UPDATETIME datetime    null,
    OC_DIAGNOSIS_UPDATEUID  varchar(255)    null,
    OC_DIAGNOSIS_VERSION    int null,
    OC_DIAGNOSIS_LATERALISATION text    null,
    OC_DIAGNOSIS_CODETYPE   varchar(255)    null,
    OC_DIAGNOSIS_ENDDATE    datetime    null
)

create table OC_CREDITS (
    OC_CREDIT_SERVERID  int null,
    OC_CREDIT_OBJECTID  int null,
    OC_CREDIT_AMOUNT    float   null,
    OC_CREDIT_BALANCEUID    varchar(255)    null,
    OC_CREDIT_DATE  datetime    null,
    OC_CREDIT_DESCRIPTION   varchar(255)    null,
    OC_CREDIT_ENCOUNTERUID  varchar(255)    null,
    OC_CREDIT_SOURCETYPE    varchar(255)    null,
    OC_CREDIT_SOURCEUID varchar(255)    null,
    OC_CREDIT_CREATETIME    datetime    null,
    OC_CREDIT_UPDATETIME    datetime    null,
    OC_CREDIT_UPDATEUID varchar(255)    null,
    OC_CREDIT_VERSION   int null,
    OC_CREDIT_TYPE  varchar(255)    null
)

create table OC_CREDITS_HISTORY (
    OC_CREDIT_SERVERID  int null,
    OC_CREDIT_OBJECTID  int null,
    OC_CREDIT_AMOUNT    float   null,
    OC_CREDIT_BALANCEUID    varchar(255)    null,
    OC_CREDIT_DATE  datetime    null,
    OC_CREDIT_DESCRIPTION   varchar(255)    null,
    OC_CREDIT_ENCOUNTERUID  varchar(255)    null,
    OC_CREDIT_SOURCETYPE    varchar(255)    null,
    OC_CREDIT_SOURCEUID varchar(255)    null,
    OC_CREDIT_CREATETIME    datetime    null,
    OC_CREDIT_UPDATETIME    datetime    null,
    OC_CREDIT_UPDATEUID varchar(255)    null,
    OC_CREDIT_VERSION   int null,
    OC_CREDIT_TYPE  varchar(255)    null
)

create table OC_WICKET_DEBETS(
	OC_WICKET_DEBET_SERVERID 		VARCHAR(255) 	NULL,
	OC_WICKET_DEBET_OBJECTID 		VARCHAR(255) 	NULL,
	OC_WICKET_DEBET_WICKETUID		VARCHAR(255)	NULL,
	OC_WICKET_DEBET_OPERATIONDATE	datetime	    NULL,
	OC_WICKET_DEBET_AMOUNT  		FLOAT		    NULL,
	OC_WICKET_DEBET_USERUID  		INT		        NULL,
	OC_WICKET_DEBET_TYPE  		    VARCHAR(255)	NULL,
	OC_WICKET_DEBET_COMMENT	 	    TEXT 		    NULL,
	OC_WICKET_DEBET_REFERENCETYPE	VARCHAR(255)	NULL,
	OC_WICKET_DEBET_REFERENCEUID	VARCHAR(255)	NULL,
	OC_WICKET_DEBET_CREATETIME 		datetime	    NULL,
	OC_WICKET_DEBET_UPDATETIME 		datetime	    NULL,
	OC_WICKET_DEBET_UPDATEUID 		int		        NULL,
	OC_WICKET_DEBET_VERSION    		int		        NULL
)

create table OC_WICKET_DEBETS_HISTORY(
	OC_WICKET_DEBET_SERVERID 		VARCHAR(255) 	NULL,
	OC_WICKET_DEBET_OBJECTID 		VARCHAR(255) 	NULL,
	OC_WICKET_DEBET_WICKETUID		VARCHAR(255)	NULL,
	OC_WICKET_DEBET_OPERATIONDATE	datetime	    NULL,
	OC_WICKET_DEBET_AMOUNT  		FLOAT		    NULL,
	OC_WICKET_DEBET_USERUID  		INT		        NULL,
	OC_WICKET_DEBET_TYPE  		    VARCHAR(255)	NULL,
	OC_WICKET_DEBET_COMMENT	 	    TEXT     		NULL,
	OC_WICKET_DEBET_REFERENCETYPE	VARCHAR(255)	NULL,
	OC_WICKET_DEBET_REFERENCEUID    VARCHAR(255)	NULL,
	OC_WICKET_DEBET_CREATETIME 		datetime	    NULL,
	OC_WICKET_DEBET_UPDATETIME 		datetime    	NULL,
	OC_WICKET_DEBET_UPDATEUID 		int 		    NULL,
	OC_WICKET_DEBET_VERSION    		int	        	NULL
)

create table OC_WICKET_CREDITS(
	OC_WICKET_CREDIT_SERVERID 		VARCHAR(255) 	NULL,
	OC_WICKET_CREDIT_OBJECTID 		VARCHAR(255) 	NULL,
	OC_WICKET_CREDIT_WICKETUID		VARCHAR(255)	NULL,
	OC_WICKET_CREDIT_OPERATIONDATE	datetime	    NULL,
	OC_WICKET_CREDIT_AMOUNT  		FLOAT		    NULL,
	OC_WICKET_CREDIT_USERUID  		INT		        NULL,
	OC_WICKET_CREDIT_TYPE  		    VARCHAR(255)	NULL,
	OC_WICKET_CREDIT_COMMENT	 	TEXT 		    NULL,
	OC_WICKET_CREDIT_REFERENCETYPE	VARCHAR(255)	NULL,
	OC_WICKET_CREDIT_REFERENCEUID	VARCHAR(255)	NULL,
	OC_WICKET_CREDIT_CREATETIME 	datetime    	NULL,
	OC_WICKET_CREDIT_UPDATETIME 	datetime	    NULL,
	OC_WICKET_CREDIT_UPDATEUID 		int 		    NULL,
	OC_WICKET_CREDIT_VERSION    	int	    	    NULL
)

create table OC_WICKET_CREDITS_HISTORY(
	OC_WICKET_CREDIT_SERVERID 		VARCHAR(255) 	NULL,
	OC_WICKET_CREDIT_OBJECTID 		VARCHAR(255) 	NULL,
	OC_WICKET_CREDIT_WICKETUID		VARCHAR(255)	NULL,
	OC_WICKET_CREDIT_OPERATIONDATE	datetime	    NULL,
	OC_WICKET_CREDIT_AMOUNT  		FLOAT		    NULL,
	OC_WICKET_CREDIT_USERUID  		INT		        NULL,
	OC_WICKET_CREDIT_TYPE  		    VARCHAR(255)	NULL,
	OC_WICKET_CREDIT_COMMENT	 	TEXT 		    NULL,
	OC_WICKET_CREDIT_REFERENCETYPE	VARCHAR(255)	NULL,
	OC_WICKET_CREDIT_REFERENCEUID	VARCHAR(255)	NULL,
	OC_WICKET_CREDIT_CREATETIME 	datetime    	NULL,
	OC_WICKET_CREDIT_UPDATETIME 	datetime	    NULL,
	OC_WICKET_CREDIT_UPDATEUID 		int 		    NULL,
	OC_WICKET_CREDIT_VERSION    	int	    	    NULL
)

create table OC_WICKETS_HISTORY(
	OC_WICKET_SERVERID 		    VARCHAR(255) 	NULL,
	OC_WICKET_OBJECTID 		    VARCHAR(255) 	NULL,
	OC_WICKET_BALANCE  		    FLOAT   		NULL,
	OC_WICKET_AUTHORIZEDUSERS 	VARCHAR(255) 	NULL,
	OC_WICKET_SERVICEUID		VARCHAR(255)	NULL,
	OC_WICKET_CREATETIME 		datetime    	NULL,
	OC_WICKET_UPDATETIME 		datetime	    NULL,
	OC_WICKET_UPDATEUID 		int	    	    NULL,
	OC_WICKET_VERSION    		int		        NULL
)

create table OC_WICKETS(
	OC_WICKET_SERVERID 		    VARCHAR(255) 	NULL,
	OC_WICKET_OBJECTID 		    VARCHAR(255) 	NULL,
	OC_WICKET_BALANCE  		    FLOAT   		NULL,
	OC_WICKET_AUTHORIZEDUSERS 	VARCHAR(255) 	NULL,
	OC_WICKET_SERVICEUID		VARCHAR(255)	NULL,
	OC_WICKET_CREATETIME 		datetime    	NULL,
	OC_WICKET_UPDATETIME 		datetime	    NULL,
	OC_WICKET_UPDATEUID 		int		        NULL,
	OC_WICKET_VERSION    		int		        NULL
)

CREATE TABLE OC_INSURANCES (
	OC_INSURANCE_SERVERID int NULL ,
	OC_INSURANCE_OBJECTID int NULL ,
	OC_INSURANCE_NR varchar(255) NULL ,
	OC_INSURANCE_INSURARUID varchar(255) NULL ,
	OC_INSURANCE_TYPE varchar(255) NULL ,
	OC_INSURANCE_START datetime NULL ,
	OC_INSURANCE_STOP datetime NULL ,
	OC_INSURANCE_COMMENT text NULL ,
	OC_INSURANCE_CREATETIME datetime NULL ,
	OC_INSURANCE_UPDATETIME datetime NULL ,
	OC_INSURANCE_UPDATEUID varchar(255) NULL ,
	OC_INSURANCE_VERSION int NULL ,
	OC_INSURANCE_PATIENTUID varchar(255) NULL
)

CREATE TABLE OC_INSURANCES_HISTORY (
	OC_INSURANCE_SERVERID int NULL ,
	OC_INSURANCE_OBJECTID int NULL ,
	OC_INSURANCE_NR varchar(255) NULL ,
	OC_INSURANCE_INSURARUID varchar(255) NULL ,
	OC_INSURANCE_TYPE varchar(255) NULL ,
	OC_INSURANCE_START datetime NULL ,
	OC_INSURANCE_STOP datetime NULL ,
	OC_INSURANCE_COMMENT text NULL ,
	OC_INSURANCE_CREATETIME datetime NULL ,
	OC_INSURANCE_UPDATETIME datetime NULL ,
	OC_INSURANCE_UPDATEUID varchar(255) NULL ,
	OC_INSURANCE_VERSION int NULL ,
	OC_INSURANCE_PATIENTUID varchar(255) NULL
)

CREATE TABLE OC_TERMINOLOGIES (
    OC_TERMINOLOGY_SERVERID int NULL ,
    OC_TERMINOLOGY_OBJECTID int NULL ,
    OC_TERMINOLOGY_TYPE varchar (255) NULL ,
    OC_TERMINOLOGY_USERUID varchar (255) NULL ,
    OC_TERMINOLOGY_PHRASE varchar (255) NULL ,
    OC_TERMINOLOGY_CREATETIME datetime NULL ,
    OC_TERMINOLOGY_UPDATETIME datetime NULL ,
    OC_TERMINOLOGY_UPDATEUID int NULL ,
    OC_TERMINOLOGY_VERSION int NULL
)

CREATE TABLE OC_TERMINOLOGIES_HISTORY (
    OC_TERMINOLOGY_SERVERID int NULL ,
    OC_TERMINOLOGY_OBJECTID int NULL ,
    OC_TERMINOLOGY_TYPE varchar (255) NULL ,
    OC_TERMINOLOGY_USERUID varchar (255) NULL ,
    OC_TERMINOLOGY_PHRASE varchar (255) NULL ,
    OC_TERMINOLOGY_CREATETIME datetime NULL ,
    OC_TERMINOLOGY_UPDATETIME datetime NULL ,
    OC_TERMINOLOGY_UPDATEUID int NULL ,
    OC_TERMINOLOGY_VERSION int NULL
)