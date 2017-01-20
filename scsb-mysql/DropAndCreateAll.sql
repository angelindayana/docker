SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `recap`;
USE `recap` ;

DROP TABLE IF EXISTS `recap`.`REPORT_T`;
-- -----------------------------------------------------
-- Table `recap`.`REPORT_T`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `REPORT_T` (
  `RECORD_NUM`    INT  NOT NULL AUTO_INCREMENT,
  `FILE_NAME`     VARCHAR(45) NOT NULL,
  `TYPE`          VARCHAR(45) NOT NULL,
  `CREATED_DATE`  DATETIME    NOT NULL,
  `INSTITUTION_NAME` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`RECORD_NUM`),
  INDEX `FILE_NAME_idx` (`FILE_NAME` ASC),
  INDEX `TYPE_idx` (`TYPE` ASC),
  INDEX `CREATED_DATE_idx` (`CREATED_DATE` ASC),
  INDEX `INSTITUTION_NAME_idx` (`INSTITUTION_NAME` ASC)
)
  ENGINE = InnoDB;


DROP TABLE IF EXISTS `recap`.`REPORT_DATA_T`;
-- -----------------------------------------------------
-- Table `recap`.`REPORT_DATA_T`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `REPORT_DATA_T` (
  `REPORT_DATA_ID` INT         NOT NULL AUTO_INCREMENT,
  `HEADER_NAME`    VARCHAR(100) NOT NULL,
  `HEADER_VALUE`   VARCHAR(8000) NOT NULL,
  `RECORD_NUM`     INT         NULL,
  PRIMARY KEY (`REPORT_DATA_ID`),
  INDEX `RECORD_NUM_idx` (`RECORD_NUM` ASC),
  INDEX `HEADER_NAME_idx` (`HEADER_NAME` ASC)
)
  ENGINE = InnoDB;



DROP TABLE IF EXISTS `recap`.`BIBLIOGRAPHIC_T`;
-- -----------------------------------------------------
-- Table `recap`.`BIBLIOGRAPHIC_T`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recap`.`BIBLIOGRAPHIC_T` (
  `BIBLIOGRAPHIC_ID`   INT         NOT NULL AUTO_INCREMENT,
  `CONTENT`            LONGBLOB    NOT NULL,
  `OWNING_INST_ID`     INT         NOT NULL,
  `CREATED_DATE`       DATETIME    NOT NULL,
  `CREATED_BY`         VARCHAR(45) NOT NULL,
  `LAST_UPDATED_DATE`  DATETIME    NOT NULL,
  `LAST_UPDATED_BY`    VARCHAR(45) NOT NULL,
  `OWNING_INST_BIB_ID` VARCHAR(45) NOT NULL,
  `IS_DELETED`         TINYINT(1)  NOT NULL DEFAULT 0,
  `CATALOGING_STATUS` varchar(20)  DEFAULT NULL,
  PRIMARY KEY (`OWNING_INST_ID`, `OWNING_INST_BIB_ID`),
  INDEX (`OWNING_INST_ID`),
  INDEX (`OWNING_INST_BIB_ID`),
  INDEX (`CREATED_DATE`),
  INDEX (`LAST_UPDATED_DATE`),
  INDEX (`IS_DELETED`),
  KEY `BIBLIOGRAPHIC_ID` (`BIBLIOGRAPHIC_ID`),
  CONSTRAINT `BIBLIOGRAPHIC_OWNING_INST_ID_FK`
  FOREIGN KEY (`OWNING_INST_ID`)
  REFERENCES `INSTITUTION_T` (`INSTITUTION_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
  ENGINE = InnoDB;


