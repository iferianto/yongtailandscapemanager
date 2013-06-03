-- ----------------------------
-- View structure for accessview
-- ----------------------------
CREATE VIEW `accessview` AS select `users`.`userid` AS `userid`,`users`.`personid` AS `personid`,`accessrights`.`accessright` AS `accessright` from (`users` join `accessrights`) where ((`users`.`start` <= now()) and ((`users`.`stop` = NULL) or (`users`.`stop` > now())) and (`users`.`userid` = `accessrights`.`userid`));

-- ----------------------------
-- View structure for adminview
-- ----------------------------
CREATE VIEW `adminview` AS select `admin`.`personid` AS `personid`,`admin`.`immatold` AS `immatold`,`admin`.`immatnew` AS `immatnew`,`admin`.`candidate` AS `candidate`,`admin`.`lastname` AS `lastname`,`admin`.`firstname` AS `firstname`,`admin`.`gender` AS `gender`,`admin`.`dateofbirth` AS `dateofbirth`,`admin`.`comment` AS `comment`,`admin`.`sourceid` AS `sourceid`,`admin`.`language` AS `language`,`admin`.`engagement` AS `engagement`,`admin`.`pension` AS `pension`,`admin`.`statute` AS `statute`,`admin`.`claimant` AS `claimant`,`admin`.`searchname` AS `searchname`,`admin`.`updatetime` AS `updatetime`,`admin`.`claimant_expiration` AS `claimant_expiration`,`admin`.`native_country` AS `native_country`,`admin`.`native_town` AS `native_town`,`admin`.`motive_end_of_service` AS `motive_end_of_service`,`admin`.`startdate_inactivity` AS `startdate_inactivity`,`admin`.`enddate_inactivity` AS `enddate_inactivity`,`admin`.`code_inactivity` AS `code_inactivity`,`admin`.`update_status` AS `update_status`,`admin`.`person_type` AS `person_type`,`admin`.`situation_end_of_service` AS `situation_end_of_service`,`admin`.`updateuserid` AS `updateuserid`,`admin`.`comment1` AS `comment1`,`admin`.`comment2` AS `comment2`,`admin`.`comment3` AS `comment3`,`admin`.`comment4` AS `comment4`,`admin`.`comment5` AS `comment5`,`admin`.`natreg` AS `natreg`,`admin`.`middlename` AS `middlename`,`admin`.`begindate` AS `begindate`,`admin`.`enddate` AS `enddate`,`admin`.`updateserverid` AS `updateserverid`,`admin`.`archiveFileCode` AS `archiveFileCode` from `admin`;

-- ----------------------------
-- View structure for functionsview
-- ----------------------------
-- CREATE VIEW `functionsview` AS select `ocadmin_dbo`.`adminfunctions`.`workid` AS `workid`,`ocadmin_dbo`.`adminfunctions`.`functionid` AS `functionid`,`ocadmin_dbo`.`adminfunctions`.`functiontype` AS `functiontype`,`labels`.`labeltype` AS `labeltype`,`labels`.`labelid` AS `labelid`,`labels`.`labelnl` AS `labelnl`,`labels`.`labelfr` AS `labelfr`,`labels`.`labelen` AS `labelen` from (`ocadmin_dbo`.`adminfunctions` join `ocadmin_dbo`.`labels`) where ((`labels`.`labeltype` = 'Function') and (`labels`.`labelid` = `ocadmin_dbo`.`adminfunctions`.`functionid`) and isnull(`ocadmin_dbo`.`adminfunctions`.`deletetime`));

