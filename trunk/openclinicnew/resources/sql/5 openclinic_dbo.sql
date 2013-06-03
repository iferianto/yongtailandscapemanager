/*
MySQL Data Transfer
Source Host: localhost
Source Database: openclinic_dbo
Target Host: localhost
Target Database: openclinic_dbo
Date: 2013/5/29 14:43:57
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for agegendercontrol
-- ----------------------------
CREATE TABLE `agegendercontrol` (
  `rowid` int(10) DEFAULT NULL,
  `id` int(10) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `minAge` float DEFAULT NULL,
  `maxAge` float DEFAULT NULL,
  `gender` varchar(2) DEFAULT NULL,
  `frequency` float DEFAULT NULL,
  `tolerance` float DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `comment` text
);

-- ----------------------------
-- Table structure for applications
-- ----------------------------
CREATE TABLE `applications` (
  `ScreenId` varchar(255) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for appointments
-- ----------------------------
CREATE TABLE `appointments` (
  `appointmentId` int(10) NOT NULL,
  `personId` int(10) DEFAULT NULL,
  `appointmentDate` datetime DEFAULT NULL,
  `visitDate` datetime DEFAULT NULL,
  `userId` int(10) DEFAULT NULL,
  `linkId` varchar(255) DEFAULT NULL,
  `ow_comment` varchar(255) DEFAULT NULL,
  `serverId` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  KEY `appointments_personid` (`personId`),
  KEY `appointments_updatetime` (`updatetime`),
  KEY `appointments_userid` (`userId`)
);

-- ----------------------------
-- Table structure for badges
-- ----------------------------
CREATE TABLE `badges` (
  `BadgeCentre` int(11) DEFAULT NULL,
  `BadgeId` varchar(255) DEFAULT NULL,
  `BadgePersonId` int(11) DEFAULT NULL,
  `BadgeBegin` datetime DEFAULT NULL,
  `BadgeEnd` datetime DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  KEY `badges_badgeid` (`BadgeId`),
  KEY `badges_badgepersonid` (`BadgePersonId`)
);

-- ----------------------------
-- Table structure for classifications
-- ----------------------------
CREATE TABLE `classifications` (
  `icpc` varchar(10) DEFAULT NULL,
  `icd10` varchar(10) DEFAULT NULL,
  KEY `icd10` (`icd10`),
  KEY `icpc` (`icpc`)
);

-- ----------------------------
-- Table structure for concepts
-- ----------------------------
CREATE TABLE `concepts` (
  `concept` varchar(10) NOT NULL,
  `icd10` varchar(6) DEFAULT NULL,
  `icpc` varchar(6) DEFAULT NULL,
  KEY `concept` (`concept`)
);

-- ----------------------------
-- Table structure for counters
-- ----------------------------
CREATE TABLE `counters` (
  `name` varchar(255) NOT NULL,
  `counter` int(10) NOT NULL
);

-- ----------------------------
-- Table structure for dc_servergroups
-- ----------------------------
CREATE TABLE `dc_servergroups` (
  `DC_SERVERGROUP_ID` int(11) DEFAULT NULL,
  `DC_SERVERGROUP_SERVERID` int(11) DEFAULT NULL
);

-- ----------------------------
-- Table structure for dc_servers
-- ----------------------------
CREATE TABLE `dc_servers` (
  `DC_SIMPLEVALUE_SERVERID` int(11) DEFAULT NULL,
  `DC_SIMPLEVALUE_NAME` varchar(255) DEFAULT NULL,
  `DC_SIMPLEVALUE_LOCATION` varchar(255) DEFAULT NULL,
  `DC_SERVER_SERVERID` int(11) DEFAULT NULL,
  `DC_SERVER_LOCATION` varchar(255) DEFAULT NULL
);

-- ----------------------------
-- Table structure for deleteobjects
-- ----------------------------
CREATE TABLE `deleteobjects` (
  `ow_objectname` varchar(255) NOT NULL,
  `ow_objectid` varchar(255) NOT NULL,
  `updatetime` datetime NOT NULL
);

-- ----------------------------
-- Table structure for diagnoses
-- ----------------------------
CREATE TABLE `diagnoses` (
  `itemTypeId` varchar(255) NOT NULL,
  `criterium` varchar(50) DEFAULT NULL
);

-- ----------------------------
-- Table structure for diagnosishistory
-- ----------------------------
CREATE TABLE `diagnosishistory` (
  `itemId` int(10) DEFAULT NULL,
  `serverid` int(10) DEFAULT NULL,
  `inactiveDate` datetime DEFAULT NULL,
  KEY `diagnosisHistory_itemId` (`itemId`)
);

-- ----------------------------
-- Table structure for documents
-- ----------------------------
CREATE TABLE `documents` (
  `id` int(10) NOT NULL,
  `type` varchar(255) NOT NULL,
  `format` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `userid` int(10) NOT NULL,
  `folder` varchar(255) NOT NULL,
  `updatetime` datetime NOT NULL,
  `personid` int(10) NOT NULL,
  KEY `documents_id` (`id`),
  KEY `documents_updatetime` (`updatetime`)
);

-- ----------------------------
-- Table structure for enterprisevisititems
-- ----------------------------
CREATE TABLE `enterprisevisititems` (
  `visitId` int(10) DEFAULT NULL,
  `itemId` int(10) DEFAULT NULL,
  `itemType` varchar(255) DEFAULT NULL,
  `itemValue` varchar(255) DEFAULT NULL,
  `serverId` int(10) DEFAULT NULL,
  KEY `visitId` (`visitId`)
);

-- ----------------------------
-- Table structure for enterprisevisits
-- ----------------------------
CREATE TABLE `enterprisevisits` (
  `visitId` int(10) NOT NULL,
  `serviceId` varchar(255) NOT NULL,
  `userId` int(10) NOT NULL,
  `creationDate` datetime NOT NULL,
  `ts` datetime NOT NULL,
  `serverid` int(10) NOT NULL,
  `updateTime` datetime DEFAULT NULL,
  KEY `serviceId` (`serviceId`),
  KEY `visitId` (`visitId`)
);

-- ----------------------------
-- Table structure for errors
-- ----------------------------
CREATE TABLE `errors` (
  `updatetime` datetime DEFAULT NULL,
  `updateuserid` int(10) DEFAULT NULL,
  `errorpage` varchar(255) DEFAULT NULL,
  `errortext` longblob,
  `errorId` int(10) DEFAULT NULL,
  KEY `errors_updatetime` (`updatetime`)
);

-- ----------------------------
-- Table structure for examinationcosts
-- ----------------------------
CREATE TABLE `examinationcosts` (
  `transactionType` varchar(255) NOT NULL,
  `cost` int(10) DEFAULT NULL,
  `income` int(10) DEFAULT NULL
);

-- ----------------------------
-- Table structure for examinations
-- ----------------------------
CREATE TABLE `examinations` (
  `id` int(10) NOT NULL,
  `transactionType` varchar(255) NOT NULL,
  `messageKey` varchar(255) NOT NULL,
  `priority` int(10) DEFAULT NULL,
  `data` longblob,
  `NL` varchar(255) DEFAULT NULL,
  `FR` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `deletedate` datetime DEFAULT NULL,
  `updateuserid` int(10) DEFAULT NULL
);

-- ----------------------------
-- Table structure for exportactivities
-- ----------------------------
CREATE TABLE `exportactivities` (
  `personId` int(10) NOT NULL,
  `userId` int(10) NOT NULL,
  `activityDateTime` datetime NOT NULL,
  `activityCode` varchar(255) NOT NULL,
  `activityId` varchar(255) DEFAULT NULL,
  `medicalCenter` varchar(255) DEFAULT NULL,
  `MD` varchar(10) DEFAULT NULL,
  `para` varchar(10) DEFAULT NULL,
  `exportDate` datetime DEFAULT NULL,
  `ts` datetime DEFAULT NULL,
  `validated` datetime DEFAULT NULL,
  `provider` varchar(50) DEFAULT NULL,
  `value` varchar(50) DEFAULT NULL
);

-- ----------------------------
-- Table structure for exportpersons
-- ----------------------------
CREATE TABLE `exportpersons` (
  `personId` int(10) DEFAULT NULL,
  `requestDate` datetime DEFAULT NULL,
  `exportDate` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for exportspecifications
-- ----------------------------
CREATE TABLE `exportspecifications` (
  `elementType` varchar(255) NOT NULL,
  `exportCode` varchar(255) NOT NULL,
  `elementContent` varchar(255) NOT NULL,
  `updatetime` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for functioncategories
-- ----------------------------
CREATE TABLE `functioncategories` (
  `id` int(10) NOT NULL,
  `messageKey` varchar(255) NOT NULL,
  `updateuserid` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `deletedate` datetime DEFAULT NULL,
  `NL` varchar(255) DEFAULT NULL,
  `FR` varchar(255) DEFAULT NULL,
  `active` int(10) DEFAULT NULL,
  `serviceId` varchar(255) DEFAULT NULL
);

-- ----------------------------
-- Table structure for functioncategoryrisks
-- ----------------------------
CREATE TABLE `functioncategoryrisks` (
  `functionCategoryId` int(10) DEFAULT NULL,
  `riskId` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for functiongroupexaminations
-- ----------------------------
CREATE TABLE `functiongroupexaminations` (
  `functionGroupExaminationId` int(10) NOT NULL,
  `contactTypeId` int(10) NOT NULL,
  `tolerance` int(10) NOT NULL,
  `frequency` int(10) NOT NULL,
  `functionGroupId` int(10) DEFAULT NULL,
  `examinationId` int(10) DEFAULT NULL,
  `ageGenderControl` varchar(1) DEFAULT NULL,
  `active` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for functiongroups
-- ----------------------------
CREATE TABLE `functiongroups` (
  `id` int(10) NOT NULL,
  `messageKey` varchar(255) NOT NULL,
  `NL` varchar(255) DEFAULT NULL,
  `FR` varchar(255) DEFAULT NULL,
  `updateuserid` int(10) DEFAULT NULL,
  `deletedate` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `active` int(10) DEFAULT NULL,
  `serviceId` varchar(255) DEFAULT NULL
);

-- ----------------------------
-- Table structure for groups
-- ----------------------------
CREATE TABLE `groups` (
  `id` int(10) NOT NULL,
  `groupType` varchar(255) NOT NULL,
  `groupName` varchar(255) NOT NULL,
  `linkId` int(10) NOT NULL,
  `active` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for healthrecord
-- ----------------------------
CREATE TABLE `healthrecord` (
  `healthRecordId` int(10) NOT NULL,
  `dateBegin` datetime DEFAULT NULL,
  `dateEnd` datetime DEFAULT NULL,
  `personId` int(10) DEFAULT NULL,
  `serverid` int(10) DEFAULT NULL,
  `version` int(10) DEFAULT NULL,
  `versionserverid` int(10) DEFAULT NULL,
  KEY `healthrecord_healthrecordid` (`healthRecordId`),
  KEY `healthrecord_personid` (`personId`)
);

-- ----------------------------
-- Table structure for icd10
-- ----------------------------
CREATE TABLE `icd10` (
  `code` varchar(6) DEFAULT NULL,
  `labelnl` varchar(255) DEFAULT NULL,
  `labelfr` varchar(255) DEFAULT NULL,
  `labelen` varchar(255) DEFAULT NULL,
  KEY `code` (`code`)
);

-- ----------------------------
-- Table structure for icpc2
-- ----------------------------
CREATE TABLE `icpc2` (
  `code` varchar(6) DEFAULT NULL,
  `labelnl` varchar(255) DEFAULT NULL,
  `labelfr` varchar(255) DEFAULT NULL,
  `labelen` varchar(255) DEFAULT NULL,
  KEY `code` (`code`)
);

-- ----------------------------
-- Table structure for items
-- ----------------------------
CREATE TABLE `items` (
  `itemId` int(10) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `transactionId` int(10) DEFAULT NULL,
  `serverid` int(10) DEFAULT NULL,
  `version` int(10) DEFAULT NULL,
  `versionserverid` int(10) DEFAULT NULL,
  `priority` int(10) DEFAULT NULL,
  `valuehash` int(10) DEFAULT NULL,
  KEY `items_itemid` (`itemId`),
  KEY `items_serveridtransactionid` (`serverid`,`transactionId`),
  KEY `items_transactionid` (`transactionId`)
);

-- ----------------------------
-- Table structure for itemshistory
-- ----------------------------
CREATE TABLE `itemshistory` (
  `itemId` int(10) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `transactionId` int(10) DEFAULT NULL,
  `serverid` int(10) DEFAULT NULL,
  `version` int(10) DEFAULT NULL,
  `versionserverid` int(10) DEFAULT NULL
);

-- ----------------------------
-- Table structure for itemtypeattributes
-- ----------------------------
CREATE TABLE `itemtypeattributes` (
  `itemType` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `userid` int(10) DEFAULT NULL,
  KEY `itemtypeattributes_type` (`itemType`)
);

-- ----------------------------
-- Table structure for itemvalueindex
-- ----------------------------
CREATE TABLE `itemvalueindex` (
  `value` varchar(255) DEFAULT NULL,
  `serverid` int(10) DEFAULT NULL,
  `itemid` int(10) DEFAULT NULL,
  KEY `itemvalueindex_serveritem` (`serverid`,`itemid`),
  KEY `itemvalueindex_value` (`value`)
);

-- ----------------------------
-- Table structure for itemviewlist
-- ----------------------------
CREATE TABLE `itemviewlist` (
  `itemType` varchar(255) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `context1` varchar(255) DEFAULT NULL,
  `context2` varchar(255) DEFAULT NULL,
  `context3` varchar(255) DEFAULT NULL,
  `priority` int(10) DEFAULT NULL,
  `showValue` int(10) DEFAULT NULL,
  KEY `itemviewlist_type` (`itemType`)
);

-- ----------------------------
-- Table structure for keywords
-- ----------------------------
CREATE TABLE `keywords` (
  `keyword` varchar(255) NOT NULL,
  `concept` varchar(10) NOT NULL,
  `language` varchar(1) NOT NULL,
  KEY `keywords` (`keyword`)
);

-- ----------------------------
-- Table structure for labanalysis
-- ----------------------------
CREATE TABLE `labanalysis` (
  `labID` int(10) DEFAULT NULL,
  `labcode` varchar(255) DEFAULT NULL,
  `labtype` varchar(255) DEFAULT NULL,
  `monster` varchar(255) DEFAULT NULL,
  `biomonitoring` varchar(255) DEFAULT NULL,
  `medidoccode` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `updateuserid` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `deletetime` datetime DEFAULT NULL,
  `labcodeother` varchar(1) DEFAULT NULL,
  `limitvalue` varchar(255) DEFAULT NULL,
  `shorttimevalue` varchar(255) DEFAULT NULL,
  `labgroup` varchar(255) DEFAULT NULL,
  `unit` varchar(25) DEFAULT NULL,
  `alertvalue` varchar(20) DEFAULT NULL,
  `unavailable` int(10) DEFAULT NULL,
  `editor` varchar(50) DEFAULT NULL,
  `editorparameters` varchar(255) DEFAULT NULL,
  `limitedvisibility` int(11) DEFAULT NULL,
  `prestationcode` varchar(50) DEFAULT NULL,
  KEY `labanalysis_labcode` (`labcode`),
  KEY `labanalysis_labID` (`labID`)
);

-- ----------------------------
-- Table structure for labprofiles
-- ----------------------------
CREATE TABLE `labprofiles` (
  `profileID` int(10) DEFAULT NULL,
  `profilecode` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `updateuserid` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `deletetime` datetime DEFAULT NULL,
  KEY `labanalaysis_profilecode` (`profilecode`),
  KEY `labprofiles_profileID` (`profileID`)
);

-- ----------------------------
-- Table structure for labprofilesanalysis
-- ----------------------------
CREATE TABLE `labprofilesanalysis` (
  `profileID` int(10) DEFAULT NULL,
  `labID` int(10) DEFAULT NULL,
  `updateuserid` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  KEY `labprofilesanalysis_profileID` (`profileID`)
);

-- ----------------------------
-- Table structure for labriskexaminationanalyses
-- ----------------------------
CREATE TABLE `labriskexaminationanalyses` (
  `rowid` int(10) DEFAULT NULL,
  `riskExaminationId` int(10) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  KEY `lab_riskexaminationid` (`riskExaminationId`)
);

-- ----------------------------
-- Table structure for lastitemgroups
-- ----------------------------
CREATE TABLE `lastitemgroups` (
  `sourceItemType` varchar(255) NOT NULL,
  `destinationItemType` varchar(255) NOT NULL,
  `updatetime` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for macros
-- ----------------------------
CREATE TABLE `macros` (
  `id` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `nl` varchar(255) DEFAULT NULL,
  `fr` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for medidockeywords
-- ----------------------------
CREATE TABLE `medidockeywords` (
  `m_key` varchar(255) DEFAULT NULL,
  `m_name` varchar(255) DEFAULT NULL,
  `m_namenl` varchar(255) DEFAULT NULL,
  `m_namefr` varchar(255) DEFAULT NULL,
  `m_nameen` varchar(255) DEFAULT NULL
);

-- ----------------------------
-- Table structure for medidocunits
-- ----------------------------
CREATE TABLE `medidocunits` (
  `m_key` varchar(255) DEFAULT NULL,
  `m_name` varchar(255) DEFAULT NULL,
  `m_namenl` varchar(255) DEFAULT NULL,
  `m_namefr` varchar(255) DEFAULT NULL,
  `m_nameen` varchar(255) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_anesthesie_controls
-- ----------------------------
CREATE TABLE `oc_anesthesie_controls` (
  `OC_AC_SERVERID` int(10) DEFAULT NULL,
  `OC_AC_OBJECTID` int(10) DEFAULT NULL,
  `OC_AC_DATE` datetime DEFAULT NULL,
  `OC_AC_BEGIN_HOUR` varchar(255) DEFAULT NULL,
  `OC_AC_END_HOUR` varchar(255) DEFAULT NULL,
  `OC_AC_DURATION` varchar(255) DEFAULT NULL,
  `OC_AC_CONTROL_PERFORMED_BY_ID` varchar(255) DEFAULT NULL,
  `OC_AC_EQUIPMENT_ANESTHESIE` varchar(255) DEFAULT NULL,
  `OC_AC_EQUIPMENT_ANESTHESIE_REMARK` varchar(255) DEFAULT NULL,
  `OC_AC_EQUIPMENT_MONITOR` varchar(255) DEFAULT NULL,
  `OC_AC_EQUIPMENT_MONITOR_REMARK` varchar(255) DEFAULT NULL,
  `OC_AC_MANAGE_MEDICINES` varchar(255) DEFAULT NULL,
  `OC_AC_MANAGE_MEDICINES_REMARK` varchar(255) DEFAULT NULL,
  `OC_AC_VACUUM_CLEANER` varchar(255) DEFAULT NULL,
  `OC_AC_VACUUM_CLEANER_REMARK` varchar(255) DEFAULT NULL,
  `OC_AC_OXYGEN` varchar(255) DEFAULT NULL,
  `OC_AC_OXYGEN_REMARK` varchar(255) DEFAULT NULL,
  `OC_AC_OTHER` varchar(255) DEFAULT NULL,
  `OC_AC_OTHER_REMARK` varchar(255) DEFAULT NULL,
  `OC_AC_CREATETIME` datetime DEFAULT NULL,
  `OC_AC_UPDATETIME` datetime DEFAULT NULL,
  `OC_AC_UPDATEUID` int(10) DEFAULT NULL,
  `OC_ACD_CREATETIME` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_answers
-- ----------------------------
CREATE TABLE `oc_answers` (
  `OC_ANSWER_ID` int(11) DEFAULT NULL,
  `OC_ANSWER_QUESTIONID` int(11) DEFAULT NULL,
  `OC_ANSWER_VALUE` varchar(255) DEFAULT NULL,
  `OC_ANSWER_SESSIONID` varchar(255) DEFAULT NULL,
  `OC_ANSWER_UPDATETIME` datetime DEFAULT NULL,
  KEY `OC_ANSWER_ID` (`OC_ANSWER_ID`),
  KEY `OC_ANSWER_SESSIONID` (`OC_ANSWER_SESSIONID`)
);

-- ----------------------------
-- Table structure for oc_antibiograms
-- ----------------------------
CREATE TABLE `oc_antibiograms` (
  `OC_AB_REQUESTEDLABANALYSISUID` varchar(255) DEFAULT NULL,
  `OC_AB_GERM1` varchar(255) DEFAULT NULL,
  `OC_AB_GERM2` varchar(255) DEFAULT NULL,
  `OC_AB_GERM3` varchar(255) DEFAULT NULL,
  `OC_AB_ANTIBIOGRAMME1` varchar(255) DEFAULT NULL,
  `OC_AB_ANTIBIOGRAMME2` varchar(255) DEFAULT NULL,
  `OC_AB_ANTIBIOGRAMME3` varchar(255) DEFAULT NULL,
  `OC_AB_CREATETIME` datetime DEFAULT NULL,
  `OC_AB_UPDATETIME` datetime DEFAULT NULL,
  `OC_AB_UPDATEUID` varchar(255) DEFAULT NULL,
  KEY `OC_AB_REQUESTEDLABANALYSISUID` (`OC_AB_REQUESTEDLABANALYSISUID`)
);

-- ----------------------------
-- Table structure for oc_balances
-- ----------------------------
CREATE TABLE `oc_balances` (
  `OC_BALANCE_SERVERID` int(10) DEFAULT NULL,
  `OC_BALANCE_OBJECTID` int(10) DEFAULT NULL,
  `OC_BALANCE_VALUE` double DEFAULT NULL,
  `OC_BALANCE_MINIMUMBALANCE` double DEFAULT NULL,
  `OC_BALANCE_MAXIMUMBALANCE` double DEFAULT NULL,
  `OC_BALANCE_OWNERTYPE` varchar(255) DEFAULT NULL,
  `OC_BALANCE_OWNERUID` varchar(255) DEFAULT NULL,
  `OC_BALANCE_DATE` datetime DEFAULT NULL,
  `OC_BALANCE_REMARKS` longtext,
  `OC_BALANCE_CREATETIME` datetime DEFAULT NULL,
  `OC_BALANCE_UPDATETIME` datetime DEFAULT NULL,
  `OC_BALANCE_UPDATEUID` varchar(255) DEFAULT NULL,
  `OC_BALANCE_VERSION` int(10) DEFAULT NULL,
  `OC_BALANCE_CLOSEDTIME` datetime DEFAULT NULL,
  KEY `balance_owneruid` (`OC_BALANCE_OWNERUID`),
  KEY `OC_BALANCE_OBJECTID` (`OC_BALANCE_OBJECTID`),
  KEY `OC_BALANCE_OWNERUID` (`OC_BALANCE_OWNERUID`)
);

-- ----------------------------
-- Table structure for oc_balances_history
-- ----------------------------
CREATE TABLE `oc_balances_history` (
  `OC_BALANCE_SERVERID` int(10) DEFAULT NULL,
  `OC_BALANCE_OBJECTID` int(10) DEFAULT NULL,
  `OC_BALANCE_VALUE` double DEFAULT NULL,
  `OC_BALANCE_MINIMUMBALANCE` double DEFAULT NULL,
  `OC_BALANCE_MAXIMUMBALANCE` double DEFAULT NULL,
  `OC_BALANCE_OWNERTYPE` varchar(255) DEFAULT NULL,
  `OC_BALANCE_OWNERUID` varchar(255) DEFAULT NULL,
  `OC_BALANCE_DATE` datetime DEFAULT NULL,
  `OC_BALANCE_REMARKS` longtext,
  `OC_BALANCE_CREATETIME` datetime DEFAULT NULL,
  `OC_BALANCE_UPDATETIME` datetime DEFAULT NULL,
  `OC_BALANCE_UPDATEUID` varchar(255) DEFAULT NULL,
  `OC_BALANCE_VERSION` int(10) DEFAULT NULL,
  `OC_BALANCE_CLOSEDTIME` datetime DEFAULT NULL,
  KEY `balance_objectid` (`OC_BALANCE_OBJECTID`),
  KEY `balance_owneruid` (`OC_BALANCE_OWNERUID`)
);

-- ----------------------------
-- Table structure for oc_barcodes
-- ----------------------------
CREATE TABLE `oc_barcodes` (
  `personid` int(10) DEFAULT NULL,
  `updateuserid` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_batches
-- ----------------------------
CREATE TABLE `oc_batches` (
  `OC_BATCH_OBJECTID` varchar(50) DEFAULT NULL,
  `OC_BATCH_SERVERID` varchar(50) DEFAULT NULL,
  `OC_BATCH_PRODUCTSTOCKUID` varchar(50) DEFAULT NULL,
  `OC_BATCH_NUMBER` varchar(50) DEFAULT NULL,
  `OC_BATCH_LEVEL` int(11) DEFAULT NULL,
  `OC_BATCH_END` datetime DEFAULT NULL,
  `OC_BATCH_COMMENT` varchar(255) DEFAULT NULL,
  `OC_BATCH_CREATETIME` datetime DEFAULT NULL,
  `OC_BATCH_UPDATETIME` datetime DEFAULT NULL,
  `OC_BATCH_UPDATEUID` varchar(50) DEFAULT NULL,
  KEY `OC_BATCH_OBJECTID` (`OC_BATCH_OBJECTID`),
  KEY `OC_BATCH_PRODUCTSTOCKUID` (`OC_BATCH_PRODUCTSTOCKUID`)
);

-- ----------------------------
-- Table structure for oc_batchoperations
-- ----------------------------
CREATE TABLE `oc_batchoperations` (
  `OC_BATCHOPERATION_PRODUCTSTOCKOPERATIONUID` varchar(50) DEFAULT NULL,
  `OC_BATCHOPERATION_SOURCEUID` varchar(50) DEFAULT NULL,
  `OC_BATCHOPERATION_DESTINATIONUID` varchar(50) DEFAULT NULL,
  `OC_BATCHOPERATION_QUANTITY` int(11) DEFAULT NULL,
  `OC_BATCHOPERATION_UPDATETIME` datetime DEFAULT NULL,
  KEY `OC_BATCHOPERATION_PRODUCTSTOCKOPERATIONUID` (`OC_BATCHOPERATION_PRODUCTSTOCKOPERATIONUID`),
  KEY `OC_BATCHOPERATION_SOURCEUID` (`OC_BATCHOPERATION_SOURCEUID`),
  KEY `OC_BATCHOPERATION_DESTINATIONUID` (`OC_BATCHOPERATION_DESTINATIONUID`)
);

-- ----------------------------
-- Table structure for oc_beds
-- ----------------------------
CREATE TABLE `oc_beds` (
  `OC_BED_SERVERID` int(10) DEFAULT NULL,
  `OC_BED_OBJECTID` int(10) DEFAULT NULL,
  `OC_BED_NAME` varchar(255) DEFAULT NULL,
  `OC_BED_SERVICEUID` varchar(255) DEFAULT NULL,
  `OC_BED_PRIORITY` int(10) DEFAULT NULL,
  `OC_BED_COMMENT` longtext,
  `OC_BED_LOCATION` varchar(255) NOT NULL,
  `OC_BED_CREATETIME` datetime DEFAULT NULL,
  `OC_BED_UPDATETIME` datetime DEFAULT NULL,
  `OC_BED_UPDATEUID` varchar(255) DEFAULT NULL,
  `OC_BED_VERSION` int(10) DEFAULT NULL,
  KEY `beds_objectid` (`OC_BED_OBJECTID`),
  KEY `beds_serviceuid` (`OC_BED_SERVICEUID`)
);

-- ----------------------------
-- Table structure for oc_beds_history
-- ----------------------------
CREATE TABLE `oc_beds_history` (
  `OC_BED_SERVERID` int(10) DEFAULT NULL,
  `OC_BED_OBJECTID` int(10) DEFAULT NULL,
  `OC_BED_NAME` varchar(255) DEFAULT NULL,
  `OC_BED_SERVICEUID` varchar(255) DEFAULT NULL,
  `OC_BED_PRIORITY` int(10) DEFAULT NULL,
  `OC_BED_COMMENT` longtext,
  `OC_BED_LOCATION` varchar(255) NOT NULL,
  `OC_BED_CREATETIME` datetime DEFAULT NULL,
  `OC_BED_UPDATETIME` datetime DEFAULT NULL,
  `OC_BED_UPDATEUID` varchar(255) DEFAULT NULL,
  `OC_BED_VERSION` int(10) DEFAULT NULL,
  KEY `beds_objectid` (`OC_BED_OBJECTID`),
  KEY `beds_serviceuid` (`OC_BED_SERVICEUID`)
);

-- ----------------------------
-- Table structure for oc_bod
-- ----------------------------
CREATE TABLE `oc_bod` (
  `weight` int(10) DEFAULT NULL,
  `codetype` varchar(10) DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_careprescription_administration
-- ----------------------------
CREATE TABLE `oc_careprescription_administration` (
  `OC_CAREPRESCR_SERVERID` int(10) NOT NULL,
  `OC_CAREPRESCR_OBJECTID` int(10) NOT NULL,
  `OC_CARESCHEMA_TIME` int(10) DEFAULT NULL,
  `OC_CARESCHEMA_QUANTITY` int(10) DEFAULT NULL,
  `OC_CARESCHEMA_DATE` datetime DEFAULT NULL,
  KEY `OC_CAREPRESCR_A_OBJECTID` (`OC_CAREPRESCR_OBJECTID`),
  KEY `OC_CARESCHEMA_DATE` (`OC_CARESCHEMA_DATE`)
);

-- ----------------------------
-- Table structure for oc_careprescription_schema
-- ----------------------------
CREATE TABLE `oc_careprescription_schema` (
  `OC_CAREPRESCR_SERVERID` int(10) NOT NULL,
  `OC_CAREPRESCR_OBJECTID` int(10) NOT NULL,
  `OC_CARESCHEMA_TIME` int(10) DEFAULT NULL,
  `OC_CARESCHEMA_QUANTITY` int(10) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_careprescriptions
-- ----------------------------
CREATE TABLE `oc_careprescriptions` (
  `OC_CAREPRESCR_SERVERID` int(10) NOT NULL,
  `OC_CAREPRESCR_OBJECTID` int(10) NOT NULL,
  `OC_CAREPRESCR_PATIENTUID` varchar(255) NOT NULL,
  `OC_CAREPRESCR_PRESCRIBERUID` varchar(255) NOT NULL,
  `OC_CAREPRESCR_CAREUID` varchar(255) NOT NULL,
  `OC_CAREPRESCR_BEGIN` datetime DEFAULT NULL,
  `OC_CAREPRESCR_END` datetime DEFAULT NULL,
  `OC_CAREPRESCR_TIMEUNIT` varchar(255) NOT NULL,
  `OC_CAREPRESCR_TIMEUNITCOUNT` int(10) NOT NULL,
  `OC_CAREPRESCR_UNITSPERTIMEUNIT` double NOT NULL,
  `OC_CAREPRESCR_CREATETIME` datetime NOT NULL,
  `OC_CAREPRESCR_UPDATETIME` datetime NOT NULL,
  `OC_CAREPRESCR_UPDATEUID` varchar(255) NOT NULL,
  `OC_CAREPRESCR_VERSION` int(10) NOT NULL,
  KEY `OC_CAREPRESCR_OBJECTID` (`OC_CAREPRESCR_OBJECTID`),
  KEY `OC_CAREPRESCR_PATIENTUID` (`OC_CAREPRESCR_PATIENTUID`),
  KEY `OC_CAREPRESCR_PRESCRIBERUID` (`OC_CAREPRESCR_PRESCRIBERUID`),
  KEY `OC_CAREPRESCR_BEGIN` (`OC_CAREPRESCR_BEGIN`)
);

-- ----------------------------
-- Table structure for oc_careproviderfees
-- ----------------------------
CREATE TABLE `oc_careproviderfees` (
  `OC_CAREPROVIDERFEE_USERID` varchar(50) DEFAULT NULL,
  `OC_CAREPROVIDERFEE_TYPE` varchar(50) DEFAULT NULL,
  `OC_CAREPROVIDERFEE_ID` varchar(50) DEFAULT NULL,
  `OC_CAREPROVIDERFEE_AMOUNT` float DEFAULT NULL,
  KEY `OC_CAREPROVIDERFEE_USERID` (`OC_CAREPROVIDERFEE_USERID`)
);

-- ----------------------------
-- Table structure for oc_chronicmedications
-- ----------------------------
CREATE TABLE `oc_chronicmedications` (
  `OC_CHRONICMED_SERVERID` int(10) NOT NULL,
  `OC_CHRONICMED_OBJECTID` int(10) NOT NULL,
  `OC_CHRONICMED_PATIENTUID` varchar(255) NOT NULL,
  `OC_CHRONICMED_PRESCRIBERUID` varchar(255) NOT NULL,
  `OC_CHRONICMED_PRODUCTUID` varchar(255) NOT NULL,
  `OC_CHRONICMED_BEGIN` datetime DEFAULT NULL,
  `OC_CHRONICMED_TIMEUNIT` varchar(255) NOT NULL,
  `OC_CHRONICMED_TIMEUNITCOUNT` int(10) NOT NULL,
  `OC_CHRONICMED_UNITSPERTIMEUNIT` double NOT NULL,
  `OC_CHRONICMED_CREATETIME` datetime NOT NULL,
  `OC_CHRONICMED_UPDATETIME` datetime NOT NULL,
  `OC_CHRONICMED_UPDATEUID` varchar(255) NOT NULL,
  `OC_CHRONICMED_VERSION` int(10) NOT NULL,
  `OC_CHRONICMED_COMMENT` longtext,
  KEY `medications_patientuid` (`OC_CHRONICMED_PATIENTUID`),
  KEY `OC_CHRONICMED_OBJECTID` (`OC_CHRONICMED_OBJECTID`),
  KEY `OC_CHRONICMED_PATIENTUID` (`OC_CHRONICMED_PATIENTUID`),
  KEY `OC_CHRONICMED_PRODUCTUID` (`OC_CHRONICMED_PRODUCTUID`),
  KEY `OC_CHRONICMED_PRESCRIBERUID` (`OC_CHRONICMED_PRESCRIBERUID`)
);

-- ----------------------------
-- Table structure for oc_cluster_diags
-- ----------------------------
CREATE TABLE `oc_cluster_diags` (
  `OC_DIAG_TYPE` varchar(10) DEFAULT NULL,
  `OC_DIAG_CODE` varchar(10) DEFAULT NULL,
  `OC_DIAG_CLUSTERDATA` varchar(255) DEFAULT NULL,
  `OC_DIAG_YEAR` int(11) DEFAULT NULL,
  KEY `OC_DIAG_CODE` (`OC_DIAG_CODE`)
);

-- ----------------------------
-- Table structure for oc_config
-- ----------------------------
CREATE TABLE `oc_config` (
  `oc_key` varchar(255) NOT NULL,
  `updateuserid` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `deletetime` datetime DEFAULT NULL,
  `comment` longtext,
  `deletedate` datetime DEFAULT NULL,
  `override` int(10) DEFAULT NULL,
  `defaultvalue` varchar(255) DEFAULT NULL,
  `oc_value` longtext,
  `sql_value` longtext,
  `synchronize` char(1) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_counters
-- ----------------------------
CREATE TABLE `oc_counters` (
  `OC_COUNTER_NAME` varchar(255) DEFAULT NULL,
  `OC_COUNTER_VALUE` int(10) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_coverageplaninvoices
-- ----------------------------
CREATE TABLE `oc_coverageplaninvoices` (
  `OC_INSURARINVOICE_SERVERID` int(11) NOT NULL,
  `OC_INSURARINVOICE_OBJECTID` int(11) NOT NULL,
  `OC_INSURARINVOICE_ID` int(11) DEFAULT NULL,
  `OC_INSURARINVOICE_DATE` datetime DEFAULT NULL,
  `OC_INSURARINVOICE_INSURARUID` varchar(20) DEFAULT NULL,
  `OC_INSURARINVOICE_CREATETIME` datetime NOT NULL,
  `OC_INSURARINVOICE_UPDATETIME` datetime NOT NULL,
  `OC_INSURARINVOICE_UPDATEUID` varchar(255) NOT NULL,
  `OC_INSURARINVOICE_VERSION` int(11) NOT NULL,
  `OC_INSURARINVOICE_STATUS` varchar(255) NOT NULL,
  `OC_INSURARINVOICE_BALANCE` float DEFAULT NULL,
  KEY `OC_INSURARINVOICE_OBJECTID` (`OC_INSURARINVOICE_OBJECTID`),
  KEY `OC_INSURARINVOICE_INSURARUID` (`OC_INSURARINVOICE_INSURARUID`)
);

-- ----------------------------
-- Table structure for oc_coverageplaninvoices_history
-- ----------------------------
CREATE TABLE `oc_coverageplaninvoices_history` (
  `OC_INSURARINVOICE_SERVERID` int(11) NOT NULL,
  `OC_INSURARINVOICE_OBJECTID` int(11) NOT NULL,
  `OC_INSURARINVOICE_ID` int(11) DEFAULT NULL,
  `OC_INSURARINVOICE_DATE` datetime DEFAULT NULL,
  `OC_INSURARINVOICE_INSURARUID` varchar(20) DEFAULT NULL,
  `OC_INSURARINVOICE_CREATETIME` datetime NOT NULL,
  `OC_INSURARINVOICE_UPDATETIME` datetime NOT NULL,
  `OC_INSURARINVOICE_UPDATEUID` varchar(255) NOT NULL,
  `OC_INSURARINVOICE_VERSION` int(11) NOT NULL,
  `OC_INSURARINVOICE_STATUS` varchar(255) NOT NULL,
  `OC_INSURARINVOICE_BALANCE` float DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_credits
-- ----------------------------
CREATE TABLE `oc_credits` (
  `OC_CREDIT_SERVERID` int(10) DEFAULT NULL,
  `OC_CREDIT_OBJECTID` int(10) DEFAULT NULL,
  `OC_CREDIT_AMOUNT` double DEFAULT NULL,
  `OC_CREDIT_BALANCEUID` varchar(255) DEFAULT NULL,
  `OC_CREDIT_DATE` datetime DEFAULT NULL,
  `OC_CREDIT_DESCRIPTION` varchar(255) DEFAULT NULL,
  `OC_CREDIT_ENCOUNTERUID` varchar(255) DEFAULT NULL,
  `OC_CREDIT_SOURCETYPE` varchar(255) DEFAULT NULL,
  `OC_CREDIT_SOURCEUID` varchar(255) DEFAULT NULL,
  `OC_CREDIT_CREATETIME` datetime DEFAULT NULL,
  `OC_CREDIT_UPDATETIME` datetime DEFAULT NULL,
  `OC_CREDIT_UPDATEUID` varchar(255) DEFAULT NULL,
  `OC_CREDIT_VERSION` int(10) DEFAULT NULL,
  `OC_CREDIT_TYPE` varchar(255) DEFAULT NULL,
  KEY `balanceuid` (`OC_CREDIT_BALANCEUID`),
  KEY `OC_CREDIT_OBJECTID` (`OC_CREDIT_OBJECTID`),
  KEY `OC_CREDIT_BALANCEUID` (`OC_CREDIT_BALANCEUID`),
  KEY `OC_CREDIT_ENCOUNTERUID` (`OC_CREDIT_ENCOUNTERUID`)
);

-- ----------------------------
-- Table structure for oc_credits_history
-- ----------------------------
CREATE TABLE `oc_credits_history` (
  `OC_CREDIT_SERVERID` int(10) DEFAULT NULL,
  `OC_CREDIT_OBJECTID` int(10) DEFAULT NULL,
  `OC_CREDIT_AMOUNT` double DEFAULT NULL,
  `OC_CREDIT_BALANCEUID` varchar(255) DEFAULT NULL,
  `OC_CREDIT_DATE` datetime DEFAULT NULL,
  `OC_CREDIT_DESCRIPTION` varchar(255) DEFAULT NULL,
  `OC_CREDIT_ENCOUNTERUID` varchar(255) DEFAULT NULL,
  `OC_CREDIT_SOURCETYPE` varchar(255) DEFAULT NULL,
  `OC_CREDIT_SOURCEUID` varchar(255) DEFAULT NULL,
  `OC_CREDIT_CREATETIME` datetime DEFAULT NULL,
  `OC_CREDIT_UPDATETIME` datetime DEFAULT NULL,
  `OC_CREDIT_UPDATEUID` varchar(255) DEFAULT NULL,
  `OC_CREDIT_VERSION` int(10) DEFAULT NULL,
  `OC_CREDIT_TYPE` varchar(255) DEFAULT NULL,
  KEY `balanceuid` (`OC_CREDIT_BALANCEUID`)
);

-- ----------------------------
-- Table structure for oc_debetfees
-- ----------------------------
CREATE TABLE `oc_debetfees` (
  `OC_DEBETFEE_DEBETUID` varchar(50) DEFAULT NULL,
  `OC_DEBETFEE_AMOUNT` float DEFAULT NULL,
  `OC_DEBETFEE_CALCULATION` varchar(50) DEFAULT NULL,
  `OC_DEBETFEE_REASON` varchar(50) DEFAULT NULL,
  `OC_DEBETFEE_PERFORMERUID` varchar(50) DEFAULT NULL,
  KEY `OC_DEBETFEE_DEBETUID` (`OC_DEBETFEE_DEBETUID`)
);

-- ----------------------------
-- Table structure for oc_debets
-- ----------------------------
CREATE TABLE `oc_debets` (
  `OC_DEBET_SERVERID` int(10) DEFAULT NULL,
  `OC_DEBET_OBJECTID` int(10) DEFAULT NULL,
  `OC_DEBET_AMOUNT` double DEFAULT NULL,
  `OC_DEBET_BALANCEUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_DATE` datetime DEFAULT NULL,
  `OC_DEBET_DESCRIPTION` varchar(255) DEFAULT NULL,
  `OC_DEBET_ENCOUNTERUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_PRESTATIONUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_SUPPLIERTYPE` varchar(255) DEFAULT NULL,
  `OC_DEBET_SUPPLIERUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_REFTYPE` varchar(255) DEFAULT NULL,
  `OC_DEBET_REFUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_CREATETIME` datetime DEFAULT NULL,
  `OC_DEBET_UPDATETIME` datetime DEFAULT NULL,
  `OC_DEBET_UPDATEUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_VERSION` int(10) DEFAULT NULL,
  `OC_DEBET_QUANTITY` int(11) DEFAULT NULL,
  `OC_DEBET_CREDITED` int(11) DEFAULT NULL,
  `OC_DEBET_INSURANCEUID` varchar(25) DEFAULT NULL,
  `OC_DEBET_PATIENTINVOICEUID` varchar(25) DEFAULT NULL,
  `OC_DEBET_INSURARINVOICEUID` varchar(25) DEFAULT NULL,
  `OC_DEBET_COMMENT` varchar(255) DEFAULT NULL,
  `oc_debet_insuraramount` float DEFAULT NULL,
  `OC_DEBET_EXTRAINSURARUID` varchar(50) DEFAULT NULL,
  `OC_DEBET_EXTRAINSURARINVOICEUID` varchar(50) DEFAULT NULL,
  `OC_DEBET_EXTRAINSURARAMOUNT` varchar(50) DEFAULT NULL,
  `OC_DEBET_RENEWALINTERVAL` int(11) DEFAULT NULL,
  `OC_DEBET_RENEWALDATE` datetime DEFAULT NULL,
  `OC_DEBET_PERFORMERUID` varchar(50) DEFAULT NULL,
  `OC_DEBET_EXTRAINSURARUID2` varchar(50) DEFAULT NULL,
  `OC_DEBET_EXTRAINSURARINVOICEUID2` varchar(50) DEFAULT NULL,
  `OC_DEBET_EXTRAINSURARAMOUNT2` float DEFAULT NULL,
  `OC_DEBET_SERVICEUID` varchar(50) DEFAULT NULL,
  KEY `OC_DEBET_OBJECTID` (`OC_DEBET_OBJECTID`),
  KEY `OC_DEBET_DATE` (`OC_DEBET_DATE`),
  KEY `OC_DEBET_BALANCEUID` (`OC_DEBET_BALANCEUID`),
  KEY `OC_DEBET_ENCOUNTERUID` (`OC_DEBET_ENCOUNTERUID`),
  KEY `OC_DEBET_PRESTATIONUID` (`OC_DEBET_PRESTATIONUID`),
  KEY `OC_DEBET_REFUID` (`OC_DEBET_REFUID`),
  KEY `OC_DEBET_INSURANCEUID` (`OC_DEBET_INSURANCEUID`),
  KEY `OC_DEBET_PATIENTINVOICEUID` (`OC_DEBET_PATIENTINVOICEUID`),
  KEY `OC_DEBET_INSURARINVOICEUID` (`OC_DEBET_INSURARINVOICEUID`),
  KEY `OC_DEBET_EXTRAINSURARUID` (`OC_DEBET_EXTRAINSURARUID`),
  KEY `OC_DEBET_EXTRAINSURARINVOICEUID` (`OC_DEBET_EXTRAINSURARINVOICEUID`),
  KEY `OC_DEBET_DATE_UID` (`OC_DEBET_DATE`,`OC_DEBET_UPDATEUID`,`OC_DEBET_PRESTATIONUID`),
  KEY `OC_DEBET_EXTRAINSURARUID2` (`OC_DEBET_EXTRAINSURARUID2`),
  KEY `OC_DEBET_EXTRAINSURARINVOICEUID2` (`OC_DEBET_EXTRAINSURARINVOICEUID2`)
);

-- ----------------------------
-- Table structure for oc_debets_history
-- ----------------------------
CREATE TABLE `oc_debets_history` (
  `OC_DEBET_SERVERID` int(10) DEFAULT NULL,
  `OC_DEBET_OBJECTID` int(10) DEFAULT NULL,
  `OC_DEBET_AMOUNT` double DEFAULT NULL,
  `OC_DEBET_BALANCEUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_DATE` datetime DEFAULT NULL,
  `OC_DEBET_DESCRIPTION` varchar(255) DEFAULT NULL,
  `OC_DEBET_ENCOUNTERUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_PRESTATIONUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_SUPPLIERTYPE` varchar(255) DEFAULT NULL,
  `OC_DEBET_SUPPLIERUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_REFTYPE` varchar(255) DEFAULT NULL,
  `OC_DEBET_REFUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_CREATETIME` datetime DEFAULT NULL,
  `OC_DEBET_UPDATETIME` datetime DEFAULT NULL,
  `OC_DEBET_UPDATEUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_VERSION` int(10) DEFAULT NULL,
  `OC_DEBET_CREDITED` int(11) DEFAULT NULL,
  `OC_DEBET_INSURANCEUID` varchar(25) DEFAULT NULL,
  `OC_DEBET_PATIENTINVOICEUID` varchar(25) DEFAULT NULL,
  `OC_DEBET_INSURARINVOICEUID` varchar(25) DEFAULT NULL,
  `OC_DEBET_COMMENT` varchar(255) DEFAULT NULL,
  `OC_DEBET_INSURARAMOUNT` float DEFAULT NULL,
  `OC_DEBET_QUANTITY` int(11) DEFAULT NULL,
  `OC_DEBET_EXTRAINSURARUID` varchar(50) DEFAULT NULL,
  `OC_DEBET_EXTRAINSURARINVOICEUID` varchar(50) DEFAULT NULL,
  `OC_DEBET_EXTRAINSURARAMOUNT` varchar(50) DEFAULT NULL,
  `OC_DEBET_RENEWALINTERVAL` int(11) DEFAULT NULL,
  `OC_DEBET_RENEWALDATE` datetime DEFAULT NULL,
  `OC_DEBET_PERFORMERUID` varchar(50) DEFAULT NULL,
  `OC_DEBET_EXTRAINSURARUID2` varchar(50) DEFAULT NULL,
  `OC_DEBET_EXTRAINSURARINVOICEUID2` varchar(50) DEFAULT NULL,
  `OC_DEBET_EXTRAINSURARAMOUNT2` float DEFAULT NULL,
  `OC_DEBET_SERVICEUID` varchar(50) DEFAULT NULL,
  KEY `balanceuid` (`OC_DEBET_BALANCEUID`)
);

-- ----------------------------
-- Table structure for oc_diag_clusters
-- ----------------------------
CREATE TABLE `oc_diag_clusters` (
  `OC_CLUSTER_DIAGTYPE` varchar(10) DEFAULT NULL,
  `OC_CLUSTER_DATA` varchar(255) DEFAULT NULL,
  `OC_CLUSTER_YEAR` int(11) DEFAULT NULL,
  `OC_CLUSTER_MORTALITY` int(11) DEFAULT NULL,
  `OC_CLUSTER_GRAVITY` int(11) DEFAULT NULL,
  `OC_CLUSTER_COUNT` int(11) DEFAULT NULL,
  KEY `OC_CLUSTER_DATA` (`OC_CLUSTER_DATA`)
);

-- ----------------------------
-- Table structure for oc_diagnoses
-- ----------------------------
CREATE TABLE `oc_diagnoses` (
  `OC_DIAGNOSIS_SERVERID` int(10) DEFAULT NULL,
  `OC_DIAGNOSIS_OBJECTID` int(10) DEFAULT NULL,
  `OC_DIAGNOSIS_DATE` datetime DEFAULT NULL,
  `OC_DIAGNOSIS_ENCOUNTERUID` varchar(25) DEFAULT NULL,
  `OC_DIAGNOSIS_AUTHORUID` varchar(25) DEFAULT NULL,
  `OC_DIAGNOSIS_CODE` varchar(10) DEFAULT NULL,
  `OC_DIAGNOSIS_CERTAINTY` int(10) DEFAULT NULL,
  `OC_DIAGNOSIS_GRAVITY` int(10) DEFAULT NULL,
  `OC_DIAGNOSIS_CREATETIME` datetime DEFAULT NULL,
  `OC_DIAGNOSIS_UPDATETIME` datetime DEFAULT NULL,
  `OC_DIAGNOSIS_UPDATEUID` varchar(10) DEFAULT NULL,
  `OC_DIAGNOSIS_VERSION` int(10) DEFAULT NULL,
  `OC_DIAGNOSIS_LATERALISATION` longtext,
  `OC_DIAGNOSIS_CODETYPE` varchar(10) DEFAULT NULL,
  `OC_DIAGNOSIS_ENDDATE` datetime DEFAULT NULL,
  `OC_DIAGNOSIS_REFERENCETYPE` varchar(50) DEFAULT NULL,
  `OC_DIAGNOSIS_REFERENCEUID` varchar(25) DEFAULT NULL,
  `OC_DIAGNOSIS_POA` char(1) DEFAULT NULL,
  `OC_DIAGNOSIS_ENCOUNTEROBJECTID` int(11) DEFAULT NULL,
  `OC_DIAGNOSIS_NC` char(1) DEFAULT NULL,
  `OC_DIAGNOSIS_SERVICEUID` varchar(50) DEFAULT NULL,
  `OC_DIAGNOSIS_FLAGS` varchar(50) DEFAULT NULL,
  KEY `authoruid` (`OC_DIAGNOSIS_AUTHORUID`),
  KEY `code` (`OC_DIAGNOSIS_CODE`),
  KEY `encounter` (`OC_DIAGNOSIS_ENCOUNTEROBJECTID`),
  KEY `encounteruid` (`OC_DIAGNOSIS_ENCOUNTERUID`),
  KEY `REFERENCEUID` (`OC_DIAGNOSIS_REFERENCETYPE`,`OC_DIAGNOSIS_REFERENCEUID`)
);

-- ----------------------------
-- Table structure for oc_diagnoses_history
-- ----------------------------
CREATE TABLE `oc_diagnoses_history` (
  `OC_DIAGNOSIS_SERVERID` int(10) DEFAULT NULL,
  `OC_DIAGNOSIS_OBJECTID` int(10) DEFAULT NULL,
  `OC_DIAGNOSIS_DATE` datetime DEFAULT NULL,
  `OC_DIAGNOSIS_ENCOUNTERUID` varchar(255) DEFAULT NULL,
  `OC_DIAGNOSIS_AUTHORUID` varchar(255) DEFAULT NULL,
  `OC_DIAGNOSIS_CODE` varchar(255) DEFAULT NULL,
  `OC_DIAGNOSIS_CERTAINTY` int(10) DEFAULT NULL,
  `OC_DIAGNOSIS_GRAVITY` int(10) DEFAULT NULL,
  `OC_DIAGNOSIS_CREATETIME` datetime DEFAULT NULL,
  `OC_DIAGNOSIS_UPDATETIME` datetime DEFAULT NULL,
  `OC_DIAGNOSIS_UPDATEUID` varchar(255) DEFAULT NULL,
  `OC_DIAGNOSIS_VERSION` int(10) DEFAULT NULL,
  `OC_DIAGNOSIS_LATERALISATION` longtext,
  `OC_DIAGNOSIS_CODETYPE` varchar(255) DEFAULT NULL,
  `OC_DIAGNOSIS_ENDDATE` datetime DEFAULT NULL,
  `OC_DIAGNOSIS_REFERENCETYPE` varchar(255) DEFAULT NULL,
  `OC_DIAGNOSIS_REFERENCEUID` varchar(255) DEFAULT NULL,
  `OC_DIAGNOSIS_POA` char(1) DEFAULT NULL,
  `OC_DIAGNOSIS_ENCOUNTEROBJECTID` int(11) DEFAULT NULL,
  `OC_DIAGNOSIS_NC` char(1) DEFAULT NULL,
  `OC_DIAGNOSIS_SERVICEUID` varchar(50) DEFAULT NULL,
  `OC_DIAGNOSIS_FLAGS` varchar(50) DEFAULT NULL,
  KEY `encounter` (`OC_DIAGNOSIS_ENCOUNTERUID`)
);

-- ----------------------------
-- Table structure for oc_diagnosis_groups
-- ----------------------------
CREATE TABLE `oc_diagnosis_groups` (
  `OC_DIAGNOSIS_CODETYPE` varchar(20) DEFAULT NULL,
  `OC_DIAGNOSIS_CODESTART` varchar(20) DEFAULT NULL,
  `OC_DIAGNOSIS_CODEEND` varchar(20) DEFAULT NULL,
  `OC_DIAGNOSIS_GROUPCODE` varchar(20) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_documents
-- ----------------------------
CREATE TABLE `oc_documents` (
  `OC_DOCUMENT_SERVERID` int(11) DEFAULT NULL,
  `OC_DOCUMENT_OBJECTID` int(11) DEFAULT NULL,
  `OC_DOCUMENT_NAME` varchar(255) DEFAULT NULL,
  `OC_DOCUMENT_CREATETIME` datetime DEFAULT NULL,
  `OC_DOCUMENT_UPDATETIME` datetime DEFAULT NULL,
  `OC_DOCUMENT_UPDATEUID` int(11) DEFAULT NULL,
  `OC_DOCUMENT_VALUE` blob
);

-- ----------------------------
-- Table structure for oc_drugsoutlist
-- ----------------------------
CREATE TABLE `oc_drugsoutlist` (
  `OC_LIST_SERVERID` int(11) NOT NULL,
  `OC_LIST_OBJECTID` int(11) NOT NULL,
  `OC_LIST_PATIENTUID` varchar(25) DEFAULT NULL,
  `OC_LIST_PRODUCTSTOCKUID` varchar(25) DEFAULT NULL,
  `OC_LIST_QUANTITY` int(11) DEFAULT NULL,
  `OC_LIST_BATCHUID` varchar(25) DEFAULT NULL,
  KEY `OC_LIST_PATIENTUID` (`OC_LIST_PATIENTUID`)
);

-- ----------------------------
-- Table structure for oc_encounter_services
-- ----------------------------
CREATE TABLE `oc_encounter_services` (
  `OC_ENCOUNTER_SERVERID` int(10) DEFAULT NULL,
  `OC_ENCOUNTER_OBJECTID` int(10) DEFAULT NULL,
  `OC_ENCOUNTER_SERVICEUID` varchar(25) DEFAULT NULL,
  `OC_ENCOUNTER_BEDUID` varchar(25) DEFAULT NULL,
  `OC_ENCOUNTER_SERVICEENDDATE` datetime DEFAULT NULL,
  `OC_ENCOUNTER_MANAGERUID` varchar(25) DEFAULT NULL,
  `OC_ENCOUNTER_SERVICEBEGINDATE` datetime DEFAULT NULL,
  KEY `encounterservices_beduid` (`OC_ENCOUNTER_BEDUID`),
  KEY `encounterservices_manageruid` (`OC_ENCOUNTER_MANAGERUID`),
  KEY `encounterservices_objectid` (`OC_ENCOUNTER_OBJECTID`),
  KEY `encounterservices_serviceuid` (`OC_ENCOUNTER_SERVICEUID`)
);

-- ----------------------------
-- Table structure for oc_encounters
-- ----------------------------
CREATE TABLE `oc_encounters` (
  `OC_ENCOUNTER_SERVERID` int(10) DEFAULT NULL,
  `OC_ENCOUNTER_OBJECTID` int(10) DEFAULT NULL,
  `OC_ENCOUNTER_TYPE` varchar(25) DEFAULT NULL,
  `OC_ENCOUNTER_BEGINDATE` datetime NOT NULL,
  `OC_ENCOUNTER_ENDDATE` datetime DEFAULT NULL,
  `OC_ENCOUNTER_PATIENTUID` varchar(25) DEFAULT NULL,
  `OC_ENCOUNTER_CREATETIME` datetime DEFAULT NULL,
  `OC_ENCOUNTER_UPDATETIME` datetime DEFAULT NULL,
  `OC_ENCOUNTER_UPDATEUID` varchar(25) DEFAULT NULL,
  `OC_ENCOUNTER_VERSION` int(10) DEFAULT NULL,
  `oc_encounter_outcome` varchar(25) DEFAULT NULL,
  `OC_ENCOUNTER_DESTINATIONUID` varchar(25) DEFAULT NULL,
  `OC_ENCOUNTER_ORIGIN` varchar(25) DEFAULT NULL,
  `OC_ENCOUNTER_SITUATION` varchar(50) DEFAULT NULL,
  `OC_ENCOUNTER_PROCESSED` datetime DEFAULT NULL,
  `OC_ENCOUNTER_CATEGORIES` varchar(50) DEFAULT NULL,
  KEY `begindate` (`OC_ENCOUNTER_BEGINDATE`),
  KEY `encounters_objectid` (`OC_ENCOUNTER_OBJECTID`),
  KEY `patientuid` (`OC_ENCOUNTER_PATIENTUID`),
  KEY `OC_ENCOUNTER_OBJECTID` (`OC_ENCOUNTER_OBJECTID`),
  KEY `OC_ENCOUNTER_BEGINDATE` (`OC_ENCOUNTER_BEGINDATE`),
  KEY `OC_ENCOUNTER_ENDDATE` (`OC_ENCOUNTER_ENDDATE`),
  KEY `OC_ENCOUNTER_PATIENTUID` (`OC_ENCOUNTER_PATIENTUID`),
  KEY `OC_ENCOUNTER_PROCESSED` (`OC_ENCOUNTER_PROCESSED`),
  KEY `OC_ENCOUNTER_UPDATETIME` (`OC_ENCOUNTER_UPDATETIME`)
);

-- ----------------------------
-- Table structure for oc_encounters_history
-- ----------------------------
CREATE TABLE `oc_encounters_history` (
  `OC_ENCOUNTER_SERVERID` int(10) DEFAULT NULL,
  `OC_ENCOUNTER_OBJECTID` int(10) DEFAULT NULL,
  `OC_ENCOUNTER_TYPE` varchar(255) DEFAULT NULL,
  `OC_ENCOUNTER_BEGINDATE` datetime DEFAULT NULL,
  `OC_ENCOUNTER_ENDDATE` datetime DEFAULT NULL,
  `OC_ENCOUNTER_PATIENTUID` varchar(255) DEFAULT NULL,
  `OC_ENCOUNTER_CREATETIME` datetime DEFAULT NULL,
  `OC_ENCOUNTER_UPDATETIME` datetime DEFAULT NULL,
  `OC_ENCOUNTER_UPDATEUID` varchar(255) DEFAULT NULL,
  `OC_ENCOUNTER_VERSION` int(10) DEFAULT NULL,
  `oc_encounter_outcome` varchar(255) DEFAULT NULL,
  `OC_ENCOUNTER_DESTINATIONUID` varchar(255) DEFAULT NULL,
  `OC_ENCOUNTER_ORIGIN` varchar(255) DEFAULT NULL,
  `OC_ENCOUNTER_SITUATION` varchar(50) DEFAULT NULL,
  `OC_ENCOUNTER_PROCESSED` datetime DEFAULT NULL,
  `OC_ENCOUNTER_CATEGORIES` varchar(50) DEFAULT NULL,
  KEY `begindate` (`OC_ENCOUNTER_BEGINDATE`),
  KEY `patientuid` (`OC_ENCOUNTER_PATIENTUID`)
);

-- ----------------------------
-- Table structure for oc_exportrequests
-- ----------------------------
CREATE TABLE `oc_exportrequests` (
  `OC_EXPORTREQUEST_TYPE` varchar(50) DEFAULT NULL,
  `OC_EXPORTREQUEST_ID` varchar(50) DEFAULT NULL,
  `OC_EXPORTREQUEST_PROCESSED` int(11) DEFAULT NULL,
  `OC_EXPORTREQUEST_UPDATETIME` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_exports
-- ----------------------------
CREATE TABLE `oc_exports` (
  `OC_EXPORT_OBJECTID` int(11) DEFAULT NULL,
  `OC_EXPORT_ID` varchar(50) DEFAULT NULL,
  `OC_EXPORT_CREATEDATETIME` datetime DEFAULT NULL,
  `OC_EXPORT_SENTDATETIME` datetime DEFAULT NULL,
  `OC_EXPORT_ACKDATETIME` datetime DEFAULT NULL,
  `OC_EXPORT_IMPORTDATETIME` datetime DEFAULT NULL,
  `OC_EXPORT_IMPORTACKDATETIME` datetime DEFAULT NULL,
  `OC_EXPORT_DATA` text,
  `OC_EXPORT_ERRORCODE` int(11) DEFAULT NULL,
  KEY `OC_EXPORT_OBJECTID` (`OC_EXPORT_OBJECTID`),
  KEY `OC_EXPORT_CREATEDATETIME` (`OC_EXPORT_CREATEDATETIME`)
);

-- ----------------------------
-- Table structure for oc_externalcontacts
-- ----------------------------
CREATE TABLE `oc_externalcontacts` (
  `serviceid` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `zipcode` varchar(10) DEFAULT NULL,
  `country` char(2) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `parentid` varchar(255) DEFAULT NULL,
  `serviceparentid` varchar(255) DEFAULT NULL,
  `inscode` varchar(255) DEFAULT NULL,
  `serviceorder` varchar(255) DEFAULT NULL,
  `servicelanguage` varchar(255) DEFAULT NULL,
  `updateuserid` int(10) DEFAULT NULL,
  `parentserviceid` varchar(50) DEFAULT NULL,
  `code1` varchar(50) DEFAULT NULL,
  `code2` varchar(50) DEFAULT NULL,
  `code3` varchar(50) DEFAULT NULL,
  `code4` varchar(50) DEFAULT NULL,
  `code5` varchar(50) DEFAULT NULL,
  `contract` varchar(255) DEFAULT NULL,
  `contracttype` varchar(255) DEFAULT NULL,
  `contactperson` varchar(255) DEFAULT NULL,
  `contractdate` datetime DEFAULT NULL,
  `portal_email` varchar(255) DEFAULT NULL,
  `contactaddress` varchar(255) DEFAULT NULL,
  `contactzipcode` varchar(255) DEFAULT NULL,
  `contactcity` varchar(255) DEFAULT NULL,
  `contactcountry` varchar(255) DEFAULT NULL,
  `contacttelephone` varchar(255) DEFAULT NULL,
  `contactfax` varchar(255) DEFAULT NULL,
  `contactemail` varchar(255) DEFAULT NULL,
  `ssn` varchar(255) DEFAULT NULL,
  `code6` varchar(255) DEFAULT NULL,
  `defaultcontext` varchar(255) DEFAULT NULL,
  KEY `services_serviceid` (`serviceid`),
  KEY `services_zipcode` (`zipcode`),
  KEY `services_updatetime` (`updatetime`)
);

-- ----------------------------
-- Table structure for oc_extrainsurarinvoices
-- ----------------------------
CREATE TABLE `oc_extrainsurarinvoices` (
  `OC_INSURARINVOICE_SERVERID` int(11) NOT NULL,
  `OC_INSURARINVOICE_OBJECTID` int(11) NOT NULL,
  `OC_INSURARINVOICE_ID` int(11) DEFAULT NULL,
  `OC_INSURARINVOICE_DATE` datetime DEFAULT NULL,
  `OC_INSURARINVOICE_INSURARUID` varchar(20) DEFAULT NULL,
  `OC_INSURARINVOICE_CREATETIME` datetime NOT NULL,
  `OC_INSURARINVOICE_UPDATETIME` datetime NOT NULL,
  `OC_INSURARINVOICE_UPDATEUID` varchar(255) NOT NULL,
  `OC_INSURARINVOICE_VERSION` int(11) NOT NULL,
  `OC_INSURARINVOICE_STATUS` varchar(255) NOT NULL,
  `OC_INSURARINVOICE_BALANCE` float DEFAULT NULL,
  KEY `OC_E_INSURARINVOICE_OBJECTID` (`OC_INSURARINVOICE_OBJECTID`),
  KEY `OC_E_INSURARINVOICE_INSURARUID` (`OC_INSURARINVOICE_INSURARUID`)
);

-- ----------------------------
-- Table structure for oc_extrainsurarinvoices_history
-- ----------------------------
CREATE TABLE `oc_extrainsurarinvoices_history` (
  `OC_INSURARINVOICE_SERVERID` int(11) NOT NULL,
  `OC_INSURARINVOICE_OBJECTID` int(11) NOT NULL,
  `OC_INSURARINVOICE_ID` int(11) DEFAULT NULL,
  `OC_INSURARINVOICE_DATE` datetime DEFAULT NULL,
  `OC_INSURARINVOICE_INSURARUID` varchar(20) DEFAULT NULL,
  `OC_INSURARINVOICE_CREATETIME` datetime NOT NULL,
  `OC_INSURARINVOICE_UPDATETIME` datetime NOT NULL,
  `OC_INSURARINVOICE_UPDATEUID` varchar(255) NOT NULL,
  `OC_INSURARINVOICE_VERSION` int(11) NOT NULL,
  `OC_INSURARINVOICE_STATUS` varchar(255) NOT NULL,
  `OC_INSURARINVOICE_BALANCE` float DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_extrainsurarinvoices2
-- ----------------------------
CREATE TABLE `oc_extrainsurarinvoices2` (
  `OC_INSURARINVOICE_SERVERID` int(11) NOT NULL,
  `OC_INSURARINVOICE_OBJECTID` int(11) NOT NULL,
  `OC_INSURARINVOICE_ID` int(11) DEFAULT NULL,
  `OC_INSURARINVOICE_DATE` datetime DEFAULT NULL,
  `OC_INSURARINVOICE_INSURARUID` varchar(20) DEFAULT NULL,
  `OC_INSURARINVOICE_CREATETIME` datetime NOT NULL,
  `OC_INSURARINVOICE_UPDATETIME` datetime NOT NULL,
  `OC_INSURARINVOICE_UPDATEUID` varchar(255) NOT NULL,
  `OC_INSURARINVOICE_VERSION` int(11) NOT NULL,
  `OC_INSURARINVOICE_STATUS` varchar(255) NOT NULL,
  `OC_INSURARINVOICE_BALANCE` float DEFAULT NULL,
  KEY `OC_E_INSURARINVOICE2_OBJECTID` (`OC_INSURARINVOICE_OBJECTID`),
  KEY `OC_E_INSURARINVOICE2_INSURARUID` (`OC_INSURARINVOICE_INSURARUID`)
);

-- ----------------------------
-- Table structure for oc_extrainsurarinvoices2_history
-- ----------------------------
CREATE TABLE `oc_extrainsurarinvoices2_history` (
  `OC_INSURARINVOICE_SERVERID` int(11) NOT NULL,
  `OC_INSURARINVOICE_OBJECTID` int(11) NOT NULL,
  `OC_INSURARINVOICE_ID` int(11) DEFAULT NULL,
  `OC_INSURARINVOICE_DATE` datetime DEFAULT NULL,
  `OC_INSURARINVOICE_INSURARUID` varchar(20) DEFAULT NULL,
  `OC_INSURARINVOICE_CREATETIME` datetime NOT NULL,
  `OC_INSURARINVOICE_UPDATETIME` datetime NOT NULL,
  `OC_INSURARINVOICE_UPDATEUID` varchar(255) NOT NULL,
  `OC_INSURARINVOICE_VERSION` int(11) NOT NULL,
  `OC_INSURARINVOICE_STATUS` varchar(255) NOT NULL,
  `OC_INSURARINVOICE_BALANCE` float DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_financedebets
-- ----------------------------
CREATE TABLE `oc_financedebets` (
  `OC_FINANCEDEBET_CREATETIME` datetime DEFAULT NULL,
  `OC_FINANCEDEBET_UPDATETIME` datetime DEFAULT NULL,
  `OC_FINANCEDEBET_UPDATEUID` varchar(20) DEFAULT NULL,
  `OC_FINANCEDEBET_VERSION` int(10) DEFAULT NULL,
  `OC_FINANCEDEBET_SERVERID` int(10) NOT NULL,
  `OC_FINANCEDEBET_OBJECTID` int(10) NOT NULL,
  `OC_FINANCEDEBET_DATE` datetime DEFAULT NULL,
  `OC_FINANCEDEBET_INSURANCEUID` varchar(20) DEFAULT NULL,
  `OC_FINANCEDEBET_PRESTATIONUID` varchar(20) DEFAULT NULL,
  `OC_FINANCEDEBET_ENCOUNTERUID` varchar(20) DEFAULT NULL,
  `OC_FINANCEDEBET_SUPPLIERUID` int(10) DEFAULT NULL,
  `OC_FINANCEDEBET_PATIENTINVOICEUID` int(10) DEFAULT NULL,
  `OC_FINANCEDEBET_INSURARINVOICEUID` int(10) DEFAULT NULL,
  `OC_FINANCEDEBET_COMMENT` varchar(255) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_fingerprints
-- ----------------------------
CREATE TABLE `oc_fingerprints` (
  `personid` int(10) DEFAULT NULL,
  `finger` char(2) DEFAULT NULL,
  `template` longblob,
  KEY `OC_FINGERPRINTS_PERSONID` (`personid`)
);

-- ----------------------------
-- Table structure for oc_hc
-- ----------------------------
CREATE TABLE `oc_hc` (
  `OC_HC_SERVERID` int(11) DEFAULT NULL,
  `OC_HC_OBJECTID` int(11) DEFAULT NULL,
  `OC_HC_CREATETIME` datetime DEFAULT NULL,
  `OC_HC_UPDATETIME` datetime DEFAULT NULL,
  `OC_HC_UPDATEUID` varchar(50) DEFAULT NULL,
  `OC_HC_VERSION` int(11) DEFAULT NULL,
  `OC_HC_NAME` varchar(255) DEFAULT NULL,
  `OC_HC_UID` varchar(50) DEFAULT NULL,
  `OC_HC_PROVINCE` varchar(50) DEFAULT NULL,
  `OC_HC_DISTRICT` varchar(50) DEFAULT NULL,
  `OC_HC_ZONE` varchar(50) DEFAULT NULL,
  `OC_HC_SECTOR` varchar(50) DEFAULT NULL,
  `OC_HC_FOSA` varchar(255) DEFAULT NULL,
  `OC_HC_CELL` varchar(255) DEFAULT NULL,
  `OC_HC_CONTACTNAME` varchar(255) DEFAULT NULL,
  `OC_HC_CONTACTFUNCTION` varchar(255) DEFAULT NULL,
  `OC_HC_REM_EPIDEMIOLOGY` text,
  `OC_HC_REM_DRUGS` text,
  `OC_HC_REM_VACCINATIONS` text,
  `OC_HC_REM_EQUIPMENT` text,
  `OC_HC_REM_BUILDING` text,
  `OC_HC_REM_TRANSPORT` text,
  `OC_HC_REM_PERSONNEL` text,
  `OC_HC_REM_OTHER` text,
  `OC_HC_POPULATION_TOTAL` int(11) DEFAULT NULL,
  `OC_HC_POPULATION_LT1M` float DEFAULT NULL,
  `OC_HC_POPULATION_LT1Y` float DEFAULT NULL,
  `OC_HC_POPULATION_LT5Y` float DEFAULT NULL,
  `OC_HC_POPULATION_LT25Y` float DEFAULT NULL,
  `OC_HC_POPULATION_LT50Y` float DEFAULT NULL,
  `OC_HC_POPULATION_MT50Y` float DEFAULT NULL,
  `OC_HC_POPULATION_PREG` float DEFAULT NULL,
  `OC_HC_POPULATION_MUT` float DEFAULT NULL,
  `OC_HC_BEDS` int(11) DEFAULT NULL,
  `OC_HC_ACTIVE` int(11) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_hc_history
-- ----------------------------
CREATE TABLE `oc_hc_history` (
  `OC_HC_SERVERID` int(11) DEFAULT NULL,
  `OC_HC_OBJECTID` int(11) DEFAULT NULL,
  `OC_HC_CREATETIME` datetime DEFAULT NULL,
  `OC_HC_UPDATETIME` datetime DEFAULT NULL,
  `OC_HC_UPDATEUID` varchar(50) DEFAULT NULL,
  `OC_HC_VERSION` int(11) DEFAULT NULL,
  `OC_HC_NAME` varchar(255) DEFAULT NULL,
  `OC_HC_UID` varchar(50) DEFAULT NULL,
  `OC_HC_PROVINCE` varchar(50) DEFAULT NULL,
  `OC_HC_DISTRICT` varchar(50) DEFAULT NULL,
  `OC_HC_ZONE` varchar(50) DEFAULT NULL,
  `OC_HC_SECTOR` varchar(50) DEFAULT NULL,
  `OC_HC_FOSA` varchar(255) DEFAULT NULL,
  `OC_HC_CELL` varchar(255) DEFAULT NULL,
  `OC_HC_CONTACTNAME` varchar(255) DEFAULT NULL,
  `OC_HC_CONTACTFUNCTION` varchar(255) DEFAULT NULL,
  `OC_HC_REM_EPIDEMIOLOGY` text,
  `OC_HC_REM_DRUGS` text,
  `OC_HC_REM_VACCINATIONS` text,
  `OC_HC_REM_EQUIPMENT` text,
  `OC_HC_REM_BUILDING` text,
  `OC_HC_REM_TRANSPORT` text,
  `OC_HC_REM_PERSONNEL` text,
  `OC_HC_REM_OTHER` text,
  `OC_HC_POPULATION_TOTAL` int(11) DEFAULT NULL,
  `OC_HC_POPULATION_LT1M` float DEFAULT NULL,
  `OC_HC_POPULATION_LT1Y` float DEFAULT NULL,
  `OC_HC_POPULATION_LT5Y` float DEFAULT NULL,
  `OC_HC_POPULATION_LT25Y` float DEFAULT NULL,
  `OC_HC_POPULATION_LT50Y` float DEFAULT NULL,
  `OC_HC_POPULATION_MT50Y` float DEFAULT NULL,
  `OC_HC_POPULATION_PREG` float DEFAULT NULL,
  `OC_HC_POPULATION_MUT` float DEFAULT NULL,
  `OC_HC_BEDS` int(11) DEFAULT NULL,
  `OC_HC_ACTIVE` int(11) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_immo
-- ----------------------------
CREATE TABLE `oc_immo` (
  `OC_IMMO_ID` int(11) DEFAULT NULL,
  `OC_IMMO_SERVICEUID` varchar(50) DEFAULT NULL,
  `OC_IMMO_LOCATION` varchar(50) DEFAULT NULL,
  `OC_IMMO_CODE` varchar(50) DEFAULT NULL,
  `OC_IMMO_BUYER` varchar(50) DEFAULT NULL,
  `OC_IMMO_COMMENT` varchar(255) DEFAULT NULL,
  KEY `OC_IMMO_ID` (`OC_IMMO_ID`)
);

-- ----------------------------
-- Table structure for oc_imports
-- ----------------------------
CREATE TABLE `oc_imports` (
  `OC_IMPORT_UID` int(11) DEFAULT NULL,
  `OC_IMPORT_SERVERID` int(11) DEFAULT NULL,
  `OC_IMPORT_OBJECTID` int(11) DEFAULT NULL,
  `OC_IMPORT_ID` varchar(50) DEFAULT NULL,
  `OC_IMPORT_CREATEDATETIME` datetime DEFAULT NULL,
  `OC_IMPORT_SENTDATETIME` datetime DEFAULT NULL,
  `OC_IMPORT_RECEIVEDATETIME` datetime DEFAULT NULL,
  `OC_IMPORT_ACKDATETIME` datetime DEFAULT NULL,
  `OC_IMPORT_IMPORTDATETIME` datetime DEFAULT NULL,
  `OC_IMPORT_IMPORTACKDATETIME` datetime DEFAULT NULL,
  `OC_IMPORT_DATA` text,
  `OC_IMPORT_ERRORCODE` int(11) DEFAULT NULL,
  `OC_IMPORT_REF` varchar(255) DEFAULT NULL,
  KEY `OC_IMPORT_UID` (`OC_IMPORT_UID`),
  KEY `OC_IMPORT_OBJECTID` (`OC_IMPORT_OBJECTID`),
  KEY `OC_IMPORT_CREATEDATETIME` (`OC_IMPORT_CREATEDATETIME`)
);

-- ----------------------------
-- Table structure for oc_insurancecategories
-- ----------------------------
CREATE TABLE `oc_insurancecategories` (
  `OC_INSURANCECATEGORY_CREATETIME` datetime DEFAULT NULL,
  `OC_INSURANCECATEGORY_UPDATETIME` datetime DEFAULT NULL,
  `OC_INSURANCECATEGORY_UPDATEUID` varchar(20) DEFAULT NULL,
  `OC_INSURANCECATEGORY_VERSION` int(10) DEFAULT NULL,
  `OC_INSURANCECATEGORY_SERVERID` int(10) NOT NULL,
  `OC_INSURANCECATEGORY_OBJECTID` int(10) NOT NULL,
  `OC_INSURANCECATEGORY_INSURARUID` varchar(255) DEFAULT NULL,
  `OC_INSURANCECATEGORY_CATEGORY` varchar(2) DEFAULT NULL,
  `OC_INSURANCECATEGORY_LABEL` varchar(255) DEFAULT NULL,
  `OC_INSURANCECATEGORY_PATIENTSHARE` int(10) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_insurancecategories_history
-- ----------------------------
CREATE TABLE `oc_insurancecategories_history` (
  `OC_INSURANCECATEGORY_CREATETIME` datetime DEFAULT NULL,
  `OC_INSURANCECATEGORY_UPDATETIME` datetime DEFAULT NULL,
  `OC_INSURANCECATEGORY_UPDATEUID` varchar(20) DEFAULT NULL,
  `OC_INSURANCECATEGORY_VERSION` int(11) DEFAULT NULL,
  `OC_INSURANCECATEGORY_SERVERID` int(11) NOT NULL,
  `OC_INSURANCECATEGORY_OBJECTID` int(11) NOT NULL,
  `OC_INSURANCECATEGORY_INSURARUID` varchar(255) DEFAULT NULL,
  `OC_INSURANCECATEGORY_CATEGORY` varchar(2) DEFAULT NULL,
  `OC_INSURANCECATEGORY_LABEL` varchar(255) DEFAULT NULL,
  `OC_INSURANCECATEGORY_PATIENTSHARE` int(11) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_insurances
-- ----------------------------
CREATE TABLE `oc_insurances` (
  `OC_INSURANCE_SERVERID` int(10) DEFAULT NULL,
  `OC_INSURANCE_OBJECTID` int(10) DEFAULT NULL,
  `OC_INSURANCE_NR` varchar(255) DEFAULT NULL,
  `OC_INSURANCE_INSURARUID` varchar(255) DEFAULT NULL,
  `OC_INSURANCE_TYPE` varchar(255) DEFAULT NULL,
  `OC_INSURANCE_START` datetime DEFAULT NULL,
  `OC_INSURANCE_STOP` datetime DEFAULT NULL,
  `OC_INSURANCE_COMMENT` longtext,
  `OC_INSURANCE_CREATETIME` datetime DEFAULT NULL,
  `OC_INSURANCE_UPDATETIME` datetime DEFAULT NULL,
  `OC_INSURANCE_UPDATEUID` varchar(255) DEFAULT NULL,
  `OC_INSURANCE_VERSION` int(10) DEFAULT NULL,
  `OC_INSURANCE_PATIENTUID` varchar(255) DEFAULT NULL,
  `OC_INSURANCE_INSURANCECATEGORYLETTER` varchar(25) DEFAULT NULL,
  `OC_INSURANCE_MEMBER` varchar(255) DEFAULT NULL,
  `OC_INSURANCE_MEMBER_IMMAT` varchar(50) DEFAULT NULL,
  `OC_INSURANCE_MEMBER_EMPLOYER` varchar(255) DEFAULT NULL,
  `OC_INSURANCE_STATUS` varchar(50) DEFAULT NULL,
  `OC_INSURANCE_EXTRAINSURARUID` varchar(50) DEFAULT NULL,
  `OC_INSURANCE_EXTRAINSURARUID2` varchar(50) DEFAULT NULL,
  KEY `insurance_objectid` (`OC_INSURANCE_OBJECTID`),
  KEY `insurance_patientuid` (`OC_INSURANCE_PATIENTUID`),
  KEY `OC_INSURANCE_OBJECTID` (`OC_INSURANCE_OBJECTID`),
  KEY `OC_INSURANCE_INSURARUID` (`OC_INSURANCE_INSURARUID`),
  KEY `OC_INSURANCE_PATIENTUID` (`OC_INSURANCE_PATIENTUID`)
);

-- ----------------------------
-- Table structure for oc_insurances_history
-- ----------------------------
CREATE TABLE `oc_insurances_history` (
  `OC_INSURANCE_SERVERID` int(10) DEFAULT NULL,
  `OC_INSURANCE_OBJECTID` int(10) DEFAULT NULL,
  `OC_INSURANCE_NR` varchar(255) DEFAULT NULL,
  `OC_INSURANCE_COMPANY` varchar(255) DEFAULT NULL,
  `OC_INSURANCE_TYPE` varchar(255) DEFAULT NULL,
  `OC_INSURANCE_START` datetime DEFAULT NULL,
  `OC_INSURANCE_STOP` datetime DEFAULT NULL,
  `OC_INSURANCE_COMMENT` longtext,
  `OC_INSURANCE_CREATETIME` datetime DEFAULT NULL,
  `OC_INSURANCE_UPDATETIME` datetime DEFAULT NULL,
  `OC_INSURANCE_UPDATEUID` varchar(255) DEFAULT NULL,
  `OC_INSURANCE_VERSION` int(10) DEFAULT NULL,
  `OC_INSURANCE_PATIENTUID` varchar(255) DEFAULT NULL,
  `OC_INSURANCE_INSURANCECATEGORYLETTER` varchar(25) DEFAULT NULL,
  `OC_INSURANCE_INSURARUID` varchar(255) DEFAULT NULL,
  `OC_INSURANCE_MEMBER` varchar(255) DEFAULT NULL,
  `OC_INSURANCE_MEMBER_IMMAT` varchar(50) DEFAULT NULL,
  `OC_INSURANCE_MEMBER_EMPLOYER` varchar(255) DEFAULT NULL,
  `OC_INSURANCE_STATUS` varchar(50) DEFAULT NULL,
  `OC_INSURANCE_EXTRAINSURARUID` varchar(50) DEFAULT NULL,
  `OC_INSURANCE_EXTRAINSURARUID2` varchar(50) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_insurarcredits
-- ----------------------------
CREATE TABLE `oc_insurarcredits` (
  `OC_INSURARCREDIT_CREATETIME` datetime DEFAULT NULL,
  `OC_INSURARCREDIT_UPDATETIME` datetime DEFAULT NULL,
  `OC_INSURARCREDIT_UPDATEUID` varchar(20) DEFAULT NULL,
  `OC_INSURARCREDIT_VERSION` int(10) DEFAULT NULL,
  `OC_INSURARCREDIT_SERVERID` int(10) NOT NULL,
  `OC_INSURARCREDIT_OBJECTID` int(10) NOT NULL,
  `OC_INSURARCREDIT_DATE` datetime DEFAULT NULL,
  `OC_INSURARCREDIT_INVOICEUID` int(10) DEFAULT NULL,
  `OC_INSURARCREDIT_AMOUNT` double DEFAULT NULL,
  `OC_INSURARCREDIT_TYPE` varchar(255) DEFAULT NULL,
  `OC_INSURARCREDIT_COMMENT` varchar(255) DEFAULT NULL,
  `OC_INSURARCREDIT_INSURARUID` varchar(50) DEFAULT NULL,
  KEY `insurarcredit_objectid` (`OC_INSURARCREDIT_OBJECTID`),
  KEY `insurarcredit_invoiceuid` (`OC_INSURARCREDIT_INVOICEUID`),
  KEY `OC_INSURARCREDIT_OBJECTID` (`OC_INSURARCREDIT_OBJECTID`),
  KEY `OC_INSURARCREDIT_INVOICEUID` (`OC_INSURARCREDIT_INVOICEUID`),
  KEY `OC_INSURARCREDIT_INSURARUID` (`OC_INSURARCREDIT_INSURARUID`)
);

-- ----------------------------
-- Table structure for oc_insurarinvoices
-- ----------------------------
CREATE TABLE `oc_insurarinvoices` (
  `OC_INSURARINVOICE_CREATETIME` datetime DEFAULT NULL,
  `OC_INSURARINVOICE_UPDATETIME` datetime DEFAULT NULL,
  `OC_INSURARINVOICE_UPDATEUID` varchar(25) DEFAULT NULL,
  `OC_INSURARINVOICE_VERSION` int(11) DEFAULT NULL,
  `OC_INSURARINVOICE_SERVERID` int(11) DEFAULT NULL,
  `OC_INSURARINVOICE_OBJECTID` int(11) DEFAULT NULL,
  `OC_INSURARINVOICE_ID` int(11) DEFAULT NULL,
  `OC_INSURARINVOICE_DATE` datetime DEFAULT NULL,
  `OC_INSURARINVOICE_INSURARUID` varchar(25) DEFAULT NULL,
  `OC_INSURARINVOICE_STATUS` varchar(255) DEFAULT NULL,
  `OC_INSURARINVOICE_BALANCE` float DEFAULT NULL,
  KEY `insuranrinvoice_objectid` (`OC_INSURARINVOICE_OBJECTID`),
  KEY `insuranrinvoice_id` (`OC_INSURARINVOICE_ID`),
  KEY `OC_INSURARINVOICE_OBJECTID` (`OC_INSURARINVOICE_OBJECTID`),
  KEY `OC_INSURARINVOICE_INSURARUID` (`OC_INSURARINVOICE_INSURARUID`)
);

-- ----------------------------
-- Table structure for oc_insurarinvoices_history
-- ----------------------------
CREATE TABLE `oc_insurarinvoices_history` (
  `OC_INSURARINVOICE_CREATETIME` datetime DEFAULT NULL,
  `OC_INSURARINVOICE_UPDATETIME` datetime DEFAULT NULL,
  `OC_INSURARINVOICE_UPDATEUID` varchar(25) DEFAULT NULL,
  `OC_INSURARINVOICE_VERSION` int(11) DEFAULT NULL,
  `OC_INSURARINVOICE_SERVERID` int(11) DEFAULT NULL,
  `OC_INSURARINVOICE_OBJECTID` int(11) DEFAULT NULL,
  `OC_INSURARINVOICE_ID` int(11) DEFAULT NULL,
  `OC_INSURARINVOICE_DATE` datetime DEFAULT NULL,
  `OC_INSURARINVOICE_INSURARUID` varchar(25) DEFAULT NULL,
  `OC_INSURARINVOICE_STATUS` varchar(255) DEFAULT NULL,
  `OC_INSURARINVOICE_BALANCE` float DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_insurars
-- ----------------------------
CREATE TABLE `oc_insurars` (
  `OC_INSURAR_CREATETIME` datetime DEFAULT NULL,
  `OC_INSURAR_UPDATETIME` datetime DEFAULT NULL,
  `OC_INSURAR_UPDATEUID` varchar(20) DEFAULT NULL,
  `OC_INSURAR_VERSION` int(10) DEFAULT NULL,
  `OC_INSURAR_SERVERID` int(10) NOT NULL,
  `OC_INSURAR_OBJECTID` int(10) NOT NULL,
  `OC_INSURAR_NAME` varchar(255) DEFAULT NULL,
  `OC_INSURAR_CONTACT` varchar(255) DEFAULT NULL,
  `OC_INSURAR_LANGUAGE` varchar(2) DEFAULT NULL,
  `OC_INSURAR_CONTACTPERSON` varchar(255) DEFAULT NULL,
  `OC_INSURAR_OFFICIAL_NAME` varchar(255) DEFAULT NULL,
  `OC_INSURAR_TYPE` varchar(25) DEFAULT NULL,
  `OC_INSURAR_DEFAULTINSURARINVOICEMODEL` varchar(25) DEFAULT NULL,
  `OC_INSURAR_DEFAULTPATIENTINVOICEMODEL` varchar(25) DEFAULT NULL,
  `OC_INSURAR_ALLOWEDREDUCTIONS` varchar(255) DEFAULT NULL,
  `OC_INSURAR_MODIFIERS` varchar(255) DEFAULT NULL,
  KEY `insurar_objectid` (`OC_INSURAR_OBJECTID`),
  KEY `insurar_name` (`OC_INSURAR_NAME`),
  KEY `OC_INSURAR_OBJECTID` (`OC_INSURAR_OBJECTID`),
  KEY `OC_INSURAR_NAME` (`OC_INSURAR_NAME`)
);

-- ----------------------------
-- Table structure for oc_invoices
-- ----------------------------
CREATE TABLE `oc_invoices` (
  `OC_INVOICE_CREATETIME` datetime DEFAULT NULL,
  `OC_INVOICE_UPDATETIME` datetime DEFAULT NULL,
  `OC_INVOICE_UPDATEUID` varchar(20) DEFAULT NULL,
  `OC_INVOICE_VERSION` int(10) DEFAULT NULL,
  `OC_INVOICE_SERVERID` int(10) NOT NULL,
  `OC_INVOICE_OBJECTID` int(10) NOT NULL,
  `OC_INVOICE_ID` int(10) DEFAULT NULL,
  `OC_INVOICE_DATE` datetime DEFAULT NULL,
  `OC_INVOICE_TYPE` varchar(20) DEFAULT NULL,
  `OC_INVOICE_CLIENTUID` varchar(20) DEFAULT NULL,
  `OC_INVOICE_STATUS` varchar(255) DEFAULT NULL,
  `OC_INVOICE_BALANCE` float DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_invoices_history
-- ----------------------------
CREATE TABLE `oc_invoices_history` (
  `OC_INVOICE_SERVERID` int(11) NOT NULL,
  `OC_INVOICE_OBJECTID` int(11) NOT NULL,
  `OC_INVOICE_ID` int(11) DEFAULT NULL,
  `OC_INVOICE_DATE` datetime DEFAULT NULL,
  `OC_INVOICE_TYPE` varchar(20) DEFAULT NULL,
  `OC_INVOICE_CLIENTUID` varchar(20) DEFAULT NULL,
  `OC_INVOICE_CREATETIME` datetime NOT NULL,
  `OC_INVOICE_UPDATETIME` datetime NOT NULL,
  `OC_INVOICE_UPDATEUID` varchar(255) NOT NULL,
  `OC_INVOICE_VERSION` int(11) NOT NULL,
  `OC_INVOICE_STATUS` varchar(255) NOT NULL,
  `OC_INVOICE_BALANCE` float DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_labels
-- ----------------------------
CREATE TABLE `oc_labels` (
  `OC_LABEL_TYPE` varchar(255) NOT NULL,
  `OC_LABEL_ID` varchar(255) NOT NULL,
  `OC_LABEL_LANGUAGE` varchar(255) NOT NULL,
  `OC_LABEL_VALUE` varchar(255) NOT NULL,
  `OC_LABEL_SHOWLINK` int(10) NOT NULL,
  `OC_LABEL_UPDATETIME` datetime NOT NULL,
  `OC_LABEL_UPDATEUSERID` int(10) NOT NULL,
  KEY `OC_LABEL_ID` (`OC_LABEL_ID`)
);

-- ----------------------------
-- Table structure for oc_meal
-- ----------------------------
CREATE TABLE `oc_meal` (
  `OC_MEAL_NAME` varchar(255) DEFAULT NULL,
  `OC_MEAL_OBJECTID` int(11) DEFAULT NULL,
  `OC_MEAL_SERVERID` int(11) DEFAULT NULL,
  `OC_MEAL_CREATETIME` datetime DEFAULT NULL,
  `OC_MEAL_UPDATETIME` datetime DEFAULT NULL,
  `OC_MEAL_UPDATEUID` varchar(255) DEFAULT NULL,
  KEY `OC_MEAL_OBJECTID` (`OC_MEAL_OBJECTID`)
);

-- ----------------------------
-- Table structure for oc_meal_component
-- ----------------------------
CREATE TABLE `oc_meal_component` (
  `OC_MEAL_ITEMUID` varchar(255) DEFAULT NULL,
  `OC_MEALUID` varchar(255) DEFAULT NULL,
  `OC_MEAL_ITEMQUANTITY` float DEFAULT NULL,
  `OC_MEAL_COMPONENT_CREATETIME` datetime DEFAULT NULL,
  `OC_MEAL_COMPONENT_UPDATETIME` datetime DEFAULT NULL,
  `OC_MEAL_COMPONENT_UPDATEUID` varchar(255) DEFAULT NULL,
  KEY `OC_MEAL_ITEMUID` (`OC_MEAL_ITEMUID`),
  KEY `OC_MEALUID` (`OC_MEALUID`)
);

-- ----------------------------
-- Table structure for oc_meal_item
-- ----------------------------
CREATE TABLE `oc_meal_item` (
  `OC_MEAL_ITEM_NAME` varchar(255) DEFAULT NULL,
  `OC_MEAL_ITEM_DESCRIPTION` varchar(255) DEFAULT NULL,
  `OC_MEAL_ITEM_UNIT` varchar(255) DEFAULT NULL,
  `OC_MEAL_ITEM_OBJECTID` int(11) DEFAULT NULL,
  `OC_MEAL_ITEM_SERVERID` int(11) DEFAULT NULL,
  `OC_MEAL_ITEM_CREATETIME` datetime DEFAULT NULL,
  `OC_MEAL_ITEM_UPDATETIME` datetime DEFAULT NULL,
  `OC_MEAL_ITEM_UPDATEUID` varchar(255) DEFAULT NULL,
  KEY `OC_MEAL_ITEM_OBJECTID` (`OC_MEAL_ITEM_OBJECTID`)
);

-- ----------------------------
-- Table structure for oc_meal_profiles
-- ----------------------------
CREATE TABLE `oc_meal_profiles` (
  `OC_MEAL_PROFILES_NAME` varchar(255) DEFAULT NULL,
  `OC_MEAL_PROFILES_MEALUID` varchar(255) DEFAULT NULL,
  `OC_MEAL_PROFILES_DATETIME` datetime DEFAULT NULL,
  `OC_MEAL_PROFILES_OBJECTID` int(11) DEFAULT NULL,
  `OC_MEAL_PROFILES_SERVERID` int(11) DEFAULT NULL,
  `OC_MEAL_PROFILES_CREATETIME` datetime DEFAULT NULL,
  `OC_MEAL_PROFILES_UPDATETIME` datetime DEFAULT NULL,
  `OC_MEAL_PROFILES_UPDATEUID` varchar(255) DEFAULT NULL,
  KEY `OC_MEAL_PROFILES_MEALUID` (`OC_MEAL_PROFILES_MEALUID`)
);

-- ----------------------------
-- Table structure for oc_notifier
-- ----------------------------
CREATE TABLE `oc_notifier` (
  `OC_NOTIFIER_TRANSACTIONID` int(11) DEFAULT NULL,
  `OC_NOTIFIER_TRANSPORT` varchar(50) DEFAULT NULL,
  `OC_NOTIFIER_RESULTS` text,
  `OC_NOTIFIER_CREATEDATETIME` datetime DEFAULT NULL,
  `OC_NOTIFIER_SENTDATETIME` datetime DEFAULT NULL,
  `OC_NOTIFIER_SENTTO` varchar(255) DEFAULT NULL,
  KEY `OC_NOTIFIER_TRANSACTIONID` (`OC_NOTIFIER_TRANSACTIONID`)
);

-- ----------------------------
-- Table structure for oc_nutricient_component
-- ----------------------------
CREATE TABLE `oc_nutricient_component` (
  `OC_NUTRICIENT_MEAL_ITEMUID` varchar(255) DEFAULT NULL,
  `OC_NUTRICIENT_ITEMUID` varchar(255) DEFAULT NULL,
  `OC_NUTRICIENT_ITEMQUANTITY` float DEFAULT NULL,
  `OC_NUTRICIENT_COMPONENT_CREATETIME` datetime DEFAULT NULL,
  `OC_NUTRICIENT_COMPONENT_UPDATETIME` datetime DEFAULT NULL,
  `OC_NUTRICIENT_COMPONENT_UPDATEUID` varchar(255) DEFAULT NULL,
  KEY `OC_N_MEAL_ITEMUID` (`OC_NUTRICIENT_MEAL_ITEMUID`),
  KEY `OC_N_ITEMUID` (`OC_NUTRICIENT_ITEMUID`)
);

-- ----------------------------
-- Table structure for oc_nutricient_item
-- ----------------------------
CREATE TABLE `oc_nutricient_item` (
  `OC_NUTRICIENT_NAME` varchar(255) DEFAULT NULL,
  `OC_NUTRICIENT_UNIT` varchar(255) DEFAULT NULL,
  `OC_NUTRICIENT_SERVERID` int(11) DEFAULT NULL,
  `OC_NUTRICIENT_OBJECTID` int(11) DEFAULT NULL,
  `OC_NUTRICIENT_ITEM_CREATETIME` datetime DEFAULT NULL,
  `OC_NUTRICIENT_ITEM_UPDATETIME` datetime DEFAULT NULL,
  `OC_NUTRICIENT_ITEM_UPDATEUID` varchar(255) DEFAULT NULL,
  KEY `OC_NUTRICIENT_OBJECTID` (`OC_NUTRICIENT_OBJECTID`)
);

-- ----------------------------
-- Table structure for oc_paperprescriptions
-- ----------------------------
CREATE TABLE `oc_paperprescriptions` (
  `OC_PP_SERVERID` int(11) NOT NULL,
  `OC_PP_OBJECTID` int(11) NOT NULL,
  `OC_PP_PATIENTUID` varchar(50) DEFAULT NULL,
  `OC_PP_PRESCRIBERUID` varchar(50) DEFAULT NULL,
  `OC_PP_DATE` datetime DEFAULT NULL,
  `OC_PP_CREATETIME` datetime DEFAULT NULL,
  `OC_PP_UPDATETIME` datetime DEFAULT NULL,
  `OC_PP_UPDATEUID` varchar(50) DEFAULT NULL,
  `OC_PP_VERSION` int(11) DEFAULT NULL,
  `OC_PP_CONTENT` text,
  KEY `PP_OBJECTID` (`OC_PP_SERVERID`),
  KEY `PP_PATIENTUID` (`OC_PP_PATIENTUID`)
);

-- ----------------------------
-- Table structure for oc_patient_meals
-- ----------------------------
CREATE TABLE `oc_patient_meals` (
  `OC_PM_PATIENTUID` varchar(255) DEFAULT NULL,
  `OC_PM_MEALUID` varchar(255) DEFAULT NULL,
  `OC_PM_DATETIME` datetime DEFAULT NULL,
  `OC_PM_CREATETIME` datetime DEFAULT NULL,
  `OC_PM_UPDATETIME` datetime DEFAULT NULL,
  `OC_PM_UPDATEUID` varchar(255) DEFAULT NULL,
  `OC_PM_TAKEN` char(1) DEFAULT NULL,
  `OC_PM_OBJECTID` int(11) DEFAULT NULL,
  `OC_PM_SERVERID` int(11) DEFAULT NULL,
  KEY `OC_PM_PATIENTUID` (`OC_PM_PATIENTUID`),
  KEY `OC_PM_DATETIME` (`OC_PM_DATETIME`)
);

-- ----------------------------
-- Table structure for oc_patientcredits
-- ----------------------------
CREATE TABLE `oc_patientcredits` (
  `OC_PATIENTCREDIT_CREATETIME` datetime DEFAULT NULL,
  `OC_PATIENTCREDIT_UPDATETIME` datetime DEFAULT NULL,
  `OC_PATIENTCREDIT_UPDATEUID` varchar(20) DEFAULT NULL,
  `OC_PATIENTCREDIT_VERSION` int(10) DEFAULT NULL,
  `OC_PATIENTCREDIT_SERVERID` int(10) NOT NULL,
  `OC_PATIENTCREDIT_OBJECTID` int(10) NOT NULL,
  `OC_PATIENTCREDIT_DATE` datetime DEFAULT NULL,
  `OC_PATIENTCREDIT_INVOICEUID` varchar(25) DEFAULT NULL,
  `OC_PATIENTCREDIT_AMOUNT` double DEFAULT NULL,
  `OC_PATIENTCREDIT_TYPE` varchar(255) DEFAULT NULL,
  `OC_PATIENTCREDIT_ENCOUNTERUID` varchar(20) DEFAULT NULL,
  `OC_PATIENTCREDIT_COMMENT` varchar(255) DEFAULT NULL,
  KEY `patientcredit_objectid` (`OC_PATIENTCREDIT_OBJECTID`),
  KEY `patientcredit_invoiceuid` (`OC_PATIENTCREDIT_INVOICEUID`),
  KEY `patientcredit_encounteruid` (`OC_PATIENTCREDIT_ENCOUNTERUID`)
);

-- ----------------------------
-- Table structure for oc_patientinvoices
-- ----------------------------
CREATE TABLE `oc_patientinvoices` (
  `OC_PATIENTINVOICE_CREATETIME` datetime DEFAULT NULL,
  `OC_PATIENTINVOICE_UPDATETIME` datetime DEFAULT NULL,
  `OC_PATIENTINVOICE_UPDATEUID` varchar(25) DEFAULT NULL,
  `OC_PATIENTINVOICE_VERSION` int(11) DEFAULT NULL,
  `OC_PATIENTINVOICE_SERVERID` int(11) DEFAULT NULL,
  `OC_PATIENTINVOICE_OBJECTID` int(11) DEFAULT NULL,
  `OC_PATIENTINVOICE_ID` int(11) DEFAULT NULL,
  `OC_PATIENTINVOICE_DATE` datetime DEFAULT NULL,
  `OC_PATIENTINVOICE_PATIENTUID` varchar(25) DEFAULT NULL,
  `OC_PATIENTINVOICE_STATUS` varchar(255) DEFAULT NULL,
  `OC_PATIENTINVOICE_BALANCE` float DEFAULT NULL,
  `OC_PATIENTINVOICE_NUMBER` varchar(50) DEFAULT NULL,
  `OC_PATIENTINVOICE_INSURARREFERENCE` varchar(50) DEFAULT NULL,
  `OC_PATIENTINVOICE_ACCEPTATIONUID` varchar(50) DEFAULT NULL,
  `OC_PATIENTINVOICE_INSURARREFERENCEDATE` varchar(50) DEFAULT NULL,
  `OC_PATIENTINVOICE_VERIFIER` varchar(255) DEFAULT NULL,
  KEY `patientinvoice_objectid` (`OC_PATIENTINVOICE_OBJECTID`),
  KEY `patientinvoice_patientuid` (`OC_PATIENTINVOICE_PATIENTUID`),
  KEY `OC_PATIENTINVOICE_OBJECTID` (`OC_PATIENTINVOICE_OBJECTID`),
  KEY `OC_PATIENTINVOICE_DATE` (`OC_PATIENTINVOICE_DATE`),
  KEY `OC_PATIENTINVOICE_PATIENTUID` (`OC_PATIENTINVOICE_PATIENTUID`)
);

-- ----------------------------
-- Table structure for oc_patientinvoices_history
-- ----------------------------
CREATE TABLE `oc_patientinvoices_history` (
  `OC_PATIENTINVOICE_CREATETIME` datetime DEFAULT NULL,
  `OC_PATIENTINVOICE_UPDATETIME` datetime DEFAULT NULL,
  `OC_PATIENTINVOICE_UPDATEUID` varchar(25) DEFAULT NULL,
  `OC_PATIENTINVOICE_VERSION` int(11) DEFAULT NULL,
  `OC_PATIENTINVOICE_SERVERID` int(11) DEFAULT NULL,
  `OC_PATIENTINVOICE_OBJECTID` int(11) DEFAULT NULL,
  `OC_PATIENTINVOICE_ID` int(11) DEFAULT NULL,
  `OC_PATIENTINVOICE_DATE` datetime DEFAULT NULL,
  `OC_PATIENTINVOICE_PATIENTUID` varchar(25) DEFAULT NULL,
  `OC_PATIENTINVOICE_STATUS` varchar(255) DEFAULT NULL,
  `OC_PATIENTINVOICE_BALANCE` float DEFAULT NULL,
  `OC_PATIENTINVOICE_NUMBER` varchar(50) DEFAULT NULL,
  `OC_PATIENTINVOICE_INSURARREFERENCE` varchar(50) DEFAULT NULL,
  `OC_PATIENTINVOICE_ACCEPTATIONUID` varchar(50) DEFAULT NULL,
  `OC_PATIENTINVOICE_INSURARREFERENCEDATE` varchar(50) DEFAULT NULL,
  `OC_PATIENTINVOICE_VERIFIER` varchar(255) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_person_pictures
-- ----------------------------
CREATE TABLE `oc_person_pictures` (
  `personid` int(10) NOT NULL,
  `picture` longblob,
  KEY `pictures_personid` (`personid`)
);

-- ----------------------------
-- Table structure for oc_planning
-- ----------------------------
CREATE TABLE `oc_planning` (
  `OC_PLANNING_PATIENTUID` varchar(255) DEFAULT NULL,
  `OC_PLANNING_USERUID` varchar(255) DEFAULT NULL,
  `OC_PLANNING_PLANNEDDATE` datetime DEFAULT NULL,
  `OC_PLANNING_EFFECTIVEDATE` datetime DEFAULT NULL,
  `OC_PLANNING_CANCELATIONDATE` datetime DEFAULT NULL,
  `OC_PLANNING_CONTACTTYPE` varchar(255) DEFAULT NULL,
  `OC_PLANNING_CONTACTUID` varchar(255) DEFAULT NULL,
  `OC_PLANNING_DESCRIPTION` longtext,
  `OC_PLANNING_SERVERID` int(10) DEFAULT NULL,
  `OC_PLANNING_TRANSACTIONUID` varchar(255) DEFAULT NULL,
  `OC_PLANNING_CREATETIME` datetime DEFAULT NULL,
  `OC_PLANNING_UPDATETIME` datetime DEFAULT NULL,
  `OC_PLANNING_UPDATEUID` varchar(255) DEFAULT NULL,
  `OC_PLANNING_VERSION` int(10) DEFAULT NULL,
  `OC_PLANNING_OBJECTID` int(10) DEFAULT NULL,
  `OC_PLANNING_ESTIMATEDTIME` varchar(255) DEFAULT NULL,
  `OC_PLANNING_CONTEXTID` varchar(255) DEFAULT NULL,
  `OC_PLANNING_PATIENTID` varchar(255) DEFAULT NULL,
  `OC_PLANNING_ESTIMATIONTIME` varchar(255) DEFAULT NULL,
  KEY `patientuid` (`OC_PLANNING_PATIENTUID`),
  KEY `transactionuid` (`OC_PLANNING_TRANSACTIONUID`),
  KEY `useruid` (`OC_PLANNING_USERUID`),
  KEY `OC_PLANNING_PATIENTID` (`OC_PLANNING_PATIENTID`),
  KEY `OC_PLANNING_USERUID` (`OC_PLANNING_USERUID`),
  KEY `OC_PLANNING_PLANNEDDATE` (`OC_PLANNING_PLANNEDDATE`),
  KEY `OC_PLANNING_OBJECTID` (`OC_PLANNING_OBJECTID`)
);

-- ----------------------------
-- Table structure for oc_pointers
-- ----------------------------
CREATE TABLE `oc_pointers` (
  `OC_POINTER_KEY` varchar(255) DEFAULT NULL,
  `OC_POINTER_VALUE` varchar(255) DEFAULT NULL,
  `OC_POINTER_UPDATETIME` datetime DEFAULT NULL,
  KEY `OC_POINTER_KEY` (`OC_POINTER_KEY`),
  KEY `OC_POINTER_UPDATETIME` (`OC_POINTER_UPDATETIME`)
);

-- ----------------------------
-- Table structure for oc_prescription_administration
-- ----------------------------
CREATE TABLE `oc_prescription_administration` (
  `OC_PRESCR_SERVERID` int(10) NOT NULL,
  `OC_PRESCR_OBJECTID` int(10) NOT NULL,
  `OC_SCHEMA_TIME` int(10) DEFAULT NULL,
  `OC_SCHEMA_QUANTITY` int(10) DEFAULT NULL,
  `OC_SCHEMA_DATE` datetime DEFAULT NULL,
  KEY `OC_A_PRESCR_OBJECTID` (`OC_PRESCR_OBJECTID`),
  KEY `OC_SCHEMA_DATE` (`OC_SCHEMA_DATE`)
);

-- ----------------------------
-- Table structure for oc_prescription_schema
-- ----------------------------
CREATE TABLE `oc_prescription_schema` (
  `OC_PRESCR_SERVERID` int(10) NOT NULL,
  `OC_PRESCR_OBJECTID` int(10) NOT NULL,
  `OC_SCHEMA_TIME` int(10) DEFAULT NULL,
  `OC_SCHEMA_QUANTITY` int(10) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_prescriptions
-- ----------------------------
CREATE TABLE `oc_prescriptions` (
  `OC_PRESCR_SERVERID` int(10) NOT NULL,
  `OC_PRESCR_OBJECTID` int(10) NOT NULL,
  `OC_PRESCR_PATIENTUID` varchar(255) NOT NULL,
  `OC_PRESCR_PRESCRIBERUID` varchar(255) NOT NULL,
  `OC_PRESCR_PRODUCTUID` varchar(255) NOT NULL,
  `OC_PRESCR_BEGIN` datetime DEFAULT NULL,
  `OC_PRESCR_END` datetime DEFAULT NULL,
  `OC_PRESCR_TIMEUNIT` varchar(255) NOT NULL,
  `OC_PRESCR_TIMEUNITCOUNT` int(10) NOT NULL,
  `OC_PRESCR_UNITSPERTIMEUNIT` double NOT NULL,
  `OC_PRESCR_SUPPLYINGSERVICEUID` varchar(255) DEFAULT NULL,
  `OC_PRESCR_CREATETIME` datetime NOT NULL,
  `OC_PRESCR_UPDATETIME` datetime NOT NULL,
  `OC_PRESCR_UPDATEUID` varchar(255) NOT NULL,
  `OC_PRESCR_VERSION` int(10) NOT NULL,
  `OC_PRESCR_REQUIREDPACKAGES` int(10) DEFAULT NULL,
  `OC_PRESCR_SERVICESTOCKUID` varchar(255) DEFAULT NULL,
  KEY `patientuid` (`OC_PRESCR_PATIENTUID`),
  KEY `OC_PRESCR_OBJECTID` (`OC_PRESCR_OBJECTID`),
  KEY `OC_PRESCR_PATIENTUID` (`OC_PRESCR_PATIENTUID`),
  KEY `OC_PRESCR_PRODUCTUID` (`OC_PRESCR_PRODUCTUID`),
  KEY `OC_PRESCR_SERVICESTOCKUID` (`OC_PRESCR_SERVICESTOCKUID`)
);

-- ----------------------------
-- Table structure for oc_prestation_codes
-- ----------------------------
CREATE TABLE `oc_prestation_codes` (
  `OC_PREST_CODE` varchar(255) DEFAULT NULL,
  `OC_PRESTATION_UID` varchar(255) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_prestation_groups
-- ----------------------------
CREATE TABLE `oc_prestation_groups` (
  `OC_GROUP_SERVERID` int(11) DEFAULT NULL,
  `OC_GROUP_OBJECTID` int(11) DEFAULT NULL,
  `OC_GROUP_DESCRIPTION` varchar(255) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_prestation_reimbursements
-- ----------------------------
CREATE TABLE `oc_prestation_reimbursements` (
  `OC_PR_INSURARUID` varchar(255) DEFAULT NULL,
  `OC_PR_PRESTATIONUID` varchar(255) DEFAULT NULL,
  `OC_PR_INSURARCODE` varchar(255) DEFAULT NULL,
  `OC_PR_PRESTATIONCODE` varchar(255) DEFAULT NULL,
  `OC_PR_PATIENTSHARE` int(11) DEFAULT NULL,
  KEY `reimbursements_prestationuid` (`OC_PR_PRESTATIONUID`)
);

-- ----------------------------
-- Table structure for oc_prestationdebets
-- ----------------------------
CREATE TABLE `oc_prestationdebets` (
  `OC_DEBET_SERVERID` int(11) NOT NULL,
  `OC_DEBET_OBJECTID` int(11) NOT NULL,
  `OC_DEBET_AMOUNT` float DEFAULT NULL,
  `OC_DEBET_INSURARAMOUNT` float DEFAULT NULL,
  `OC_DEBET_BALANCEUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_DATE` datetime DEFAULT NULL,
  `OC_DEBET_DESCRIPTION` varchar(255) DEFAULT NULL,
  `OC_DEBET_ENCOUNTERUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_PRESTATIONUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_SUPPLIERTYPE` varchar(255) DEFAULT NULL,
  `OC_DEBET_SUPPLIERUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_REFTYPE` varchar(255) DEFAULT NULL,
  `OC_DEBET_REFUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_CREATETIME` datetime NOT NULL,
  `OC_DEBET_UPDATETIME` datetime NOT NULL,
  `OC_DEBET_UPDATEUID` varchar(255) NOT NULL,
  `OC_DEBET_VERSION` int(11) NOT NULL,
  `OC_DEBET_INSURANCEUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_PATIENTINVOICEUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_INSURARINVOICEUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_COMMENT` varchar(255) DEFAULT NULL,
  `OC_DEBET_EXTRAINSURARUID` varchar(50) DEFAULT NULL,
  `OC_DEBET_EXTRAINSURARINVOICEUID` varchar(50) DEFAULT NULL,
  `OC_DEBET_EXTRAINSURARAMOUNT` varchar(50) DEFAULT NULL,
  `OC_DEBET_CREDITED` int(11) DEFAULT NULL,
  `OC_DEBET_QUANTITY` int(11) DEFAULT NULL,
  `OC_DEBET_RENEWALINTERVAL` int(11) DEFAULT NULL,
  `OC_DEBET_RENEWALDATE` datetime DEFAULT NULL,
  KEY `OC_DEBET_OBJECTID` (`OC_DEBET_OBJECTID`),
  KEY `OC_DEBET_DATE_UID` (`OC_DEBET_DATE`,`OC_DEBET_UPDATEUID`,`OC_DEBET_PRESTATIONUID`),
  KEY `OC_DEBET_DATE` (`OC_DEBET_DATE`),
  KEY `OC_DEBET_BALANCEUID` (`OC_DEBET_BALANCEUID`),
  KEY `OC_DEBET_ENCOUNTERUID` (`OC_DEBET_ENCOUNTERUID`),
  KEY `OC_DEBET_PRESTATIONUID` (`OC_DEBET_PRESTATIONUID`),
  KEY `OC_DEBET_REFUID` (`OC_DEBET_REFUID`),
  KEY `OC_DEBET_INSURANCEUID` (`OC_DEBET_INSURANCEUID`),
  KEY `OC_DEBET_PATIENTINVOICEUID` (`OC_DEBET_PATIENTINVOICEUID`),
  KEY `OC_DEBET_INSURARINVOICEUID` (`OC_DEBET_INSURARINVOICEUID`),
  KEY `OC_DEBET_EXTRAINSURARUID` (`OC_DEBET_EXTRAINSURARUID`),
  KEY `OC_DEBET_EXTRAINSURARINVOICEUID` (`OC_DEBET_EXTRAINSURARINVOICEUID`)
);

-- ----------------------------
-- Table structure for oc_prestationdebets_history
-- ----------------------------
CREATE TABLE `oc_prestationdebets_history` (
  `OC_DEBET_SERVERID` int(11) NOT NULL,
  `OC_DEBET_OBJECTID` int(11) NOT NULL,
  `OC_DEBET_AMOUNT` float DEFAULT NULL,
  `OC_DEBET_INSURARAMOUNT` float DEFAULT NULL,
  `OC_DEBET_BALANCEUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_DATE` datetime DEFAULT NULL,
  `OC_DEBET_DESCRIPTION` varchar(255) DEFAULT NULL,
  `OC_DEBET_ENCOUNTERUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_PRESTATIONUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_SUPPLIERTYPE` varchar(255) DEFAULT NULL,
  `OC_DEBET_SUPPLIERUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_REFTYPE` varchar(255) DEFAULT NULL,
  `OC_DEBET_REFUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_CREATETIME` datetime NOT NULL,
  `OC_DEBET_UPDATETIME` datetime NOT NULL,
  `OC_DEBET_UPDATEUID` varchar(255) NOT NULL,
  `OC_DEBET_VERSION` int(11) NOT NULL,
  `OC_DEBET_INSURANCEUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_PATIENTINVOICEUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_INSURARINVOICEUID` varchar(255) DEFAULT NULL,
  `OC_DEBET_COMMENT` varchar(255) DEFAULT NULL,
  `OC_DEBET_EXTRAINSURARUID` varchar(50) DEFAULT NULL,
  `OC_DEBET_EXTRAINSURARINVOICEUID` varchar(50) DEFAULT NULL,
  `OC_DEBET_EXTRAINSURARAMOUNT` varchar(50) DEFAULT NULL,
  `OC_DEBET_CREDITED` int(11) DEFAULT NULL,
  `OC_DEBET_QUANTITY` int(11) DEFAULT NULL,
  `OC_DEBET_RENEWALINTERVAL` int(11) DEFAULT NULL,
  `OC_DEBET_RENEWALDATE` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_prestationfamily_reimbursements
-- ----------------------------
CREATE TABLE `oc_prestationfamily_reimbursements` (
  `OC_PR_INSURARUID` varchar(255) NOT NULL,
  `OC_PR_PRESTATIONTYPE` varchar(255) NOT NULL,
  `OC_PR_PRESTATIONSHARE` int(11) DEFAULT NULL,
  `active` int(11) DEFAULT NULL,
  `OC_PR_INSURARCODE` varchar(255) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_prestationgroups_prestations
-- ----------------------------
CREATE TABLE `oc_prestationgroups_prestations` (
  `OC_PRESTATIONGROUP_GROUPUID` varchar(20) DEFAULT NULL,
  `OC_PRESTATIONGROUP_PRESTATIONUID` varchar(20) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_prestationgrps
-- ----------------------------
CREATE TABLE `oc_prestationgrps` (
  `OC_PRESTATIONGRP_SERVERID` int(10) DEFAULT NULL,
  `OC_PRESTATIONGRP_OBJECTID` int(10) DEFAULT NULL,
  `OC_PRESTATIONGRP_DESCRIPTION` varchar(255) DEFAULT NULL,
  `OC_PRESTATIONGRP_PRESTATIONUID` varchar(255) DEFAULT NULL,
  `OC_PRESTATIONGRP_CREATETIME` datetime DEFAULT NULL,
  `OC_PRESTATIONGRP_UPDATETIME` datetime DEFAULT NULL,
  `OC_PRESTATIONGRP_UPDATEUID` varchar(255) DEFAULT NULL,
  `OC_PRESTATIONGRP_VERSION` int(10) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_prestationgrps_history
-- ----------------------------
CREATE TABLE `oc_prestationgrps_history` (
  `OC_PRESTATIONGRP_SERVERID` int(10) DEFAULT NULL,
  `OC_PRESTATIONGRP_OBJECTID` int(10) DEFAULT NULL,
  `OC_PRESTATIONGRP_DESCRIPTION` varchar(255) DEFAULT NULL,
  `OC_PRESTATIONGRP_PRESTATIONUID` varchar(255) DEFAULT NULL,
  `OC_PRESTATIONGRP_CREATETIME` datetime DEFAULT NULL,
  `OC_PRESTATIONGRP_UPDATETIME` datetime DEFAULT NULL,
  `OC_PRESTATIONGRP_UPDATEUID` varchar(255) DEFAULT NULL,
  `OC_PRESTATIONGRP_VERSION` int(10) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_prestations
-- ----------------------------
CREATE TABLE `oc_prestations` (
  `OC_PRESTATION_SERVERID` int(10) DEFAULT NULL,
  `OC_PRESTATION_OBJECTID` int(10) DEFAULT NULL,
  `OC_PRESTATION_DESCRIPTION` varchar(255) DEFAULT NULL,
  `OC_PRESTATION_PRICE` double DEFAULT NULL,
  `OC_PRESTATION_REFTYPE` varchar(255) DEFAULT NULL,
  `OC_PRESTATION_REFUID` varchar(255) DEFAULT NULL,
  `OC_PRESTATION_CREATETIME` datetime DEFAULT NULL,
  `OC_PRESTATION_UPDATETIME` datetime DEFAULT NULL,
  `OC_PRESTATION_UPDATEUID` varchar(255) DEFAULT NULL,
  `OC_PRESTATION_VERSION` int(10) DEFAULT NULL,
  `OC_PRESTATION_TYPE` varchar(25) DEFAULT NULL,
  `OC_PRESTATION_CODE` varchar(255) DEFAULT NULL,
  `OC_PRESTATION_CATEGORIES` varchar(255) DEFAULT NULL,
  `OC_PRESTATION_INVOICEGROUP` varchar(50) DEFAULT NULL,
  `OC_PRESTATION_MFPPERCENTAGE` int(11) DEFAULT NULL,
  `OC_PRESTATION_RENEWALINTERVAL` int(11) DEFAULT NULL,
  `OC_PRESTATION_COVERAGEPLAN` varchar(50) DEFAULT NULL,
  `OC_PRESTATION_COVERAGEPLANCATEGORY` varchar(10) DEFAULT NULL,
  `OC_PRESTATION_VARIABLEPRICE` int(11) DEFAULT NULL,
  `OC_PRESTATION_INACTIVE` int(11) DEFAULT NULL,
  `OC_PRESTATION_PERFORMERUID` varchar(50) DEFAULT NULL,
  `OC_PRESTATION_SUPPLEMENT` float DEFAULT NULL,
  `OC_PRESTATION_CLASS` varchar(50) DEFAULT NULL,
  `OC_PRESTATION_MODIFIERS` varchar(255) DEFAULT NULL,
  `OC_PRESTATION_SERVICEUID` varchar(50) DEFAULT NULL,
  KEY `objectid` (`OC_PRESTATION_OBJECTID`),
  KEY `prest_uid` (`OC_PRESTATION_OBJECTID`),
  KEY `prestation_objectid` (`OC_PRESTATION_OBJECTID`),
  KEY `refuid` (`OC_PRESTATION_REFUID`),
  KEY `OC_PRESTATION_OBJECTID` (`OC_PRESTATION_OBJECTID`),
  KEY `OC_PRESTATION_CODE` (`OC_PRESTATION_CODE`)
);

-- ----------------------------
-- Table structure for oc_prestations_copy
-- ----------------------------
CREATE TABLE `oc_prestations_copy` (
  `OC_PRESTATION_SERVERID` int(10) DEFAULT NULL,
  `OC_PRESTATION_OBJECTID` int(10) DEFAULT NULL,
  `OC_PRESTATION_DESCRIPTION` varchar(255) DEFAULT NULL,
  `OC_PRESTATION_PRICE` double DEFAULT NULL,
  `OC_PRESTATION_REFTYPE` varchar(255) DEFAULT NULL,
  `OC_PRESTATION_REFUID` varchar(255) DEFAULT NULL,
  `OC_PRESTATION_CREATETIME` datetime DEFAULT NULL,
  `OC_PRESTATION_UPDATETIME` datetime DEFAULT NULL,
  `OC_PRESTATION_UPDATEUID` varchar(255) DEFAULT NULL,
  `OC_PRESTATION_VERSION` int(10) DEFAULT NULL,
  `OC_PRESTATION_TYPE` varchar(25) DEFAULT NULL,
  `OC_PRESTATION_CODE` varchar(255) DEFAULT NULL,
  `OC_PRESTATION_CATEGORIES` varchar(255) DEFAULT NULL,
  `OC_PRESTATION_INVOICEGROUP` varchar(50) DEFAULT NULL,
  KEY `objectid` (`OC_PRESTATION_OBJECTID`),
  KEY `refuid` (`OC_PRESTATION_REFUID`),
  KEY `prestation_objectid` (`OC_PRESTATION_OBJECTID`),
  KEY `OC_PRESTATION_OBJECTID` (`OC_PRESTATION_OBJECTID`),
  KEY `OC_PRESTATION_CODE` (`OC_PRESTATION_CODE`)
);

-- ----------------------------
-- Table structure for oc_prestations_history
-- ----------------------------
CREATE TABLE `oc_prestations_history` (
  `OC_PRESTATION_SERVERID` int(10) DEFAULT NULL,
  `OC_PRESTATION_OBJECTID` int(10) DEFAULT NULL,
  `OC_PRESTATION_DESCRIPTION` varchar(255) DEFAULT NULL,
  `OC_PRESTATION_PRICE` double DEFAULT NULL,
  `OC_PRESTATION_REFTYPE` varchar(255) DEFAULT NULL,
  `OC_PRESTATION_REFUID` varchar(255) DEFAULT NULL,
  `OC_PRESTATION_CREATETIME` datetime DEFAULT NULL,
  `OC_PRESTATION_UPDATETIME` datetime DEFAULT NULL,
  `OC_PRESTATION_UPDATEUID` varchar(255) DEFAULT NULL,
  `OC_PRESTATION_VERSION` int(10) DEFAULT NULL,
  KEY `objectid` (`OC_PRESTATION_OBJECTID`),
  KEY `refuid` (`OC_PRESTATION_REFUID`)
);

-- ----------------------------
-- Table structure for oc_problems
-- ----------------------------
CREATE TABLE `oc_problems` (
  `OC_PROBLEM_PATIENTUID` varchar(50) DEFAULT NULL,
  `OC_PROBLEM_CODETYPE` varchar(10) DEFAULT NULL,
  `OC_PROBLEM_CODE` varchar(50) DEFAULT NULL,
  `OC_PROBLEM_BEGIN` datetime DEFAULT NULL,
  `OC_PROBLEM_END` datetime DEFAULT NULL,
  `OC_PROBLEM_SERVERID` int(10) DEFAULT NULL,
  `OC_PROBLEM_OBJECTID` int(10) DEFAULT NULL,
  `OC_PROBLEM_CREATETIME` datetime DEFAULT NULL,
  `OC_PROBLEM_UPDATETIME` datetime DEFAULT NULL,
  `OC_PROBLEM_UPDATEUID` varchar(255) DEFAULT NULL,
  `OC_PROBLEM_VERSION` int(10) DEFAULT NULL,
  `OC_PROBLEM_GRAVITY` int(10) DEFAULT NULL,
  `OC_PROBLEM_CERTAINTY` int(10) DEFAULT NULL,
  `OC_PROBLEM_COMMENT` longtext,
  KEY `patientuid` (`OC_PROBLEM_PATIENTUID`)
);

-- ----------------------------
-- Table structure for oc_problems_history
-- ----------------------------
CREATE TABLE `oc_problems_history` (
  `OC_PROBLEM_PATIENTUID` varchar(50) DEFAULT NULL,
  `OC_PROBLEM_CODETYPE` varchar(10) DEFAULT NULL,
  `OC_PROBLEM_CODE` varchar(50) DEFAULT NULL,
  `OC_PROBLEM_BEGIN` datetime DEFAULT NULL,
  `OC_PROBLEM_END` datetime DEFAULT NULL,
  `OC_PROBLEM_SERVERID` int(10) DEFAULT NULL,
  `OC_PROBLEM_OBJECTID` int(10) DEFAULT NULL,
  `OC_PROBLEM_CREATETIME` datetime DEFAULT NULL,
  `OC_PROBLEM_UPDATETIME` datetime DEFAULT NULL,
  `OC_PROBLEM_UPDATEUID` varchar(255) DEFAULT NULL,
  `OC_PROBLEM_VERSION` int(10) DEFAULT NULL,
  `OC_PROBLEM_GRAVITY` int(10) DEFAULT NULL,
  `OC_PROBLEM_CERTAINTY` int(10) DEFAULT NULL,
  `OC_PROBLEM_COMMENT` longtext,
  KEY `patientuid` (`OC_PROBLEM_PATIENTUID`)
);

-- ----------------------------
-- Table structure for oc_prodstockoperations_history
-- ----------------------------
CREATE TABLE `oc_prodstockoperations_history` (
  `OC_OPERATION_SERVERID` int(10) NOT NULL,
  `OC_OPERATION_OBJECTID` int(10) NOT NULL,
  `OC_OPERATION_DESCRIPTION` varchar(255) NOT NULL,
  `OC_OPERATION_SRCDESTTYPE` varchar(255) NOT NULL,
  `OC_OPERATION_SRCDESTUID` varchar(255) NOT NULL,
  `OC_OPERATION_DATE` datetime NOT NULL,
  `OC_OPERATION_PRODUCTSTOCKUID` varchar(255) NOT NULL,
  `OC_OPERATION_UNITSCHANGED` int(10) NOT NULL,
  `OC_OPERATION_CREATETIME` datetime NOT NULL,
  `OC_OPERATION_UPDATETIME` datetime NOT NULL,
  `OC_OPERATION_UPDATEUID` varchar(255) NOT NULL,
  `OC_OPERATION_VERSION` int(10) NOT NULL
);

-- ----------------------------
-- Table structure for oc_product_schema
-- ----------------------------
CREATE TABLE `oc_product_schema` (
  `OC_SCHEMA_PRODUCTUID` varchar(255) NOT NULL,
  `OC_SCHEMA_SERVERID` int(10) NOT NULL,
  `OC_SCHEMA_OBJECTID` int(10) NOT NULL,
  `OC_SCHEMA_TIME` int(10) NOT NULL,
  `OC_SCHEMA_QUANTITY` int(10) NOT NULL
);

-- ----------------------------
-- Table structure for oc_productorders
-- ----------------------------
CREATE TABLE `oc_productorders` (
  `OC_ORDER_SERVERID` int(10) NOT NULL,
  `OC_ORDER_OBJECTID` int(10) NOT NULL,
  `OC_ORDER_DESCRIPTION` varchar(255) NOT NULL,
  `OC_ORDER_PRODUCTSTOCKUID` varchar(255) NOT NULL,
  `OC_ORDER_PACKAGESORDERED` int(10) NOT NULL,
  `OC_ORDER_PACKAGESDELIVERED` int(10) DEFAULT NULL,
  `OC_ORDER_DATEORDERED` datetime DEFAULT NULL,
  `OC_ORDER_DATEDELIVERYDUE` datetime DEFAULT NULL,
  `OC_ORDER_DATEDELIVERED` datetime DEFAULT NULL,
  `OC_ORDER_IMPORTANCE` varchar(255) NOT NULL,
  `OC_ORDER_CREATETIME` datetime NOT NULL,
  `OC_ORDER_UPDATETIME` datetime NOT NULL,
  `OC_ORDER_UPDATEUID` varchar(255) NOT NULL,
  `OC_ORDER_VERSION` int(10) NOT NULL,
  `OC_ORDER_STATUS` varchar(50) DEFAULT NULL,
  KEY `OC_ORDER_OBJECTID` (`OC_ORDER_OBJECTID`),
  KEY `OC_ORDER_PRODUCTSTOCKUID` (`OC_ORDER_PRODUCTSTOCKUID`),
  KEY `OC_ORDER_DATEORDERED` (`OC_ORDER_DATEORDERED`)
);

-- ----------------------------
-- Table structure for oc_productreceptionoperations
-- ----------------------------
CREATE TABLE `oc_productreceptionoperations` (
  `OC_OPERATION_SERVERID` int(11) NOT NULL,
  `OC_OPERATION_OBJECTID` int(11) NOT NULL,
  `OC_OPERATION_UNITSRECEIVED` int(11) DEFAULT NULL,
  `OC_OPERATION_UPDATETIME` datetime NOT NULL,
  `OC_OPERATION_UPDATEUID` varchar(255) NOT NULL,
  KEY `OC_OPERATION_OBJECTID` (`OC_OPERATION_OBJECTID`)
);

-- ----------------------------
-- Table structure for oc_products
-- ----------------------------
CREATE TABLE `oc_products` (
  `OC_PRODUCT_SERVERID` int(10) NOT NULL,
  `OC_PRODUCT_OBJECTID` int(10) NOT NULL,
  `OC_PRODUCT_NAME` varchar(255) NOT NULL,
  `OC_PRODUCT_UNIT` varchar(255) NOT NULL,
  `OC_PRODUCT_UNITPRICE` double NOT NULL,
  `OC_PRODUCT_PACKAGEUNITS` int(10) NOT NULL,
  `OC_PRODUCT_MINORDERPACKAGES` int(10) DEFAULT NULL,
  `OC_PRODUCT_SUPPLIERUID` varchar(255) DEFAULT NULL,
  `OC_PRODUCT_TIMEUNIT` varchar(255) DEFAULT NULL,
  `OC_PRODUCT_TIMEUNITCOUNT` int(10) DEFAULT NULL,
  `OC_PRODUCT_UNITSPERTIMEUNIT` double DEFAULT NULL,
  `OC_PRODUCT_CREATETIME` datetime NOT NULL,
  `OC_PRODUCT_UPDATETIME` datetime NOT NULL,
  `OC_PRODUCT_UPDATEUID` varchar(255) NOT NULL,
  `OC_PRODUCT_VERSION` int(10) NOT NULL,
  `OC_PRODUCT_PRODUCTGROUP` varchar(255) DEFAULT NULL,
  `OC_PRODUCT_PRESCRIPTIONINFO` varchar(255) DEFAULT NULL,
  `OC_PRODUCT_BARCODE` varchar(50) DEFAULT NULL,
  `OC_PRODUCT_PRESTATIONCODE` varchar(50) DEFAULT NULL,
  `OC_PRODUCT_PRESTATIONQUANTITY` int(11) DEFAULT NULL,
  `OC_PRODUCT_MARGIN` float DEFAULT NULL,
  `OC_PRODUCT_APPLYLOWERPRICES` int(11) DEFAULT NULL,
  `OC_PRODUCT_AUTOMATICINVOICING` int(11) DEFAULT NULL,
  KEY `products_objectid` (`OC_PRODUCT_OBJECTID`),
  KEY `products_name` (`OC_PRODUCT_NAME`),
  KEY `OC_PRODUCT_OBJECTID` (`OC_PRODUCT_OBJECTID`)
);

-- ----------------------------
-- Table structure for oc_products_history
-- ----------------------------
CREATE TABLE `oc_products_history` (
  `OC_PRODUCT_SERVERID` int(10) NOT NULL,
  `OC_PRODUCT_OBJECTID` int(10) NOT NULL,
  `OC_PRODUCT_NAME` varchar(255) NOT NULL,
  `OC_PRODUCT_UNIT` varchar(255) NOT NULL,
  `OC_PRODUCT_UNITPRICE` double NOT NULL,
  `OC_PRODUCT_PACKAGEUNITS` int(10) NOT NULL,
  `OC_PRODUCT_MINORDERPACKAGES` int(10) DEFAULT NULL,
  `OC_PRODUCT_SUPPLIERUID` varchar(255) DEFAULT NULL,
  `OC_PRODUCT_TIMEUNIT` varchar(255) DEFAULT NULL,
  `OC_PRODUCT_TIMEUNITCOUNT` int(10) DEFAULT NULL,
  `OC_PRODUCT_UNITSPERTIMEUNIT` double DEFAULT NULL,
  `OC_PRODUCT_CREATETIME` datetime NOT NULL,
  `OC_PRODUCT_UPDATETIME` datetime NOT NULL,
  `OC_PRODUCT_UPDATEUID` varchar(255) NOT NULL,
  `OC_PRODUCT_VERSION` int(10) NOT NULL,
  `OC_PRODUCT_PRODUCTGROUP` varchar(255) DEFAULT NULL,
  `OC_PRODUCT_PRESCRIPTIONINFO` varchar(255) DEFAULT NULL,
  `OC_PRODUCT_BARCODE` varchar(50) DEFAULT NULL,
  `OC_PRODUCT_PRESTATIONCODE` varchar(50) DEFAULT NULL,
  `OC_PRODUCT_PRESTATIONQUANTITY` int(11) DEFAULT NULL,
  `OC_PRODUCT_MARGIN` float DEFAULT NULL,
  `OC_PRODUCT_APPLYLOWERPRICES` int(11) DEFAULT NULL,
  `OC_PRODUCT_AUTOMATICINVOICING` int(11) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_productstockoperationdocuments
-- ----------------------------
CREATE TABLE `oc_productstockoperationdocuments` (
  `OC_DOCUMENT_SERVERID` int(11) NOT NULL,
  `OC_DOCUMENT_OBJECTID` int(11) NOT NULL,
  `OC_DOCUMENT_TYPE` varchar(50) DEFAULT NULL,
  `OC_DOCUMENT_SOURCEUID` varchar(50) DEFAULT NULL,
  `OC_DOCUMENT_DESTINATIONUID` varchar(50) DEFAULT NULL,
  `OC_DOCUMENT_DATE` datetime DEFAULT NULL,
  `OC_DOCUMENT_COMMENT` varchar(255) DEFAULT NULL,
  `OC_DOCUMENT_REFERENCE` varchar(255) DEFAULT NULL,
  KEY `OC_DOCUMENT_OBJECTID` (`OC_DOCUMENT_OBJECTID`),
  KEY `OC_DOCUMENT_REFERENCE` (`OC_DOCUMENT_REFERENCE`)
);

-- ----------------------------
-- Table structure for oc_productstockoperations
-- ----------------------------
CREATE TABLE `oc_productstockoperations` (
  `OC_OPERATION_SERVERID` int(10) NOT NULL,
  `OC_OPERATION_OBJECTID` int(10) NOT NULL,
  `OC_OPERATION_DESCRIPTION` varchar(255) NOT NULL,
  `OC_OPERATION_SRCDESTTYPE` varchar(255) NOT NULL,
  `OC_OPERATION_SRCDESTUID` varchar(255) NOT NULL,
  `OC_OPERATION_DATE` datetime NOT NULL,
  `OC_OPERATION_PRODUCTSTOCKUID` varchar(255) NOT NULL,
  `OC_OPERATION_UNITSCHANGED` int(10) NOT NULL,
  `OC_OPERATION_CREATETIME` datetime NOT NULL,
  `OC_OPERATION_UPDATETIME` datetime NOT NULL,
  `OC_OPERATION_UPDATEUID` varchar(255) NOT NULL,
  `OC_OPERATION_VERSION` int(10) NOT NULL,
  `OC_OPERATION_PRESCRIPTIONUID` varchar(255) DEFAULT NULL,
  `OC_OPERATION_BATCHUID` varchar(50) DEFAULT NULL,
  `OC_OPERATION_UID` varchar(50) DEFAULT NULL,
  `OC_OPERATION_UNITSRECEIVED` int(11) DEFAULT NULL,
  `OC_OPERATION_RECEIVECOMMENT` varchar(255) DEFAULT NULL,
  `OC_OPERATION_RECEIVEPRODUCTSTOCKUID` varchar(255) DEFAULT NULL,
  `OC_OPERATION_DOCUMENTUID` varchar(50) DEFAULT NULL,
  `OC_OPERATION_ENCOUNTERUID` varchar(50) DEFAULT NULL,
  `OC_OPERATION_ORDERUID` varchar(50) DEFAULT NULL,
  KEY `productstockoperations_precript` (`OC_OPERATION_PRESCRIPTIONUID`),
  KEY `OC_OPERATION_OBJECTID` (`OC_OPERATION_OBJECTID`),
  KEY `OC_OPERATION_PRODUCTSTOCKUID` (`OC_OPERATION_PRODUCTSTOCKUID`),
  KEY `OC_OPERATION_SRCDESTUID` (`OC_OPERATION_SRCDESTUID`)
);

-- ----------------------------
-- Table structure for oc_productstocks
-- ----------------------------
CREATE TABLE `oc_productstocks` (
  `OC_STOCK_SERVERID` int(10) NOT NULL,
  `OC_STOCK_OBJECTID` int(10) NOT NULL,
  `OC_STOCK_SERVICESTOCKUID` varchar(255) NOT NULL,
  `OC_STOCK_PRODUCTUID` varchar(255) NOT NULL,
  `OC_STOCK_LEVEL` int(10) NOT NULL,
  `OC_STOCK_MINIMUMLEVEL` int(10) NOT NULL,
  `OC_STOCK_MAXIMUMLEVEL` int(10) DEFAULT NULL,
  `OC_STOCK_ORDERLEVEL` int(10) DEFAULT NULL,
  `OC_STOCK_BEGIN` datetime DEFAULT NULL,
  `OC_STOCK_END` datetime DEFAULT NULL,
  `OC_STOCK_DEFAULTIMPORTANCE` varchar(255) NOT NULL,
  `OC_STOCK_CREATETIME` datetime NOT NULL,
  `OC_STOCK_UPDATETIME` datetime NOT NULL,
  `OC_STOCK_UPDATEUID` varchar(255) NOT NULL,
  `OC_STOCK_VERSION` int(10) NOT NULL,
  `OC_STOCK_SUPPLIERUID` varchar(255) DEFAULT NULL,
  KEY `productstocks_objectid` (`OC_STOCK_OBJECTID`),
  KEY `productstocks_productuid` (`OC_STOCK_PRODUCTUID`),
  KEY `OC_STOCK_OBJECTID` (`OC_STOCK_OBJECTID`),
  KEY `OC_STOCK_SERVICESTOCKUID` (`OC_STOCK_SERVICESTOCKUID`),
  KEY `OC_STOCK_PRODUCTUID` (`OC_STOCK_PRODUCTUID`)
);

-- ----------------------------
-- Table structure for oc_productstocks_history
-- ----------------------------
CREATE TABLE `oc_productstocks_history` (
  `OC_STOCK_SERVERID` int(10) NOT NULL,
  `OC_STOCK_OBJECTID` int(10) NOT NULL,
  `OC_STOCK_SERVICESTOCKUID` varchar(255) NOT NULL,
  `OC_STOCK_PRODUCTUID` varchar(255) NOT NULL,
  `OC_STOCK_LEVEL` int(10) NOT NULL,
  `OC_STOCK_MINIMUMLEVEL` int(10) NOT NULL,
  `OC_STOCK_MAXIMUMLEVEL` int(10) NOT NULL,
  `OC_STOCK_ORDERLEVEL` int(10) NOT NULL,
  `OC_STOCK_BEGIN` datetime NOT NULL,
  `OC_STOCK_END` datetime NOT NULL,
  `OC_STOCK_DEFAULTIMPORTANCE` int(10) NOT NULL,
  `OC_STOCK_CREATETIME` datetime NOT NULL,
  `OC_STOCK_UPDATETIME` datetime NOT NULL,
  `OC_STOCK_UPDATEUID` varchar(255) NOT NULL,
  `OC_STOCK_VERSION` int(10) NOT NULL
);

-- ----------------------------
-- Table structure for oc_questionnaires
-- ----------------------------
CREATE TABLE `oc_questionnaires` (
  `OC_QUESTIONNAIRE_ID` int(11) DEFAULT NULL,
  `OC_QUESTIONNAIRE_TITLE_NL` varchar(255) DEFAULT NULL,
  `OC_QUESTIONNAIRE_TITLE_FR` varchar(255) DEFAULT NULL,
  `OC_QUESTIONNAIRE_TITLE_DE` varchar(255) DEFAULT NULL,
  `OC_QUESTIONNAIRE_TITLE_EN` varchar(255) DEFAULT NULL,
  `OC_QUESTIONNAIRE_TITLE_ES` varchar(255) DEFAULT NULL,
  `OC_QUESTIONNAIRE_ACTIVE` int(11) DEFAULT NULL,
  KEY `OC_QUESTIONNAIRE_ID` (`OC_QUESTIONNAIRE_ID`)
);

-- ----------------------------
-- Table structure for oc_questions
-- ----------------------------
CREATE TABLE `oc_questions` (
  `OC_QUESTION_ID` int(11) DEFAULT NULL,
  `OC_QUESTION_QUESTIONNAIREID` int(11) DEFAULT NULL,
  `OC_QUESTION_NL` varchar(255) DEFAULT NULL,
  `OC_QUESTION_FR` varchar(255) DEFAULT NULL,
  `OC_QUESTION_DE` varchar(255) DEFAULT NULL,
  `OC_QUESTION_EN` varchar(255) DEFAULT NULL,
  `OC_QUESTION_ES` varchar(255) DEFAULT NULL,
  `OC_QUESTION_ANSWERTYPE` varchar(50) DEFAULT NULL,
  `OC_QUESTION_ANSWERVALUES` varchar(255) DEFAULT NULL,
  `OC_QUESTION_ANSWERMANDATORY` int(11) DEFAULT NULL,
  KEY `OC_QUESTION_QUESTIONNAIREID` (`OC_QUESTION_QUESTIONNAIREID`),
  KEY `OC_QUESTION_ID` (`OC_QUESTION_ID`)
);

-- ----------------------------
-- Table structure for oc_references
-- ----------------------------
CREATE TABLE `oc_references` (
  `OC_REFERENCE_SERVERID` int(10) DEFAULT NULL,
  `OC_REFERENCE_OBJECTID` int(10) DEFAULT NULL,
  `OC_REFERENCE_PATIENTUID` varchar(255) DEFAULT NULL,
  `OC_REFERENCE_REQUESTDATE` datetime DEFAULT NULL,
  `OC_REFERENCE_REQUESTSERVICEUID` varchar(255) DEFAULT NULL,
  `OC_REFERENCE_STATUS` varchar(255) DEFAULT NULL,
  `OC_REFERENCE_EXECUTIONDATE` datetime DEFAULT NULL,
  `OC_REFERENCE_CREATEUSERUID` varchar(255) DEFAULT NULL,
  `OC_REFERENCE_CREATETIME` datetime DEFAULT NULL,
  `OC_REFERENCE_UPDATETIME` datetime DEFAULT NULL,
  `OC_REFERENCE_UPDATEUID` varchar(255) DEFAULT NULL,
  `OC_REFERENCE_CREATESERVICEUID` varchar(255) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_rfe
-- ----------------------------
CREATE TABLE `oc_rfe` (
  `OC_RFE_SERVERID` int(11) NOT NULL,
  `OC_RFE_OBJECTID` int(11) NOT NULL,
  `OC_RFE_ENCOUNTERUID` varchar(50) DEFAULT NULL,
  `OC_RFE_CODETYPE` varchar(10) DEFAULT NULL,
  `OC_RFE_CODE` varchar(10) DEFAULT NULL,
  `OC_RFE_DATE` datetime DEFAULT NULL,
  `OC_RFE_FLAGS` varchar(255) DEFAULT NULL,
  `OC_RFE_VERSION` int(11) DEFAULT NULL,
  `OC_RFE_CREATETIME` datetime DEFAULT NULL,
  `OC_RFE_UPDATETIME` datetime NOT NULL,
  `OC_RFE_UPDATEUID` varchar(50) NOT NULL,
  KEY `OC_RFE_OBJECTID` (`OC_RFE_OBJECTID`),
  KEY `OC_RFE_OENCOUNTERUID` (`OC_RFE_ENCOUNTERUID`),
  KEY `OC_RFE_DATE` (`OC_RFE_DATE`)
);

-- ----------------------------
-- Table structure for oc_rfe_history
-- ----------------------------
CREATE TABLE `oc_rfe_history` (
  `OC_RFE_SERVERID` int(11) NOT NULL,
  `OC_RFE_OBJECTID` int(11) NOT NULL,
  `OC_RFE_ENCOUNTERUID` varchar(50) DEFAULT NULL,
  `OC_RFE_CODETYPE` varchar(10) DEFAULT NULL,
  `OC_RFE_CODE` varchar(10) DEFAULT NULL,
  `OC_RFE_DATE` datetime DEFAULT NULL,
  `OC_RFE_FLAGS` varchar(255) DEFAULT NULL,
  `OC_RFE_VERSION` int(11) DEFAULT NULL,
  `OC_RFE_CREATETIME` datetime DEFAULT NULL,
  `OC_RFE_UPDATETIME` datetime NOT NULL,
  `OC_RFE_UPDATEUID` varchar(50) NOT NULL
);

-- ----------------------------
-- Table structure for oc_servicediagnoses
-- ----------------------------
CREATE TABLE `oc_servicediagnoses` (
  `OC_SERVICEDIAGNOSIS_SERVICEUID` varchar(50) DEFAULT NULL,
  `OC_SERVICEDIAGNOSIS_CODE` varchar(20) DEFAULT NULL,
  `OC_SERVICEDIAGNOSIS_CODETYPE` varchar(20) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_servicestocks
-- ----------------------------
CREATE TABLE `oc_servicestocks` (
  `OC_STOCK_SERVERID` int(10) NOT NULL,
  `OC_STOCK_OBJECTID` int(10) NOT NULL,
  `OC_STOCK_NAME` varchar(255) NOT NULL,
  `OC_STOCK_SERVICEUID` varchar(255) NOT NULL,
  `OC_STOCK_BEGIN` datetime DEFAULT NULL,
  `OC_STOCK_END` datetime DEFAULT NULL,
  `OC_STOCK_STOCKMANAGERUID` varchar(255) NOT NULL,
  `OC_STOCK_CREATETIME` datetime NOT NULL,
  `OC_STOCK_UPDATETIME` datetime NOT NULL,
  `OC_STOCK_UPDATEUID` varchar(255) NOT NULL,
  `OC_STOCK_VERSION` int(10) NOT NULL,
  `OC_STOCK_DEFAULTSUPPLIERUID` varchar(255) DEFAULT NULL,
  `OC_STOCK_AUTHORIZEDUSERS` varchar(255) DEFAULT NULL,
  `OC_STOCK_ORDERPERIODINMONTHS` int(10) DEFAULT NULL,
  `OC_STOCK_NOSYNC` int(11) DEFAULT NULL,
  KEY `OC_S_STOCK_OBJECTID` (`OC_STOCK_OBJECTID`),
  KEY `OC_STOCK_SERVICEUID` (`OC_STOCK_SERVICEUID`)
);

-- ----------------------------
-- Table structure for oc_snomedct
-- ----------------------------
CREATE TABLE `oc_snomedct` (
  `OC_SNOMEDCT_ENCOUNTERUID` varchar(50) DEFAULT NULL,
  `OC_SNOMEDCT_TRANSACTIONUID` varchar(50) DEFAULT NULL,
  `OC_SNOMEDCT_CONCEPTUID` varchar(50) DEFAULT NULL,
  `OC_SNOMEDCT_READCODE` varchar(50) DEFAULT NULL,
  `OC_SNOMEDCT_SNOMEDID` varchar(50) DEFAULT NULL,
  `OC_SNOMEDCT_DESCRIPTION` varchar(255) DEFAULT NULL,
  KEY `OC_SNOMEDCT_ENCOUNTERUID` (`OC_SNOMEDCT_ENCOUNTERUID`)
);

-- ----------------------------
-- Table structure for oc_tariffs
-- ----------------------------
CREATE TABLE `oc_tariffs` (
  `OC_TARIFF_INSURARUID` varchar(20) DEFAULT NULL,
  `OC_TARIFF_PRESTATIONUID` varchar(20) DEFAULT NULL,
  `OC_TARIFF_INSURANCECATEGORY` varchar(2) DEFAULT NULL,
  `OC_TARIFF_PRICE` float DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_terminologies
-- ----------------------------
CREATE TABLE `oc_terminologies` (
  `OC_TERMINOLOGY_SERVERID` int(10) DEFAULT NULL,
  `OC_TERMINOLOGY_OBJECTID` int(10) DEFAULT NULL,
  `OC_TERMINOLOGY_TYPE` varchar(255) DEFAULT NULL,
  `OC_TERMINOLOGY_USERUID` varchar(255) DEFAULT NULL,
  `OC_TERMINOLOGY_PHRASE` varchar(255) DEFAULT NULL,
  `OC_TERMINOLOGY_CREATETIME` datetime DEFAULT NULL,
  `OC_TERMINOLOGY_UPDATETIME` datetime DEFAULT NULL,
  `OC_TERMINOLOGY_UPDATEUID` int(10) DEFAULT NULL,
  `OC_TERMINOLOGY_VERSION` int(10) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_terminologies_history
-- ----------------------------
CREATE TABLE `oc_terminologies_history` (
  `OC_TERMINOLOGY_SERVERID` int(10) DEFAULT NULL,
  `OC_TERMINOLOGY_OBJECTID` int(10) DEFAULT NULL,
  `OC_TERMINOLOGY_TYPE` varchar(255) DEFAULT NULL,
  `OC_TERMINOLOGY_USERUID` varchar(255) DEFAULT NULL,
  `OC_TERMINOLOGY_PHRASE` varchar(255) DEFAULT NULL,
  `OC_TERMINOLOGY_CREATETIME` datetime DEFAULT NULL,
  `OC_TERMINOLOGY_UPDATETIME` datetime DEFAULT NULL,
  `OC_TERMINOLOGY_UPDATEUID` int(10) DEFAULT NULL,
  `OC_TERMINOLOGY_VERSION` int(10) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_unknownlabels
-- ----------------------------
CREATE TABLE `oc_unknownlabels` (
  `OC_LABEL_TYPE` varchar(255) NOT NULL,
  `OC_LABEL_ID` varchar(255) NOT NULL,
  `OC_LABEL_LANGUAGE` varchar(255) NOT NULL,
  `OC_LABEL_VALUE` varchar(255) NOT NULL,
  `OC_LABEL_UNKNOWNDATETIME` datetime NOT NULL,
  `OC_LABEL_UPDATETIME` datetime NOT NULL,
  `OC_LABEL_UPDATEUSERID` int(10) NOT NULL
);

-- ----------------------------
-- Table structure for oc_userdiagnoses
-- ----------------------------
CREATE TABLE `oc_userdiagnoses` (
  `OC_USERDIAGNOSIS_USERID` int(10) DEFAULT NULL,
  `OC_USERDIAGNOSIS_CODE` varchar(255) DEFAULT NULL,
  `OC_USERDIAGNOSIS_CODETYPE` varchar(255) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_userexaminations
-- ----------------------------
CREATE TABLE `oc_userexaminations` (
  `userid` int(10) NOT NULL,
  `examinationid` int(10) NOT NULL
);

-- ----------------------------
-- Table structure for oc_userproducts
-- ----------------------------
CREATE TABLE `oc_userproducts` (
  `OC_PRODUCT_USERID` varchar(255) DEFAULT NULL,
  `OC_PRODUCT_PRODUCTUID` varchar(255) DEFAULT NULL,
  `OC_PRODUCT_PRODUCTSTOCKUID` varchar(255) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_wicket_credits
-- ----------------------------
CREATE TABLE `oc_wicket_credits` (
  `oc_wicket_credit_serverid` int(11) DEFAULT NULL,
  `oc_wicket_credit_objectid` int(11) DEFAULT NULL,
  `OC_WICKET_CREDIT_WICKETUID` varchar(255) NOT NULL,
  `OC_WICKET_CREDIT_OPERATIONDATE` datetime NOT NULL,
  `OC_WICKET_CREDIT_AMOUNT` double NOT NULL,
  `OC_WICKET_CREDIT_USERUID` int(10) NOT NULL,
  `OC_WICKET_CREDIT_TYPE` varchar(255) NOT NULL,
  `OC_WICKET_CREDIT_COMMENT` longtext NOT NULL,
  `OC_WICKET_CREDIT_REFERENCETYPE` varchar(255) NOT NULL,
  `OC_WICKET_CREDIT_REFERENCEUID` varchar(255) NOT NULL,
  `OC_WICKET_CREDIT_CREATETIME` datetime NOT NULL,
  `OC_WICKET_CREDIT_UPDATETIME` datetime NOT NULL,
  `OC_WICKET_CREDIT_UPDATEUID` int(10) NOT NULL,
  `OC_WICKET_CREDIT_VERSION` int(10) NOT NULL,
  `OC_WICKET_CREDIT_INVOICEUID` varchar(50) DEFAULT NULL,
  KEY `OC_WICKET_CREDIT_OBJECTID` (`oc_wicket_credit_objectid`),
  KEY `OC_WICKET_CREDIT_INVOICEUID` (`OC_WICKET_CREDIT_INVOICEUID`)
);

-- ----------------------------
-- Table structure for oc_wicket_credits_history
-- ----------------------------
CREATE TABLE `oc_wicket_credits_history` (
  `oc_wicket_credit_serverid` int(11) DEFAULT NULL,
  `oc_wicket_credit_objectid` int(11) DEFAULT NULL,
  `OC_WICKET_CREDIT_WICKETUID` varchar(255) NOT NULL,
  `OC_WICKET_CREDIT_OPERATIONDATE` datetime NOT NULL,
  `OC_WICKET_CREDIT_AMOUNT` double NOT NULL,
  `OC_WICKET_CREDIT_USERUID` int(10) NOT NULL,
  `OC_WICKET_CREDIT_TYPE` varchar(255) NOT NULL,
  `OC_WICKET_CREDIT_COMMENT` longtext NOT NULL,
  `OC_WICKET_CREDIT_REFERENCETYPE` varchar(255) NOT NULL,
  `OC_WICKET_CREDIT_REFERENCEUID` varchar(255) NOT NULL,
  `OC_WICKET_CREDIT_CREATETIME` datetime NOT NULL,
  `OC_WICKET_CREDIT_UPDATETIME` datetime NOT NULL,
  `OC_WICKET_CREDIT_UPDATEUID` int(10) NOT NULL,
  `OC_WICKET_CREDIT_VERSION` int(10) NOT NULL,
  `OC_WICKET_CREDIT_INVOICEUID` varchar(50) DEFAULT NULL
);

-- ----------------------------
-- Table structure for oc_wicket_debets
-- ----------------------------
CREATE TABLE `oc_wicket_debets` (
  `oc_wicket_debet_serverid` int(11) DEFAULT NULL,
  `oc_wicket_debet_objectid` int(11) DEFAULT NULL,
  `OC_WICKET_DEBET_WICKETUID` varchar(255) NOT NULL,
  `OC_WICKET_DEBET_OPERATIONDATE` datetime NOT NULL,
  `OC_WICKET_DEBET_AMOUNT` double NOT NULL,
  `OC_WICKET_DEBET_USERUID` int(10) NOT NULL,
  `OC_WICKET_DEBET_TYPE` varchar(255) NOT NULL,
  `OC_WICKET_DEBET_COMMENT` longtext NOT NULL,
  `OC_WICKET_DEBET_REFERENCETYPE` varchar(255) NOT NULL,
  `OC_WICKET_DEBET_REFERENCEUID` varchar(255) NOT NULL,
  `OC_WICKET_DEBET_CREATETIME` datetime NOT NULL,
  `OC_WICKET_DEBET_UPDATETIME` datetime NOT NULL,
  `OC_WICKET_DEBET_UPDATEUID` int(10) NOT NULL,
  `OC_WICKET_DEBET_VERSION` int(10) NOT NULL,
  KEY `OC_WICKET_DEBET_OBJECTID` (`oc_wicket_debet_objectid`)
);

-- ----------------------------
-- Table structure for oc_wicket_debets_history
-- ----------------------------
CREATE TABLE `oc_wicket_debets_history` (
  `oc_wicket_debet_serverid` int(11) DEFAULT NULL,
  `oc_wicket_debet_objectid` int(11) DEFAULT NULL,
  `OC_WICKET_DEBET_WICKETUID` varchar(255) NOT NULL,
  `OC_WICKET_DEBET_OPERATIONDATE` datetime NOT NULL,
  `OC_WICKET_DEBET_AMOUNT` double NOT NULL,
  `OC_WICKET_DEBET_USERUID` int(10) NOT NULL,
  `OC_WICKET_DEBET_TYPE` varchar(255) NOT NULL,
  `OC_WICKET_DEBET_COMMENT` longtext NOT NULL,
  `OC_WICKET_DEBET_REFERENCETYPE` varchar(255) NOT NULL,
  `OC_WICKET_DEBET_REFERENCEUID` varchar(255) NOT NULL,
  `OC_WICKET_DEBET_CREATETIME` datetime NOT NULL,
  `OC_WICKET_DEBET_UPDATETIME` datetime NOT NULL,
  `OC_WICKET_DEBET_UPDATEUID` int(10) NOT NULL,
  `OC_WICKET_DEBET_VERSION` int(10) NOT NULL
);

-- ----------------------------
-- Table structure for oc_wickets
-- ----------------------------
CREATE TABLE `oc_wickets` (
  `OC_WICKET_SERVERID` varchar(255) NOT NULL,
  `OC_WICKET_OBJECTID` varchar(255) NOT NULL,
  `OC_WICKET_BALANCE` double NOT NULL,
  `OC_WICKET_AUTHORIZEDUSERS` varchar(255) NOT NULL,
  `OC_WICKET_SERVICEUID` varchar(255) NOT NULL,
  `OC_WICKET_CREATETIME` datetime NOT NULL,
  `OC_WICKET_UPDATETIME` datetime NOT NULL,
  `OC_WICKET_UPDATEUID` int(10) NOT NULL,
  `OC_WICKET_VERSION` int(10) NOT NULL
);

-- ----------------------------
-- Table structure for oc_wickets_history
-- ----------------------------
CREATE TABLE `oc_wickets_history` (
  `OC_WICKET_SERVERID` varchar(255) NOT NULL,
  `OC_WICKET_OBJECTID` varchar(255) NOT NULL,
  `OC_WICKET_BALANCE` double NOT NULL,
  `OC_WICKET_AUTHORIZEDUSERS` varchar(255) NOT NULL,
  `OC_WICKET_SERVICEUID` varchar(255) NOT NULL,
  `OC_WICKET_CREATETIME` datetime NOT NULL,
  `OC_WICKET_UPDATETIME` datetime NOT NULL,
  `OC_WICKET_UPDATEUID` int(10) NOT NULL,
  `OC_WICKET_VERSION` int(10) NOT NULL
);

-- ----------------------------
-- Table structure for patientdiagnosis
-- ----------------------------
CREATE TABLE `patientdiagnosis` (
  `personId` int(10) DEFAULT NULL,
  `diagnose` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `beginDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  KEY `personId` (`personId`)
);

-- ----------------------------
-- Table structure for permanentitems
-- ----------------------------
CREATE TABLE `permanentitems` (
  `transactionId` int(10) NOT NULL,
  `serverid` int(10) NOT NULL,
  `itemType` varchar(255) NOT NULL,
  `ts` datetime NOT NULL,
  KEY `permanentitems_itemtype` (`itemType`),
  KEY `permanentitems_transactionid` (`transactionId`)
);

-- ----------------------------
-- Table structure for printabledocuments
-- ----------------------------
CREATE TABLE `printabledocuments` (
  `documentName` varchar(255) DEFAULT NULL,
  `documentLabelId` varchar(255) DEFAULT NULL,
  `documentModule` varchar(255) DEFAULT NULL,
  `selected` bit(1) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for report_risksummaryperunit
-- ----------------------------
CREATE TABLE `report_risksummaryperunit` (
  `personId` int(11) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `immat` varchar(20) DEFAULT NULL,
  `unit` varchar(255) DEFAULT NULL,
  `r1` char(1) DEFAULT NULL,
  `r2` char(1) DEFAULT NULL,
  `r3` char(1) DEFAULT NULL,
  `r4` char(1) DEFAULT NULL,
  `r5` char(1) DEFAULT NULL,
  `r6` char(1) DEFAULT NULL,
  `r7` char(1) DEFAULT NULL,
  `r8` char(1) DEFAULT NULL,
  `hasProfile` char(1) DEFAULT NULL
);

-- ----------------------------
-- Table structure for requestedlabanalyses
-- ----------------------------
CREATE TABLE `requestedlabanalyses` (
  `serverid` int(10) NOT NULL,
  `transactionid` int(10) NOT NULL,
  `analysiscode` varchar(50) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `resultvalue` varchar(255) DEFAULT NULL,
  `resultunit` varchar(50) DEFAULT NULL,
  `resultmodifier` varchar(50) DEFAULT NULL,
  `resultcomment` longtext,
  `resultrefmax` varchar(50) DEFAULT NULL,
  `resultrefmin` varchar(50) DEFAULT NULL,
  `resultdate` datetime DEFAULT NULL,
  `resultuserid` int(10) DEFAULT NULL,
  `patientid` int(10) DEFAULT NULL,
  `resultprovisional` varchar(1) DEFAULT NULL,
  `technicalvalidator` int(10) DEFAULT NULL,
  `technicalvalidationdatetime` datetime DEFAULT NULL,
  `finalvalidator` int(10) DEFAULT NULL,
  `finalvalidationdatetime` datetime DEFAULT NULL,
  `requestdatetime` datetime DEFAULT NULL,
  `samplereceptiondatetime` datetime DEFAULT NULL,
  `sampletakendatetime` datetime DEFAULT NULL,
  `sampler` int(10) DEFAULT NULL,
  `worklisteddatetime` datetime DEFAULT NULL,
  `objectid` int(11) DEFAULT NULL,
  KEY `request_analysiscode` (`analysiscode`),
  KEY `request_resultvalue` (`resultvalue`)
);

-- ----------------------------
-- Table structure for resultprofiles
-- ----------------------------
CREATE TABLE `resultprofiles` (
  `profileID` int(10) DEFAULT NULL,
  `profilecode` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `updateuserid` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `deletetime` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for resultprofilesanalysis
-- ----------------------------
CREATE TABLE `resultprofilesanalysis` (
  `profileID` int(10) DEFAULT NULL,
  `labID` int(10) DEFAULT NULL,
  `updateuserid` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL
);

-- ----------------------------
-- Table structure for riskcodes
-- ----------------------------
CREATE TABLE `riskcodes` (
  `id` int(10) NOT NULL,
  `code` varchar(255) NOT NULL,
  `messageKey` varchar(255) NOT NULL,
  `showDefault` int(10) DEFAULT NULL,
  `NL` varchar(255) DEFAULT NULL,
  `FR` varchar(255) DEFAULT NULL,
  `active` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `deletedate` datetime DEFAULT NULL,
  `updateuserid` int(10) DEFAULT NULL
);

-- ----------------------------
-- Table structure for riskexaminations
-- ----------------------------
CREATE TABLE `riskexaminations` (
  `riskExaminationId` int(10) NOT NULL,
  `frequency` int(10) NOT NULL,
  `tolerance` int(10) NOT NULL,
  `riskId` int(10) DEFAULT NULL,
  `examinationId` int(10) DEFAULT NULL,
  `ageGenderControl` varchar(1) DEFAULT NULL,
  `active` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for riskgroups
-- ----------------------------
CREATE TABLE `riskgroups` (
  `id` int(10) DEFAULT NULL,
  `groupType` varchar(255) DEFAULT NULL,
  `groupName` varchar(255) DEFAULT NULL,
  `linkId` varchar(50) DEFAULT NULL,
  `active` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  KEY `groups_linkid` (`linkId`),
  KEY `groups_updatetime` (`updatetime`)
);

-- ----------------------------
-- Table structure for riskprofilecontexts
-- ----------------------------
CREATE TABLE `riskprofilecontexts` (
  `profileContextId` int(10) NOT NULL,
  `itemType` varchar(255) DEFAULT NULL,
  `itemId` int(10) DEFAULT NULL,
  `profileId` int(10) DEFAULT NULL,
  KEY `riskprofilecontexts_profileid` (`profileId`)
);

-- ----------------------------
-- Table structure for riskprofileitems
-- ----------------------------
CREATE TABLE `riskprofileitems` (
  `profileItemId` int(10) NOT NULL,
  `itemType` varchar(255) DEFAULT NULL,
  `itemId` int(10) DEFAULT NULL,
  `status` int(10) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `profileId` int(10) DEFAULT NULL,
  `frequency` int(10) DEFAULT NULL,
  `tolerance` int(10) DEFAULT NULL,
  `ageGenderControl` varchar(1) DEFAULT NULL,
  KEY `riskprofileitems_profileid` (`profileId`)
);

-- ----------------------------
-- Table structure for riskprofiles
-- ----------------------------
CREATE TABLE `riskprofiles` (
  `profileId` int(10) NOT NULL,
  `dateBegin` datetime DEFAULT NULL,
  `dateEnd` datetime DEFAULT NULL,
  `personId` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `updateserverid` int(10) DEFAULT NULL,
  KEY `riskprofileitems_personid` (`personId`),
  KEY `riskprofileitems_profileId` (`personId`)
);

-- ----------------------------
-- Table structure for servers
-- ----------------------------
CREATE TABLE `servers` (
  `serverId` varchar(255) NOT NULL,
  `serverName` varchar(255) NOT NULL,
  `fromServerDirectory` varchar(255) NOT NULL,
  `toServerDirectory` varchar(255) NOT NULL,
  `updateuserid` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `deletetime` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for serviceexaminations
-- ----------------------------
CREATE TABLE `serviceexaminations` (
  `serviceid` varchar(255) NOT NULL,
  `examinationid` varchar(255) NOT NULL
);

-- ----------------------------
-- Table structure for servicegroups
-- ----------------------------
CREATE TABLE `servicegroups` (
  `serviceId` varchar(255) NOT NULL,
  `group1` varchar(255) NOT NULL,
  `group2` varchar(255) NOT NULL,
  `group3` varchar(255) NOT NULL,
  `group4` varchar(255) NOT NULL,
  `group5` varchar(255) NOT NULL
);

-- ----------------------------
-- Table structure for transactionitems
-- ----------------------------
CREATE TABLE `transactionitems` (
  `transactionTypeId` varchar(255) NOT NULL,
  `itemTypeId` varchar(255) NOT NULL,
  `defaultValue` varchar(255) DEFAULT NULL,
  `modifier` varchar(255) DEFAULT NULL,
  `priority` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  KEY `ttid` (`transactionTypeId`,`itemTypeId`)
);

-- ----------------------------
-- Table structure for transactions
-- ----------------------------
CREATE TABLE `transactions` (
  `transactionId` int(10) NOT NULL,
  `creationDate` datetime DEFAULT NULL,
  `transactionType` varchar(255) DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  `status` int(10) DEFAULT NULL,
  `healthRecordId` int(10) DEFAULT NULL,
  `userId` int(10) DEFAULT NULL,
  `serverid` int(10) DEFAULT NULL,
  `version` int(10) DEFAULT NULL,
  `versionserverid` int(10) DEFAULT NULL,
  `ts` datetime DEFAULT NULL,
  KEY `transactions_healthrecordid` (`healthRecordId`),
  KEY `transactions_transactionid` (`transactionId`),
  KEY `transactions_ts` (`ts`),
  KEY `transactions_updatetime` (`updateTime`)
);

-- ----------------------------
-- Table structure for transactionshistory
-- ----------------------------
CREATE TABLE `transactionshistory` (
  `transactionId` int(10) NOT NULL,
  `creationDate` datetime DEFAULT NULL,
  `transactionType` varchar(255) DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  `status` int(10) DEFAULT NULL,
  `healthRecordId` int(10) DEFAULT NULL,
  `userId` int(10) DEFAULT NULL,
  `serverid` int(10) DEFAULT NULL,
  `version` int(10) DEFAULT NULL,
  `versionserverid` int(10) DEFAULT NULL,
  `ts` datetime DEFAULT NULL,
  KEY `transactions_healthrecordid` (`healthRecordId`),
  KEY `transactions_transactionid` (`transactionId`)
);

-- ----------------------------
-- Table structure for workplacerisks
-- ----------------------------
CREATE TABLE `workplacerisks` (
  `riskId` int(10) DEFAULT NULL,
  `workplaceId` int(10) DEFAULT NULL,
  `active` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  KEY `workplacerisks_workplaceid` (`workplaceId`)
);

-- ----------------------------
-- Table structure for workplaces
-- ----------------------------
CREATE TABLE `workplaces` (
  `id` int(10) NOT NULL,
  `messageKey` varchar(255) NOT NULL,
  `deletedate` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `updateuserid` int(10) DEFAULT NULL,
  `NL` varchar(255) DEFAULT NULL,
  `FR` varchar(255) DEFAULT NULL,
  `active` int(10) DEFAULT NULL,
  `serviceId` varchar(255) DEFAULT NULL
);