DROP TABLE IF EXISTS `recap`.`HOLDINGS_T`;
-- -----------------------------------------------------
-- Table `recap`.`HOLDINGS_T`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HOLDINGS_T` (
  `HOLDINGS_ID`             INT          NOT NULL AUTO_INCREMENT,
  `CONTENT`                 LONGBLOB         NOT NULL,
  `CREATED_DATE`            DATETIME     NOT NULL,
  `CREATED_BY`              VARCHAR(45)  NOT NULL,
  `LAST_UPDATED_DATE`       DATETIME     NOT NULL,
  `LAST_UPDATED_BY`         VARCHAR(45)  NOT NULL,
  `OWNING_INST_ID`	        INT          NOT NULL,
  `OWNING_INST_HOLDINGS_ID` VARCHAR(100) NOT NULL,
  `IS_DELETED`              TINYINT(1)   NOT NULL DEFAULT 0,
  KEY `HOLDINGS_ID` (`HOLDINGS_ID`),
  PRIMARY KEY (`OWNING_INST_ID`, `OWNING_INST_HOLDINGS_ID`),
  INDEX (`OWNING_INST_HOLDINGS_ID`),
  INDEX (`OWNING_INST_ID`),
  INDEX (`IS_DELETED`),
  CONSTRAINT `HOLDINGS_OWNING_INST_ID_FK`
  FOREIGN KEY (`OWNING_INST_ID`)
  REFERENCES `INSTITUTION_T` (`INSTITUTION_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
  ENGINE = InnoDB;


DROP TABLE IF EXISTS `recap`.`ITEM_T`;
-- -----------------------------------------------------
-- Table `recap`.`ITEM_T`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recap`.`ITEM_T` (
  `ITEM_ID`                 INT           NOT NULL AUTO_INCREMENT,
  `BARCODE`                VARCHAR(45)   NOT NULL,
  `CUSTOMER_CODE`           VARCHAR(45)   NOT NULL,
  `CALL_NUMBER`             VARCHAR(2000) NULL,
  `CALL_NUMBER_TYPE`        VARCHAR(80)   NULL,
  `ITEM_AVAIL_STATUS_ID`    INT           NOT NULL,
  `COPY_NUMBER`             INT           NULL,
  `OWNING_INST_ID`          INT           NOT NULL,
  `COLLECTION_GROUP_ID`     INT           NOT NULL,
  `CREATED_DATE`            DATETIME      NOT NULL,
  `CREATED_BY`              VARCHAR(45)   NOT NULL,
  `LAST_UPDATED_DATE`       DATETIME      NOT NULL,
  `LAST_UPDATED_BY`         VARCHAR(45)   NOT NULL,
  `USE_RESTRICTIONS`        VARCHAR(2000) NULL,
  `VOLUME_PART_YEAR`        VARCHAR(2000) NULL,
  `OWNING_INST_ITEM_ID`     VARCHAR(45)   NOT NULL,
  `IS_DELETED`              TINYINT(1)    NOT NULL DEFAULT 0,
  `CATALOGING_STATUS`       varchar(20)  DEFAULT NULL,
  PRIMARY KEY (`OWNING_INST_ITEM_ID`, `OWNING_INST_ID`),
  KEY `ITEM_ID` (`ITEM_ID`),
  INDEX `ITEM_AVAIL_STATUS_ID_FK_idx` (`ITEM_AVAIL_STATUS_ID` ASC),
  INDEX `COLLECTION_TYPE_FK_idx` (`COLLECTION_GROUP_ID` ASC),
  INDEX `BAR_CODE_idx` (`BARCODE` ASC),
  INDEX (`IS_DELETED`),
  CONSTRAINT `ITEM_AVAIL_STATUS_ID_FK`
  FOREIGN KEY (`ITEM_AVAIL_STATUS_ID`)
  REFERENCES `recap`.`ITEM_STATUS_T` (`ITEM_STATUS_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ITEM_OWNING_INST_ID_FK`
  FOREIGN KEY (`OWNING_INST_ID`)
  REFERENCES `recap`.`INSTITUTION_T` (`INSTITUTION_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ITEM_COLLECTION_GROUP_FK`
  FOREIGN KEY (`COLLECTION_GROUP_ID`)
  REFERENCES `recap`.`COLLECTION_GROUP_T` (`COLLECTION_GROUP_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
  ENGINE = InnoDB;


