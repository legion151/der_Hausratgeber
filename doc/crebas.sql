-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hausratgeber
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hausratgeber
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hausratgeber` DEFAULT CHARACTER SET utf8 ;
USE `hausratgeber` ;

-- -----------------------------------------------------
-- Table `hausratgeber`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hausratgeber`.`Customers` (
  `customerID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `IBAN` VARCHAR(45) NULL,
  `custRefID` VARCHAR(45) NULL,
  PRIMARY KEY (`customerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hausratgeber`.`Transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hausratgeber`.`Transactions` (
  `transactionID` INT NOT NULL AUTO_INCREMENT,
  `customerID` INT NULL,
  `value` FLOAT NULL,
  `payer` VARCHAR(256) NULL,
  `payee` VARCHAR(256) NULL,
  `systemRelevance` VARCHAR(45) NULL,
  `assumedCategory` VARCHAR(45) NULL,
  `customerRelevance` FLOAT NULL,
  PRIMARY KEY (`transactionID`),
  INDEX `T_TRANSACTION_CUST_ID_idx` (`customerID` ASC) ,
  CONSTRAINT `T_TRANSACTION_CUST_ID`
    FOREIGN KEY (`customerID`)
    REFERENCES `hausratgeber`.`Customers` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hausratgeber`.`Categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hausratgeber`.`Categories` (
  `categoryID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`categoryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hausratgeber`.`Inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hausratgeber`.`Inventory` (
  `inventoryID` INT NOT NULL AUTO_INCREMENT,
  `transactionID` INT NULL,
  `purchaseDate` DATE NULL,
  `warrantyEndDate` VARCHAR(45) NULL,
  `value` FLOAT NULL,
  `categoryID` INT NULL,
  PRIMARY KEY (`inventoryID`),
  INDEX `T_INVENTORY_TRANSID_idx` (`transactionID` ASC) ,
  INDEX `T_INVENTORY_CATEGORIES_idx` (`categoryID` ASC) ,
  CONSTRAINT `T_INVENTORY_TRANSID`
    FOREIGN KEY (`transactionID`)
    REFERENCES `hausratgeber`.`Transactions` (`transactionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `T_INVENTORY_CATEGORIES`
    FOREIGN KEY (`categoryID`)
    REFERENCES `hausratgeber`.`Categories` (`categoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hausratgeber`.`Vouchers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hausratgeber`.`Vouchers` (
  `inventoryID` INT NOT NULL,
  `data` MEDIUMBLOB NULL,
  PRIMARY KEY (`inventoryID`),
  CONSTRAINT `T_INVOICES_TRANSID`
    FOREIGN KEY (`inventoryID`)
    REFERENCES `hausratgeber`.`Inventory` (`inventoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hausratgeber`.`Contracts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hausratgeber`.`Contracts` (
  `contractID` INT NOT NULL AUTO_INCREMENT,
  `contractRefNo` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `sumInsured` INT NULL,
  PRIMARY KEY (`contractID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hausratgeber`.`InsuranceCategories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hausratgeber`.`InsuranceCategories` (
  `contractID` INT NOT NULL,
  `categoryID` INT NULL,
  PRIMARY KEY (`contractID`),
  INDEX `T_INSURANCECATEGORIES_CATEGORYID_idx` (`categoryID` ASC) ,
  CONSTRAINT `T_INSURANCECATEGORIES_CONTRACTID`
    FOREIGN KEY (`contractID`)
    REFERENCES `hausratgeber`.`Contracts` (`contractID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `T_INSURANCECATEGORIES_CATEGORYID`
    FOREIGN KEY (`categoryID`)
    REFERENCES `hausratgeber`.`Categories` (`categoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
