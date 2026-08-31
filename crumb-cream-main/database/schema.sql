-- =========================================================
-- Crumb & Cream — Database Schema
-- Import this in phpMyAdmin or HeidiSQL (both included with Laragon)
-- =========================================================

CREATE DATABASE IF NOT EXISTS `crumb_and_cream`
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE `crumb_and_cream`;

CREATE TABLE IF NOT EXISTS `orders` (
  `id`             INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `customer_name`  VARCHAR(120)      NOT NULL,
  `contact_info`   VARCHAR(150)      NOT NULL COMMENT 'Phone number or email',
  `size`           VARCHAR(50)       NOT NULL,
  `quantity`       SMALLINT UNSIGNED NOT NULL DEFAULT 1,
  `message`        TEXT              NULL,
  `status`         ENUM('new', 'contacted', 'completed', 'cancelled') NOT NULL DEFAULT 'new',
  `created_at`     TIMESTAMP         NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =========================================================
-- Crumb & Cream — Payment columns
-- Run this ONCE against your existing database (phpMyAdmin /
-- HeidiSQL: open the SQL tab, paste, run) after importing schema.sql.
-- =========================================================

USE `crumb_and_cream`;

ALTER TABLE `orders`
  ADD COLUMN `amount` DECIMAL(10,2) NULL COMMENT 'Order total in PHP, set when a payment is generated'
    AFTER `message`,
  ADD COLUMN `payment_status` ENUM('unpaid', 'paid', 'expired', 'failed') NOT NULL DEFAULT 'unpaid'
    AFTER `status`,
  ADD COLUMN `payment_intent_id` VARCHAR(60) NULL COMMENT 'PayMongo payment intent id'
    AFTER `payment_status`;