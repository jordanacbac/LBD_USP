-- MySQL Script generated by MySQL Workbench
-- Sun Apr  8 21:07:09 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`caravana`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`caravana` ;

CREATE TABLE IF NOT EXISTS `mydb`.`caravana` (
  `id_caravana` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cidade_origem` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_caravana`),
  UNIQUE INDEX `id_caravana_UNIQUE` (`id_caravana` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`participante`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`participante` ;

CREATE TABLE IF NOT EXISTS `mydb`.`participante` (
  `cpf` CHAR(11) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `data_nasc` DATE NOT NULL,
  `genero` CHAR(1) NOT NULL,
  `ocupacao` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(20) NOT NULL,
  `id_caravana` INT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  INDEX `fk_participante_caravana_idx` (`id_caravana` ASC),
  CONSTRAINT `fk_participante_caravana`
    FOREIGN KEY (`id_caravana`)
    REFERENCES `mydb`.`caravana` (`id_caravana`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`barraca`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`barraca` ;

CREATE TABLE IF NOT EXISTS `mydb`.`barraca` (
  `id_barraca` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cpf` CHAR(11) NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  `marca` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_barraca`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  UNIQUE INDEX `id_barraca_UNIQUE` (`id_barraca` ASC),
  CONSTRAINT `fk_barraca_participante`
    FOREIGN KEY (`cpf`)
    REFERENCES `mydb`.`participante` (`cpf`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`participante_isento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`participante_isento` ;

CREATE TABLE IF NOT EXISTS `mydb`.`participante_isento` (
  `cpf` CHAR(11) NOT NULL,
  `tipo_participante` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  CONSTRAINT `fk_participante_isento`
    FOREIGN KEY (`cpf`)
    REFERENCES `mydb`.`participante` (`cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`participante_pagante`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`participante_pagante` ;

CREATE TABLE IF NOT EXISTS `mydb`.`participante_pagante` (
  `cpf` CHAR(11) NOT NULL,
  `valor_inscricao` DOUBLE NOT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  CONSTRAINT `fk_participante_pagante`
    FOREIGN KEY (`cpf`)
    REFERENCES `mydb`.`participante` (`cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`onibus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`onibus` ;

CREATE TABLE IF NOT EXISTS `mydb`.`onibus` (
  `id_caravana` INT UNSIGNED NOT NULL,
  `num_onibus` INT UNSIGNED NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  `capacidade` INT NOT NULL,
  PRIMARY KEY (`num_onibus`, `id_caravana`),
  INDEX `fk_onibus_caravana_idx` (`id_caravana` ASC),
  CONSTRAINT `fk_onibus_caravana`
    FOREIGN KEY (`id_caravana`)
    REFERENCES `mydb`.`caravana` (`id_caravana`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`expositor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`expositor` ;

CREATE TABLE IF NOT EXISTS `mydb`.`expositor` (
  `cpf` CHAR(11) NOT NULL,
  `nome_expo` VARCHAR(45) NOT NULL,
  `tema_expo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  CONSTRAINT `fk_expositor_participante`
    FOREIGN KEY (`cpf`)
    REFERENCES `mydb`.`participante_isento` (`cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`produto` ;

CREATE TABLE IF NOT EXISTS `mydb`.`produto` (
  `id_produto` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cpf` CHAR(11) NOT NULL,
  `nome_produto` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `quantidade_estoque` INT NOT NULL,
  `preco` DOUBLE NOT NULL,
  PRIMARY KEY (`id_produto`),
  UNIQUE INDEX `id_produto_UNIQUE` (`id_produto` ASC),
  INDEX `fk_expositor_produto_idx` (`cpf` ASC),
  CONSTRAINT `fk_expositor_produto`
    FOREIGN KEY (`cpf`)
    REFERENCES `mydb`.`expositor` (`cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`jornalista`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`jornalista` ;

CREATE TABLE IF NOT EXISTS `mydb`.`jornalista` (
  `cpf` CHAR(11) NOT NULL,
  `credencial` INT NOT NULL,
  `area_atuacao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  UNIQUE INDEX `credencial_UNIQUE` (`credencial` ASC),
  CONSTRAINT `fk_participante_jornalista`
    FOREIGN KEY (`cpf`)
    REFERENCES `mydb`.`participante_isento` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`materia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`materia` ;

CREATE TABLE IF NOT EXISTS `mydb`.`materia` (
  `id_materia` INT NOT NULL AUTO_INCREMENT,
  `cpf` CHAR(11) NOT NULL,
  `titulo_materia` VARCHAR(45) NOT NULL,
  `assunto` VARCHAR(45) NOT NULL,
  `data` DATE NOT NULL,
  PRIMARY KEY (`id_materia`),
  UNIQUE INDEX `id_materia_UNIQUE` (`id_materia` ASC),
  INDEX `fk_jornalista_materia_idx` (`cpf` ASC),
  CONSTRAINT `fk_jornalista_materia`
    FOREIGN KEY (`cpf`)
    REFERENCES `mydb`.`jornalista` (`cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`categoria_veiculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`categoria_veiculo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`categoria_veiculo` (
  `id_categoria_veiculo` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `desc_categoria_veiculol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_categoria_veiculo`),
  UNIQUE INDEX `id_categoria_veiculo_UNIQUE` (`id_categoria_veiculo` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`veiculo_comunicacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`veiculo_comunicacao` ;

CREATE TABLE IF NOT EXISTS `mydb`.`veiculo_comunicacao` (
  `id_veiculo` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_categoria_veiculo` INT UNSIGNED NULL,
  `nome_veiculo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_veiculo`),
  UNIQUE INDEX `id_veiculo_comunicacao_UNIQUE` (`id_veiculo` ASC),
  INDEX `fk_categoria_veiculo_idx` (`id_categoria_veiculo` ASC),
  CONSTRAINT `fk_categoria_veiculo`
    FOREIGN KEY (`id_categoria_veiculo`)
    REFERENCES `mydb`.`categoria_veiculo` (`id_categoria_veiculo`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`jornalista_veiculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`jornalista_veiculo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`jornalista_veiculo` (
  `id_jornalista_veiculo` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_veiculo` INT UNSIGNED NOT NULL,
  `cpf` CHAR(11) NOT NULL,
  PRIMARY KEY (`id_jornalista_veiculo`),
  INDEX `fk_jornalista_veiculo_idx` (`cpf` ASC),
  UNIQUE INDEX `id_jornalista_veiculo_UNIQUE` (`id_jornalista_veiculo` ASC),
  CONSTRAINT `fk_veiculo_jornalista`
    FOREIGN KEY (`id_veiculo`)
    REFERENCES `mydb`.`veiculo_comunicacao` (`id_veiculo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_jornalista_veiculo`
    FOREIGN KEY (`cpf`)
    REFERENCES `mydb`.`jornalista` (`cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`painelista`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`painelista` ;

CREATE TABLE IF NOT EXISTS `mydb`.`painelista` (
  `cpf` CHAR(11) NOT NULL,
  `tipo_apresentador` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  CONSTRAINT `fk_palestrante`
    FOREIGN KEY (`cpf`)
    REFERENCES `mydb`.`participante_isento` (`cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tema`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`tema` ;

CREATE TABLE IF NOT EXISTS `mydb`.`tema` (
  `id_tema` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `desc_tema` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tema`),
  UNIQUE INDEX `id_tema_UNIQUE` (`id_tema` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`atividade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`atividade` ;

CREATE TABLE IF NOT EXISTS `mydb`.`atividade` (
  `id_atividade` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_tema` INT UNSIGNED NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `tipo` CHAR(1) NOT NULL,
  PRIMARY KEY (`id_atividade`),
  UNIQUE INDEX `id_atividade_UNIQUE` (`id_atividade` ASC),
  INDEX `fk_tema_idx` (`id_tema` ASC),
  CONSTRAINT `fk_tema`
    FOREIGN KEY (`id_tema`)
    REFERENCES `mydb`.`tema` (`id_tema`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`participacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`participacao` ;

CREATE TABLE IF NOT EXISTS `mydb`.`participacao` (
  `id_participacao` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cpf` CHAR(11) NOT NULL,
  `id_atividade` INT UNSIGNED NOT NULL,
  INDEX `fk_atividade_participante_idx` (`id_atividade` ASC),
  PRIMARY KEY (`id_participacao`),
  UNIQUE INDEX `id_participacao_UNIQUE` (`id_participacao` ASC),
  CONSTRAINT `fk_participante_atividade`
    FOREIGN KEY (`cpf`)
    REFERENCES `mydb`.`participante` (`cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_atividade_participante`
    FOREIGN KEY (`id_atividade`)
    REFERENCES `mydb`.`atividade` (`id_atividade`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`painel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`painel` ;

CREATE TABLE IF NOT EXISTS `mydb`.`painel` (
  `id_atividade` INT UNSIGNED NOT NULL,
  `topicos` NVARCHAR(250) NOT NULL,
  PRIMARY KEY (`id_atividade`),
  UNIQUE INDEX `id_atividade_UNIQUE` (`id_atividade` ASC),
  CONSTRAINT `fk_painel`
    FOREIGN KEY (`id_atividade`)
    REFERENCES `mydb`.`atividade` (`id_atividade`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`painelista_painel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`painelista_painel` ;

CREATE TABLE IF NOT EXISTS `mydb`.`painelista_painel` (
  `id_apresentador_atividade` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cpf` CHAR(11) NOT NULL,
  `id_atividade` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_apresentador_atividade`),
  UNIQUE INDEX `id_apresentador_atividade_UNIQUE` (`id_apresentador_atividade` ASC),
  INDEX `fk_apresentador_atividade_idx` (`cpf` ASC),
  INDEX `fk_painel_painelista_idx` (`id_atividade` ASC),
  CONSTRAINT `fk_painelista_painel`
    FOREIGN KEY (`cpf`)
    REFERENCES `mydb`.`painelista` (`cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_painel_painelista`
    FOREIGN KEY (`id_atividade`)
    REFERENCES `mydb`.`painel` (`id_atividade`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`palestrante`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`palestrante` ;

CREATE TABLE IF NOT EXISTS `mydb`.`palestrante` (
  `cpf` CHAR(11) NOT NULL,
  `especializacao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  CONSTRAINT `fk_palestrante`
    FOREIGN KEY (`cpf`)
    REFERENCES `mydb`.`participante_isento` (`cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`palestra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`palestra` ;

CREATE TABLE IF NOT EXISTS `mydb`.`palestra` (
  `id_atividade` INT UNSIGNED NOT NULL,
  `cpf` CHAR(11) NOT NULL,
  `data_palestra` DATE NOT NULL,
  `horario_palestra` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_atividade`),
  UNIQUE INDEX `id_atividade_UNIQUE` (`id_atividade` ASC),
  INDEX `fk_palestrante_palestra_idx` (`cpf` ASC),
  CONSTRAINT `fk_palestra`
    FOREIGN KEY (`id_atividade`)
    REFERENCES `mydb`.`atividade` (`id_atividade`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_palestrante_palestra`
    FOREIGN KEY (`cpf`)
    REFERENCES `mydb`.`palestrante` (`cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`endereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`endereco` ;

CREATE TABLE IF NOT EXISTS `mydb`.`endereco` (
  `id_endereco` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cpf` CHAR(11) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(100) NOT NULL,
  `bairro` VARCHAR(100) NOT NULL,
  `rua` VARCHAR(100) NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  `complemento` VARCHAR(100) NULL,
  `cep` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`id_endereco`),
  UNIQUE INDEX `id_endereco_UNIQUE` (`id_endereco` ASC),
  INDEX `fk_endereco_idx` (`cpf` ASC),
  CONSTRAINT `fk_endereco`
    FOREIGN KEY (`cpf`)
    REFERENCES `mydb`.`participante` (`cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;