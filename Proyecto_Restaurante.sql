-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Proyecto_Restaurante
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Proyecto_Restaurante
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Proyecto_Restaurante` DEFAULT CHARACTER SET utf8 ;
USE `Proyecto_Restaurante` ;

-- -----------------------------------------------------
-- Table `Proyecto_Restaurante`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto_Restaurante`.`Cliente` (
  `idCliente` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `dni` INT(8) NOT NULL,
  `ruc` INT(10) NOT NULL,
  `celular` INT(9) NULL,
  `correo` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `idCliente_UNIQUE` (`idCliente` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Proyecto_Restaurante`.`Mesero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto_Restaurante`.`Mesero` (
  `idMesero` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `dni` INT(9) NOT NULL,
  `celular` INT(9) NULL,
  PRIMARY KEY (`idMesero`),
  UNIQUE INDEX `idMesero_UNIQUE` (`idMesero` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Proyecto_Restaurante`.`Comida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto_Restaurante`.`Comida` (
  `idComida` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  `precio` DECIMAL(3,2) NOT NULL,
  `stock` INT NOT NULL,
  PRIMARY KEY (`idComida`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Proyecto_Restaurante`.`Bebida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto_Restaurante`.`Bebida` (
  `idBebida` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  `precio` DECIMAL(3,2) NOT NULL,
  `stock` INT NOT NULL,
  PRIMARY KEY (`idBebida`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Proyecto_Restaurante`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto_Restaurante`.`Pedido` (
  `idPedido` INT NOT NULL,
  `idCliente` INT NOT NULL,
  `idMesero` INT NOT NULL,
  `CostoTotal` DECIMAL(4,2) NOT NULL,
  `Fecha` DATETIME NOT NULL,
  `idComida` INT NOT NULL,
  `idBebida` INT NOT NULL,
  INDEX `idMesero_idx` (`idMesero` ASC) VISIBLE,
  INDEX `idCliente_idx` (`idCliente` ASC) VISIBLE,
  INDEX `idComida_idx` (`idComida` ASC) VISIBLE,
  INDEX `idBebida_idx` (`idBebida` ASC) VISIBLE,
  PRIMARY KEY (`idPedido`),
  CONSTRAINT `idCliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `Proyecto_Restaurante`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idMesero`
    FOREIGN KEY (`idMesero`)
    REFERENCES `Proyecto_Restaurante`.`Mesero` (`idMesero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idComida`
    FOREIGN KEY (`idComida`)
    REFERENCES `Proyecto_Restaurante`.`Comida` (`idComida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idBebida`
    FOREIGN KEY (`idBebida`)
    REFERENCES `Proyecto_Restaurante`.`Bebida` (`idBebida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Proyecto_Restaurante`.`MetodoPago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto_Restaurante`.`MetodoPago` (
  `idMetodoPago` INT NOT NULL,
  `tipo` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idMetodoPago`),
  UNIQUE INDEX `idMetodoPago_UNIQUE` (`idMetodoPago` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `Proyecto_Restaurante`.`Comprobante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto_Restaurante`.`Comprobante` (
  `idComprobante` INT NOT NULL,
  `tipo` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idComprobante`));


-- -----------------------------------------------------
-- Table `Proyecto_Restaurante`.`Reporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto_Restaurante`.`Reporte` (
  `idReporte` INT NOT NULL,
  `idComprobante` INT NOT NULL,
  `idMetodoPago` INT NOT NULL,
  `idPedido` INT NOT NULL,
  `Detalles` VARCHAR(255) NULL,
  PRIMARY KEY (`idReporte`),
  UNIQUE INDEX `idReporte_UNIQUE` (`idReporte` ASC) VISIBLE,
  INDEX `idComprobante_idx` (`idComprobante` ASC) VISIBLE,
  INDEX `idMetodoPago_idx` (`idMetodoPago` ASC) VISIBLE,
  INDEX `idPedido_idx` (`idPedido` ASC) VISIBLE,
  CONSTRAINT `idComprobante`
    FOREIGN KEY (`idComprobante`)
    REFERENCES `Proyecto_Restaurante`.`Comprobante` (`idComprobante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idMetodoPago`
    FOREIGN KEY (`idMetodoPago`)
    REFERENCES `Proyecto_Restaurante`.`MetodoPago` (`idMetodoPago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idPedido`
    FOREIGN KEY (`idPedido`)
    REFERENCES `Proyecto_Restaurante`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
