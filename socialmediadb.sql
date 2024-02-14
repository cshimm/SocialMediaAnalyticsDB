-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb3 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`city` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `city_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`city_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`country` (
  `country_id` INT NOT NULL AUTO_INCREMENT,
  `country_name` VARCHAR(45) NOT NULL,
  `country_code` INT NULL DEFAULT NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`education_level`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`education_level` (
  `education_level_id` INT NOT NULL AUTO_INCREMENT,
  `education_level` VARCHAR(45) NULL,
  PRIMARY KEY (`education_level_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`gender`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`gender` (
  `gender_id` INT NOT NULL AUTO_INCREMENT,
  `gender_name` VARCHAR(45) NULL,
  PRIMARY KEY (`gender_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`gender_lookup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`gender_lookup` (
  `gender_code` INT NOT NULL AUTO_INCREMENT,
  `gender_id` INT NULL,
  `gender_abbr` VARCHAR(45) NULL,
  INDEX `gl_gender_id_idx` (`gender_id` ASC) VISIBLE,
  PRIMARY KEY (`gender_code`),
  CONSTRAINT `gl_gender_id`
    FOREIGN KEY (`gender_id`)
    REFERENCES `mydb`.`gender` (`gender_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`person` (
  `person_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `date_of_birth` DATE NULL DEFAULT NULL,
  `gender_code` INT NULL DEFAULT NULL,
  `ecucation_level` INT NULL,
  PRIMARY KEY (`person_id`),
  INDEX `p_education_level_id_idx` (`ecucation_level` ASC) VISIBLE,
  INDEX `p_gender_code_idx` (`gender_code` ASC) VISIBLE,
  CONSTRAINT `p_education_level_id`
    FOREIGN KEY (`ecucation_level`)
    REFERENCES `mydb`.`education_level` (`education_level_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `p_gender_code`
    FOREIGN KEY (`gender_code`)
    REFERENCES `mydb`.`gender_lookup` (`gender_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`state`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`state` (
  `state_id` INT NOT NULL AUTO_INCREMENT,
  `state_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`state_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `person_id` INT NULL DEFAULT NULL,
  `street_address` VARCHAR(45) NULL DEFAULT NULL,
  `apt_num` INT NULL DEFAULT NULL,
  `zip_code` INT NULL DEFAULT NULL,
  `cityID` INT NULL DEFAULT NULL,
  `countryID` INT NULL DEFAULT NULL,
  `StateID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `a_person_id_idx` (`person_id` ASC) VISIBLE,
  INDEX `a_city_id_idx` (`cityID` ASC) VISIBLE,
  INDEX `a_state_id_idx` (`StateID` ASC) INVISIBLE,
  INDEX `a_country_id_idx` (`countryID` ASC) VISIBLE,
  CONSTRAINT `a_city_id`
    FOREIGN KEY (`cityID`)
    REFERENCES `mydb`.`city` (`city_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `a_country_id`
    FOREIGN KEY (`countryID`)
    REFERENCES `mydb`.`country` (`country_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `a_person_id`
    FOREIGN KEY (`person_id`)
    REFERENCES `mydb`.`person` (`person_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `a_state_id`
    FOREIGN KEY (`StateID`)
    REFERENCES `mydb`.`state` (`state_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`social_platform`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`social_platform` (
  `social_platform_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`social_platform_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`SM_data_feed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SM_data_feed` (
  `data_feed_id` INT NOT NULL AUTO_INCREMENT,
  `SMUID` INT NULL,
  `event_id` INT NULL,
  `evcatcodes` VARCHAR(45) NULL,
  `timeonevent` VARCHAR(45) NULL,
  `ip_address` VARCHAR(45) NULL,
  `location` VARCHAR(45) NULL,
  `device` VARCHAR(400) NULL,
  `mentions` VARCHAR(400) NULL,
  `hashtags` VARCHAR(400) NULL,
  `content` VARCHAR(400) NULL,
  PRIMARY KEY (`data_feed_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`social_account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`social_account` (
  `social_account_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NULL DEFAULT NULL,
  `person_id` INT NULL DEFAULT NULL,
  `social_platform_id` INT NULL DEFAULT NULL,
  `SMUID` INT NULL,
  PRIMARY KEY (`social_account_id`),
  INDEX `person_id_idx` (`person_id` ASC) VISIBLE,
  INDEX `platform_id_idx` (`social_platform_id` ASC) VISIBLE,
  INDEX `sa_SMUID_idx` (`SMUID` ASC) VISIBLE,
  CONSTRAINT `sa_person_id`
    FOREIGN KEY (`person_id`)
    REFERENCES `mydb`.`person` (`person_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `sa_platform_id`
    FOREIGN KEY (`social_platform_id`)
    REFERENCES `mydb`.`social_platform` (`social_platform_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `sa_SMUID`
    FOREIGN KEY (`SMUID`)
    REFERENCES `mydb`.`SM_data_feed` (`SMUID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`device_make`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`device_make` (
  `device_make_id` INT NOT NULL AUTO_INCREMENT,
  `make_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`device_make_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`device_model`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`device_model` (
  `device_model_id` INT NOT NULL AUTO_INCREMENT,
  `make_id` INT NULL DEFAULT NULL,
  `model_name` VARCHAR(45) NULL DEFAULT NULL,
  `model_year` YEAR(4) NULL,
  PRIMARY KEY (`device_model_id`),
  INDEX `dm_make_id_idx` (`make_id` ASC) VISIBLE,
  CONSTRAINT `dm_make_id`
    FOREIGN KEY (`make_id`)
    REFERENCES `mydb`.`device_make` (`device_make_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`device`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`device` (
  `device_id` INT NOT NULL AUTO_INCREMENT,
  `ip_address` VARCHAR(45) NULL DEFAULT NULL,
  `model_id` INT NULL DEFAULT NULL,
  `account_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`device_id`),
  INDEX `dev_account_id_idx` (`account_id` ASC) VISIBLE,
  INDEX `dev_model_id_idx` (`model_id` ASC) VISIBLE,
  CONSTRAINT `dev_account_id`
    FOREIGN KEY (`account_id`)
    REFERENCES `mydb`.`social_account` (`social_account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `dev_model_id`
    FOREIGN KEY (`model_id`)
    REFERENCES `mydb`.`device_model` (`device_model_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`email`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`email` (
  `email_id` INT NOT NULL AUTO_INCREMENT,
  `person_id` INT NULL DEFAULT NULL,
  `email_address` VARCHAR(60) NULL DEFAULT NULL,
  PRIMARY KEY (`email_id`),
  INDEX `e_person_id_idx` (`person_id` ASC) VISIBLE,
  CONSTRAINT `e_person_id`
    FOREIGN KEY (`person_id`)
    REFERENCES `mydb`.`person` (`person_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`event_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`event_type` (
  `event_type_id` INT NOT NULL AUTO_INCREMENT,
  `event_name` VARCHAR(45) NULL,
  PRIMARY KEY (`event_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`location` (
  `location_id` INT NOT NULL AUTO_INCREMENT,
  `location_name` VARCHAR(45) NULL,
  `social_account_id` INT NULL,
  `city_id` INT NULL,
  PRIMARY KEY (`location_id`),
  INDEX `location_SA_fk_idx` (`social_account_id` ASC) VISIBLE,
  INDEX `location_city_fk_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `location_SA_fk`
    FOREIGN KEY (`social_account_id`)
    REFERENCES `mydb`.`social_account` (`social_account_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `location_city_fk`
    FOREIGN KEY (`city_id`)
    REFERENCES `mydb`.`city` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ip_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ip_address` (
  `ip_address_id` INT NOT NULL AUTO_INCREMENT,
  `ip_address` VARCHAR(45) NULL,
  `location_id` INT NULL,
  PRIMARY KEY (`ip_address_id`),
  INDEX `ip_location_fk_idx` (`location_id` ASC) INVISIBLE,
  CONSTRAINT `ip_location_fk`
    FOREIGN KEY (`location_id`)
    REFERENCES `mydb`.`location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`device_event_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`device_event_log` (
  `device_event_id` INT NOT NULL AUTO_INCREMENT,
  `device_id` INT NULL DEFAULT NULL,
  `event_time` DATETIME NOT NULL,
  `ip_address_id` INT NULL,
  `event_type_id` INT NULL,
  PRIMARY KEY (`device_event_id`),
  INDEX `li_device_id_idx` (`device_id` ASC) VISIBLE,
  INDEX `event_type_idx` (`event_type_id` ASC) VISIBLE,
  INDEX `event_log_ip_idx` (`ip_address_id` ASC) VISIBLE,
  CONSTRAINT `event_device_id`
    FOREIGN KEY (`device_id`)
    REFERENCES `mydb`.`device` (`device_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `event_type_log`
    FOREIGN KEY (`event_type_id`)
    REFERENCES `mydb`.`event_type` (`event_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `event_log_ip`
    FOREIGN KEY (`ip_address_id`)
    REFERENCES `mydb`.`ip_address` (`ip_address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`phone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`phone` (
  `phone_id` INT NOT NULL AUTO_INCREMENT,
  `person_id` INT NULL DEFAULT NULL,
  `country_code` INT NULL DEFAULT NULL,
  `phone_num` INT NULL DEFAULT NULL,
  PRIMARY KEY (`phone_id`),
  INDEX `p_person_id_idx` (`person_id` ASC) VISIBLE,
  CONSTRAINT `p_person_id`
    FOREIGN KEY (`person_id`)
    REFERENCES `mydb`.`person` (`person_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `price` VARCHAR(45) NOT NULL,
  `recurring` TINYINT NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`purchase`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`purchase` (
  `purchase_id` INT NOT NULL AUTO_INCREMENT,
  `event_time` DATETIME NULL DEFAULT NULL,
  `seller_acc_id` INT NULL DEFAULT NULL,
  `buyer_acc_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`purchase_id`),
  INDEX `pur_buyer_id_idx` (`buyer_acc_id` ASC) VISIBLE,
  INDEX `pur_seller_id_idx` (`seller_acc_id` ASC) VISIBLE,
  CONSTRAINT `pur_buyer_id`
    FOREIGN KEY (`buyer_acc_id`)
    REFERENCES `mydb`.`social_account` (`social_account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pur_seller_id`
    FOREIGN KEY (`seller_acc_id`)
    REFERENCES `mydb`.`social_account` (`social_account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`purchase_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`purchase_products` (
  `purchase_products_id` INT NOT NULL AUTO_INCREMENT,
  `qty` INT NULL DEFAULT NULL,
  `product_id` INT NULL DEFAULT NULL,
  `purchase_id` INT NULL,
  PRIMARY KEY (`purchase_products_id`),
  INDEX `pp_product_id_idx` (`product_id` ASC) VISIBLE,
  INDEX `pp_purchase_id_idx` (`purchase_id` ASC) VISIBLE,
  CONSTRAINT `pp_product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `mydb`.`product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pp_purchase_id`
    FOREIGN KEY (`purchase_id`)
    REFERENCES `mydb`.`purchase` (`purchase_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`event_nature`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`event_nature` (
  `event_nature_id` INT NOT NULL AUTO_INCREMENT,
  `event_nature_name` VARCHAR(45) NULL,
  PRIMARY KEY (`event_nature_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`social_event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`social_event` (
  `social_event_id` INT NOT NULL AUTO_INCREMENT,
  `account_id` INT NULL DEFAULT NULL,
  `content` VARCHAR(400) NULL DEFAULT NULL,
  `event_time` DATETIME NULL DEFAULT NULL,
  `event_type_id` INT NULL,
  `event_nature_id` INT NULL,
  PRIMARY KEY (`social_event_id`),
  INDEX `sp_account_id_idx` (`account_id` ASC) VISIBLE,
  INDEX `event_type_idx` (`event_type_id` ASC) VISIBLE,
  INDEX `event_nature_idx` (`event_nature_id` ASC) VISIBLE,
  CONSTRAINT `sp_account_id`
    FOREIGN KEY (`account_id`)
    REFERENCES `mydb`.`social_account` (`social_account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `event_type_social`
    FOREIGN KEY (`event_type_id`)
    REFERENCES `mydb`.`event_type` (`event_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `event_nature`
    FOREIGN KEY (`event_nature_id`)
    REFERENCES `mydb`.`event_nature` (`event_nature_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`political_party`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`political_party` (
  `political_party_id` INT NOT NULL AUTO_INCREMENT,
  `party_name` VARCHAR(45) NULL,
  PRIMARY KEY (`political_party_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`occupation_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`occupation_status` (
  `occupation_status_id` INT NOT NULL,
  `occupation_status_name` VARCHAR(45) NULL,
  PRIMARY KEY (`occupation_status_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`occupation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`occupation` (
  `occupation_id` INT NOT NULL,
  `person_id` INT NULL,
  `occupation_name` VARCHAR(45) NULL,
  `occupation_status_id` INT NULL,
  PRIMARY KEY (`occupation_id`),
  INDEX `person_occupation_idx` (`person_id` ASC) VISIBLE,
  INDEX `occupation_status_idx` (`occupation_status_id` ASC) VISIBLE,
  CONSTRAINT `person_occupation`
    FOREIGN KEY (`person_id`)
    REFERENCES `mydb`.`person` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `occupation_status`
    FOREIGN KEY (`occupation_status_id`)
    REFERENCES `mydb`.`occupation_status` (`occupation_status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`hashtags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`hashtags` (
  `hashtag_id` INT NOT NULL AUTO_INCREMENT,
  `hashtag_name` VARCHAR(45) NULL,
  PRIMARY KEY (`hashtag_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`political_affiliation_lookup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`political_affiliation_lookup` (
  `affialiation_code` INT NOT NULL,
  `political_party_id` INT NULL,
  PRIMARY KEY (`affialiation_code`),
  INDEX `pal_political_party_idx` (`political_party_id` ASC) VISIBLE,
  CONSTRAINT `pal_political_party`
    FOREIGN KEY (`political_party_id`)
    REFERENCES `mydb`.`political_party` (`political_party_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`view_intensity_lookup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`view_intensity_lookup` (
  `intensity_code` INT NOT NULL,
  `intensity_nickname` VARCHAR(45) NULL,
  PRIMARY KEY (`intensity_code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`political_preference`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`political_preference` (
  `political_preference_id` INT NOT NULL AUTO_INCREMENT,
  `person_id` INT NULL,
  `political_affiliation_code` INT NULL,
  `intensity` INT NULL,
  `event_time` DATETIME NULL,
  PRIMARY KEY (`political_preference_id`),
  INDEX `ppref_person_id_idx` (`person_id` ASC) VISIBLE,
  INDEX `ppref_political_party_id_idx` (`political_affiliation_code` ASC) VISIBLE,
  INDEX `ppref_intensity_level_idx` (`intensity` ASC) VISIBLE,
  CONSTRAINT `ppref_person_id`
    FOREIGN KEY (`person_id`)
    REFERENCES `mydb`.`person` (`person_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ppref_political_party_id`
    FOREIGN KEY (`political_affiliation_code`)
    REFERENCES `mydb`.`political_affiliation_lookup` (`affialiation_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ppref_intensity_level`
    FOREIGN KEY (`intensity`)
    REFERENCES `mydb`.`view_intensity_lookup` (`intensity_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`religion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`religion` (
  `religion_id` INT NOT NULL AUTO_INCREMENT,
  `religion_name` VARCHAR(45) NULL,
  PRIMARY KEY (`religion_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`religious_affiliation_lookup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`religious_affiliation_lookup` (
  `affiliation_code` INT NOT NULL AUTO_INCREMENT,
  `religion_id` INT NULL,
  PRIMARY KEY (`affiliation_code`),
  INDEX `ral_religion_id_idx` (`religion_id` ASC) VISIBLE,
  CONSTRAINT `ral_religion_id`
    FOREIGN KEY (`religion_id`)
    REFERENCES `mydb`.`religion` (`religion_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`religious_identity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`religious_identity` (
  `religious_identity_id` INT NOT NULL AUTO_INCREMENT,
  `person_id` INT NULL,
  `affiliation_lookup_code` INT NULL,
  `intensity` INT NULL,
  `timestamp` DATETIME NULL,
  PRIMARY KEY (`religious_identity_id`),
  INDEX `ppref_person_id_idx` (`person_id` ASC) VISIBLE,
  INDEX `ri_affiliation_lookup_code_idx` (`affiliation_lookup_code` ASC) VISIBLE,
  INDEX `ri_intensity_id_idx` (`intensity` ASC) VISIBLE,
  CONSTRAINT `ri_person_id`
    FOREIGN KEY (`person_id`)
    REFERENCES `mydb`.`person` (`person_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ri_affiliation_lookup_code`
    FOREIGN KEY (`affiliation_lookup_code`)
    REFERENCES `mydb`.`religious_affiliation_lookup` (`affiliation_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ri_intensity_id`
    FOREIGN KEY (`intensity`)
    REFERENCES `mydb`.`view_intensity_lookup` (`intensity_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`social_issue`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`social_issue` (
  `social_issue_id` INT NOT NULL AUTO_INCREMENT,
  `social_issue_name` VARCHAR(45) NULL,
  PRIMARY KEY (`social_issue_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`social_issue_lookup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`social_issue_lookup` (
  `social_issue_code` INT NOT NULL,
  `social_issue_id` INT NULL,
  PRIMARY KEY (`social_issue_code`),
  INDEX `sia_social_issue_id_idx` (`social_issue_id` ASC) VISIBLE,
  CONSTRAINT `sia_social_issue_id`
    FOREIGN KEY (`social_issue_id`)
    REFERENCES `mydb`.`social_issue` (`social_issue_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`social_issue_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`social_issue_view` (
  `social_issue_view_id` INT NOT NULL,
  `person_id` INT NULL,
  `social_issue_lookup_code` INT NULL,
  `intensity_code` INT NULL,
  `event_time` DATETIME NULL,
  PRIMARY KEY (`social_issue_view_id`),
  INDEX `siv_person_id_idx` (`person_id` ASC) VISIBLE,
  INDEX `siv_social_issue_lookup_code_idx` (`social_issue_lookup_code` ASC) VISIBLE,
  INDEX `siv_intensity_id_idx` (`intensity_code` ASC) VISIBLE,
  CONSTRAINT `siv_person_id`
    FOREIGN KEY (`person_id`)
    REFERENCES `mydb`.`person` (`person_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `siv_social_issue_lookup_code`
    FOREIGN KEY (`social_issue_lookup_code`)
    REFERENCES `mydb`.`social_issue_lookup` (`social_issue_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `siv_intensity_id`
    FOREIGN KEY (`intensity_code`)
    REFERENCES `mydb`.`view_intensity_lookup` (`intensity_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`social_mate_preference_lookup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`social_mate_preference_lookup` (
  `person_id` INT NOT NULL,
  `smp_attribute` VARCHAR(45) NOT NULL,
  `preference` VARCHAR(45) NULL,
  PRIMARY KEY (`person_id`),
  CONSTRAINT `smpl_person_id`
    FOREIGN KEY (`person_id`)
    REFERENCES `mydb`.`person` (`person_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`advertisement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`advertisement` (
  `advertisement_id` INT NOT NULL AUTO_INCREMENT,
  `advertisement_name` VARCHAR(45) NULL,
  PRIMARY KEY (`advertisement_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ad_clicked`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ad_clicked` (
  `ad_clicked_id` INT NOT NULL AUTO_INCREMENT,
  `advertisement_id` INT NULL,
  `social_account_id` INT NULL,
  `event_time` DATETIME NULL,
  PRIMARY KEY (`ad_clicked_id`),
  INDEX `ac_social_account_id_idx` (`social_account_id` ASC) VISIBLE,
  INDEX `ac_advertisement_id_idx` (`advertisement_id` ASC) VISIBLE,
  CONSTRAINT `ac_social_account_id`
    FOREIGN KEY (`social_account_id`)
    REFERENCES `mydb`.`social_account` (`social_account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ac_advertisement_id`
    FOREIGN KEY (`advertisement_id`)
    REFERENCES `mydb`.`advertisement` (`advertisement_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`social_action`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`social_action` (
  `social_action_id` INT NOT NULL AUTO_INCREMENT,
  `social_account_id` INT NULL,
  `social_event_id` INT NULL,
  `event_type_id` INT NULL,
  `content` VARCHAR(400) NULL,
  `event_time` DATETIME NULL,
  PRIMARY KEY (`social_action_id`),
  INDEX `saccount_FK_idx` (`social_account_id` ASC) VISIBLE,
  INDEX `sevent_FK_idx` (`social_event_id` ASC) VISIBLE,
  INDEX `seventtype_FK_idx` (`event_type_id` ASC) VISIBLE,
  CONSTRAINT `saccount_FK`
    FOREIGN KEY (`social_account_id`)
    REFERENCES `mydb`.`social_account` (`social_account_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sevent_FK`
    FOREIGN KEY (`social_event_id`)
    REFERENCES `mydb`.`social_event` (`social_event_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `seventtype_FK`
    FOREIGN KEY (`event_type_id`)
    REFERENCES `mydb`.`event_type` (`event_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`event_tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`event_tag` (
  `event_tag_id` INT NOT NULL AUTO_INCREMENT,
  `social_event_id` INT NULL,
  `hashtag_id` INT NULL,
  PRIMARY KEY (`event_tag_id`),
  INDEX `even_tag_FK_idx` (`social_event_id` ASC) VISIBLE,
  INDEX `hashtag_FK_idx` (`hashtag_id` ASC) VISIBLE,
  CONSTRAINT `even_tag_FK`
    FOREIGN KEY (`social_event_id`)
    REFERENCES `mydb`.`social_event` (`social_event_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `hashtag_FK`
    FOREIGN KEY (`hashtag_id`)
    REFERENCES `mydb`.`hashtags` (`hashtag_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