DROP TABLE IF EXISTS `recap`.`BIBLIOGRAPHIC_HOLDINGS_T`;
-- -----------------------------------------------------
-- Table `recap`.`BIBLIOGRAPHIC_HOLDINGS_T`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recap`.`BIBLIOGRAPHIC_HOLDINGS_T` (
  `OWNING_INST_BIB_ID`      VARCHAR(45)  NOT NULL,
  `BIB_INST_ID`             INT          NOT NULL,
  `HOLDINGS_INST_ID`        INT          NOT NULL,
  `OWNING_INST_HOLDINGS_ID` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`OWNING_INST_BIB_ID`, `BIB_INST_ID`, `HOLDINGS_INST_ID`, `OWNING_INST_HOLDINGS_ID`),
  INDEX (`BIB_INST_ID`),
  INDEX (`OWNING_INST_BIB_ID`),
  CONSTRAINT `OWNING_INST_HOLDINGS_ID_FK`
  FOREIGN KEY (`HOLDINGS_INST_ID`, `OWNING_INST_HOLDINGS_ID`)
  REFERENCES `HOLDINGS_T` (`OWNING_INST_ID`, `OWNING_INST_HOLDINGS_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `OWNING_INST_ID_OWNING_INST_BIB_ID_FK`
  FOREIGN KEY (`BIB_INST_ID`, `OWNING_INST_BIB_ID`)
  REFERENCES `BIBLIOGRAPHIC_T` (`OWNING_INST_ID`, `OWNING_INST_BIB_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
  ENGINE = InnoDB;


DROP TABLE IF EXISTS `recap`.`BIBLIOGRAPHIC_ITEM_T`;
-- -----------------------------------------------------
-- Table `recap`.`BIBLIOGRAPHIC_ITEM_T`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `recap`.`BIBLIOGRAPHIC_ITEM_T` (
  `OWNING_INST_BIB_ID` VARCHAR(45) NOT NULL ,
  `BIB_INST_ID` INT NOT NULL ,
  `ITEM_INST_ID` INT NOT NULL ,
  `OWNING_INST_ITEM_ID` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`OWNING_INST_BIB_ID`,`BIB_INST_ID`,`ITEM_INST_ID`,`OWNING_INST_ITEM_ID`),
  CONSTRAINT `BIB_INST_ID_OWNING_INST_BIB_ID_FK`
    FOREIGN KEY (`BIB_INST_ID` , `OWNING_INST_BIB_ID`)
    REFERENCES `recap`.`BIBLIOGRAPHIC_T` (`OWNING_INST_ID` , `OWNING_INST_BIB_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ITEM_INST_ID_OWNING_INST_ITEM_ID_FK`
    FOREIGN KEY (`ITEM_INST_ID` , `OWNING_INST_ITEM_ID`)
    REFERENCES `recap`.`ITEM_T` (`OWNING_INST_ID` , `OWNING_INST_ITEM_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


DROP TABLE IF EXISTS `recap`.`ITEM_HOLDINGS_T`;
-- -----------------------------------------------------
-- Table `recap`.`ITEM_HOLDINGS_T`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recap`.`ITEM_HOLDINGS_T` (
  `OWNING_INST_HOLDINGS_ID`  VARCHAR(100) NOT NULL,
  `HOLDINGS_INST_ID`         INT          NOT NULL,
  `ITEM_INST_ID`             INT          NOT NULL,
  `OWNING_INST_ITEM_ID`      VARCHAR(45)  NOT NULL,
  PRIMARY KEY (`OWNING_INST_HOLDINGS_ID`, `HOLDINGS_INST_ID`, `ITEM_INST_ID`, `OWNING_INST_ITEM_ID`),
  CONSTRAINT `HOLDINGS_INST_ID_OWNING_INST_HOLDINGS_ID_FK`
  FOREIGN KEY (`HOLDINGS_INST_ID`, `OWNING_INST_HOLDINGS_ID`)
  REFERENCES `recap`.`HOLDINGS_T` (`OWNING_INST_ID`, `OWNING_INST_HOLDINGS_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `OWNING_INST_ITEM_ID_ITEM_INST_ID_FK`
  FOREIGN KEY (`ITEM_INST_ID`, `OWNING_INST_ITEM_ID`)
  REFERENCES `recap`.`ITEM_T` (`OWNING_INST_ID`, `OWNING_INST_ITEM_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;


DROP TABLE IF EXISTS `recap`.`XML_RECORDS_T`;
-- -----------------------------------------------------
-- Table `recap`.`XML_RECORDS_T`
-- -----------------------------------------------------
CREATE TABLE  IF NOT EXISTS `recap`.`XML_RECORDS_T` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `XML_RECORD` LONGBLOB NOT NULL,
  `XML_FILE` VARCHAR(100) NOT NULL,
  `OWNING_INST_BIB_ID` VARCHAR(45) NULL,
  `OWNING_INST` VARCHAR (10) NULL,
  `DATE_LOADED` DATETIME NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX (`XML_FILE`),
  INDEX (`OWNING_INST_BIB_ID`),
  INDEX (`OWNING_INST`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `recap`.`ETL_GFA_TEMP_T`;
-- -----------------------------------------------------
-- Table `recap`.`ETL_GFA_TEMP_T`
-- -----------------------------------------------------
 CREATE  TABLE IF NOT EXISTS `recap`.`ETL_GFA_TEMP_T`(
  `ITEM_BARCODE`  VARCHAR(45) NOT NULL,
  `CUSTOMER_CODE` VARCHAR(45) NOT NULL,
  `ITEM_STATUS`   VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ITEM_BARCODE`),
  INDEX (`ITEM_BARCODE`)
)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `recap`.`MATCHING_MATCHPOINTS_T`;