-- ----------------------------
-- View structure for labels
-- ----------------------------
CREATE VIEW `labels` AS select `a`.`OC_LABEL_TYPE` AS `labeltype`,`a`.`OC_LABEL_ID` AS `labelid`,`a`.`OC_LABEL_VALUE` AS `labelnl`,`b`.`OC_LABEL_VALUE` AS `labelfr`,`c`.`OC_LABEL_VALUE` AS `labelen` from ((`openclinic_dbo`.`oc_labels` `a` join `openclinic_dbo`.`oc_labels` `b`) join `openclinic_dbo`.`oc_labels` `c`) where ((`a`.`OC_LABEL_TYPE` = `b`.`OC_LABEL_TYPE`) and (`a`.`OC_LABEL_TYPE` = `c`.`OC_LABEL_TYPE`) and (`a`.`OC_LABEL_ID` = `b`.`OC_LABEL_ID`) and (`a`.`OC_LABEL_ID` = `c`.`OC_LABEL_ID`) and (`a`.`OC_LABEL_LANGUAGE` = 'nl') and (`b`.`OC_LABEL_LANGUAGE` = 'fr') and (`c`.`OC_LABEL_LANGUAGE` = 'en'));

-- ----------------------------
-- View structure for privateview
-- ----------------------------
CREATE VIEW `privateview` AS select `adminprivate`.`privateid` AS `privateid`,`adminprivate`.`personid` AS `personid`,`adminprivate`.`start` AS `start`,`adminprivate`.`stop` AS `stop`,`adminprivate`.`comment` AS `privatecomment`,`adminprivate`.`address` AS `address`,`adminprivate`.`city` AS `city`,`adminprivate`.`zipcode` AS `zipcode`,`adminprivate`.`country` AS `country`,`adminprivate`.`telephone` AS `telephone`,`adminprivate`.`fax` AS `fax`,`adminprivate`.`email` AS `email`,`adminprivate`.`mobile` AS `mobile` from `adminprivate`;

-- ----------------------------
-- View structure for ranksview
-- ----------------------------
CREATE VIEW `ranksview` AS select `ocadmin_dbo`.`adminwork`.`workid` AS `workid`,`ocadmin_dbo`.`adminwork`.`rankid` AS `rankid`,`labels`.`labeltype` AS `labeltype`,`labels`.`labelid` AS `labelid`,`labels`.`labelnl` AS `labelnl`,`labels`.`labelfr` AS `labelfr`,`labels`.`labelen` AS `labelen` from (`ocadmin_dbo`.`adminwork` join `ocadmin_dbo`.`labels`) where ((`labels`.`labeltype` = _latin1'Rank') and (`labels`.`labelid` = `ocadmin_dbo`.`adminwork`.`rankid`));

-- ----------------------------
-- View structure for ranksview2
-- ----------------------------
CREATE VIEW `ranksview2` AS select `ocadmin_dbo`.`adminwork`.`workid` AS `workid`,`ocadmin_dbo`.`adminwork`.`personid` AS `personid`,`ocadmin_dbo`.`adminwork`.`start` AS `start`,`ocadmin_dbo`.`adminwork`.`stop` AS `stop`,`ocadmin_dbo`.`adminwork`.`rankid` AS `rankid`,`ocadmin_dbo`.`adminwork`.`telephone` AS `telephone`,`ocadmin_dbo`.`adminwork`.`fax` AS `fax`,`ocadmin_dbo`.`adminwork`.`email` AS `email`,`ocadmin_dbo`.`adminwork`.`comment` AS `comment`,`ocadmin_dbo`.`adminwork`.`updatetime` AS `updatetime`,`ocadmin_dbo`.`adminwork`.`status` AS `status`,`ocadmin_dbo`.`adminwork`.`statussituation` AS `statussituation`,`ocadmin_dbo`.`adminwork`.`category` AS `category`,`ocadmin_dbo`.`adminwork`.`companyBegin` AS `companyBegin`,`ocadmin_dbo`.`adminwork`.`companyEnd` AS `companyEnd`,`ocadmin_dbo`.`adminwork`.`companyEndReason` AS `companyEndReason`,`ocadmin_dbo`.`adminwork`.`passive` AS `passive`,`ocadmin_dbo`.`adminwork`.`functionBegin` AS `functionBegin`,`ocadmin_dbo`.`adminwork`.`functionEnd` AS `functionEnd`,`ocadmin_dbo`.`adminwork`.`updateserverid` AS `updateserverid`,`labels`.`labeltype` AS `labeltype`,`labels`.`labelid` AS `labelid`,`labels`.`labelnl` AS `labelnl`,`labels`.`labelfr` AS `labelfr`,`labels`.`labelen` AS `labelen` from (`ocadmin_dbo`.`adminwork` join `ocadmin_dbo`.`labels`) where ((`labels`.`labeltype` = _latin1'Rank') and (`labels`.`labelid` = `ocadmin_dbo`.`adminwork`.`rankid`));

