SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for accesslogs
-- ----------------------------
CREATE TABLE `accesslogs` (
  `userid` int(10) DEFAULT NULL,
  `accesstime` datetime DEFAULT NULL,
  `accessid` int(10) DEFAULT NULL,
  `accesscode` varchar(255) DEFAULT NULL,
  KEY `index_accessid` (`accessid`),
  KEY `index_accesscode` (`accesscode`)
);

-- ----------------------------
-- Table structure for accessrights
-- ----------------------------
CREATE TABLE `accessrights` (
  `userid` int(10) NOT NULL,
  `accessright` varchar(255) NOT NULL,
  `updatetime` datetime DEFAULT NULL,
  `active` int(10) DEFAULT NULL,
  KEY `accessrights_updatetime` (`updatetime`)
);

-- ----------------------------
-- Table structure for admin
-- ----------------------------
CREATE TABLE `admin` (
  `personid` int(10) NOT NULL,
  `immatold` varchar(25) DEFAULT NULL,
  `immatnew` varchar(25) DEFAULT NULL,
  `candidate` varchar(25) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `dateofbirth` datetime DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `sourceid` varchar(1) DEFAULT NULL,
  `language` char(2) DEFAULT NULL,
  `engagement` datetime DEFAULT NULL,
  `pension` datetime DEFAULT NULL,
  `statute` varchar(1) DEFAULT NULL,
  `claimant` varchar(1) DEFAULT NULL,
  `searchname` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `claimant_expiration` datetime DEFAULT NULL,
  `native_country` varchar(2) DEFAULT NULL,
  `native_town` varchar(255) DEFAULT NULL,
  `motive_end_of_service` varchar(3) DEFAULT NULL,
  `startdate_inactivity` datetime DEFAULT NULL,
  `enddate_inactivity` datetime DEFAULT NULL,
  `code_inactivity` varchar(3) DEFAULT NULL,
  `update_status` varchar(1) DEFAULT NULL,
  `person_type` varchar(1) DEFAULT NULL,
  `situation_end_of_service` varchar(1) DEFAULT NULL,
  `updateuserid` int(10) DEFAULT NULL,
  `comment1` varchar(100) DEFAULT NULL,
  `comment2` varchar(100) DEFAULT NULL,
  `comment3` varchar(100) DEFAULT NULL,
  `comment4` varchar(100) DEFAULT NULL,
  `comment5` varchar(100) DEFAULT NULL,
  `natreg` varchar(50) DEFAULT NULL,
  `middlename` varchar(255) DEFAULT NULL,
  `begindate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `updateserverid` int(10) DEFAULT NULL,
  `archiveFileCode` varchar(255) DEFAULT NULL,
  KEY `admin_immatnew` (`immatnew`),
  KEY `admin_immatold` (`immatold`),
  KEY `admin_natreg` (`natreg`),
  KEY `admin_personid` (`personid`),
  KEY `admin_searchname` (`searchname`),
  KEY `admin_updatetime` (`updatetime`)
);

-- ----------------------------
-- Table structure for adminextends
-- ----------------------------
CREATE TABLE `adminextends` (
  `personid` int(10) DEFAULT NULL,
  `extendid` int(10) DEFAULT NULL,
  `extendtype` varchar(255) DEFAULT NULL,
  `labelid` varchar(255) DEFAULT NULL,
  `extendvalue` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `updateuserid` int(10) DEFAULT NULL,
  `updateserverid` int(10) DEFAULT NULL,
  KEY `adminextends_personid` (`personid`),
  KEY `adminextends_updatetime` (`updatetime`)
);

-- ----------------------------
-- Table structure for adminfamilyrelation
-- ----------------------------
CREATE TABLE `adminfamilyrelation` (
  `relationid` int(10) NOT NULL,
  `sourceid` int(10) NOT NULL,
  `destinationid` int(10) NOT NULL,
  `relationtype` varchar(255) NOT NULL,
  `updatetime` datetime DEFAULT NULL,
  `updateserverid` int(10) DEFAULT NULL
);

-- ----------------------------
-- Table structure for adminfunctions
-- ----------------------------
CREATE TABLE `adminfunctions` (
  `workid` int(10) NOT NULL,
  `functionid` varchar(255) NOT NULL,
  `functiontype` varchar(1) NOT NULL,
  `updatetime` datetime DEFAULT NULL,
  `deletetime` datetime DEFAULT NULL,
  `functioncategory` varchar(255) DEFAULT NULL,
  `updateserverid` int(10) DEFAULT NULL,
  KEY `adminfunctions_updatetime` (`updatetime`),
  KEY `adminfunctions_workid` (`workid`)
);

-- ----------------------------
-- Table structure for adminhistory
-- ----------------------------
CREATE TABLE `adminhistory` (
  `personid` int(10) NOT NULL,
  `natreg` varchar(11) DEFAULT NULL,
  `immatold` varchar(25) DEFAULT NULL,
  `immatnew` varchar(25) DEFAULT NULL,
  `candidate` varchar(25) DEFAULT NULL,
  `lastname` varchar(100) NOT NULL,
  `firstname` varchar(100) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `dateofbirth` datetime DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `sourceid` varchar(1) DEFAULT NULL,
  `engagement` datetime DEFAULT NULL,
  `pension` datetime DEFAULT NULL,
  `statute` varchar(1) DEFAULT NULL,
  `claimant` varchar(1) DEFAULT NULL,
  `searchname` varchar(100) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `claimant_expiration` datetime DEFAULT NULL,
  `native_town` varchar(100) DEFAULT NULL,
  `motive_end_of_service` varchar(3) DEFAULT NULL,
  `startdate_inactivity` datetime DEFAULT NULL,
  `enddate_inactivity` datetime DEFAULT NULL,
  `code_inactivity` varchar(3) DEFAULT NULL,
  `update_status` varchar(1) DEFAULT NULL,
  `person_type` varchar(1) DEFAULT NULL,
  `situation_end_of_service` varchar(1) DEFAULT NULL,
  `updateuserid` int(10) DEFAULT NULL,
  `comment1` varchar(100) DEFAULT NULL,
  `comment2` varchar(100) DEFAULT NULL,
  `comment3` varchar(100) DEFAULT NULL,
  `comment4` varchar(100) DEFAULT NULL,
  `comment5` varchar(100) DEFAULT NULL,
  `native_country` varchar(100) DEFAULT NULL,
  `middlename` varchar(255) DEFAULT NULL,
  `begindate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `updateserverid` int(10) DEFAULT NULL,
  `language` char(2) DEFAULT NULL,
  KEY `adminhistory_immatnew` (`immatnew`),
  KEY `adminhistory_immatold` (`immatold`),
  KEY `adminhistory_natreg` (`natreg`),
  KEY `adminhistory_personid` (`personid`),
  KEY `adminhistory_searchname` (`searchname`),
  KEY `adminhistory_updatetime` (`updatetime`)
);