CREATE TABLE IF NOT EXISTS `MATCHING_MATCHPOINTS_T` (
 `ID`    INT  NOT NULL AUTO_INCREMENT,
 `MATCH_CRITERIA`     VARCHAR(45),
 `CRITERIA_VALUE`          VARCHAR(500),
 `CRITERIA_VALUE_COUNT`          INTEGER,
 PRIMARY KEY (`ID`),
 INDEX `MATCH_CRITERIA_idx` (`MATCH_CRITERIA` ASC),
 INDEX `CRITERIA_VALUE_idx` (`CRITERIA_VALUE` ASC),
 INDEX `CRITERIA_VALUE_COUNT_idx` (`CRITERIA_VALUE_COUNT` ASC)
)
 ENGINE = InnoDB;

DROP TABLE IF EXISTS `recap`.`MATCHING_BIB_T`;

CREATE TABLE IF NOT EXISTS `MATCHING_BIB_T` (
`ID` INT NOT NULL AUTO_INCREMENT,
`ROOT` VARCHAR(200) NOT NULL,
`BIB_ID` INT  NOT NULL,
`OWNING_INSTITUTION` VARCHAR(5),
`OWNING_INST_BIB_ID` VARCHAR(45),
`TITLE` VARCHAR(2000),
`OCLC` VARCHAR(1500),
`ISBN` VARCHAR(1500),
`ISSN` VARCHAR(1500),
`LCCN` VARCHAR(500),
`MATERIAL_TYPE` VARCHAR(45),
`MATCHING` VARCHAR(45),
PRIMARY KEY (`ID`),
INDEX `ROOT_idx` (`ROOT` ASC),
INDEX `BIB_ID_idx` (`BIB_ID` ASC),
INDEX `OWNING_INSTITUTION_idx` (`OWNING_INSTITUTION` ASC),
INDEX `OWNING_INST_BIB_ID_idx` (`OWNING_INST_BIB_ID` ASC),
INDEX `LCCN_idx` (`LCCN` ASC),
INDEX `MATERIAL_TYPE_idx` (`MATERIAL_TYPE` ASC),
INDEX `MATCHING_idx` (`MATCHING` ASC)
)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `recap`.`USER_T`;