-- ----------------------------
-- View structure for servicesview
-- ----------------------------
CREATE VIEW `servicesview` AS select `ocadmin_dbo`.`adminservices`.`workid` AS `workid`,`ocadmin_dbo`.`adminservices`.`serviceid` AS `serviceid`,`ocadmin_dbo`.`adminservices`.`servicetype` AS `servicetype`,`l`.`OC_LABEL_TYPE` AS `OC_LABEL_TYPE`,`l`.`OC_LABEL_ID` AS `OC_LABEL_ID`,`l`.`OC_LABEL_LANGUAGE` AS `OC_LABEL_LANGUAGE`,`l`.`OC_LABEL_VALUE` AS `OC_LABEL_VALUE` from (`ocadmin_dbo`.`adminservices` join `openclinic_dbo`.`oc_labels` `l`) where (((`l`.`OC_LABEL_TYPE` = 'Service') or (`l`.`OC_LABEL_TYPE` = 'service')) and (`l`.`OC_LABEL_ID` = `ocadmin_dbo`.`adminservices`.`serviceid`));

-- ----------------------------
-- View structure for unitgroupsview
-- ----------------------------
CREATE VIEW `unitgroupsview` AS select cast(`groups`.`linkId` as signed) AS `intLinkId`,`groups`.`id` AS `id`,`groups`.`groupType` AS `groupType`,`groups`.`groupName` AS `groupName`,`groups`.`linkId` AS `linkId`,`groups`.`active` AS `active`,`groups`.`updatetime` AS `updatetime` from `groups` where (`groups`.`active` = 1);

-- ----------------------------
-- View structure for userparametersview
-- ----------------------------
CREATE VIEW `userparametersview` AS select `userparameters`.`userid` AS `userid`,`userparameters`.`parameter` AS `parameter`,`userparameters`.`value` AS `myvalue`,`userparameters`.`updatetime` AS `updatetime`,`userparameters`.`active` AS `active` from `userparameters`;

-- ----------------------------
-- View structure for usersview
-- ----------------------------
CREATE VIEW `usersview` AS select `users`.`userid` AS `userid`,`users`.`personid` AS `personid`,`users`.`start` AS `start`,`users`.`stop` AS `stop`,`users`.`updatetime` AS `updatetime`,`users`.`project` AS `project`,`users`.`encryptedpassword` AS `encryptedpassword`,`users`.`password` AS `password` from `users`;

-- ----------------------------
-- View structure for workview
-- ----------------------------
CREATE VIEW `workview` AS select `adminwork`.`workid` AS `workid`,`adminwork`.`personid` AS `personid`,`adminwork`.`start` AS `start`,`adminwork`.`stop` AS `stop`,`adminwork`.`rankid` AS `rankid`,`adminwork`.`telephone` AS `telephone`,`adminwork`.`fax` AS `fax`,`adminwork`.`email` AS `email`,`adminwork`.`comment` AS `comment`,`adminwork`.`updatetime` AS `updatetime`,`adminwork`.`status` AS `status`,`adminwork`.`statussituation` AS `statussituation`,`adminwork`.`category` AS `category`,`adminwork`.`companyBegin` AS `companyBegin`,`adminwork`.`companyEnd` AS `companyEnd`,`adminwork`.`companyEndReason` AS `companyEndReason`,`adminwork`.`passive` AS `passive`,`adminwork`.`functionBegin` AS `functionBegin`,`adminwork`.`functionEnd` AS `functionEnd`,`adminwork`.`updateserverid` AS `updateserverid` from `adminwork`;

-- ----------------------------
-- Records 
-- ----------------------------