-- ----------------------------
-- Table structure for adminphysicians
-- ----------------------------
CREATE TABLE `adminphysicians` (
  `personid` int(10) NOT NULL,
  `PhysicianLastname` varchar(255) DEFAULT NULL,
  `PhysicianFirstname` varchar(255) DEFAULT NULL,
  `PhysicianAddress` varchar(255) DEFAULT NULL,
  `PhysicianZipcode` varchar(255) DEFAULT NULL,
  `PhysicianCity` varchar(255) DEFAULT NULL,
  `PhysicianPhone` varchar(255) DEFAULT NULL,
  `PhysicianSendReport` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `updateuserid` int(10) DEFAULT NULL,
  KEY `admin_personid` (`personid`)
);

-- ----------------------------
-- Table structure for adminprivate
-- ----------------------------
CREATE TABLE `adminprivate` (
  `privateid` int(10) NOT NULL,
  `personid` int(10) NOT NULL,
  `start` datetime NOT NULL,
  `stop` datetime DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `zipcode` varchar(25) DEFAULT NULL,
  `country` varchar(2) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `updateserverid` int(10) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `sanitarydistrict` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `sector` varchar(255) DEFAULT NULL,
  `cell` varchar(255) DEFAULT NULL,
  `quarter` varchar(255) DEFAULT NULL,
  `business` varchar(255) DEFAULT NULL,
  `businessfunction` varchar(255) DEFAULT NULL,
  KEY `adminprivate_personid` (`personid`),
  KEY `adminprivate_privateid` (`privateid`),
  KEY `adminprivate_updatetime` (`updatetime`)
);