CREATE TABLE IF NOT EXISTS `USER_T` (
  `USER_ID` INT NOT NULL AUTO_INCREMENT,
  `LOGIN_ID` VARCHAR(45) NOT NULL,
  `USER_INSTITUTION` INT NOT NULL,
  `USER_DESCRIPTION` VARCHAR(45) NOT NULL,
  `USER_EMAILID` VARCHAR(60) NULL,
  PRIMARY KEY (`USER_ID`),
  INDEX `FK_USER_T_1_IDX` (`USER_INSTITUTION` ASC, `LOGIN_ID` ASC),
  UNIQUE INDEX `USER_EMAILID_UNIQUE` (`USER_EMAILID` ASC),
  CONSTRAINT `FK_USER_T_1`
    FOREIGN KEY (`USER_INSTITUTION`)
    REFERENCES `INSTITUTION_T` (`INSTITUTION_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

ENGINE = InnoDB;

DROP TABLE IF EXISTS `recap`.`ROLES_T`;

CREATE TABLE IF NOT EXISTS `ROLES_T` (
  `ROLE_ID` INT NOT NULL AUTO_INCREMENT,
  `ROLE_NAME` VARCHAR(45) NOT NULL,
  `ROLE_DESCRIPTION` VARCHAR(80) NULL,
  PRIMARY KEY (`ROLE_ID`),
  UNIQUE INDEX `ROLE_NAME_UNIQUE` (`ROLE_NAME` ASC))

ENGINE = InnoDB;

DROP TABLE IF EXISTS `recap`.`USER_ROLE_T`;

 CREATE TABLE IF NOT EXISTS `USER_ROLE_T` (
  `USER_ID` INT NOT NULL,
  `ROLE_ID` INT NOT NULL ,
  INDEX `FK_USER_ROLE_T_1_IDX` (`USER_ID` ASC),
  INDEX `FK_USER_ROLE_T_2_IDX` (`ROLE_ID` ASC),
  CONSTRAINT `FK_USER_ROLE_T_1`
  FOREIGN KEY (`USER_ID`)
  REFERENCES `USER_T` (`USER_ID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
  CONSTRAINT `FK_USER_ROLE_T_2`
  FOREIGN KEY (`ROLE_ID`)
  REFERENCES `ROLES_T` (`ROLE_ID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION)

ENGINE = InnoDB;

DROP TABLE IF EXISTS `recap`.`PERMISSIONS_T`;

CREATE TABLE IF NOT EXISTS `PERMISSIONS_T` (
  `PERMISSION_ID` INT NOT NULL AUTO_INCREMENT,
  `PERMISSION_NAME` VARCHAR(45) NOT NULL,
  `PERMISSION_DESCRIPTION` VARCHAR(80) NULL,
  PRIMARY KEY (`PERMISSION_ID`))

ENGINE = InnoDB;

DROP TABLE IF EXISTS `recap`.`ROLE_PERMISSION_T`;

CREATE TABLE IF NOT EXISTS `ROLE_PERMISSION_T` (
  `ROLE_ID` INT NOT NULL,
  `PERMISSION_ID` INT NOT NULL,
  INDEX `FK_ROLE_PERMISSION_T_1_IDX` (`ROLE_ID` ASC),
  INDEX `FK_ROLE_PERMISSION_T_2_IDX` (`PERMISSION_ID` ASC),
  CONSTRAINT `FK_ROLE_PERMISSION_T_1`
    FOREIGN KEY (`ROLE_ID`)
    REFERENCES `ROLES_T` (`ROLE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ROLE_PERMISSION_T_2`
    FOREIGN KEY (`PERMISSION_ID`)
    REFERENCES `PERMISSIONS_T` (`PERMISSION_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
