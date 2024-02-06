-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema asm3
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema asm3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `asm3` DEFAULT CHARACTER SET utf8 ;
USE `asm3` ;

-- -----------------------------------------------------
-- Table `asm3`.`NHAN_VIEN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asm3`.`NHAN_VIEN` (
  `id_nv` INT NOT NULL AUTO_INCREMENT,
  `ten` VARCHAR(250) NULL,
  `ngay_sinh` DATE NULL,
  `dia_chi` VARCHAR(250) NULL,
  `sdt` VARCHAR(45) NULL,
  `ten_dang_nhap` VARCHAR(100) NULL,
  `mk_dang_nhap` VARCHAR(100) NULL,
  PRIMARY KEY (`id_nv`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asm3`.`DON_HANG_BAN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asm3`.`DON_HANG_BAN` (
  `id_dhb` INT NOT NULL AUTO_INCREMENT,
  `ngay_ban` DATETIME NULL,
  `ten_kh` VARCHAR(100) NULL,
  `sdt_kh` VARCHAR(45) NULL,
  `tong_don` DECIMAL NULL,
  `id_nv` INT NOT NULL,
  PRIMARY KEY (`id_dhb`, `id_nv`),
  INDEX `fk_DON_HANG_NHAN_VIEN_idx` (`id_nv` ASC) VISIBLE,
  CONSTRAINT `fk_DON_HANG_NHAN_VIEN`
    FOREIGN KEY (`id_nv`)
    REFERENCES `asm3`.`NHAN_VIEN` (`id_nv`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asm3`.`HANG_HOA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asm3`.`HANG_HOA` (
  `id_hh` INT NOT NULL AUTO_INCREMENT,
  `ten_hh` VARCHAR(100) NULL,
  `gia_mua` DECIMAL NULL,
  `gia_ban` DECIMAL NULL,
  `ngay_cap_nhat` DATETIME NOT NULL DEFAULT NOW(),
  PRIMARY KEY (`id_hh`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asm3`.`CHI_TIET_DON_HANG_BAN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asm3`.`CHI_TIET_DON_HANG_BAN` (
  `so_luong` INT NOT NULL,
  `gia_ban` DECIMAL NOT NULL,
  `id_dhb` INT NOT NULL,
  `id_hh` INT NOT NULL,
  PRIMARY KEY (`id_dhb`, `id_hh`),
  INDEX `fk_CHI_TIET_DON_HANG_BAN_HANG_HOA1_idx` (`id_hh` ASC) VISIBLE,
  CONSTRAINT `fk_CHI_TIET_DON_HANG_BAN_DON_HANG_BAN1`
    FOREIGN KEY (`id_dhb`)
    REFERENCES `asm3`.`DON_HANG_BAN` (`id_dhb`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CHI_TIET_DON_HANG_BAN_HANG_HOA1`
    FOREIGN KEY (`id_hh`)
    REFERENCES `asm3`.`HANG_HOA` (`id_hh`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asm3`.`DON_VI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asm3`.`DON_VI` (
  `id_don_vi` INT NOT NULL AUTO_INCREMENT,
  `ten_don_vi` VARCHAR(45) NULL,
  PRIMARY KEY (`id_don_vi`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asm3`.`NHA_CUNG_CAP`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asm3`.`NHA_CUNG_CAP` (
  `id_ncc` INT NOT NULL AUTO_INCREMENT,
  `ten` VARCHAR(100) NULL,
  `dia_chi` VARCHAR(100) NULL,
  `sdt` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`id_ncc`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asm3`.`DON_HANG_MUA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asm3`.`DON_HANG_MUA` (
  `id_dhm` INT NOT NULL AUTO_INCREMENT,
  `ngay_dat_hang` DATETIME NULL,
  `tong_gia_tri` DECIMAL NULL,
  `id_ncc` INT NOT NULL,
  PRIMARY KEY (`id_dhm`, `id_ncc`),
  INDEX `fk_DON_HANG_MUA_NHA_CUNG_CAP1_idx` (`id_ncc` ASC) VISIBLE,
  CONSTRAINT `fk_DON_HANG_MUA_NHA_CUNG_CAP1`
    FOREIGN KEY (`id_ncc`)
    REFERENCES `asm3`.`NHA_CUNG_CAP` (`id_ncc`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asm3`.`CHI_TIET_DON_HANG_MUA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asm3`.`CHI_TIET_DON_HANG_MUA` (
  `so_luong` INT NOT NULL,
  `gia_mua` DECIMAL NULL,
  `id_hh` INT NOT NULL,
  `id_dhm` INT NOT NULL,
  PRIMARY KEY (`id_hh`, `id_dhm`),
  INDEX `fk_CHI_TIET_DON_HANG_MUA_DON_HANG_MUA1_idx` (`id_dhm` ASC) VISIBLE,
  CONSTRAINT `fk_CHI_TIET_DON_HANG_MUA_HANG_HOA1`
    FOREIGN KEY (`id_hh`)
    REFERENCES `asm3`.`HANG_HOA` (`id_hh`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CHI_TIET_DON_HANG_MUA_DON_HANG_MUA1`
    FOREIGN KEY (`id_dhm`)
    REFERENCES `asm3`.`DON_HANG_MUA` (`id_dhm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asm3`.`HANGHOA_DONVI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asm3`.`HANGHOA_DONVI` (
  `id_don_vi` INT NOT NULL,
  `id_hh` INT NOT NULL,
  `so_luong` INT NULL,
  `gia_mua` DECIMAL NULL,
  `gia_ban` DECIMAL NULL,
  `ngay_cap_nhat` DATETIME NOT NULL DEFAULT NOW(),
  PRIMARY KEY (`id_don_vi`, `id_hh`),
  INDEX `fk_DON_VI_has_HANG_HOA_HANG_HOA1_idx` (`id_hh` ASC) VISIBLE,
  INDEX `fk_DON_VI_has_HANG_HOA_DON_VI1_idx` (`id_don_vi` ASC) VISIBLE,
  CONSTRAINT `fk_DON_VI_has_HANG_HOA_DON_VI1`
    FOREIGN KEY (`id_don_vi`)
    REFERENCES `asm3`.`DON_VI` (`id_don_vi`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DON_VI_has_HANG_HOA_HANG_HOA1`
    FOREIGN KEY (`id_hh`)
    REFERENCES `asm3`.`HANG_HOA` (`id_hh`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