-- ----------------------------
-- Table structure for adminservices
-- ----------------------------
CREATE TABLE `adminservices` (
  `workid` int(10) NOT NULL,
  `serviceid` varchar(255) NOT NULL,
  `servicetype` varchar(1) NOT NULL,
  `updatetime` datetime DEFAULT NULL,
  `updateserverid` int(10) DEFAULT NULL,
  KEY `adminservices_updatetime` (`updatetime`),
  KEY `adminservices_workid` (`workid`)
);

-- ----------------------------
-- Table structure for adminsocsec
-- ----------------------------
CREATE TABLE `adminsocsec` (
  `socsecid` int(10) DEFAULT NULL,
  `personid` int(10) DEFAULT NULL,
  `covered` varchar(255) DEFAULT NULL,
  `enterprise` varchar(255) DEFAULT NULL,
  `assurancenumber` varchar(255) DEFAULT NULL,
  `assurancetype` varchar(255) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `stop` datetime DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `updateserverid` int(10) DEFAULT NULL,
  KEY `personid` (`personid`),
  KEY `updatetime` (`updatetime`)
);

-- ----------------------------
-- Table structure for adminwork
-- ----------------------------
CREATE TABLE `adminwork` (
  `workid` int(10) NOT NULL,
  `personid` int(10) NOT NULL,
  `start` datetime NOT NULL,
  `stop` datetime DEFAULT NULL,
  `rankid` varchar(255) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `statussituation` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `companyBegin` datetime DEFAULT NULL,
  `companyEnd` datetime DEFAULT NULL,
  `companyEndReason` varchar(255) DEFAULT NULL,
  `passive` varchar(255) DEFAULT NULL,
  `functionBegin` datetime DEFAULT NULL,
  `functionEnd` datetime DEFAULT NULL,
  `updateserverid` int(10) DEFAULT NULL,
  KEY `adminwork_personid` (`personid`),
  KEY `adminwork_startstop` (`start`,`stop`),
  KEY `adminwork_updatetime` (`updatetime`),
  KEY `adminwork_workid` (`workid`)
);

-- ----------------------------
-- Table structure for albaniazipcodes
-- ----------------------------
CREATE TABLE `albaniazipcodes` (
  `zipcode` varchar(10) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  KEY `rwandazip_zipcode` (`zipcode`),
  KEY `rwandazip_district` (`district`)
);

-- ----------------------------
-- Table structure for alternateid
-- ----------------------------
CREATE TABLE `alternateid` (
  `personid` int(10) NOT NULL,
  `alternateid` varchar(255) NOT NULL,
  KEY `alternateid_personid` (`personid`)
);

-- ----------------------------
-- Table structure for bangladeshzipcodes
-- ----------------------------
CREATE TABLE `bangladeshzipcodes` (
  `zipcode` varchar(10) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  KEY `rwandazip_zipcode` (`zipcode`),
  KEY `rwandazip_district` (`district`)
);

-- ----------------------------
-- Table structure for belgiumzipcodes
-- ----------------------------
CREATE TABLE `belgiumzipcodes` (
  `zipcode` varchar(10) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  KEY `rwandazip_zipcode` (`zipcode`),
  KEY `rwandazip_district` (`district`),
  KEY `belgiumzip_zipcode` (`zipcode`),
  KEY `belgiumzip_district` (`district`)
);

-- ----------------------------
-- Table structure for brazilzipcodes
-- ----------------------------
CREATE TABLE `brazilzipcodes` (
  `zipcode` varchar(10) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  KEY `rwandazip_zipcode` (`zipcode`),
  KEY `rwandazip_district` (`district`)
);

