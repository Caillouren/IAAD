-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Condomínio
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Condomínio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Condomínio` DEFAULT CHARACTER SET utf8 ;
USE `Condomínio` ;

-- -----------------------------------------------------
-- Table `Condomínio`.`Administradora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Condomínio`.`Administradora` (
  `CNPJ` CHAR(14) NOT NULL,
  `Nome` VARCHAR(20) NOT NULL,
  `Endereço` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CNPJ`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Condomínio`.`Pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Condomínio`.`Pessoa` (
  `Cpf` CHAR(11) NOT NULL,
  `Nome` VARCHAR(20) NOT NULL,
  `Gênero` CHAR(1) NULL,
  `Data_nascimento` DATE NULL,
  `Telefone` CHAR(9) NOT NULL,
  `E-mail` VARCHAR(25) NOT NULL,
  `Profissão` VARCHAR(45) NULL,
  PRIMARY KEY (`Cpf`),
  UNIQUE INDEX `E-mail_UNIQUE` (`E-mail` ASC) VISIBLE,
  UNIQUE INDEX `Telefone_UNIQUE` (`Telefone` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Condomínio`.`Edifício`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Condomínio`.`Edifício` (
  `Cod_edifício` CHAR(5) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Endereço` VARCHAR(45) NOT NULL,
  `Cpf_Síndico` CHAR(11) NOT NULL,
  `Cnpj_admin` CHAR(14) NOT NULL,
  PRIMARY KEY (`Cod_edifício`),
  INDEX `Cnpj_admin_idx` (`Cnpj_admin` ASC) VISIBLE,
  INDEX `Cpf_sindíco_idx` (`Cpf_Síndico` ASC) VISIBLE,
  CONSTRAINT `Cnpj_admin`
    FOREIGN KEY (`Cnpj_admin`)
    REFERENCES `Condomínio`.`Administradora` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Cpf_sindíco`
    FOREIGN KEY (`Cpf_Síndico`)
    REFERENCES `Condomínio`.`Pessoa` (`Cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Condomínio`.`Apartamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Condomínio`.`Apartamento` (
  `Cod_Apartamento` CHAR(4) NOT NULL,
  `Cod_Edifício` CHAR(5) NOT NULL,
  `Cpf_proprietário` CHAR(11) NOT NULL,
  `NúmeroApt` INT NOT NULL,
  `Qtd_Quartos` INT NOT NULL,
  `Qtd_Banheiros` INT NULL,
  PRIMARY KEY (`Cod_Apartamento`, `Cod_Edifício`),
  INDEX `Cod_Edifício _idx` (`Cod_Edifício` ASC) VISIBLE,
  INDEX `Cpf_Proprietário _idx` (`Cpf_proprietário` ASC) VISIBLE,
  CONSTRAINT `Cod_Edifício `
    FOREIGN KEY (`Cod_Edifício`)
    REFERENCES `Condomínio`.`Edifício` (`Cod_edifício`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Cpf_Proprietário `
    FOREIGN KEY (`Cpf_proprietário`)
    REFERENCES `Condomínio`.`Pessoa` (`Cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Condomínio`.`Morador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Condomínio`.`Morador` (
  `Cod_apartamento` CHAR(4) NOT NULL,
  `Cod_Edifício` CHAR(5) NOT NULL,
  `Cpf_morador` CHAR(11) NOT NULL,
  PRIMARY KEY (`Cod_apartamento`, `Cod_Edifício`, `Cpf_morador`),
  INDEX `Cod_Edifício_idx` (`Cod_Edifício` ASC) VISIBLE,
  INDEX `Cpf_morador_idx` (`Cpf_morador` ASC) VISIBLE,
  CONSTRAINT `Cpf_morador`
    FOREIGN KEY (`Cpf_morador`)
    REFERENCES `Condomínio`.`Pessoa` (`Cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Cod_Apartamento `
    FOREIGN KEY (`Cod_apartamento`)
    REFERENCES `Condomínio`.`Apartamento` (`Cod_Apartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Condomínio`.`Funcionário`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Condomínio`.`Funcionário` (
  `Cpf_Funcionário` CHAR(11) NOT NULL,
  `Cod_Edifício` CHAR(5) NOT NULL,
  `Data_Admissão` DATE NOT NULL,
  `CargoFunção` VARCHAR(45) NOT NULL,
  `Salário` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`Cpf_Funcionário`, `Cod_Edifício`),
  INDEX `Cod_Edifício _idx` (`Cod_Edifício` ASC) VISIBLE,
  CONSTRAINT `Cpf_Funcionário `
    FOREIGN KEY (`Cpf_Funcionário`)
    REFERENCES `Condomínio`.`Pessoa` (`Cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

alter table Funcionário	ADD FOREIGN KEY(Cod_Edifício) REFERENCES Edifício(Cod_edifício);
alter table Morador	ADD FOREIGN KEY(Cod_Edifício) REFERENCES Edifício(Cod_edifício);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
