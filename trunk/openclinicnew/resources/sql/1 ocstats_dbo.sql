/*
MySQL Data Transfer
Source Host: localhost
Source Database: ocstats_dbo
Target Host: localhost
Target Database: ocstats_dbo
Date: 2013/5/29 14:45:03
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for dc_activityvalues
-- ----------------------------
CREATE TABLE `dc_activityvalues` (
  `DC_ACTIVITYVALUE_SERVERID` int(11) DEFAULT NULL,
  `DC_ACTIVITYVALUE_OBJECTID` int(11) DEFAULT NULL,
  `DC_ACTIVITYVALUE_TYPE` varchar(50) DEFAULT NULL,
  `DC_ACTIVITYVALUE_YEAR` int(11) DEFAULT NULL,
  `DC_ACTIVITYVALUE_MONTH` int(11) DEFAULT NULL,
  `DC_ACTIVITYVALUE_USERCOUNT` int(11) DEFAULT NULL,
  `DC_ACTIVITYVALUE_MEAN` float DEFAULT NULL,
  `DC_ACTIVITYVALUE_MEANDEVIATION` float DEFAULT NULL,
  `DC_ACTIVITYVALUE_MEDIAN` float DEFAULT NULL,
  KEY `DC_ACTIVITYVALUE_OBJECTID` (`DC_ACTIVITYVALUE_OBJECTID`),
  KEY `DC_ACTIVITYVALUE_TYPE` (`DC_ACTIVITYVALUE_TYPE`),
  KEY `DC_ACTIVITYVALUE_YEARMONTH` (`DC_ACTIVITYVALUE_YEAR`,`DC_ACTIVITYVALUE_MONTH`)
);

-- ----------------------------
-- Table structure for dc_bedoccupancyvalues
-- ----------------------------
CREATE TABLE `dc_bedoccupancyvalues` (
  `DC_BEDOCCUPANCYVALUE_SERVERID` int(11) DEFAULT NULL,
  `DC_BEDOCCUPANCYVALUE_OBJECTID` int(11) DEFAULT NULL,
  `DC_BEDOCCUPANCYVALUE_SERVICEUID` varchar(50) DEFAULT NULL,
  `DC_BEDOCCUPANCYVALUE_DATE` datetime DEFAULT NULL,
  `DC_BEDOCCUPANCYVALUE_TOTALBEDS` int(11) DEFAULT NULL,
  `DC_BEDOCCUPANCYVALUE_OCCUPIEDBEDS` int(11) DEFAULT NULL,
  KEY `DC_BEDOCCUPANCYVALUE_OBJECTID` (`DC_BEDOCCUPANCYVALUE_OBJECTID`),
  KEY `DC_BEDOCCUPANCYVALUE_SERVICEUID` (`DC_BEDOCCUPANCYVALUE_SERVICEUID`),
  KEY `DC_BEDOCCUPANCYVALUE_DATE` (`DC_BEDOCCUPANCYVALUE_DATE`)
);

-- ----------------------------
-- Table structure for dc_diagnosisvalues
-- ----------------------------
CREATE TABLE `dc_diagnosisvalues` (
  `DC_DIAGNOSISVALUE_SERVERID` int(11) DEFAULT NULL,
  `DC_DIAGNOSISVALUE_OBJECTID` int(11) DEFAULT NULL,
  `DC_DIAGNOSISVALUE_CODETYPE` varchar(50) DEFAULT NULL,
  `DC_DIAGNOSISVALUE_CODE` varchar(50) DEFAULT NULL,
  `DC_DIAGNOSISVALUE_YEAR` int(11) DEFAULT NULL,
  `DC_DIAGNOSISVALUE_MONTH` int(11) DEFAULT NULL,
  `DC_DIAGNOSISVALUE_COUNT` int(11) DEFAULT NULL,
  KEY `DC_DIAGNOSISVALUE_OBJECTID` (`DC_DIAGNOSISVALUE_OBJECTID`),
  KEY `DC_DIAGNOSISVALUE_CODE` (`DC_DIAGNOSISVALUE_CODE`),
  KEY `DC_DIAGNOSISVALUE_YEARMONTH` (`DC_DIAGNOSISVALUE_YEAR`,`DC_DIAGNOSISVALUE_MONTH`)
);

-- ----------------------------
-- Table structure for dc_encounterdiagnosisvalues
-- ----------------------------
CREATE TABLE `dc_encounterdiagnosisvalues` (
  `DC_DIAGNOSISVALUE_SERVERID` int(11) DEFAULT NULL,
  `DC_DIAGNOSISVALUE_OBJECTID` int(11) DEFAULT NULL,
  `DC_DIAGNOSISVALUE_CODETYPE` varchar(50) DEFAULT NULL,
  `DC_DIAGNOSISVALUE_CODE` varchar(50) DEFAULT NULL,
  `DC_DIAGNOSISVALUE_YEAR` int(11) DEFAULT NULL,
  `DC_DIAGNOSISVALUE_MONTH` int(11) DEFAULT NULL,
  `DC_DIAGNOSISVALUE_COUNT` int(11) DEFAULT NULL,
  `DC_DIAGNOSISVALUE_ENCOUNTERTYPE` varchar(50) DEFAULT NULL,
  KEY `DC_DIAGNOSISVALUE_OBJECTID` (`DC_DIAGNOSISVALUE_OBJECTID`),
  KEY `DC_DIAGNOSISVALUE_CODE` (`DC_DIAGNOSISVALUE_CODE`),
  KEY `DC_DIAGNOSISVALUE_YEARMONTH` (`DC_DIAGNOSISVALUE_YEAR`,`DC_DIAGNOSISVALUE_MONTH`)
);

-- ----------------------------
-- Table structure for dc_financialvalues
-- ----------------------------
CREATE TABLE `dc_financialvalues` (
  `DC_FINANCIALVALUE_SERVERID` int(11) DEFAULT NULL,
  `DC_FINANCIALVALUE_OBJECTID` int(11) DEFAULT NULL,
  `DC_FINANCIALVALUE_PARAMETERID` varchar(50) DEFAULT NULL,
  `DC_FINANCIALVALUE_CLASS` varchar(50) DEFAULT NULL,
  `DC_FINANCIALVALUE_YEAR` int(11) DEFAULT NULL,
  `DC_FINANCIALVALUE_MONTH` int(11) DEFAULT NULL,
  `DC_FINANCIALVALUE_VALUE` varchar(50) DEFAULT NULL,
  KEY `DC_FINANCIALVALUE_OBJECTID` (`DC_FINANCIALVALUE_OBJECTID`),
  KEY `DC_FINANCIALVALUE_YEARMONTH` (`DC_FINANCIALVALUE_YEAR`,`DC_FINANCIALVALUE_MONTH`)
);

-- ----------------------------
-- Table structure for dc_monitorservers
-- ----------------------------
CREATE TABLE `dc_monitorservers` (
  `DC_MONITORSERVER_SERVERID` int(11) DEFAULT NULL,
  `DC_MONITORSERVER_SERVERUID` varchar(50) DEFAULT NULL,
  `DC_MONITORSERVER_NAME` varchar(255) DEFAULT NULL,
  `DC_MONITORSERVER_COUNTRY` varchar(5) DEFAULT NULL,
  `DC_MONITORSERVER_CITY` varchar(255) DEFAULT NULL,
  `DC_MONITORSERVER_EMAIL` varchar(255) DEFAULT NULL,
  `DC_MONITORSERVER_CONTACT` varchar(255) DEFAULT NULL,
  `DC_MONITORSERVER_TYPE` varchar(50) DEFAULT NULL,
  `DC_MONITORSERVER_LEVEL` varchar(50) DEFAULT NULL,
  `DC_MONITORSERVER_BEDS` varchar(50) DEFAULT NULL,
  `DC_MONITORSERVER_UPDATETIME` datetime DEFAULT NULL,
  `DC_MONITORSERVER_LATITUDE` varchar(50) DEFAULT NULL,
  `DC_MONITORSERVER_LONGITUDE` varchar(50) DEFAULT NULL,
  KEY `DC_MONITORSERVER_SERVERID` (`DC_MONITORSERVER_SERVERID`),
  KEY `DC_MONITORSERVER_SERVERUID` (`DC_MONITORSERVER_SERVERID`)
);

-- ----------------------------
-- Table structure for dc_monitorvalues
-- ----------------------------
CREATE TABLE `dc_monitorvalues` (
  `DC_MONITORVALUE_SERVERID` int(11) DEFAULT NULL,
  `DC_MONITORVALUE_DATE` datetime DEFAULT NULL,
  `DC_MONITORVALUE_PATIENTCOUNT` int(11) DEFAULT NULL,
  `DC_MONITORVALUE_VISITCOUNT` int(11) DEFAULT NULL,
  `DC_MONITORVALUE_ADMISSIONCOUNT` int(11) DEFAULT NULL,
  `DC_MONITORVALUE_TRANSACTIONCOUNT` int(11) DEFAULT NULL,
  `DC_MONITORVALUE_LABANALYSESCOUNT` int(11) DEFAULT NULL,
  `DC_MONITORVALUE_PATIENTINVOICECOUNT` int(11) DEFAULT NULL,
  `DC_MONITORVALUE_DEBETCOUNT` int(11) DEFAULT NULL,
  `DC_MONITORVALUE_UPDATETIME` datetime DEFAULT NULL,
  KEY `DC_MONITORVALUE_SERVERID_DATE` (`DC_MONITORVALUE_SERVERID`,`DC_MONITORVALUE_DATE`)
);

-- ----------------------------
-- Table structure for dc_mortalityvalues
-- ----------------------------
CREATE TABLE `dc_mortalityvalues` (
  `DC_MORTALITYVALUE_SERVERID` int(11) DEFAULT NULL,
  `DC_MORTALITYVALUE_OBJECTID` int(11) DEFAULT NULL,
  `DC_MORTALITYVALUE_CODETYPE` varchar(50) DEFAULT NULL,
  `DC_MORTALITYVALUE_CODE` varchar(50) DEFAULT NULL,
  `DC_MORTALITYVALUE_YEAR` int(11) DEFAULT NULL,
  `DC_MORTALITYVALUE_MONTH` int(11) DEFAULT NULL,
  `DC_MORTALITYVALUE_COUNT` int(11) DEFAULT NULL,
  `DC_MORTALITYVALUE_DIAGNOSISCOUNT` int(11) DEFAULT NULL,
  KEY `DC_MORTALITYVALUE_OBJECTID` (`DC_MORTALITYVALUE_OBJECTID`),
  KEY `DC_MORTALITYVALUE_CODE` (`DC_MORTALITYVALUE_CODE`),
  KEY `DC_MORTALITYVALUE_YEARMONTH` (`DC_MORTALITYVALUE_YEAR`,`DC_MORTALITYVALUE_MONTH`)
);

-- ----------------------------
-- Table structure for dc_patientrecords
-- ----------------------------
CREATE TABLE `dc_patientrecords` (
  `DC_PATIENTRECORD_SERVERID` int(11) DEFAULT NULL,
  `DC_PATIENTRECORD_PERSONID` int(11) DEFAULT NULL,
  `DC_PATIENTRECORD_FIRSTNAME` varchar(255) DEFAULT NULL,
  `DC_PATIENTRECORD_LASTNAME` varchar(255) DEFAULT NULL,
  `DC_PATIENTRECORD_GENDER` varchar(50) DEFAULT NULL,
  `DC_PATIENTRECORD_DATEOFBIRTH` varchar(50) DEFAULT NULL,
  `DC_PATIENTRECORD_ARCHIVEFILE` varchar(50) DEFAULT NULL,
  KEY `DC_PATIENTRECORD_PERSONID` (`DC_PATIENTRECORD_PERSONID`)
);

-- ----------------------------
-- Table structure for dc_simplevalues
-- ----------------------------
CREATE TABLE `dc_simplevalues` (
  `DC_SIMPLEVALUE_SERVERID` int(11) DEFAULT NULL,
  `DC_SIMPLEVALUE_OBJECTID` int(11) DEFAULT NULL,
  `DC_SIMPLEVALUE_PARAMETERID` varchar(50) DEFAULT NULL,
  `DC_SIMPLEVALUE_CREATEDATETIME` datetime DEFAULT NULL,
  `DC_SIMPLEVALUE_SENTDATETIME` datetime DEFAULT NULL,
  `DC_SIMPLEVALUE_RECEIVEDATETIME` datetime DEFAULT NULL,
  `DC_SIMPLEVALUE_IMPORTDATETIME` datetime DEFAULT NULL,
  `DC_SIMPLEVALUE_DATA` varchar(255) DEFAULT NULL,
  KEY `DC_SIMPLEVALUE_OBJECTID` (`DC_SIMPLEVALUE_OBJECTID`),
  KEY `DC_SIMPLEVALUE_PARAMETERID` (`DC_SIMPLEVALUE_PARAMETERID`),
  KEY `DC_SIMPLEVALUE_CREATEDATETIME` (`DC_SIMPLEVALUE_CREATEDATETIME`)
);

-- ----------------------------
-- Table structure for oc_config
-- ----------------------------
CREATE TABLE `oc_config` (
  `OC_KEY` varchar(255) DEFAULT NULL,
  `OC_VALUE` varchar(255) DEFAULT NULL
);

-- ----------------------------
-- Table structure for updatestats1
-- ----------------------------
CREATE TABLE `updatestats1` (
  `OC_ENCOUNTERUID` varchar(50) DEFAULT NULL,
  `OC_PATIENTUID` varchar(50) DEFAULT NULL,
  `OC_BEGINDATE` datetime DEFAULT NULL,
  `OC_ENDDATE` datetime DEFAULT NULL,
  `OC_SERVICEUID` varchar(50) DEFAULT NULL,
  `OC_INSURAR` varchar(255) DEFAULT NULL,
  `OC_TYPE` varchar(50) DEFAULT NULL,
  KEY `STATS1_ENCOUNTERUID` (`OC_ENCOUNTERUID`),
  KEY `STATS1_BEGINDATE` (`OC_BEGINDATE`)
);

-- ----------------------------
-- Table structure for updatestats2
-- ----------------------------
CREATE TABLE `updatestats2` (
  `OC_ENCOUNTER_SERVERID` int(11) DEFAULT NULL,
  `OC_ENCOUNTER_OBJECTID` int(11) DEFAULT NULL,
  `OC_ENCOUNTER_PATIENTUID` varchar(50) DEFAULT NULL,
  `OC_ENCOUNTER_BEGINDATE` datetime DEFAULT NULL,
  `OC_ENCOUNTER_ENDDATE` datetime DEFAULT NULL,
  `OC_ENCOUNTER_OUTCOME` varchar(50) DEFAULT NULL,
  `OC_ENCOUNTER_TYPE` varchar(50) DEFAULT NULL,
  `OC_ENCOUNTER_SERVICEUID` varchar(50) DEFAULT NULL,
  `OC_DIAGNOSIS_CODE` varchar(50) DEFAULT NULL,
  `OC_DIAGNOSIS_CODETYPE` varchar(50) DEFAULT NULL,
  `OC_DIAGNOSIS_GRAVITY` int(11) DEFAULT NULL,
  `OC_DIAGNOSIS_CERTAINTY` int(11) DEFAULT NULL,
  KEY `STATS2_ENCOUNTEROBJECTID` (`OC_ENCOUNTER_OBJECTID`),
  KEY `STATS2_BEGINDATE` (`OC_ENCOUNTER_BEGINDATE`),
  KEY `STATS2_ENDDATE` (`OC_ENCOUNTER_ENDDATE`)
);

-- ----------------------------
-- Table structure for updatestats3
-- ----------------------------
CREATE TABLE `updatestats3` (
  `OC_ENCOUNTERUID` varchar(50) DEFAULT NULL,
  `OC_ENCOUNTERTYPE` varchar(50) DEFAULT NULL,
  `OC_INSURAR` varchar(255) DEFAULT NULL,
  `OC_DATE` datetime DEFAULT NULL,
  KEY `STATS3_ENCOUNTERUID` (`OC_ENCOUNTERUID`),
  KEY `STATS3_DATE` (`OC_DATE`)
);

-- ----------------------------
-- Table structure for updatestats4
-- ----------------------------
CREATE TABLE `updatestats4` (
  `OC_INSURAR` varchar(255) DEFAULT NULL,
  `OC_DEBETOBJECTID` int(11) DEFAULT NULL,
  `OC_PRESTATIONREFTYPE` varchar(50) DEFAULT NULL,
  `OC_PRESTATIONCODE` varchar(50) DEFAULT NULL,
  `OC_SERVICEUID` varchar(50) DEFAULT NULL,
  `OC_ENCOUNTERTYPE` varchar(50) DEFAULT NULL,
  `OC_ENCOUNTERUID` varchar(50) DEFAULT NULL,
  `OC_AMOUNT` float DEFAULT NULL,
  `OC_BEGINDATE` datetime DEFAULT NULL,
  `OC_ENDDATE` datetime DEFAULT NULL,
  KEY `STATS3_BEGINDATE` (`OC_BEGINDATE`),
  KEY `STATS3_ENDDATE` (`OC_ENDDATE`)
);

-- ----------------------------
-- View structure for adminview
-- ----------------------------
CREATE VIEW `adminview` AS select `ocadmin_dbo`.`admin`.`personid` AS `personid`,`ocadmin_dbo`.`admin`.`immatold` AS `immatold`,`ocadmin_dbo`.`admin`.`immatnew` AS `immatnew`,`ocadmin_dbo`.`admin`.`candidate` AS `candidate`,`ocadmin_dbo`.`admin`.`lastname` AS `lastname`,`ocadmin_dbo`.`admin`.`firstname` AS `firstname`,`ocadmin_dbo`.`admin`.`gender` AS `gender`,`ocadmin_dbo`.`admin`.`dateofbirth` AS `dateofbirth`,`ocadmin_dbo`.`admin`.`comment` AS `comment`,`ocadmin_dbo`.`admin`.`sourceid` AS `sourceid`,`ocadmin_dbo`.`admin`.`language` AS `language`,`ocadmin_dbo`.`admin`.`engagement` AS `engagement`,`ocadmin_dbo`.`admin`.`pension` AS `pension`,`ocadmin_dbo`.`admin`.`statute` AS `statute`,`ocadmin_dbo`.`admin`.`claimant` AS `claimant`,`ocadmin_dbo`.`admin`.`searchname` AS `searchname`,`ocadmin_dbo`.`admin`.`updatetime` AS `updatetime`,`ocadmin_dbo`.`admin`.`claimant_expiration` AS `claimant_expiration`,`ocadmin_dbo`.`admin`.`native_country` AS `native_country`,`ocadmin_dbo`.`admin`.`native_town` AS `native_town`,`ocadmin_dbo`.`admin`.`motive_end_of_service` AS `motive_end_of_service`,`ocadmin_dbo`.`admin`.`startdate_inactivity` AS `startdate_inactivity`,`ocadmin_dbo`.`admin`.`enddate_inactivity` AS `enddate_inactivity`,`ocadmin_dbo`.`admin`.`code_inactivity` AS `code_inactivity`,`ocadmin_dbo`.`admin`.`update_status` AS `update_status`,`ocadmin_dbo`.`admin`.`person_type` AS `person_type`,`ocadmin_dbo`.`admin`.`situation_end_of_service` AS `situation_end_of_service`,`ocadmin_dbo`.`admin`.`updateuserid` AS `updateuserid`,`ocadmin_dbo`.`admin`.`comment1` AS `comment1`,`ocadmin_dbo`.`admin`.`comment2` AS `comment2`,`ocadmin_dbo`.`admin`.`comment3` AS `comment3`,`ocadmin_dbo`.`admin`.`comment4` AS `comment4`,`ocadmin_dbo`.`admin`.`comment5` AS `comment5`,`ocadmin_dbo`.`admin`.`natreg` AS `natreg`,`ocadmin_dbo`.`admin`.`middlename` AS `middlename`,`ocadmin_dbo`.`admin`.`begindate` AS `begindate`,`ocadmin_dbo`.`admin`.`enddate` AS `enddate`,`ocadmin_dbo`.`admin`.`updateserverid` AS `updateserverid`,`ocadmin_dbo`.`admin`.`archiveFileCode` AS `archiveFileCode` from `ocadmin_dbo`.`admin`;

-- ----------------------------
-- Records 
-- ----------------------------