-- ----------------------------
-- Table structure for burundizipcodes
-- ----------------------------
CREATE TABLE `burundizipcodes` (
  `zipcode` varchar(10) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  KEY `burundizip_zipcode` (`zipcode`),
  KEY `burundizip_district` (`district`)
);

-- ----------------------------
-- Table structure for categories
-- ----------------------------
CREATE TABLE `categories` (
  `categoryid` varchar(50) DEFAULT NULL,
  `categoryparentid` varchar(50) DEFAULT NULL,
  `updateuserid` int(11) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for counters
-- ----------------------------
CREATE TABLE `counters` (
  `name` varchar(255) NOT NULL,
  `counter` int(10) NOT NULL,
  KEY `counters_name` (`name`)
);

-- ----------------------------
-- Table structure for deleted
-- ----------------------------
CREATE TABLE `deleted` (
  `ow_tablename` varchar(255) DEFAULT NULL,
  `ow_primarykey` varchar(255) DEFAULT NULL,
  `ow_primarykey_value` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  KEY `deleted_updatetime` (`updatetime`)
);

-- ----------------------------
-- Table structure for documents
-- ----------------------------
CREATE TABLE `documents` (
  `documentid` int(10) NOT NULL,
  `personid` int(10) NOT NULL,
  `folderid` int(10) NOT NULL,
  `author` varchar(255) DEFAULT NULL,
  `date` datetime NOT NULL,
  `title` varchar(255) NOT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `mimetype` varchar(255) DEFAULT NULL
);

-- ----------------------------
-- Table structure for drczipcodes
-- ----------------------------
CREATE TABLE `drczipcodes` (
  `zipcode` varchar(10) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  KEY `drc_zipcode` (`zipcode`),
  KEY `drczip_zipcode` (`zipcode`),
  KEY `drczip_district` (`district`)
);

-- ----------------------------
-- Table structure for emaildestinations
-- ----------------------------
CREATE TABLE `emaildestinations` (
  `destinationid` int(10) DEFAULT NULL,
  `destinationlabel` varchar(255) DEFAULT NULL,
  `destinationemail` varchar(255) DEFAULT NULL,
  `destinationuserids` varchar(255) DEFAULT NULL,
  `updateuserid` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  KEY `emaildestinations_updatetime` (`updatetime`)
);

-- ----------------------------
-- Table structure for emails
-- ----------------------------
CREATE TABLE `emails` (
  `emailid` int(10) DEFAULT NULL,
  `senderid` int(10) DEFAULT NULL,
  `senderemail` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `senderdate` datetime DEFAULT NULL,
  `receiverid` int(10) DEFAULT NULL,
  `receiveremail` varchar(255) DEFAULT NULL,
  `receiverdate` datetime DEFAULT NULL,
  `senderreaddate` datetime DEFAULT NULL,
  `toemail` varchar(255) DEFAULT NULL,
  `receivername` varchar(255) DEFAULT NULL,
  `archivedate` datetime DEFAULT NULL,
  `sendermessage` longblob,
  `receivermessage` longblob,
  `receivermail` varchar(255) DEFAULT NULL
);

-- ----------------------------
-- Table structure for epsservices
-- ----------------------------
CREATE TABLE `epsservices` (
  `EPSID` int(10) NOT NULL,
  `serviceid` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `updateuserid` int(10) DEFAULT NULL,
  `deletedate` datetime DEFAULT NULL,
  KEY `serviceid` (`serviceid`)
);

-- ----------------------------
-- Table structure for externalpreventionservices
-- ----------------------------
CREATE TABLE `externalpreventionservices` (
  `EPSID` int(10) NOT NULL,
  `EPSName` varchar(255) DEFAULT NULL,
  `EPSAddress` varchar(255) DEFAULT NULL,
  `EPSZipcode` varchar(255) DEFAULT NULL,
  `EPSCity` varchar(255) DEFAULT NULL,
  `EPSPhone` varchar(255) DEFAULT NULL,
  `EPSFax` varchar(255) DEFAULT NULL,
  `EPSPhysicianLastname` varchar(255) DEFAULT NULL,
  `EPSPhysicianFirstname` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `updateuserid` int(10) DEFAULT NULL,
  `deletedate` datetime DEFAULT NULL,
  KEY `epsid` (`EPSID`)
);

-- ----------------------------
-- Table structure for groups
-- ----------------------------
CREATE TABLE `groups` (
  `id` int(10) NOT NULL,
  `groupType` varchar(255) NOT NULL,
  `groupName` varchar(255) NOT NULL,
  `linkId` varchar(255) DEFAULT NULL,
  `active` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  KEY `groups_linkid` (`linkId`),
  KEY `groups_updatetime` (`updatetime`)
);

-- ----------------------------
-- Table structure for intrusionattempts
-- ----------------------------
CREATE TABLE `intrusionattempts` (
  `intruderID` varchar(255) NOT NULL,
  `intrusionCount` int(10) DEFAULT NULL,
  `blocked` varchar(1) DEFAULT NULL,
  `releaseTime` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for ivorycoastzipcodes
-- ----------------------------
CREATE TABLE `ivorycoastzipcodes` (
  `zipcode` varchar(18) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `sector` varchar(255) DEFAULT NULL,
  KEY `rwandazip_zipcode` (`zipcode`),
  KEY `malizip_zipcode` (`zipcode`),
  KEY `malizip_district` (`district`)
);

-- ----------------------------
-- Table structure for kenyazipcodes
-- ----------------------------
CREATE TABLE `kenyazipcodes` (
  `zipcode` varchar(10) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  KEY `rwandazip_zipcode` (`zipcode`),
  KEY `rwandazip_district` (`district`)
);

-- ----------------------------
-- Table structure for malizipcodes
-- ----------------------------
CREATE TABLE `malizipcodes` (
  `zipcode` varchar(18) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `sector` varchar(255) DEFAULT NULL,
  KEY `rwandazip_zipcode` (`zipcode`),
  KEY `malizip_zipcode` (`zipcode`),
  KEY `malizip_district` (`district`)
);

-- ----------------------------
-- Table structure for medicalcenters
-- ----------------------------
CREATE TABLE `medicalcenters` (
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `zipcode` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL
);

-- ----------------------------
-- Table structure for menu
-- ----------------------------
CREATE TABLE `menu` (
  `menuId` int(10) NOT NULL,
  `menuParentId` varchar(255) DEFAULT NULL,
  `labelId` varchar(255) DEFAULT NULL,
  `menuProjects` varchar(255) DEFAULT NULL,
  `menuPermissions` varchar(255) DEFAULT NULL,
  `deletedate` datetime DEFAULT NULL,
  `updateuserid` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for mergepersons
-- ----------------------------
CREATE TABLE `mergepersons` (
  `sourcePersonId` int(10) NOT NULL,
  `targetPersonId` int(10) NOT NULL,
  `updatetime` datetime NOT NULL
);

-- ----------------------------
-- Table structure for nozipcodes
-- ----------------------------
CREATE TABLE `nozipcodes` (
  `zipcode` varchar(10) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  KEY `nozip_zipcode` (`zipcode`),
  KEY `nozip_district` (`district`)
);

-- ----------------------------
-- Table structure for patients
-- ----------------------------
CREATE TABLE `patients` (
  `patient` int(11) NOT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `dateofbirth` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for personnel
-- ----------------------------
CREATE TABLE `personnel` (
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for providers
-- ----------------------------
CREATE TABLE `providers` (
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for rwandazipcodes
-- ----------------------------
CREATE TABLE `rwandazipcodes` (
  `zipcode` varchar(10) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  KEY `rwandazip_zipcode` (`zipcode`),
  KEY `rwandazip_district` (`district`)
);

-- ----------------------------
-- Table structure for services
-- ----------------------------
CREATE TABLE `services` (
  `serviceid` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `zipcode` varchar(10) DEFAULT NULL,
  `country` varchar(2) DEFAULT NULL,
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
  `defaultservicestockuid` varchar(255) DEFAULT NULL,
  `wicket` int(10) DEFAULT NULL,
  `totalbeds` int(10) DEFAULT NULL,
  `inactive` int(11) DEFAULT NULL,
  `costcenter` varchar(50) DEFAULT NULL,
  `acceptsVisits` int(11) DEFAULT NULL,
  `performeruid` varchar(50) DEFAULT NULL,
  `stayprestationuid` varchar(50) DEFAULT NULL,
  KEY `services_serviceid` (`serviceid`),
  KEY `services_updatetime` (`updatetime`),
  KEY `services_zipcode` (`zipcode`)
);

-- ----------------------------
-- Table structure for srilankazipcodes
-- ----------------------------
CREATE TABLE `srilankazipcodes` (
  `zipcode` varchar(10) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  KEY `rwandazip_zipcode` (`zipcode`),
  KEY `rwandazip_district` (`district`)
);

-- ----------------------------
-- Table structure for tanzaniazipcodes
-- ----------------------------
CREATE TABLE `tanzaniazipcodes` (
  `zipcode` varchar(10) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  KEY `rwandazip_zipcode` (`zipcode`),
  KEY `rwandazip_district` (`district`),
  KEY `tanzaniazip_zipcode` (`zipcode`),
  KEY `tanzaniazip_district` (`district`)
);

-- ----------------------------
-- Table structure for ugandazipcodes
-- ----------------------------
CREATE TABLE `ugandazipcodes` (
  `zipcode` varchar(10) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  KEY `rwandazip_zipcode` (`zipcode`),
  KEY `rwandazip_district` (`district`)
);

-- ----------------------------
-- Table structure for usermessages
-- ----------------------------
CREATE TABLE `usermessages` (
  `userid` int(10) NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  KEY `usermessages_userid` (`userid`)
);

-- ----------------------------
-- Table structure for userparameters
-- ----------------------------
CREATE TABLE `userparameters` (
  `userid` int(10) NOT NULL,
  `parameter` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `active` int(10) DEFAULT NULL,
  KEY `userpars_updatetime` (`updatetime`),
  KEY `userpars_userid_parameter` (`userid`,`parameter`)
);

-- ----------------------------
-- Table structure for userprofilemotivations
-- ----------------------------
CREATE TABLE `userprofilemotivations` (
  `userid` int(10) DEFAULT NULL,
  `patientid` int(10) DEFAULT NULL,
  `updatetime` datetime NOT NULL,
  `motivation` varchar(255) DEFAULT NULL,
  `screenid` varchar(255) DEFAULT NULL,
  KEY `userproms_updatetime` (`updatetime`),
  KEY `userproms_userid_parameter` (`userid`)
);

-- ----------------------------
-- Table structure for userprofilepermissions
-- ----------------------------
CREATE TABLE `userprofilepermissions` (
  `userprofileid` int(10) DEFAULT NULL,
  `screenid` varchar(255) DEFAULT NULL,
  `permission` varchar(255) DEFAULT NULL,
  `active` int(10) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for userprofiles
-- ----------------------------
CREATE TABLE `userprofiles` (
  `userprofileid` int(10) DEFAULT NULL,
  `userprofilename` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for users
-- ----------------------------
CREATE TABLE `users` (
  `userid` int(10) DEFAULT NULL,
  `personid` int(10) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `stop` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `project` varchar(255) DEFAULT NULL,
  `encryptedpassword` longblob,
  `password` varchar(255) DEFAULT NULL,
  KEY `users_personid` (`personid`),
  KEY `users_userid` (`userid`)
);

-- ----------------------------
-- Table structure for userservices
-- ----------------------------
CREATE TABLE `userservices` (
  `userid` int(10) DEFAULT NULL,
  `serviceid` varchar(255) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `activeservice` int(10) DEFAULT NULL
);

-- ----------------------------
-- Table structure for zipcodes
-- ----------------------------
CREATE TABLE `zipcodes` (
  `zipcode` varchar(255) DEFAULT NULL,
  `citynl` varchar(255) DEFAULT NULL,
  `cityfr` varchar(255) DEFAULT NULL,
  `cityen` varchar(255) DEFAULT NULL
);