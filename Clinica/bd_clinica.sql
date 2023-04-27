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
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Paciente` (
  `idPaciente` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `CPF` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(45) NOT NULL,
  `E-mail` VARCHAR(45) NOT NULL,
  `DataNascimento` DATE NOT NULL,
  PRIMARY KEY (`idPaciente`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Exame`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Exame` (
  `idExame` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Descricao` VARCHAR(45) NOT NULL,
  `Valor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idExame`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Convenio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Convenio` (
  `idConvenio` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Taxa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idConvenio`),
  UNIQUE INDEX `Nome_UNIQUE` (`Nome` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PacienteConvenio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PacienteConvenio` (
  `idPacienteConvenio` INT NOT NULL,
  `Paciente_idPaciente` INT NOT NULL,
  `Convenio_idConvenio` INT NOT NULL,
  PRIMARY KEY (`idPacienteConvenio`),
  INDEX `fk_PacienteConvenio_Paciente1_idx` (`Paciente_idPaciente` ASC) VISIBLE,
  INDEX `fk_PacienteConvenio_Convenio1_idx` (`Convenio_idConvenio` ASC) VISIBLE,
  UNIQUE INDEX `PacienteConvenio` (`Paciente_idPaciente` ASC, `Convenio_idConvenio` ASC) VISIBLE,
  CONSTRAINT `fk_PacienteConvenio_Paciente1`
    FOREIGN KEY (`Paciente_idPaciente`)
    REFERENCES `mydb`.`Paciente` (`idPaciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PacienteConvenio_Convenio1`
    FOREIGN KEY (`Convenio_idConvenio`)
    REFERENCES `mydb`.`Convenio` (`idConvenio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DataExame`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DataExame` (
  `idDataExame` INT NOT NULL,
  `DataExame` DATE NOT NULL,
  `PacienteConvenio_idPacienteConvenio` INT NOT NULL,
  `Exame_idExame` INT NOT NULL,
  PRIMARY KEY (`idDataExame`),
  INDEX `fk_DataExame_PacienteConvenio1_idx` (`PacienteConvenio_idPacienteConvenio` ASC) VISIBLE,
  INDEX `fk_DataExame_Exame1_idx` (`Exame_idExame` ASC) VISIBLE,
  UNIQUE INDEX `DataUNIQUE` (`DataExame` ASC, `PacienteConvenio_idPacienteConvenio` ASC, `Exame_idExame` ASC) VISIBLE,
  CONSTRAINT `fk_DataExame_PacienteConvenio1`
    FOREIGN KEY (`PacienteConvenio_idPacienteConvenio`)
    REFERENCES `mydb`.`PacienteConvenio` (`idPacienteConvenio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DataExame_Exame1`
    FOREIGN KEY (`Exame_idExame`)
    REFERENCES `mydb`.`Exame` (`idExame`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
