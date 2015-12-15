-- phpMyAdmin SQL Dump
-- version 4.4.15.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 15, 2015 at 01:55 AM
-- Server version: 5.5.41-MariaDB
-- PHP Version: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lixi`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_users`
--

CREATE TABLE IF NOT EXISTS `admin_users` (
  `id` bigint(20) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `account_non_expired` tinyint(1) NOT NULL,
  `account_non_locked` tinyint(1) NOT NULL,
  `credentials_non_expired` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `password_next_time` tinyint(4) NOT NULL,
  `created_date` datetime NOT NULL,
  `created_by` varchar(255) NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `modified_by` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `admin_users`
--

INSERT INTO `admin_users` (`id`, `first_name`, `middle_name`, `last_name`, `email`, `password`, `phone`, `account_non_expired`, `account_non_locked`, `credentials_non_expired`, `enabled`, `password_next_time`, `created_date`, `created_by`, `modified_date`, `modified_by`) VALUES
(6, 'Chon', 'Huu', 'Nguyen', 'chonnh@gmail.com', '$2a$10$cHM879WE9Xb.K3ios//zDOzjcbmAazpKCRaEPxmdDu6H3g.oRz8yC', '0967007869', 1, 1, 1, 1, 0, '2015-04-15 04:24:23', 'chonnh@gmail.com', '2015-06-27 15:23:25', 'chonnh@gmail.com'),
(7, 'Yuric', 'I.', 'Hannart', 'yhannart@gmail.com', '$2a$10$d3yYe4Z..7m2VHHLAzqbmefLjoLKavMbRVZXN07/9hDGGVYgEU2Da', '', 1, 1, 1, 1, 0, '2015-06-17 00:00:00', 'chonnh@gmail.com', '2015-07-01 16:47:48', 'yhannart@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `admin_users_authority`
--

CREATE TABLE IF NOT EXISTS `admin_users_authority` (
  `id` bigint(20) NOT NULL,
  `admin_user_id` bigint(20) DEFAULT NULL,
  `authority` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `admin_users_authority`
--

INSERT INTO `admin_users_authority` (`id`, `admin_user_id`, `authority`) VALUES
(1, 6, 'ACCESS_ADMINISTRATION'),
(2, 6, 'SYSTEM_CONFIG_CONTROLLER'),
(5, 6, 'SYSTEM_USER_CONTROLLER'),
(25, 7, 'ACCESS_ADMINISTRATION'),
(26, 7, 'SYSTEM_CONFIG_CONTROLLER'),
(27, 7, 'SYSTEM_USER_CONTROLLER'),
(28, 6, 'SYSTEM_ORDERS_CONTROLLER'),
(29, 7, 'SYSTEM_ORDERS_CONTROLLER');

-- --------------------------------------------------------

--
-- Table structure for table `admin_user_password_history`
--

CREATE TABLE IF NOT EXISTS `admin_user_password_history` (
  `id` bigint(20) NOT NULL,
  `admin_user_id` bigint(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `modified_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `authorities`
--

CREATE TABLE IF NOT EXISTS `authorities` (
  `id` bigint(20) NOT NULL,
  `authority` varchar(255) NOT NULL,
  `description` text
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `authorities`
--

INSERT INTO `authorities` (`id`, `authority`, `description`) VALUES
(1, 'ACCESS_ADMINISTRATION', 'message.access_administration'),
(2, 'SYSTEM_CONFIG_CONTROLLER', 'message.system_config'),
(3, 'SYSTEM_USER_CONTROLLER', 'message.system_user'),
(4, 'SYSTEM_ORDERS_CONTROLLER', 'message.system_orders');

-- --------------------------------------------------------

--
-- Table structure for table `authorize_customer_result`
--

CREATE TABLE IF NOT EXISTS `authorize_customer_result` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `response_code` varchar(255) NOT NULL,
  `response_text` text NOT NULL,
  `created_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `authorize_customer_result`
--

INSERT INTO `authorize_customer_result` (`id`, `user_id`, `response_code`, `response_text`, `created_date`) VALUES
(8, 12, 'Ok', '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<ns2:local xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd" xmlns:ns2="uri">\n    <resultCode>Ok</resultCode>\n    <message>\n        <code>I00001</code>\n        <text>Successful.</text>\n    </message>\n</ns2:local>\n', '2015-11-12 03:59:19'),
(9, 15, 'Error', '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<ns2:local xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd" xmlns:ns2="uri">\n    <resultCode>Error</resultCode>\n    <message>\n        <code>E00027</code>\n        <text>(TESTMODE) The credit card number is invalid.</text>\n    </message>\n</ns2:local>\n', '2015-12-12 21:52:07'),
(10, 15, 'Error', '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<ns2:local xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd" xmlns:ns2="uri">\n    <resultCode>Error</resultCode>\n    <message>\n        <code>E00015</code>\n        <text>The field length is invalid for Card Number.</text>\n    </message>\n</ns2:local>\n', '2015-12-12 22:13:35'),
(11, 15, 'Ok', '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<ns2:local xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd" xmlns:ns2="uri">\n    <resultCode>Ok</resultCode>\n    <message>\n        <code>I00001</code>\n        <text>Successful.</text>\n    </message>\n</ns2:local>\n', '2015-12-12 22:20:23'),
(12, 15, 'Ok', '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<ns2:local xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd" xmlns:ns2="uri">\n    <resultCode>Ok</resultCode>\n    <message>\n        <code>I00001</code>\n        <text>Successful.</text>\n    </message>\n</ns2:local>\n', '2015-12-12 23:05:41');

-- --------------------------------------------------------

--
-- Table structure for table `authorize_payment_result`
--

CREATE TABLE IF NOT EXISTS `authorize_payment_result` (
  `id` bigint(20) NOT NULL,
  `card_id` bigint(20) NOT NULL,
  `response_code` varchar(255) NOT NULL,
  `response_text` text NOT NULL,
  `created_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `authorize_payment_result`
--

INSERT INTO `authorize_payment_result` (`id`, `card_id`, `response_code`, `response_text`, `created_date`) VALUES
(1, 13, 'Error', '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<ns2:local xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd" xmlns:ns2="uri">\n    <resultCode>Error</resultCode>\n    <message>\n        <code>E00015</code>\n        <text>The field length is invalid for Card Number.</text>\n    </message>\n</ns2:local>\n', '2015-11-13 08:39:55'),
(2, 14, 'Ok', '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<ns2:local xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd" xmlns:ns2="uri">\n    <resultCode>Ok</resultCode>\n    <message>\n        <code>I00001</code>\n        <text>Successful.</text>\n    </message>\n</ns2:local>\n', '2015-11-13 09:03:33'),
(3, 5, 'Error', '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<ns2:local xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd" xmlns:ns2="uri">\n    <resultCode>Error</resultCode>\n    <message>\n        <code>E00015</code>\n        <text>The field length is invalid for Card Number.</text>\n    </message>\n</ns2:local>\n', '2015-12-13 01:03:42'),
(4, 6, 'Error', '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<ns2:local xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd" xmlns:ns2="uri">\n    <resultCode>Error</resultCode>\n    <message>\n        <code>E00015</code>\n        <text>The field length is invalid for Card Number.</text>\n    </message>\n</ns2:local>\n', '2015-12-13 01:04:45'),
(5, 7, 'Error', '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<ns2:local xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd" xmlns:ns2="uri">\n    <resultCode>Error</resultCode>\n    <message>\n        <code>E00015</code>\n        <text>The field length is invalid for Card Number.</text>\n    </message>\n</ns2:local>\n', '2015-12-13 01:16:55'),
(6, 8, 'Ok', '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<ns2:local xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd" xmlns:ns2="uri">\n    <resultCode>Ok</resultCode>\n    <message>\n        <code>I00001</code>\n        <text>Successful.</text>\n    </message>\n</ns2:local>\n', '2015-12-13 01:21:49');

-- --------------------------------------------------------

--
-- Table structure for table `billing_address`
--

CREATE TABLE IF NOT EXISTS `billing_address` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `zip_code` varchar(255) NOT NULL,
  `country` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `billing_address`
--

INSERT INTO `billing_address` (`id`, `user_id`, `first_name`, `last_name`, `address`, `city`, `state`, `zip_code`, `country`) VALUES
(1, 15, 'Chon', 'Huu Nguyen', '51/1 Vu Bao', 'Quy Nhon', 'Binh Dinh', '0000', 'US'),
(2, 15, 'Dam', 'Dao', '51/1 Vu Bao', 'Quy Nhon', 'Binh Dinh', '123', 'US'),
(3, 15, 'Dam', 'Dao', '51/1 Vu Bao', 'Quy Nhon', 'Binh Dinh', '0000', 'US'),
(4, 15, 'Dam', 'Dao', '51/1 Vu Bao', 'Quy Nhon', 'Binh Dinh', '0000', 'US'),
(5, 15, 'Dam', 'Dao', '51/1 Vu Bao', 'Quy Nhon', 'Binh Dinh', '0000', 'US'),
(6, 15, 'Dam', 'Dao', '51/1 Vu Bao', 'Quy Nhon', 'Binh Dinh', '0000', 'US');

-- --------------------------------------------------------

--
-- Table structure for table `buy_card`
--

CREATE TABLE IF NOT EXISTS `buy_card` (
  `id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `recipient` bigint(20) NOT NULL,
  `vtc_code` varchar(10) NOT NULL,
  `num_of_card` int(11) NOT NULL,
  `value_of_card` int(11) NOT NULL,
  `modified_date` datetime NOT NULL,
  `is_submitted` int(11) DEFAULT '0',
  `response_code` int(11) DEFAULT NULL,
  `response_message` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `buy_card_result`
--

CREATE TABLE IF NOT EXISTS `buy_card_result` (
  `id` bigint(20) NOT NULL,
  `buy_id` bigint(20) NOT NULL,
  `buy_request` text,
  `buy_response` text,
  `get_request` text,
  `get_response` text,
  `get_response_decrypt` text,
  `modified_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE IF NOT EXISTS `countries` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `name`) VALUES
(1, 'US'),
(2, 'UK'),
(3, 'Australia'),
(4, 'Canada'),
(5, 'Denmark'),
(6, 'Finland'),
(7, 'France'),
(8, 'Japan'),
(9, 'Germany'),
(10, 'New Zealand'),
(11, 'Norway'),
(12, 'Sweden');

-- --------------------------------------------------------

--
-- Table structure for table `currency_type`
--

CREATE TABLE IF NOT EXISTS `currency_type` (
  `id` bigint(20) NOT NULL,
  `code` varchar(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sort_order` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `currency_type`
--

INSERT INTO `currency_type` (`id`, `code`, `name`, `sort_order`) VALUES
(1, 'USD', 'US DOLLAR', 1),
(2, 'VND', 'VN DONG', 999999999);

-- --------------------------------------------------------

--
-- Table structure for table `customer_comment`
--

CREATE TABLE IF NOT EXISTS `customer_comment` (
  `id` bigint(20) NOT NULL,
  `problem_id` bigint(20) NOT NULL,
  `content` text,
  `created_by` varchar(255) DEFAULT NULL,
  `created_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer_comment`
--

INSERT INTO `customer_comment` (`id`, `problem_id`, `content`, `created_by`, `created_date`) VALUES
(5, 3, 'asdas das d', 'yhannart@gmail.com', '2015-11-27 07:35:01'),
(6, 3, ' dad ad dada sa d', 'yhannart@gmail.com', '2015-11-27 07:35:10'),
(7, 3, 'sa da das\r\nsa das dd asd\r\nsa das d', 'yhannart@gmail.com', '2015-11-27 07:35:15'),
(8, 4, 'sdfsfsf', 'yhannart@gmail.com', '2015-11-28 04:15:21'),
(9, 4, 'dsf sd fs ', 'yhannart@gmail.com', '2015-11-28 04:15:25'),
(10, 6, 'adas dsa da d', 'yhannart@gmail.com', '2015-11-28 23:25:29'),
(11, 6, 'adas dsa da d', 'yhannart@gmail.com', '2015-11-28 23:26:08'),
(12, 6, 'sad sad ', 'yhannart@gmail.com', '2015-11-28 23:26:12'),
(13, 6, 'sd sadsad', 'yhannart@gmail.com', '2015-11-28 23:30:55'),
(14, 1035, 'sd asda', 'yhannart@gmail.com', '2015-11-28 23:31:05');

-- --------------------------------------------------------

--
-- Table structure for table `customer_problem`
--

CREATE TABLE IF NOT EXISTS `customer_problem` (
  `id` bigint(20) NOT NULL,
  `subject_id` bigint(20) NOT NULL,
  `content` text,
  `order_id` bigint(20) DEFAULT NULL,
  `contact_method` varchar(255) DEFAULT NULL,
  `contact_data` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_date` datetime NOT NULL,
  `status` bigint(20) NOT NULL,
  `status_date` datetime DEFAULT NULL,
  `handled_by` varchar(255) DEFAULT NULL,
  `handled_date` datetime DEFAULT NULL,
  `closed_date` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1037 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer_problem`
--

INSERT INTO `customer_problem` (`id`, `subject_id`, `content`, `order_id`, `contact_method`, `contact_data`, `created_by`, `created_date`, `status`, `status_date`, `handled_by`, `handled_date`, `closed_date`) VALUES
(3, 1, 'dasd asdsad ', 1, '1', 'chonnh@gmail.com', NULL, '2015-11-27 02:26:47', 1, NULL, NULL, '2015-11-27 02:41:19', NULL),
(4, 2, 'df dsf dsf sdf ds ', 12, '2', '0967007869', NULL, '2015-11-27 02:27:07', 3, '2015-11-28 04:15:56', 'yhannart@gmail.com', '2015-11-28 03:29:47', NULL),
(5, 1, 'dsa dasdsa das dsad s', 12, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:17:30', 1, NULL, NULL, NULL, NULL),
(6, 1, 'asd sad sad ad', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:20:06', 3, '2015-11-28 04:57:24', 'yhannart@gmail.com', '2015-11-28 04:39:42', NULL),
(7, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(8, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(9, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(10, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(11, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(12, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(13, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(14, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(15, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(16, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(17, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(18, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(19, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(20, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(21, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(22, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(23, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(24, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(25, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(26, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(27, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(28, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(29, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(30, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(31, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(32, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(33, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(34, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(35, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(36, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(37, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(38, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(39, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(40, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(41, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(42, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(43, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(44, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(45, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(46, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(47, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(48, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(49, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(50, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(51, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(52, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(53, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(54, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(55, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(56, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(57, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(58, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(59, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(60, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(61, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(62, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(63, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(64, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(65, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(66, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(67, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(68, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(69, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(70, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(71, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(72, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(73, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(74, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(75, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(76, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(77, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(78, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(79, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(80, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(81, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(82, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(83, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(84, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(85, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(86, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(87, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(88, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(89, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(90, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(91, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(92, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(93, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(94, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(95, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(96, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(97, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(98, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(99, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(100, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(101, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(102, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(103, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(104, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(105, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(106, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(107, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(108, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(109, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(110, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(111, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(112, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(113, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(114, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(115, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(116, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(117, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(118, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(119, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(120, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(121, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(122, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(123, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(124, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(125, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(126, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(127, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(128, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(129, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(130, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(131, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(132, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(133, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(134, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(135, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(136, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(137, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(138, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(139, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(140, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(141, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(142, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(143, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(144, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(145, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(146, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(147, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(148, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(149, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(150, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(151, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(152, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(153, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(154, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(155, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(156, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(157, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(158, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(159, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(160, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(161, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(162, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(163, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(164, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(165, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(166, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(167, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(168, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(169, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(170, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(171, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(172, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(173, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(174, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(175, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(176, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(177, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(178, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(179, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(180, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(181, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(182, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(183, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(184, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(185, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(186, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(187, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(188, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(189, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(190, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(191, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(192, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(193, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(194, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(195, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(196, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(197, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(198, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(199, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(200, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(201, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(202, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(203, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(204, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(205, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(206, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(207, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(208, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(209, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(210, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(211, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(212, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(213, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(214, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(215, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(216, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(217, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(218, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(219, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(220, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(221, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(222, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(223, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(224, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(225, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(226, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(227, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(228, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(229, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(230, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(231, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(232, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(233, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(234, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(235, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(236, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(237, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(238, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(239, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(240, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(241, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(242, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(243, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(244, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(245, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(246, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(247, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(248, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(249, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(250, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(251, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(252, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(253, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(254, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(255, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(256, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(257, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(258, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(259, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(260, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(261, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(262, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(263, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(264, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(265, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(266, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(267, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(268, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(269, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(270, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(271, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(272, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(273, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(274, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(275, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(276, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(277, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(278, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(279, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(280, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(281, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(282, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(283, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(284, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(285, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(286, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(287, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(288, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(289, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(290, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(291, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(292, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(293, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(294, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(295, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(296, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(297, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(298, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(299, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(300, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(301, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(302, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(303, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(304, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(305, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(306, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(307, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(308, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(309, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(310, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(311, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(312, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(313, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(314, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(315, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(316, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(317, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(318, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(319, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(320, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(321, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(322, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(323, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(324, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(325, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(326, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(327, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(328, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(329, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(330, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(331, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(332, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(333, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(334, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(335, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(336, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(337, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(338, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(339, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(340, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(341, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(342, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(343, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(344, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(345, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(346, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(347, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(348, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(349, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(350, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(351, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(352, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(353, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(354, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(355, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(356, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(357, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(358, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(359, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(360, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(361, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(362, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(363, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(364, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(365, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(366, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(367, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(368, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(369, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(370, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(371, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(372, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(373, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(374, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(375, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(376, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(377, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(378, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(379, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(380, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(381, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(382, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(383, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(384, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(385, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(386, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(387, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(388, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(389, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(390, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(391, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(392, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(393, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(394, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(395, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(396, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(397, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(398, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(399, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(400, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(401, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(402, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(403, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(404, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(405, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(406, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(407, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(408, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(409, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(410, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(411, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(412, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(413, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(414, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(415, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(416, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(417, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(418, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(419, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(420, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(421, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(422, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(423, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(424, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(425, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(426, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(427, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(428, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(429, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(430, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(431, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(432, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(433, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(434, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(435, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(436, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(437, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(438, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(439, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(440, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(441, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(442, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(443, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(444, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(445, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(446, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL);
INSERT INTO `customer_problem` (`id`, `subject_id`, `content`, `order_id`, `contact_method`, `contact_data`, `created_by`, `created_date`, `status`, `status_date`, `handled_by`, `handled_date`, `closed_date`) VALUES
(447, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(448, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(449, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(450, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(451, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(452, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(453, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(454, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(455, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(456, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(457, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(458, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(459, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(460, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(461, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(462, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(463, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(464, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(465, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(466, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(467, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(468, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(469, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(470, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(471, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(472, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(473, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(474, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(475, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(476, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(477, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(478, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(479, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(480, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(481, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(482, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(483, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(484, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(485, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(486, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(487, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(488, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(489, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(490, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(491, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(492, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(493, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(494, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(495, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(496, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(497, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(498, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(499, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(500, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(501, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(502, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(503, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(504, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(505, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(506, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(507, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(508, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(509, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(510, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(511, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(512, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(513, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(514, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(515, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(516, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(517, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(518, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(519, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(520, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(521, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(522, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(523, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(524, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(525, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(526, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(527, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(528, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(529, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(530, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(531, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(532, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(533, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(534, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(535, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(536, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(537, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(538, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(539, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(540, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(541, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(542, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(543, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(544, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(545, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(546, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(547, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(548, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(549, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(550, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(551, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(552, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(553, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(554, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(555, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(556, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(557, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(558, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(559, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(560, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(561, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(562, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(563, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(564, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(565, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(566, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(567, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(568, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(569, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(570, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(571, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(572, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(573, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(574, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(575, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(576, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(577, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(578, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(579, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(580, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(581, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(582, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(583, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(584, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(585, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(586, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(587, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(588, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(589, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(590, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(591, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(592, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(593, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(594, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(595, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(596, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(597, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(598, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(599, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(600, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(601, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(602, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(603, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(604, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(605, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(606, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(607, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(608, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(609, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(610, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(611, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(612, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(613, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(614, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(615, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(616, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(617, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(618, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(619, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(620, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(621, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(622, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(623, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(624, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(625, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(626, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(627, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(628, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(629, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(630, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(631, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(632, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(633, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(634, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(635, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(636, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(637, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(638, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(639, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(640, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(641, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(642, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(643, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(644, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(645, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(646, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(647, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(648, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(649, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(650, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(651, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(652, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(653, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(654, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(655, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(656, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(657, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(658, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(659, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(660, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(661, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(662, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(663, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(664, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(665, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(666, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(667, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(668, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(669, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(670, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(671, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(672, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(673, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(674, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(675, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(676, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(677, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(678, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(679, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(680, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(681, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(682, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(683, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(684, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(685, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(686, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(687, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(688, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(689, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(690, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(691, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(692, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(693, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(694, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(695, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(696, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(697, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(698, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(699, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(700, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(701, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(702, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(703, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(704, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(705, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(706, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(707, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(708, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(709, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(710, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(711, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(712, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(713, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(714, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(715, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(716, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(717, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(718, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(719, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(720, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(721, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(722, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(723, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(724, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(725, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(726, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(727, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(728, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(729, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(730, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(731, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(732, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(733, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(734, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(735, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(736, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(737, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(738, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(739, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(740, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(741, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(742, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(743, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(744, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(745, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(746, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(747, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(748, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(749, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(750, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(751, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(752, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(753, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(754, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(755, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(756, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(757, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(758, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(759, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(760, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(761, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(762, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(763, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(764, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(765, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(766, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(767, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(768, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(769, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(770, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(771, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(772, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(773, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(774, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(775, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(776, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(777, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(778, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(779, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(780, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(781, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(782, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(783, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(784, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(785, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(786, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(787, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(788, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(789, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(790, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(791, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(792, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(793, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(794, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(795, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(796, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(797, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(798, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(799, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(800, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(801, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(802, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(803, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(804, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(805, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(806, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(807, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(808, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(809, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(810, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(811, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(812, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(813, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(814, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(815, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(816, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(817, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(818, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(819, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(820, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(821, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(822, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(823, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(824, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(825, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(826, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(827, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(828, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(829, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(830, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(831, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(832, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(833, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(834, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(835, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(836, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(837, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(838, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(839, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(840, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(841, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(842, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(843, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(844, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(845, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(846, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(847, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(848, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(849, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(850, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(851, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(852, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(853, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(854, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(855, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(856, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(857, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(858, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(859, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(860, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(861, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(862, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(863, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(864, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(865, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(866, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(867, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(868, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(869, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(870, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(871, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(872, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(873, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(874, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(875, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(876, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(877, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(878, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(879, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(880, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(881, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(882, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(883, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(884, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(885, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(886, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(887, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(888, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(889, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(890, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL);
INSERT INTO `customer_problem` (`id`, `subject_id`, `content`, `order_id`, `contact_method`, `contact_data`, `created_by`, `created_date`, `status`, `status_date`, `handled_by`, `handled_date`, `closed_date`) VALUES
(891, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(892, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(893, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(894, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(895, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(896, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(897, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(898, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(899, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(900, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(901, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(902, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(903, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(904, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(905, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(906, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(907, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(908, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(909, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(910, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(911, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(912, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(913, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(914, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(915, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(916, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(917, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(918, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(919, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(920, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(921, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(922, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(923, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(924, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(925, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(926, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(927, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(928, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(929, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(930, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(931, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(932, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(933, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(934, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(935, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(936, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(937, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(938, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(939, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(940, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(941, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(942, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(943, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(944, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(945, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(946, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(947, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(948, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(949, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(950, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(951, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(952, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(953, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(954, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(955, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(956, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(957, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(958, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(959, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(960, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(961, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(962, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(963, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(964, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(965, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(966, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(967, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(968, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(969, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(970, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(971, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(972, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(973, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(974, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(975, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(976, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(977, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(978, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(979, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(980, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(981, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(982, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(983, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(984, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(985, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(986, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(987, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(988, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(989, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(990, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(991, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(992, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(993, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(994, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(995, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(996, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(997, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(998, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(999, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1000, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1001, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1002, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1003, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1004, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1005, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1006, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1007, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1008, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1009, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1010, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1011, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1012, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1013, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1014, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1015, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1016, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1017, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1018, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1019, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1020, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1021, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1022, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1023, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1024, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1025, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1026, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1027, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1028, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1029, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1030, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1031, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1032, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1033, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1034, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 5, '2015-11-28 04:56:55', 'yhannart@gmail.com', '2015-11-28 04:39:46', NULL),
(1035, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 1, NULL, NULL, NULL, NULL),
(1036, 1, 'sda das dsa d', NULL, '1', 'chonnh@gmail.com', NULL, '2015-11-27 10:27:12', 5, '2015-11-28 04:57:04', 'yhannart@gmail.com', '2015-11-28 04:39:45', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customer_problem_management`
--

CREATE TABLE IF NOT EXISTS `customer_problem_management` (
  `id` bigint(20) NOT NULL,
  `prob_id` bigint(20) NOT NULL,
  `handled_by` varchar(255) DEFAULT NULL,
  `handled_date` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer_problem_management`
--

INSERT INTO `customer_problem_management` (`id`, `prob_id`, `handled_by`, `handled_date`) VALUES
(1, 4, 'yhannart@gmail.com', '2015-11-28 04:15:07'),
(2, 6, 'yhannart@gmail.com', '2015-11-28 04:40:07'),
(3, 1034, 'yhannart@gmail.com', '2015-11-28 04:57:11'),
(4, 1036, 'chonnh@gmail.com', '2015-11-29 00:19:36');

-- --------------------------------------------------------

--
-- Table structure for table `customer_problem_status`
--

CREATE TABLE IF NOT EXISTS `customer_problem_status` (
  `id` bigint(20) NOT NULL,
  `code` int(11) NOT NULL,
  `description` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer_problem_status`
--

INSERT INTO `customer_problem_status` (`id`, `code`, `description`) VALUES
(1, 0, 'Open'),
(2, 1, 'In Process'),
(3, 2, 'Resolved'),
(4, 3, 'Re-Open'),
(5, 4, 'Re-Assigned'),
(6, 5, 'Cancel');

-- --------------------------------------------------------

--
-- Table structure for table `customer_subject`
--

CREATE TABLE IF NOT EXISTS `customer_subject` (
  `id` bigint(20) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer_subject`
--

INSERT INTO `customer_subject` (`id`, `subject`, `created_by`, `created_date`) VALUES
(1, 'I cannot access my account.', NULL, '2015-11-15 11:43:20'),
(2, 'test subject', NULL, '2015-11-17 08:32:37');

-- --------------------------------------------------------

--
-- Table structure for table `dau_so`
--

CREATE TABLE IF NOT EXISTS `dau_so` (
  `id` bigint(20) NOT NULL,
  `code` varchar(255) NOT NULL,
  `network` bigint(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `dau_so`
--

INSERT INTO `dau_so` (`id`, `code`, `network`) VALUES
(1, '090', 3),
(2, '093', 3),
(3, '0120', 3),
(4, '0121', 3),
(5, '0122', 3),
(6, '0126', 3),
(7, '0128', 3),
(8, '096', 1),
(9, '097', 1),
(10, '098', 1),
(11, '0163', 1),
(12, '0164', 1),
(13, '0165', 1),
(14, '0166', 1),
(15, '0167', 1),
(16, '0168', 1),
(17, '0169', 1),
(18, '091', 2),
(19, '094', 2),
(20, '0123', 2),
(21, '0124', 2),
(22, '0125', 2),
(23, '0127', 2),
(24, '0129', 2),
(25, '092', 5),
(26, '0188', 5),
(27, '095', 6),
(28, '0993', 4),
(29, '0994', 4),
(30, '0995', 4),
(31, '0996', 4),
(32, '0199', 4);

-- --------------------------------------------------------

--
-- Table structure for table `exchange_rates`
--

CREATE TABLE IF NOT EXISTS `exchange_rates` (
  `id` bigint(20) NOT NULL,
  `trader_id` bigint(20) NOT NULL,
  `currency_id` bigint(20) NOT NULL,
  `buy` decimal(10,0) NOT NULL,
  `sell` decimal(10,0) NOT NULL,
  `vcb_buy` decimal(10,0) NOT NULL,
  `vcb_sell` decimal(10,0) NOT NULL,
  `date_input` date NOT NULL,
  `time_input` time NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exchange_rates`
--

INSERT INTO `exchange_rates` (`id`, `trader_id`, `currency_id`, `buy`, `sell`, `vcb_buy`, `vcb_sell`, `date_input`, `time_input`) VALUES
(1, 1, 1, 22000, 22346, 21770, 21830, '2015-06-15', '10:17:45'),
(2, 1, 1, 22345, 22000, 21770, 21830, '2015-06-15', '10:18:07'),
(3, 1, 1, 22345, 22346, 21770, 21830, '2015-06-15', '10:31:39'),
(4, 1, 1, 22000, 22346, 21770, 21830, '2015-06-16', '15:42:58'),
(5, 1, 1, 22345, 20000, 21780, 21840, '2015-08-05', '21:48:24');

-- --------------------------------------------------------

--
-- Table structure for table `lixi_card_fees`
--

CREATE TABLE IF NOT EXISTS `lixi_card_fees` (
  `id` bigint(20) NOT NULL,
  `card_type` int(11) NOT NULL,
  `credit_debit` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `gift_only` double NOT NULL,
  `allow_refund` double NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lixi_card_fees`
--

INSERT INTO `lixi_card_fees` (`id`, `card_type`, `credit_debit`, `country`, `gift_only`, `allow_refund`) VALUES
(1, 1, 'DEBIT', 'USA', 2.49, 3.3),
(2, 2, 'DEBIT', 'USA', 2.49, 3.3),
(3, 3, 'DEBIT', 'USA', 2.49, 3.3),
(4, 4, 'DEBIT', 'USA', 2.49, 3.3),
(5, 1, 'DEBIT', 'OTHER', 3.89, 4.7),
(6, 2, 'DEBIT', 'OTHER', 3.89, 4.7),
(7, 3, 'DEBIT', 'OTHER', 3.89, 4.7),
(8, 4, 'DEBIT', 'OTHER', 3.89, 4.7),
(9, 1, 'CREDIT', 'USA', 2.69, 3.5),
(10, 2, 'CREDIT', 'USA', 2.69, 3.5),
(11, 3, 'CREDIT', 'USA', 2.69, 3.5),
(12, 4, 'CREDIT', 'USA', 2.69, 3.5),
(13, 1, 'CREDIT', 'OTHER', 3.89, 4.7),
(14, 2, 'CREDIT', 'OTHER', 3.89, 4.7),
(15, 3, 'CREDIT', 'OTHER', 3.89, 4.7),
(16, 4, 'CREDIT', 'OTHER', 3.89, 4.7);

-- --------------------------------------------------------

--
-- Table structure for table `lixi_category`
--

CREATE TABLE IF NOT EXISTS `lixi_category` (
  `id` int(11) NOT NULL,
  `vatgia_id` int(11) NOT NULL,
  `code` varchar(20) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `english` varchar(255) DEFAULT NULL,
  `vietnam` varchar(255) DEFAULT NULL,
  `activated` int(11) NOT NULL DEFAULT '1',
  `sort_order` int(11) NOT NULL DEFAULT '9999',
  `created_date` datetime NOT NULL,
  `created_by` varchar(255) NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `modified_by` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lixi_category`
--

INSERT INTO `lixi_category` (`id`, `vatgia_id`, `code`, `name`, `english`, `vietnam`, `activated`, `sort_order`, `created_date`, `created_by`, `modified_date`, `modified_by`) VALUES
(33, 13, 'FLOWER', 'Flower', 'Flower', 'Hoa tươi', 1, 1, '2015-09-14 10:38:23', 'yhannart@gmail.com', NULL, NULL),
(35, 11, 'COSMETICS', 'Cosmetics', 'Cosmetics', 'Mỹ Phẩm', 1, 9999, '2015-10-15 22:44:55', 'yhannart@gmail.com', NULL, NULL),
(37, 12, 'PERFUME', 'Perfume', 'Perfume', 'Nước hoa', 1, 9999, '2015-12-01 02:09:05', 'yhannart@gmail.com', NULL, NULL),
(39, 8, 'CHILDREN_TOY', 'Children Toy', 'Children Toy', 'Đồ chơi trẻ em', 1, 9999, '2015-12-01 02:33:39', 'yhannart@gmail.com', NULL, NULL),
(41, 9, 'JEWELRIES', 'Jewelries', 'Jewelries', 'Trang sức', 1, 9999, '2015-12-01 02:34:53', 'yhannart@gmail.com', NULL, NULL),
(43, 10, 'CANDIES', 'Candies', 'Candies', 'Bánh kẹo', 1, 9999, '2015-12-01 02:35:29', 'yhannart@gmail.com', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lixi_exchange_rates`
--

CREATE TABLE IF NOT EXISTS `lixi_exchange_rates` (
  `id` bigint(20) NOT NULL,
  `date_input` date NOT NULL,
  `time_input` time NOT NULL,
  `currency` varchar(10) NOT NULL,
  `buy` decimal(10,0) NOT NULL,
  `buy_percentage` double NOT NULL,
  `sell` decimal(10,0) NOT NULL,
  `sell_percentage` double NOT NULL,
  `created_by` varchar(255) NOT NULL,
  `created_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lixi_exchange_rates`
--

INSERT INTO `lixi_exchange_rates` (`id`, `date_input`, `time_input`, `currency`, `buy`, `buy_percentage`, `sell`, `sell_percentage`, `created_by`, `created_date`) VALUES
(1, '2015-06-17', '16:07:20', 'USD', 20691, -5, 20748, -5, 'chonnh@gmail.com', '2015-06-17 16:07:20'),
(2, '2015-06-17', '16:10:22', 'USD', 20691, -5, 20748, -5, 'chonnh@gmail.com', '2015-06-17 16:10:23'),
(3, '2015-06-17', '16:17:18', 'USD', 20691, -5, 20748, -5, 'chonnh@gmail.com', '2015-06-17 16:17:18'),
(4, '2015-06-17', '16:51:28', 'USD', 20686, -5, 20743, -5, 'yhannart@gmail.com', '2015-06-17 16:51:28'),
(5, '2015-06-17', '20:54:59', 'USD', 20000, -8.15, 20000, -8.4, 'chonnh@gmail.com', '2015-06-17 20:54:59'),
(6, '2015-06-17', '20:55:31', 'USD', 20000, -8.15, 20000, -8.4, 'chonnh@gmail.com', '2015-06-17 20:55:31'),
(7, '2015-06-18', '15:54:05', 'USD', 20686, -5, 22927, 5, 'chonnh@gmail.com', '2015-06-18 15:54:05'),
(8, '2015-06-18', '15:54:05', 'USD', 20686, -5, 22927, 5, 'chonnh@gmail.com', '2015-06-18 15:54:21'),
(9, '2015-06-18', '15:57:44', 'USD', 20686, -5, 23000, 5.34, 'chonnh@gmail.com', '2015-06-18 15:57:45'),
(10, '2015-06-18', '15:57:52', 'USD', 20686, -5, 23000, 5.34, 'chonnh@gmail.com', '2015-06-18 15:57:52'),
(11, '2015-08-12', '15:00:40', 'USD', 20000, -9.09, 23000, 4.21, 'yhannart@gmail.com', '2015-08-12 15:00:41'),
(12, '2015-08-13', '03:24:43', 'USD', 20891, -5, 23163, 5, 'yhannart@gmail.com', '2015-08-13 03:24:44'),
(13, '2015-08-13', '03:24:56', 'USD', 20000, -9.05, 23000, 4.26, 'yhannart@gmail.com', '2015-08-13 03:24:56'),
(14, '2015-08-20', '22:23:45', 'USD', 20500, -8.24, 23500, 4.82, 'yhannart@gmail.com', '2015-08-20 22:23:46'),
(15, '2015-11-29', '01:11:13', 'USD', 21300, -5, 23600, 5, 'yhannart@gmail.com', '2015-11-29 01:11:13'),
(16, '2015-11-29', '01:11:31', 'USD', 21700, -3, 23100, 3, 'yhannart@gmail.com', '2015-11-29 01:11:31');

-- --------------------------------------------------------

--
-- Table structure for table `lixi_fees`
--

CREATE TABLE IF NOT EXISTS `lixi_fees` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `fee` double NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lixi_fees`
--

INSERT INTO `lixi_fees` (`id`, `name`, `code`, `fee`) VALUES
(1, 'Lixi Card Processing Fee', 'LIXI_CARD_PROCESSING_FEE_ADD_ON', 0.35),
(2, 'Lixi Handling Fee', 'LIXI_HANDLING_FEE', 1),
(3, 'Lixi Echeck Gift Only', 'LIXI_ECHECK_FEE_GIFT_ONLY', 0.25),
(4, 'Lixi Echeck Allow Refund', 'LIXI_ECHECK_FEE_ALLOW_REFUND', 1.06);

-- --------------------------------------------------------

--
-- Table structure for table `lixi_global_fee`
--

CREATE TABLE IF NOT EXISTS `lixi_global_fee` (
  `id` bigint(20) NOT NULL,
  `country` bigint(20) NOT NULL,
  `payment_method` int(11) NOT NULL,
  `amount` double NOT NULL,
  `gift_only_fee` double NOT NULL,
  `allow_refund_fee` double NOT NULL,
  `max_fee` double NOT NULL,
  `lixi_fee` double NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lixi_global_fee`
--

INSERT INTO `lixi_global_fee` (`id`, `country`, `payment_method`, `amount`, `gift_only_fee`, `allow_refund_fee`, `max_fee`, `lixi_fee`) VALUES
(1, 1, 0, 50, 0, 3, 999, 0.99),
(2, 1, 0, 100, 0, 3, 2.76, 0.99),
(3, 1, 0, 250, 0, 3, 4.76, 0.99),
(4, 1, 1, 100, 0, 1.5, 1, 0.99),
(5, 1, 1, 250, 0, 1.5, 2, 0.99);

-- --------------------------------------------------------

--
-- Table structure for table `lixi_handling_fees`
--

CREATE TABLE IF NOT EXISTS `lixi_handling_fees` (
  `id` bigint(20) NOT NULL,
  `currency_code` varchar(10) NOT NULL,
  `start_range` double NOT NULL,
  `end_range` double NOT NULL,
  `fee` double NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lixi_handling_fees`
--

INSERT INTO `lixi_handling_fees` (`id`, `currency_code`, `start_range`, `end_range`, `fee`) VALUES
(1, 'USD', 0, 100, 1),
(2, 'USD', 100, 500, 1),
(3, 'USD', 500, 3000, 1);

-- --------------------------------------------------------

--
-- Table structure for table `lixi_invoices`
--

CREATE TABLE IF NOT EXISTS `lixi_invoices` (
  `id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `invoice_date` datetime DEFAULT NULL,
  `gift_price` double DEFAULT NULL,
  `card_fee` double DEFAULT NULL,
  `lixi_fee` double DEFAULT NULL,
  `total_amount` double DEFAULT NULL,
  `net_trans_id` varchar(255) DEFAULT NULL,
  `net_response_code` varchar(255) DEFAULT NULL,
  `net_trans_status` varchar(255) DEFAULT NULL,
  `last_check_date` datetime DEFAULT NULL,
  `created_date` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lixi_invoices`
--

INSERT INTO `lixi_invoices` (`id`, `order_id`, `invoice_date`, `gift_price`, `card_fee`, `lixi_fee`, `total_amount`, `net_trans_id`, `net_response_code`, `net_trans_status`, `last_check_date`, `created_date`) VALUES
(2, 4, '2015-12-15 08:48:44', 29.74, 0.89, 0.99, 31.62, '7802090559', '2', NULL, NULL, '2015-12-15 08:48:44');

-- --------------------------------------------------------

--
-- Table structure for table `lixi_invoice_payment`
--

CREATE TABLE IF NOT EXISTS `lixi_invoice_payment` (
  `id` bigint(20) NOT NULL,
  `invoice_id` bigint(20) NOT NULL,
  `response_code` varchar(10) DEFAULT '0',
  `response_text` mediumtext,
  `modified_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lixi_invoice_payment`
--

INSERT INTO `lixi_invoice_payment` (`id`, `invoice_id`, `response_code`, `response_text`, `modified_date`) VALUES
(3, 56, '-999', 'Can not create CreateTransactionResponse', '2015-11-13 09:46:24'),
(4, 56, '2', '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<ns2:local xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd" xmlns:ns2="uri">\n    <responseCode>2</responseCode>\n    <authCode>000000</authCode>\n    <avsResultCode>P</avsResultCode>\n    <cvvResultCode></cvvResultCode>\n    <cavvResultCode></cavvResultCode>\n    <transId>7704338550</transId>\n    <refTransID></refTransID>\n    <transHash>A0064A35396CC5443E5B6A2A26B24C74</transHash>\n    <testRequest>0</testRequest>\n    <accountNumber>XXXX0019</accountNumber>\n    <accountType>Visa</accountType>\n    <errors>\n        <error>\n            <errorCode>2</errorCode>\n            <errorText>This transaction has been declined.</errorText>\n        </error>\n    </errors>\n</ns2:local>\n', '2015-11-13 11:07:41'),
(5, 1, 'Error', '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<createTransactionResponse xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">\n    <messages>\n        <resultCode>Error</resultCode>\n        <message>\n            <code>E00027</code>\n            <text>The transaction was unsuccessful.</text>\n        </message>\n    </messages>\n    <transactionResponse>\n        <responseCode>3</responseCode>\n        <authCode></authCode>\n        <avsResultCode>P</avsResultCode>\n        <cvvResultCode></cvvResultCode>\n        <cavvResultCode></cavvResultCode>\n        <transId>0</transId>\n        <refTransID></refTransID>\n        <transHash>F68A9C87C1E1472521704EF38C21F647</transHash>\n        <testRequest>0</testRequest>\n        <accountNumber></accountNumber>\n        <accountType></accountType>\n        <errors>\n            <error>\n                <errorCode>5</errorCode>\n                <errorText>A valid amount is required.</errorText>\n            </error>\n        </errors>\n    </transactionResponse>\n</createTransactionResponse>\n', '2015-12-15 08:38:11'),
(6, 2, '2', '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<createTransactionResponse xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">\n    <messages>\n        <resultCode>Ok</resultCode>\n        <message>\n            <code>I00001</code>\n            <text>Successful.</text>\n        </message>\n    </messages>\n    <transactionResponse>\n        <responseCode>2</responseCode>\n        <authCode>000000</authCode>\n        <avsResultCode>U</avsResultCode>\n        <cvvResultCode></cvvResultCode>\n        <cavvResultCode></cavvResultCode>\n        <transId>7802090559</transId>\n        <refTransID></refTransID>\n        <transHash>A71912EFED2FC8AFFDC09F59ABE22A12</transHash>\n        <testRequest>0</testRequest>\n        <accountNumber>XXXX2222</accountNumber>\n        <accountType>Visa</accountType>\n        <errors>\n            <error>\n                <errorCode>2</errorCode>\n                <errorText>This transaction has been declined.</errorText>\n            </error>\n        </errors>\n    </transactionResponse>\n</createTransactionResponse>\n', '2015-12-15 08:48:49');

-- --------------------------------------------------------

--
-- Table structure for table `lixi_orders`
--

CREATE TABLE IF NOT EXISTS `lixi_orders` (
  `id` bigint(20) NOT NULL,
  `sender` bigint(20) NOT NULL,
  `lx_exchange_rate_id` bigint(20) NOT NULL,
  `card_id` bigint(20) DEFAULT NULL,
  `bank_account_id` bigint(20) DEFAULT NULL,
  `lixi_status` int(11) DEFAULT NULL,
  `lixi_message` text,
  `setting` int(11) DEFAULT NULL,
  `modified_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lixi_orders`
--

INSERT INTO `lixi_orders` (`id`, `sender`, `lx_exchange_rate_id`, `card_id`, `bank_account_id`, `lixi_status`, `lixi_message`, `setting`, `modified_date`) VALUES
(4, 15, 16, 8, NULL, -1, NULL, 1, '2015-12-15 08:48:44');

-- --------------------------------------------------------

--
-- Table structure for table `lixi_order_gifts`
--

CREATE TABLE IF NOT EXISTS `lixi_order_gifts` (
  `id` bigint(20) NOT NULL,
  `recipient` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `category` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `product_price` double DEFAULT NULL,
  `exch_price` double DEFAULT NULL,
  `usd_price` double DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_image` varchar(255) DEFAULT NULL,
  `product_quantity` int(11) NOT NULL DEFAULT '1',
  `bk_status` int(11) DEFAULT NULL,
  `bk_message` varchar(255) DEFAULT NULL,
  `bk_receive_method` varchar(255) DEFAULT NULL,
  `bk_updated` datetime DEFAULT NULL,
  `modified_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lixi_order_gifts`
--

INSERT INTO `lixi_order_gifts` (`id`, `recipient`, `order_id`, `category`, `product_id`, `product_price`, `exch_price`, `usd_price`, `product_name`, `product_image`, `product_quantity`, `bk_status`, `bk_message`, `bk_receive_method`, `bk_updated`, `modified_date`) VALUES
(49, 14, 4, 41, 106, 95000, 95046, 4.38, 'Dây chuyền thời trang Hàn Quốc PK2051', 'http://p.vatgia.vn/ir/pictures_fullsize/7/ZHVoMTQwNDkxMjYxNy5qcGc-/day-chuyen-thoi-trang-han-quoc-pk2051.jpg', 1, -1, NULL, NULL, NULL, '2015-12-11 02:20:19'),
(50, 14, 4, 41, 89, 105000, 105028, 4.84, 'Vòng tay PK 2394', 'http://p.vatgia.vn/ir/pictures_fullsize/7/d2t6MTQyNTU0Mjc4My5qcGc-/vong-tay-pk-2394.jpg', 1, -1, NULL, NULL, NULL, '2015-12-11 02:20:21'),
(51, 14, 4, 41, 97, 95000, 95046, 4.38, 'Vòng tay PK 2372', 'http://p.vatgia.vn/ir/pictures_fullsize/7/emRmMTQyNTU0MjkyOC5qcGc-/vong-tay-pk-2372.jpg', 1, -1, NULL, NULL, NULL, '2015-12-11 02:20:23'),
(52, 14, 4, 41, 83, 95000, 95046, 4.38, 'Bộ trang sức ngọc trai bướm PK 2143', 'http://p.vatgia.vn/ir/pictures_fullsize/7/cGlhMTQwOTU2NjcxMC5qcGc-/bo-trang-suc-ngoc-trai-buom-pk-2143.jpg', 1, -1, NULL, NULL, NULL, '2015-12-11 02:20:24'),
(53, 14, 4, 41, 94, 85000, 85064, 3.92, 'Dây chuyền PK 2588', 'http://p.vatgia.vn/ir/pictures_fullsize/7/ZmV3MTQyNTU0MTYxNi5qcGc-/day-chuyen-pk-2588.jpg', 3, -1, NULL, NULL, NULL, '2015-12-11 02:20:25');

-- --------------------------------------------------------

--
-- Table structure for table `money_level`
--

CREATE TABLE IF NOT EXISTS `money_level` (
  `id` bigint(20) NOT NULL,
  `amount` double NOT NULL,
  `code` varchar(10) NOT NULL,
  `is_default` tinyint(4) NOT NULL DEFAULT '0',
  `modified_date` datetime NOT NULL,
  `modified_by` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `money_level`
--

INSERT INTO `money_level` (`id`, `amount`, `code`, `is_default`, `modified_date`, `modified_by`) VALUES
(1, 150, 'USD', 1, '2015-08-19 10:23:18', 'chonnh@gmail.com'),
(2, 200, 'USD', 0, '2015-08-19 08:16:13', 'chonnh@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `networks`
--

CREATE TABLE IF NOT EXISTS `networks` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `networks`
--

INSERT INTO `networks` (`id`, `name`) VALUES
(1, 'Viettel'),
(2, 'Vinafone'),
(3, 'Mobifone'),
(4, 'Gmobile'),
(5, 'Vietnamobile'),
(6, 'SFone');

-- --------------------------------------------------------

--
-- Table structure for table `recipients`
--

CREATE TABLE IF NOT EXISTS `recipients` (
  `id` bigint(20) NOT NULL,
  `sender` bigint(20) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `dial_code` varchar(10) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `note` text,
  `modified_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `recipients`
--

INSERT INTO `recipients` (`id`, `sender`, `first_name`, `middle_name`, `last_name`, `email`, `dial_code`, `phone`, `note`, `modified_date`) VALUES
(13, 15, 'Dam', 'Thi', 'Dao', 'daothidam88@gmail.com', '+84', '0967218391', 'Happy Birthday g', '2015-12-11 01:56:05'),
(14, 15, 'Thong', 'Van', 'Chau', 'thongcv@gmail.com', '+84', '01649838760', 'Happy Birthday', '2015-12-11 02:20:15');

-- --------------------------------------------------------

--
-- Table structure for table `support_locale`
--

CREATE TABLE IF NOT EXISTS `support_locale` (
  `id` bigint(20) NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_by` varchar(255) NOT NULL,
  `created_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `support_locale`
--

INSERT INTO `support_locale` (`id`, `code`, `name`, `created_by`, `created_date`) VALUES
(1, 'en_US', 'English', 'chonnh@gmail.com', '2015-07-21 11:00:00'),
(2, 'vi_VN', 'Vietnamese', 'chonnh@gmail.com', '2015-07-21 10:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `top_up_mobile_phone`
--

CREATE TABLE IF NOT EXISTS `top_up_mobile_phone` (
  `id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `recipient` bigint(20) NOT NULL,
  `amount` double NOT NULL,
  `currency` varchar(10) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `modified_date` datetime NOT NULL,
  `is_submitted` int(11) DEFAULT '0',
  `response_code` int(11) DEFAULT NULL,
  `response_message` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `top_up_result`
--

CREATE TABLE IF NOT EXISTS `top_up_result` (
  `id` bigint(20) NOT NULL,
  `top_up_id` bigint(20) NOT NULL,
  `request_data` text NOT NULL,
  `response_data` text NOT NULL,
  `modified_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `traders`
--

CREATE TABLE IF NOT EXISTS `traders` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `created_date` datetime NOT NULL,
  `modified_date` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `traders`
--

INSERT INTO `traders` (`id`, `name`, `username`, `password`, `email`, `phone`, `created_date`, `modified_date`) VALUES
(1, 'Nguyen Huu Chon', 'chonnh', '$2a$10$qNLGaXSrFaMwNAYk0p84VekxjXRjVXFOdEUAok0U3kFZE0k0KHtau', 'chonnh@gmail.com', '0967007869', '2015-06-12 11:06:54', NULL),
(2, 'ABC', 'daothidam', '$2a$10$Qb8ecnMq4klE0bra09hkSuQkDEdJpIlnbah9u.Y7Y2VVpPkRthI/i', 'abc@abc.com', '0967457869', '2015-08-03 23:55:40', NULL),
(3, 'Ngueyn Van A', 'nguyenvana', '$2a$10$NI4bNqAURDDE05at5KcWCOqdXk.BTjj/fjwCDtSs1U8SfjAQfwZme', 'chonnh1@gmail.com', '0909123456', '2015-08-06 15:34:40', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) NOT NULL,
  `authorize_profile_id` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `account_non_expired` tinyint(1) NOT NULL,
  `account_non_locked` tinyint(1) NOT NULL,
  `credentials_non_expired` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `activated` tinyint(1) NOT NULL,
  `created_date` datetime NOT NULL,
  `created_by` varchar(255) NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `modified_by` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `authorize_profile_id`, `first_name`, `middle_name`, `last_name`, `email`, `password`, `phone`, `account_non_expired`, `account_non_locked`, `credentials_non_expired`, `enabled`, `activated`, `created_date`, `created_by`, `modified_date`, `modified_by`) VALUES
(12, NULL, 'Nguyen Huu', '', 'Chon', 'chonnh@gmail.com', '$2a$10$fl.cco/w1qCkD1UNDTUij.8cMrEpAdZZhr7G/Zt3uLdBdzWsZsHhS', '+84967007869', 1, 1, 1, 1, 1, '2015-10-31 01:52:33', 'chonnh@gmail.com', NULL, NULL),
(15, '201421605', 'Dam', 'Thi', 'Dao', 'daothidam88@gmail.com', '$2a$10$lL.xqmiRJTr6qo8BY12tu.Fa82YxgalI71IBTE1XVJeKs0nryJYVq', '0967218391', 1, 1, 1, 1, 1, '2015-12-03 02:52:21', 'daothidam88@gmail.com', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_bank_accounts`
--

CREATE TABLE IF NOT EXISTS `user_bank_accounts` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `bank_rounting` varchar(255) NOT NULL,
  `checking_account` varchar(255) NOT NULL,
  `driver_license` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `bill_address` bigint(20) DEFAULT NULL,
  `modified_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_cards`
--

CREATE TABLE IF NOT EXISTS `user_cards` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `authorize_payment_id` varchar(255) DEFAULT NULL,
  `card_type` int(11) NOT NULL,
  `card_name` varchar(255) NOT NULL,
  `card_number` varchar(255) NOT NULL,
  `exp_month` int(11) NOT NULL,
  `exp_year` int(11) NOT NULL,
  `card_cvv` varchar(10) NOT NULL,
  `bill_address` bigint(20) DEFAULT NULL,
  `modified_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_cards`
--

INSERT INTO `user_cards` (`id`, `user_id`, `authorize_payment_id`, `card_type`, `card_name`, `card_number`, `exp_month`, `exp_year`, `card_cvv`, `bill_address`, `modified_date`) VALUES
(4, 15, '194955369', 1, 'NGUYEN HUU CHON', '4283100434520019', 2, 2019, '300', 1, '2015-12-12 23:05:38'),
(8, 15, '194979953', 1, 'DAO THI DAM', 'XXXX2222', 0, 0, '000', 6, '2015-12-13 01:21:46');

-- --------------------------------------------------------

--
-- Table structure for table `user_money_level`
--

CREATE TABLE IF NOT EXISTS `user_money_level` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `money_level` bigint(20) NOT NULL,
  `modified_date` datetime NOT NULL,
  `modified_by` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_money_level`
--

INSERT INTO `user_money_level` (`id`, `user_id`, `money_level`, `modified_date`, `modified_by`) VALUES
(10, 15, 1, '2015-12-03 02:52:21', 'SYSTEM_AUTO');

-- --------------------------------------------------------

--
-- Table structure for table `user_secret_code`
--

CREATE TABLE IF NOT EXISTS `user_secret_code` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `code` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_date` datetime NOT NULL,
  `expired_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `vatgia_category`
--

CREATE TABLE IF NOT EXISTS `vatgia_category` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `activated` int(11) NOT NULL DEFAULT '1',
  `sort_order` int(11) NOT NULL DEFAULT '9999'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vatgia_category`
--

INSERT INTO `vatgia_category` (`id`, `title`, `activated`, `sort_order`) VALUES
(1, 'Accessories', 0, 9999),
(2, 'Baby Stuffs', 0, 9999),
(3, 'Clothes', 0, 9999),
(5, 'Sleep lamp', 0, 9999),
(6, 'Chocolate', 0, 9999),
(8, 'Toy', 1, 9999),
(9, 'Jewelries', 1, 9999),
(10, 'Candies', 1, 9999),
(11, 'Cosmetics', 1, 9999),
(12, 'Perfume', 1, 9999),
(13, 'Flower', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `vatgia_products`
--

CREATE TABLE IF NOT EXISTS `vatgia_products` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `category_name` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `link_detail` varchar(255) DEFAULT NULL,
  `alive` int(11) DEFAULT NULL,
  `modified_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vatgia_products`
--

INSERT INTO `vatgia_products` (`id`, `category_id`, `category_name`, `name`, `price`, `image_url`, `link_detail`, `alive`, `modified_date`) VALUES
(1, 1, 'Accessories', 'Mini fan', 75000, 'http://p.vatgia.vn/pictures_fullsize/dia1334650616.jpg', 'http://vatgia.com/shoptuancua&module=product&view=detail&record_id=2087683', 1, '2015-12-04 03:42:01'),
(2, 1, 'Accessories', 'Laptop table ', 280000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dXV6MTM0MDI2Mjk4Mi5qcGc-/ban-de-laptop-da-nang-m-lucky.jpg', 'http://vatgia.com/shoptuancua&module=product&view=detail&record_id=2260052', 1, '2015-12-04 03:42:01'),
(3, 1, 'Accessories', 'Laptop fan', 518000, 'http://p.vatgia.vn/pictures_fullsize/xzz1340185187.jpg', 'http://vatgia.com/shoptuancua&module=product&view=detail&record_id=2257148', 1, '2015-12-04 03:42:01'),
(4, 1, 'Accessories', 'Bracelet', 160000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/c3ZpMTQyODg5MTc0Ni5qcGc-/vong-tay-meo-than-tai-3-meo.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4994218', 1, '2015-12-04 03:42:01'),
(5, 1, 'Accessories', 'Bracelet', 220000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Y29hMTQyODg5MTcwOS5qcGc-/vong-tay-meo-than-tai-5-meo.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4994214', 1, '2015-12-04 03:42:01'),
(6, 1, 'Accessories', 'Alarm ', 280000, 'http://p.vatgia.vn/pictures_fullsize/oxx1429067798.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=5000799', 1, '2015-12-04 03:42:01'),
(7, 1, 'Accessories', 'Alarm ', 280000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/b3h6MTQyODk3OTUwOS5qcGc-/dong-ho-dien-tu-bang-viet-huynh-quang-kitty.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4997490', 1, '2015-12-04 03:42:01'),
(8, 1, 'Accessories', 'Alarm ', 340000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Z3FiMTQyODk3OTMxNS5qcGc-/dong-ho-bao-thuc-go-chieng.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4997462', 1, '2015-12-04 03:42:01'),
(9, 1, 'Accessories', 'Alarm ', 400000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/YnlxMTQyODk3NTk2Mi5qcGc-/dong-ho-xe-dap-co-dien.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4997177', 1, '2015-12-04 03:42:01'),
(10, 1, 'Accessories', 'Clock', 350000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/cndlMTQyODk0ODkwMC5qcGc-/dong-ho-treo-tuong-moc-treo-hinh-hoa.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4997024', 1, '2015-12-04 03:42:01'),
(11, 2, 'Baby Stuffs', 'Piano for kid', 330000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dHdjMTM2NjYxNDE1Ni5qcGc-/dan-hoc-nhac-37-phim.jpg', 'http://vatgia.com/shoptuancua&module=product&view=detail&record_id=3041229', 1, '2015-12-04 03:42:01'),
(12, 2, 'Baby Stuffs', 'roller skates', 780000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/d3VhMTM2MTc4MjM3OS5qcGc-/giay-patin-flying-eagle-x2-xanh-den.jpg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=2501410', 1, '2015-12-04 03:42:01'),
(13, 2, 'Baby Stuffs', 'roller skates', 680000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGhyMTM0NzYxMDkyOS5qcGVn/giay-truot-patin-flying-eagle-x1.jpeg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=2501465', 1, '2015-12-04 03:42:01'),
(14, 2, 'Baby Stuffs', 'roller skates', 1100000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bnllMTQyNzk0NTgzNy5wbmc-/giay-truot-patin-seba-f5166-xanh.png', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=4964528', 1, '2015-12-04 03:42:01'),
(15, 2, 'Baby Stuffs', 'roller skates', 1160000, 'http://p.vatgia.vn/ir/user_product_fullsize/7/cG1tMTQyNjU3NTIyOC5KUEc-/giay-truot-patin-tre-em-ibord.jpg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=4747941', 1, '2015-12-04 03:42:01'),
(16, 2, 'Baby Stuffs', 'roller skates', 1680000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dHFvMTQyNzI2NzE3OC5wbmc-/giay-truot-patin-golden-2.png', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=4940146', 1, '2015-12-04 03:42:01'),
(17, 2, 'Baby Stuffs', 'roller skates', 1089000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/YmN1MTQyNzk0NTk0MS5qcGc-/giay-truot-patin-seba-f5166-vang.jpg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=4964535', 1, '2015-12-04 03:42:01'),
(18, 2, 'Baby Stuffs', 'roller skates', 1089000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/aWtxMTQyNzk0NjA4OS5qcGc-/giay-truot-patin-seba-f5166-den-trang.jpg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=4964553', 1, '2015-12-04 03:42:01'),
(19, 2, 'Baby Stuffs', 'Skate board', 850000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Z2pjMTM5MzgzMTk0OS5qcGc-/van-truot-penny-mklong-v1.jpg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=3859291', 1, '2015-12-04 03:42:01'),
(20, 2, 'Baby Stuffs', 'Skate board', 764400, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Z2pjMTM5MzgzMTk0OS5qcGc-/van-truot-penny-mklong-v1.jpg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=3844730', 1, '2015-12-04 03:42:01'),
(21, 2, 'Baby Stuffs', 'Skate board', 880000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Z2xrMTM4NDIyNjQxMi5qcGc-/van-truot-rap-san-1.jpg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=3569224', 1, '2015-12-04 03:42:01'),
(22, 2, 'Baby Stuffs', 'Skate board', 880000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/d3F0MTM4NDIyNjU5Ny5qcGc-/van-truot-rap-san-3.jpg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=3569233', 1, '2015-12-04 03:42:01'),
(23, 2, 'Baby Stuffs', 'Skate board', 680000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/emZkMTM5MzMxMjQ0NS5qcGc-/van-truot-fire-skateboard.jpg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=3844743', 1, '2015-12-04 03:42:01'),
(24, 2, 'Baby Stuffs', 'Skate board', 760000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/aHNlMTM4NDIyNjI1Ni5qcGc-/van-lac.jpg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=3569214', 1, '2015-12-04 03:42:01'),
(25, 2, 'Baby Stuffs', 'Skate board', 1250000, 'http://p.vatgia.vn/pictures_fullsize/fyu1402282628.jpg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=4139681', 1, '2015-12-04 03:42:01'),
(26, 3, 'Clothes', 'Dress set', 550000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/cW1oMTQwODU0NDc0Mi5qcGc-/set-bo-vay-zara-sang-trong-dv380.jpg', 'http://vatgia.com/thoitranglady&module=product&view=detail&record_id=4357758', 1, '2015-12-04 03:42:02'),
(27, 3, 'Clothes', 'Dress', 490000, 'http://g.vatgia.vn/gallery_img/9/iih1407229481.jpg', 'http://vatgia.com/thoitranglady&module=product&view=detail&record_id=4310794', 1, '2015-12-04 03:42:02'),
(28, 3, 'Clothes', 'dress', 340000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/eWltMTM5ODIzOTg2MC5qcGc-/dam-cong-so-dv331.jpg', 'http://vatgia.com/thoitranglady&module=product&view=detail&record_id=4011674', 1, '2015-12-04 03:42:02'),
(29, 3, 'Clothes', 'Maxi', 255000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/YWV5MTM2Nzk5ODc5My5qcGc-/dam-maxi-hai-day-dv195.jpg', 'http://vatgia.com/thoitranglady&module=product&view=detail&record_id=3075098', 1, '2015-12-04 03:42:02'),
(30, 3, 'Clothes', 'Maxi', 250000, 'http://p.vatgia.vn/pictures_fullsize/feu1366643972.jpg', 'http://vatgia.com/thoitranglady&module=product&view=detail&record_id=3042878', 1, '2015-12-04 03:42:02'),
(31, 3, 'Clothes', 'dress', 139000, '', 'http://vatgia.com/xbibishop&module=product&view=detail&record_id=4128631', 1, '2015-12-04 03:42:02'),
(32, 3, 'Clothes', 'dress', 129000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/cGJpMTM5OTUyNTYxOC5qcGc-/vay-suong-hoa-tiet-thuy-thu-xb-492.jpg', 'http://vatgia.com/xbibishop&module=product&view=detail&record_id=4046024', 1, '2015-12-04 03:42:02'),
(33, 3, 'Clothes', 'Man shirt', 250000, 'http://p.vatgia.vn/pictures_fullsize/csy1427008904.jpg', 'http://vatgia.com/xbibishop&module=product&view=detail&record_id=4931307', 1, '2015-12-04 03:42:02'),
(34, 3, 'Clothes', 'Man shirt', 250000, 'http://p.vatgia.vn/pictures_fullsize/egb1427012162.jpg', 'http://vatgia.com/xbibishop&module=product&view=detail&record_id=4931386', 1, '2015-12-04 03:42:02'),
(35, 3, 'Clothes', 'Man shirt', 250000, 'http://p.vatgia.vn/pictures_fullsize/gxq1427009792.jpg', 'http://vatgia.com/xbibishop&module=product&view=detail&record_id=4931371', 1, '2015-12-04 03:42:02'),
(42, 5, 'Sleep lamp', 'Sleep lamp', 120000, 'http://p.vatgia.vn/pictures_fullsize/pps1428996903.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4998814', 1, '2015-12-04 03:42:02'),
(43, 5, 'Sleep lamp', 'Sleep lamp', 170000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/cWpiMTQyODk5Njg2OS5qcGc-/den-ngu-phi-hanh-gia.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4998811', 1, '2015-12-04 03:42:02'),
(44, 5, 'Sleep lamp', 'Alarm lamp', 270000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/ZmdsMTQyODk5Njc3OS5qcGc-/den-ngu-bao-thuc-cho-snoopy.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4998796', 1, '2015-12-04 03:42:02'),
(45, 5, 'Sleep lamp', '3D lamp', 290000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bHJoMTQyODk5NjY5OC5qcGc-/den-ngu-3d-dan-tuong-hinh-cho-dom.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4998791', 1, '2015-12-04 03:42:02'),
(46, 5, 'Sleep lamp', 'Cat familylamp', 380000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/a3VnMTQyODk5Njg4NS5qcGc-/den-ngu-gia-dinh-meo-con.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4998812', 1, '2015-12-04 03:42:02'),
(47, 6, 'Chocolate\r\n', 'Chocolate', 90000, 'http://p.vatgia.vn/pictures_fullsize/wsr1428980714.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4997641', 1, '2015-12-04 03:42:02'),
(48, 6, 'Chocolate\r\n', 'Chocolate', 90000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/c2JrMTQyOTAzMDA4OC5qcGc-/socola-valentine-hop-1-vien-vtn-3.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=5000092', 1, '2015-12-04 03:42:02'),
(49, 6, 'Chocolate\r\n', 'Chocolate', 180000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/ZXV3MTQyODk4MDg1My5qcGc-/socola-valentine-hop-1-vien-vtn-5.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4997658', 1, '2015-12-04 03:42:02'),
(50, 6, 'Chocolate\r\n', 'Chocolate', 180000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/ZW9yMTQyOTAzMDk4OC5qcGc-/socola-valentine-hop-1-vien-vtn-7.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=5000098', 1, '2015-12-04 03:42:02'),
(51, 6, 'Chocolate\r\n', 'Chocolate', 250000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dmtrMTQyOTAzMDg3OS5qcGc-/socola-valentine-hop-1-vien-vtn-8.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=5000096', 1, '2015-12-04 03:42:02'),
(64, 8, 'Toy', 'Car', 330000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dHZtMTQyODk0NjIwMi5qcGc-/mo-hinh-o-to-mai-che-co-dien.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4996993', 1, '2015-12-04 03:42:03'),
(65, 8, 'Toy', 'Car', 980000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/enZnMTQyOTA3MzQxMC5qcGc-/bo-mo-hinh-xe-dua-duong-ray.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=5001429', 1, '2015-12-04 03:42:03'),
(66, 8, 'Toy', 'Board', 150000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/cmliMTQyODk0ODQyNC5qcGc-/mo-hinh-tau-go-dia-trung-hai-belem-20cm.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4997020', 1, '2015-12-04 03:42:03'),
(67, 8, 'Toy', 'Board', 150000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/b2NpMTQyODk0NjYyNS5qcGc-/mo-hinh-thuyen-buom-r-rickmers.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4996999', 1, '2015-12-04 03:42:03'),
(68, 8, 'Toy', 'Board', 150000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dW1wMTQyODk0NzgxMy5qcGc-/mo-hinh-thuyen-buom-fregatte.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4997014', 1, '2015-12-04 03:42:03'),
(69, 8, 'Toy', 'Car', 410000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/ZmdrMTQyODk0NjMwMS5qcGc-/mo-hinh-xe-mini-cooper.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4996994', 1, '2015-12-04 03:42:03'),
(70, 8, 'Toy', 'Car', 330000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/anJ0MTQyODk0NzUwMS5qcGc-/bo-mo-hinh-sieu-xe-batman.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4997013', 1, '2015-12-04 03:42:03'),
(71, 8, 'Toy', 'Airplane', 350000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/a2JzMTQyOTA2NTIxOS5qcGc-/may-bay-mo-hinh-co-dien.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=5000480', 1, '2015-12-04 03:42:03'),
(77, 9, 'Jewelries', 'Bộ trang sức trái tim PK 2241', 220000, 'http://p.vatgia.vn/pictures_fullsize/gwx1418914893.jpg', 'http://www.vatgia.com/2407/4731705/b%E1%BB%99-trang-s%E1%BB%A9c-tr%C3%A1i-tim-pk-2241.html', 1, '2015-12-04 03:42:03'),
(78, 9, 'Jewelries', 'Bộ trang sức nơ ngọc trai PK 2284', 115000, 'http://p.vatgia.vn/pictures_fullsize/luy1418913028.jpg', 'http://www.vatgia.com/2407/4731660/b%E1%BB%99-trang-s%E1%BB%A9c-n%C6%A1-ng%E1%BB%8Dc-trai-pk-2284.html', 1, '2015-12-04 03:42:03'),
(79, 9, 'Jewelries', 'Vòng tay mạ vàng Hàn Quốc PK 1888', 130000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Z2ltMTM5NzE4NzM1Ny5qcGc-/vong-tay-ma-vang-han-quoc-pk-1888.jpg', 'http://www.vatgia.com/2406/3973042/v%C3%B2ng-tay-m%E1%BA%A1-v%C3%A0ng-h%C3%A0n-qu%E1%BB%91c-pk-1888.html', 1, '2015-12-04 03:42:03'),
(80, 9, 'Jewelries', 'Bộ trang sức thời trang PK 2007', 195000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dWtnMTQwMTExNDk2My5qcGc-/bo-trang-suc-thoi-trang-pk-2007.jpg', 'http://www.vatgia.com/2407/4102195/b%E1%BB%99-trang-s%E1%BB%A9c-th%E1%BB%9Di-trang-pk-2007.html', 1, '2015-12-04 03:42:03'),
(81, 9, 'Jewelries', 'Dây chuyền ngọc trai DT078', 1395000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/ZXdhMTM5NjU3OTEwNC5qcGc-/day-chuyen-ngoc-trai-dt078.jpg', 'http://www.vatgia.com/2405/3952642/d%C3%A2y-chuy%E1%BB%81n-ng%E1%BB%8Dc-trai-dt078.html', 1, '2015-12-04 03:42:03'),
(82, 9, 'Jewelries', 'Bộ trang sức PK 2429', 312000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/d2RwMTQyOTEwNjcwMi5qcGc-/bo-trang-suc-pk-2429.jpg', 'http://www.vatgia.com/2407/4885127/b%E1%BB%99-trang-s%E1%BB%A9c-pk-2429.html', 1, '2015-12-04 03:42:03'),
(83, 9, 'Jewelries', 'Bộ trang sức ngọc trai bướm PK 2143', 95000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/cGlhMTQwOTU2NjcxMC5qcGc-/bo-trang-suc-ngoc-trai-buom-pk-2143.jpg', 'http://www.vatgia.com/2407/4392754/b%E1%BB%99-trang-s%E1%BB%A9c-ng%E1%BB%8Dc-trai-b%C6%B0%E1%BB%9Bm-pk-2143.html', 1, '2015-12-04 03:42:03'),
(84, 9, 'Jewelries', 'Bộ trang sức thời trang PK 2017', 230000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/YXp4MTQwMTExNDQxMi5qcGc-/bo-trang-suc-thoi-trang-pk-2017.jpg', 'http://www.vatgia.com/2407/4102176/b%E1%BB%99-trang-s%E1%BB%A9c-th%E1%BB%9Di-trang-pk-2017.html', 1, '2015-12-04 03:42:03'),
(85, 9, 'Jewelries', 'Bộ trang sức ngọc trai PK 2236', 155000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/emJoMTQxODkxNTAzMS5qcGc-/bo-trang-suc-ngoc-trai-pk-2236.jpg', 'http://www.vatgia.com/2407/4731709/b%E1%BB%99-trang-s%E1%BB%A9c-ng%E1%BB%8Dc-trai-pk-2236.html', 1, '2015-12-04 03:42:03'),
(86, 9, 'Jewelries', 'Bộ trang sức giọt nước PK 2245', 175000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/cm53MTQxODkxNDgxNy5qcGc-/bo-trang-suc-giot-nuoc-pk-2245.jpg', 'http://www.vatgia.com/2407/4731703/b%E1%BB%99-trang-s%E1%BB%A9c-gi%E1%BB%8Dt-n%C6%B0%E1%BB%9Bc-pk-2245.html', 1, '2015-12-04 03:42:03'),
(87, 9, 'Jewelries', 'Bông tai BT0012', 165000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/eXNjMTQyOTU4OTAwOC5qcGc-/bong-tai-bt0012.jpg', 'http://www.vatgia.com/2409/5017746/b%C3%B4ng-tai-bt0012.html', 1, '2015-12-04 03:42:03'),
(88, 9, 'Jewelries', 'Nhẫn nam RM0266', 600000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/YWdpMTQyOTgwMTkyNC5qcGc-/nhan-nam-rm0266.jpg', 'http://www.vatgia.com/7101/5027399/nh%E1%BA%ABn-nam-rm0266.html', 1, '2015-12-04 03:42:03'),
(89, 9, 'Jewelries', 'Vòng tay PK 2394', 105000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/d2t6MTQyNTU0Mjc4My5qcGc-/vong-tay-pk-2394.jpg', 'http://www.vatgia.com/2406/4889715/v%C3%B2ng-tay-pk-2394.html', 1, '2015-12-04 03:42:03'),
(90, 9, 'Jewelries', 'Bộ trang sức hoa ngọc trai PK 2160', 130000, 'http://p.vatgia.vn/ir/gallery_img/15/7/YXp5MTQxMDc5MDU2Ni5qcGc-/bo-trang-suc-hoa-ngoc-trai-pk-2160-anh-2.jpg', 'http://www.vatgia.com/2407/4428744/b%E1%BB%99-trang-s%E1%BB%A9c-hoa-ng%E1%BB%8Dc-trai-pk-2160.html', 1, '2015-12-04 03:42:03'),
(91, 9, 'Jewelries', 'Bộ trang sức thời trang PK 1925', 155000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/aWNrMTM5ODMzMzU3NC5qcGc-/bo-trang-suc-thoi-trang-pk-1925.jpg', 'http://www.vatgia.com/2407/4016528/b%E1%BB%99-trang-s%E1%BB%A9c-th%E1%BB%9Di-trang-pk-1925.html', 1, '2015-12-04 03:42:03'),
(92, 9, 'Jewelries', 'Bộ thạch anh tím SPB0312', 860000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dWtqMTQzNDUxNDczNC5qcGc-/bo-thach-anh-tim-spb0312.jpg', 'http://www.vatgia.com/2407/5156389/b%E1%BB%99-th%E1%BA%A1ch-anh-t%C3%ADm-spb0312.html', 1, '2015-12-04 03:42:03'),
(93, 9, 'Jewelries', 'Bộ trang sức thời trang PK 1970', 195000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dWlzMTQwODEwNDg4Ni5qcGc-/bo-trang-suc-thoi-trang-pk-1970.jpg', 'http://www.vatgia.com/2407/4342408/b%E1%BB%99-trang-s%E1%BB%A9c-th%E1%BB%9Di-trang-pk-1970.html', 1, '2015-12-04 03:42:03'),
(94, 9, 'Jewelries', 'Dây chuyền PK 2588', 85000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/ZmV3MTQyNTU0MTYxNi5qcGc-/day-chuyen-pk-2588.jpg', 'http://www.vatgia.com/2405/4889598/d%C3%A2y-chuy%E1%BB%81n-pk-2588.html', 1, '2015-12-04 03:42:03'),
(95, 9, 'Jewelries', 'Bộ trang sức ngọc trai PK 2464', 190000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/d3hwMTQzMjQ3Nzg2Ny5qcGc-/bo-trang-suc-ngoc-trai-pk-2464.jpg', 'http://www.vatgia.com/2407/5099902/b%E1%BB%99-trang-s%E1%BB%A9c-ng%E1%BB%8Dc-trai-pk-2464.html', 1, '2015-12-04 03:42:03'),
(96, 9, 'Jewelries', 'Bộ trang sức PK 2377', 175000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/eWNyMTQyNTY1MDI4Ni5qcGc-/bo-trang-suc-pk-2377.jpg', 'http://www.vatgia.com/2407/4893201/b%E1%BB%99-trang-s%E1%BB%A9c-pk-2377.html', 1, '2015-12-04 03:42:03'),
(97, 9, 'Jewelries', 'Vòng tay PK 2372', 95000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/emRmMTQyNTU0MjkyOC5qcGc-/vong-tay-pk-2372.jpg', 'http://www.vatgia.com/2406/4889724/v%C3%B2ng-tay-pk-2372.html', 1, '2015-12-04 03:42:03'),
(98, 9, 'Jewelries', 'Bộ trang sức hình cá PK 2279', 310000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/YnZyMTQxODkxMzI3My5qcGc-/bo-trang-suc-hinh-ca-pk-2279.jpg', 'http://www.vatgia.com/2407/4731669/b%E1%BB%99-trang-s%E1%BB%A9c-h%C3%ACnh-c%C3%A1-pk-2279.html', 1, '2015-12-04 03:42:03'),
(99, 9, 'Jewelries', 'Bộ trang sức thời trang PK 1986', 210000, 'http://p.vatgia.vn/ir/gallery_img/15/7/a2FuMTQwMTExNzExMC5qcGc-/bo-trang-suc-thoi-trang-pk-1986-anh-2.jpg', 'http://www.vatgia.com/2407/4102307/b%E1%BB%99-trang-s%E1%BB%A9c-th%E1%BB%9Di-trang-pk-1986.html', 1, '2015-12-04 03:42:03'),
(100, 9, 'Jewelries', 'Bộ trang sức thời trang PK 1986', 210000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bmR3MTQwMTExNzExMC5qcGc-/bo-trang-suc-thoi-trang-pk-1986.jpg', 'http://www.vatgia.com/2407/4102307/b%E1%BB%99-trang-s%E1%BB%A9c-th%E1%BB%9Di-trang-pk-1986.html', 1, '2015-12-04 03:42:03'),
(101, 9, 'Jewelries', 'Bộ trang sức trái tim PK 2121', 160000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/eGJqMTQwOTU2NzMxMS5qcGc-/bo-trang-suc-trai-tim-pk-2121.jpg', 'http://www.vatgia.com/2407/4392767/b%E1%BB%99-trang-s%E1%BB%A9c-tr%C3%A1i-tim-pk-2121.html', 1, '2015-12-04 03:42:03'),
(102, 9, 'Jewelries', 'Bộ trang sức ngọc trai PK 2265', 270000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/d2t5MTQyOTEwNjUwNy5qcGc-/bo-trang-suc-ngoc-trai-pk-2265.jpg', 'http://www.vatgia.com/2407/4731691/b%E1%BB%99-trang-s%E1%BB%A9c-ng%E1%BB%8Dc-trai-pk-2265.html', 1, '2015-12-04 03:42:03'),
(103, 9, 'Jewelries', 'Bông tai nam bạc cao cấp RM0814', 260000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/ZGZ6MTQzNDY5Mzc2My5qcGc-/bong-tai-nam-bac-cao-cap-rm0814.jpg', 'http://www.vatgia.com/7095/5161403/b%C3%B4ng-tai-nam-b%E1%BA%A1c-cao-c%E1%BA%A5p-rm0814.html', 1, '2015-12-04 03:42:03'),
(104, 9, 'Jewelries', 'Bộ trang sức thời trang PK 1927', 105000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dnppMTM5ODMzMzczMi5qcGc-/bo-trang-suc-thoi-trang-pk-1927.jpg', 'http://www.vatgia.com/2407/4016540/b%E1%BB%99-trang-s%E1%BB%A9c-th%E1%BB%9Di-trang-pk-1927.html', 1, '2015-12-04 03:42:03'),
(105, 9, 'Jewelries', 'Bộ trang sức trái châu PK 2238', 280000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGpkMTQxODkxNDk2NC5qcGc-/bo-trang-suc-trai-chau-pk-2238.jpg', 'http://www.vatgia.com/2407/4731707/b%E1%BB%99-trang-s%E1%BB%A9c-tr%C3%A1i-ch%C3%A2u-pk-2238.html', 1, '2015-12-04 03:42:03'),
(106, 9, 'Jewelries', 'Dây chuyền thời trang Hàn Quốc PK2051', 95000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/ZHVoMTQwNDkxMjYxNy5qcGc-/day-chuyen-thoi-trang-han-quoc-pk2051.jpg', 'http://www.vatgia.com/2405/4234463/d%C3%A2y-chuy%E1%BB%81n-th%E1%BB%9Di-trang-h%C3%A0n-qu%E1%BB%91c-pk2051.html', 1, '2015-12-04 03:42:03'),
(107, 9, 'Jewelries', 'Dây chuyền thời trang PK 2490', 130000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dmp6MTQzMjQ3OTI3OS5qcGc-/day-chuyen-thoi-trang-pk-2490.jpg', 'http://www.vatgia.com/2405/5099938/d%C3%A2y-chuy%E1%BB%81n-th%E1%BB%9Di-trang-pk-2490.html', 1, '2015-12-04 03:42:03'),
(108, 10, 'Candies', 'Kẹo hồng sâm không đường 500g - Hàn Quốc', 100000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bHFjMTQzODIyMjUxNS5qcGc-/keo-hong-sam-khong-duong-500g-han-quoc.jpg', 'http://www.vatgia.com/13526/5256873/k%E1%BA%B9o-h%E1%BB%93ng-s%C3%A2m-kh%C3%B4ng-%C4%91%C6%B0%E1%BB%9Dng-500g-h%C3%A0n-qu%E1%BB%91c.html', 1, '2015-12-04 03:42:04'),
(109, 10, 'Candies', 'Kẹo sâm Hàn Quốc K01', 50000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/aHdtMTM0Njg2NjA4My5qcGc-/keo-halls-25ven-my.jpg', 'http://www.vatgia.com/shopmebill&module=product&view=detail&record_id=1863211', 1, '2015-12-04 03:42:04'),
(110, 10, 'Candies', 'Kẹo Halls 25vên-Mỹ', 60000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/aHdtMTM0Njg2NjA4My5qcGc-/keo-halls-25ven-my.jpg', 'http://www.vatgia.com/980/2476647/k%E1%BA%B9o-halls-25v%C3%AAn-m%E1%BB%B9.html', 1, '2015-12-04 03:42:04'),
(111, 10, 'Candies', 'Kẹo cao su Wrigley’s New 5 Cobalt vị bạc hà', 32000, 'http://p.vatgia.vn/pictures_fullsize/isb1321980018.jpg', 'http://www.vatgia.com/980/1750235/k%E1%BA%B9o-cao-su-wrigley-s-new-5-cobalt-v%E1%BB%8B-b%E1%BA%A1c-h%C3%A0.html', 1, '2015-12-04 03:42:04'),
(112, 10, 'Candies', 'Kẹo Dẻo Welch’s Mixed Fruit 142g', 70000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/b3B3MTQzOTg4MDUyOC5qcGc-/keo-deo-welchs-mixed-fruit-142g.jpg', 'http://www.vatgia.com/13520/5302209/k%E1%BA%B9o-d%E1%BA%BBo-welch-s-mixed-fruit-142g.html', 1, '2015-12-04 03:42:04'),
(113, 10, 'Candies', '2 hộp kẹo dẻo Gummy Bears 150g HHA-261', 114000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dXl1MTQzMjEwMzUzNy5qcGc-/2-hop-keo-deo-gummy-bears-150g-hha-261.jpg', 'http://www.vatgia.com/13520/5086310/2-h%E1%BB%99p-k%E1%BA%B9o-d%E1%BA%BBo-gummy-bears-150g-hha-261.html', 1, '2015-12-04 03:42:04'),
(114, 10, 'Candies', 'Kẹo vitamin rau củ VT004', 210000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bG9vMTMwMzExMzQ2MS5qcGc-/keo-vitamin-rau-cu-vt004.jpg', 'http://www.vatgia.com/980/1292974/k%E1%BA%B9o-vitamin-rau-c%E1%BB%A7-vt004.html', 1, '2015-12-04 03:42:04'),
(115, 10, 'Candies', 'Kẹo M&M Milk Chocolate 357.2g', 130000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bWFlMTQzOTk1MzI0MS5qcGc-/keo-m-m-milk-chocolate-357-2g.jpg', 'http://www.vatgia.com/13520/5304294/k%E1%BA%B9o-m-m-milk-chocolate-357-2g.html', 1, '2015-12-04 03:42:04'),
(116, 10, 'Candies', 'Kẹo trái cây Morinaga (94gr)', 80000, 'http://p.vatgia.vn/pictures_fullsize/esb1408784395.jpg', 'http://www.vatgia.com/13524/4367328/k%E1%BA%B9o-tr%C3%A1i-c%C3%A2y-morinaga-94gr.html', 1, '2015-12-04 03:42:04'),
(117, 10, 'Candies', 'Kẹo Gum Mỹ Trident', 35000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/eGVoMTMxODc1NDIyNi5qcGc-/keo-gum-my-trident.jpg', 'http://www.vatgia.com/980/1661558/k%E1%BA%B9o-gum-m%E1%BB%B9-trident.html', 1, '2015-12-04 03:42:04'),
(118, 10, 'Candies', 'Chocolate Hershey Kisses Milk Chocolate 1.58kg', 450000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dWt4MTQzOTg3OTU5OS5qcGc-/chocolate-hershey-kisses-milk-chocolate-1-58kg.jpg', 'http://www.vatgia.com/13520/5302140/chocolate-hershey-kisses-milk-chocolate-1-58kg.html', 1, '2015-12-04 03:42:04'),
(119, 10, 'Candies', 'Kẹo cao su chewing gum Elodie dâu không đường 100g', 68000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/ZGhvMTQzNTYzMzU5Ny5qcGc-/keo-cao-su-chewing-gum-elodie-dau-khong-duong-100g.jpg', 'http://www.vatgia.com/13522/5184467/k%E1%BA%B9o-cao-su-chewing-gum-elodie-d%C3%A2u-kh%C3%B4ng-%C4%91%C6%B0%E1%BB%9Dng-100g.html', 1, '2015-12-04 03:42:04'),
(120, 10, 'Candies', 'Kẹo dẻo Frui By The Foot 42Rolls 893g', 420000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bnJsMTQzOTg3OTk2NC5qcGc-/keo-deo-frui-by-the-foot-42rolls-893g.jpg', 'http://www.vatgia.com/13520/5302164/k%E1%BA%B9o-d%E1%BA%BBo-frui-by-the-foot-42rolls-893g.html', 1, '2015-12-04 03:42:04'),
(121, 10, 'Candies', 'Kẹo dẻo Fruit Snacks 1.70kg', 240000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dnZjMTQzOTg3OTk3MC5qcGc-/keo-deo-fruit-snacks-1-70kg.jpg', 'http://www.vatgia.com/13520/5302162/k%E1%BA%B9o-d%E1%BA%BBo-fruit-snacks-1-70kg.html', 1, '2015-12-04 03:42:04'),
(122, 10, 'Candies', 'Kẹo Cucu Nhật Bản (87gr)', 70000, 'http://p.vatgia.vn/pictures_fullsize/avz1421219633.jpg', 'http://www.vatgia.com/13521/4794492/k%E1%BA%B9o-cucu-nh%E1%BA%ADt-b%E1%BA%A3n-87gr.html', 1, '2015-12-04 03:42:04'),
(123, 10, 'Candies', '2 hộp kẹo trái cây Cavendish & Harvey – Đức', 148000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/eHBpMTQyNjU2NjU3Ny5qcGc-/2-hop-keo-trai-cay-cavendish-harvey-duc.jpg', 'http://www.vatgia.com/13524/4917084/2-h%E1%BB%99p-k%E1%BA%B9o-tr%C3%A1i-c%C3%A2y-cavendish-harvey-%E2%80%93-%C4%91%E1%BB%A9c.html', 1, '2015-12-04 03:42:04'),
(124, 10, 'Candies', 'Kẹo Gum Extra Dessert Delights', 25000, 'http://p.vatgia.vn/pictures_fullsize/oec1329870606.jpg', 'http://www.vatgia.com/980/1941559/k%E1%BA%B9o-gum-extra-dessert-delights.html', 1, '2015-12-04 03:42:04'),
(125, 10, 'Candies', 'Kẹo Socola Merci Petits 125g (2100937)', 53500, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bG50MTM1NjQzMTI0OC5qcGc-/keo-socola-merci-petits-125g-2100937.jpg', 'http://www.vatgia.com/980/482209/k%E1%BA%B9o-socola-merci-petits-125g-2100937.html', 1, '2015-12-04 03:42:04'),
(126, 10, 'Candies', 'Kẹo chocolate M&M Mega Peanuts - Socola M&M peanuts', 218000, 'http://p.vatgia.vn/ir/gallery_img/7/7/d3JlMTQzNjQ0NDczMy5qcGc-/keo-chocolate-m-m-mega-peanuts-socola-m-m-peanuts-anh-2.jpg', 'http://www.vatgia.com/13519/5206140/k%E1%BA%B9o-chocolate-m-m-mega-peanuts-socola-m-m-peanuts.html', 1, '2015-12-04 03:42:04'),
(127, 10, 'Candies', 'Kẹo Gum Trident Layers dâu nhân cam', 35000, 'http://p.vatgia.vn/pictures_fullsize/suz1438019611.jpg', 'http://www.vatgia.com/13522/5250354/k%E1%BA%B9o-gum-trident-layers-da%CC%82u-nha%CC%82n-cam.html', 1, '2015-12-04 03:42:04'),
(128, 10, 'Candies', 'Kẹo Halls mật ong và chanh', 55000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/ZG5rMTM5NzExOTk1OC5qcGc-/keo-halls-mat-ong-va-chanh-25-vien.jpg', 'http://www.vatgia.com/13524/3971276/k%E1%BA%B9o-halls-m%E1%BA%ADt-ong-v%C3%A0-chanh-25-vi%C3%AAn.html', 1, '2015-12-04 03:42:04'),
(129, 10, 'Candies', 'Chocolate Hershey’s Miniatures Special Dark (1.36kg)', 500000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dmNkMTQzNDA4MDEzNC5qcGc-/chocolate-hersheys-miniatures-special-dark-1-36kg.jpg', 'http://www.vatgia.com/13519/5145953/chocolate-hershey-s-miniatures-special-dark-1-36kg.html', 1, '2015-12-04 03:42:04'),
(130, 10, 'Candies', 'Kẹo Hồng Sâm Hàn Quốc (200gram)', 75000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/cmRmMTM5OTA5ODEwNS5qcGc-/keo-hong-sam-han-quoc-200gram.jpg', 'http://www.vatgia.com/13526/4034087/k%E1%BA%B9o-h%E1%BB%93ng-s%C3%A2m-h%C3%A0n-qu%E1%BB%91c-200gram.html', 1, '2015-12-04 03:42:04'),
(131, 10, 'Candies', 'Kẹo mềm hương trái cây Starburst - Kẹo trái cây mềm Hồng', 228000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/eHZxMTQzNDM2MDAyMC5qcGc-/keo-mem-huong-trai-cay-starburst-keo-trai-cay-mem-hong.jpg', 'http://www.vatgia.com/13520/5151955/k%E1%BA%B9o-m%E1%BB%81m-h%C6%B0%C6%A1ng-tr%C3%A1i-c%C3%A2y-starburst-k%E1%BA%B9o-tr%C3%A1i-c%C3%A2y-m%E1%BB%81m-h%E1%BB%93ng.html', 1, '2015-12-04 03:42:04'),
(132, 10, 'Candies', 'Kẹo dẻo Wonka Randoms (283.4g)', 128000, 'http://g.vatgia.vn/gallery_img/7/piq1411197885.jpg', 'http://www.vatgia.com/13520/4447471/k%E1%BA%B9o-d%E1%BA%BBo-wonka-randoms-283-4g.html', 1, '2015-12-04 03:42:04'),
(133, 10, 'Candies', 'Kẹo trà xanh của Nhật', 60000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/ZGZyMTQxMzM2NzUxOS5qcGc-/keo-tra-xanh-cua-nhat.jpg', 'http://www.vatgia.com/15064/4539580/k%E1%BA%B9o-tr%C3%A0-xanh-c%E1%BB%A7a-nh%E1%BA%ADt.html', 1, '2015-12-04 03:42:04'),
(134, 10, 'Candies', 'Kẹo chocolate M&M Mega Peanuts - Socola M&M peanuts', 218000, 'http://p.vatgia.vn/pictures_fullsize/pij1436503524.jpg', 'http://www.vatgia.com/13519/5206140/k%E1%BA%B9o-chocolate-m-m-mega-peanuts-socola-m-m-peanuts.html', 1, '2015-12-04 03:42:04'),
(135, 10, 'Candies', 'Kẹo sữa Mix Caramel Coffee & Milk', 70000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/enZjMTQwODc5MTI5My5KUEc-/keo-sua-mix-caramel-coffee-milk.jpg', 'http://www.vatgia.com/13523/4367723/k%E1%BA%B9o-s%E1%BB%AFa-mix-caramel-coffee-milk.html', 1, '2015-12-04 03:42:04'),
(136, 10, 'Candies', 'Kẹo gum trái cây Fruitio - Nhật Bản', 130000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Z3V0MTM0NTc5OTg4Ni5qcGc-/keo-gum-trai-cay-fruitio-nhat-ban.jpg', 'http://www.vatgia.com/980/2445641/k%E1%BA%B9o-gum-tr%C3%A1i-c%C3%A2y-fruitio-nh%E1%BA%ADt-b%E1%BA%A3n.html', 1, '2015-12-04 03:42:04'),
(137, 10, 'Candies', 'Kẹo Hồng Sâm Không Đường 500gr- Hàn Quốc', 150000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/aWZ1MTM4NjU5MTc0OS5qcGc-/keo-hong-sam-khong-duong-500gr-han-quoc.jpg', 'http://www.vatgia.com/980/3656060/k%E1%BA%B9o-h%E1%BB%93ng-s%C3%A2m-kh%C3%B4ng-%C4%91%C6%B0%E1%BB%9Dng-500gr-h%C3%A0n-qu%E1%BB%91c.html', 1, '2015-12-04 03:42:04'),
(138, 8, 'Toy', 'Máy bay điêu khiển siêu nhỏ siêu đầm 3.5 kênh gyro shoptoyss HSN300', 279000, 'http://p.vatgia.vn/ir/user_product_fullsize/7/cXBrMTQyNjU3NjgwMS5qcGc-/may-bay-dieu-khien-sieu-nho-sieu-dam-3-5-kenh-gyro-shoptoyss-hsn300.jpg', 'http://www.vatgia.com/shop_toy&module=product&view=detail&record_id=4660248&checkclick=1700991498&eTitan=1700991498', 1, '2015-12-04 03:42:03'),
(139, 8, 'Toy', 'Tàu ngầm điều khiển lặn dưới nước submarine rc 216 shoptoyss TN216', 320000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/cXlmMTQxNjgyMDc2OC5qcGc-/tau-ngam-dieu-khien-lan-duoi-nuoc-submarine-rc-216-shoptoyss-tn216.jpg', 'http://www.vatgia.com/8842/4659610/t%C3%A0u-ng%E1%BA%A7m-%C4%91i%E1%BB%81u-khi%E1%BB%83n-l%E1%BA%B7n-d%C6%B0%E1%BB%9Bi-n%C6%B0%E1%BB%9Bc-submarine-rc-216-shoptoyss-tn216.html', 1, '2015-12-04 03:42:03'),
(140, 8, 'Toy', 'Cờ tỷ phú hộp giấy lớn 5in1', 79000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/d3RrMTQwODE2NTYzMS5qcGc-/co-ty-phu-hop-giay-lon-5in1.jpg', 'http://www.vatgia.com/1221/4343935/c%E1%BB%9D-t%E1%BB%B7-ph%C3%BA-h%E1%BB%99p-gi%E1%BA%A5y-l%E1%BB%9Bn-5in1.html', 1, '2015-12-04 03:42:03'),
(141, 8, 'Toy', 'Máy Bay Điều Khiển Từ Xa Đời Mới 2015', 400000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/b3JoMTQzODIyMzI3OC5qcGc-/may-bay-dieu-khien-tu-xa-doi-moi-2015.jpg', 'http://www.vatgia.com/1250/5256965/m%C3%A1y-bay-%C4%91i%E1%BB%81u-khi%E1%BB%83n-t%E1%BB%AB-xa-%C4%91%E1%BB%9Di-m%E1%BB%9Bi-2015.html', 1, '2015-12-04 03:42:03'),
(142, 8, 'Toy', 'Đồ chơi rút gỗ thông minh', 85000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/aG51MTM3MTI2MTA1My5qcGc-/do-choi-rut-go-thong-minh.jpg', 'http://www.vatgia.com/dealsaigonvn&module=product&view=detail&record_id=3173317', 1, '2015-12-04 03:42:03'),
(143, 8, 'Toy', 'Xí Ngầu', 25000, 'http://p.vatgia.vn/ir/user_product_fullsize/7/ZWhuMTQxMzM2NjE4NC5qcGc-/xi-ngau.jpg', 'http://www.vatgia.com/1221/4539419/x%C3%AD-ng%E1%BA%A7u.html', 1, '2015-12-04 03:42:03'),
(144, 8, 'Toy', 'Đoàn tàu tri thức kiểu dáng ANGRY BIRDS - quà tặng 1.6 ', 90000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/ZnNzMTQzODA1MTU1MS5KUEc-/doan-tau-tri-thuc-kieu-dang-angry-birds-qua-tang-1-6-04-147-120-0514.jpg', 'http://www.vatgia.com/11194/5250836/%C4%91o%C3%A0n-t%C3%A0u-tri-th%E1%BB%A9c-ki%E1%BB%83u-d%C3%A1ng-angry-birds-qu%C3%A0-t%E1%BA%B7ng-1-6-04-147-120-0514.html', 1, '2015-12-04 03:42:03'),
(145, 8, 'Toy', 'Bàn bóng đá Huy Tuấn Bilac soccer', 450000, 'http://p.vatgia.vn/pictures_fullsize/fgv1435909222.jpg', 'http://www.vatgia.com/13063/5192127/b%C3%A0n-b%C3%B3ng-%C4%91%C3%A1-huy-tu%E1%BA%A5n-bilac-soccer.html', 1, '2015-12-04 03:42:03'),
(146, 8, 'Toy', 'Bảng ghép hình bằng gỗ gắn nam châm cho bé MVDV49162', 99000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bmllMTQzMjgxMTIwNi5qcGc-/bang-ghep-hinh-bang-go-gan-nam-cham-cho-be-mvdv49162.jpg', 'http://www.vatgia.com/1104/5112871/b%E1%BA%A3ng-gh%C3%A9p-h%C3%ACnh-b%E1%BA%B1ng-g%E1%BB%97-g%E1%BA%AFn-nam-ch%C3%A2m-cho-b%C3%A9-mvdv49162.html', 1, '2015-12-04 03:42:03'),
(147, 8, 'Toy', 'Bộ đồ chơi bé tập làm điệu CBE030', 390000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/cGtxMTQzNDk0MjA2Ny5qcGc-/bo-do-choi-be-tap-lam-dieu-cbe030.jpg', 'http://www.vatgia.com/756/5166151/b%E1%BB%99-%C4%91%E1%BB%93-ch%C6%A1i-b%C3%A9-t%E1%BA%ADp-l%C3%A0m-%C4%91i%E1%BB%87u-cbe030.html', 1, '2015-12-04 03:42:03'),
(148, 8, 'Toy', 'Bộ đồ chơi nhà bếp lớn - BV-3399', 350000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dGN4MTQxOTIyOTgxMC5qcGc-/bo-do-choi-nha-bep-lon-bv-3399.jpg', 'http://www.vatgia.com/756/4738827/b%E1%BB%99-%C4%91%E1%BB%93-ch%C6%A1i-nh%C3%A0-b%E1%BA%BFp-l%E1%BB%9Bn-bv-3399.html', 1, '2015-12-04 03:42:03'),
(149, 8, 'Toy', 'Đồ chơi tổng hợp khác Trò chơi rút khỉ - Loại lớn (Tumbling Monkeys Board Game) QT500', 150000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/b2hwMTQyNzkzOTMzMy5qcGc-/do-choi-tong-hop-khac-tro-choi-rut-khi-loai-lon-tumbling-monkeys-board-game-qt500.jpg', 'http://www.vatgia.com/756/4963987/%C4%91%E1%BB%93-ch%C6%A1i-t%E1%BB%95ng-h%E1%BB%A3p-kh%C3%A1c-tr%C3%B2-ch%C6%A1i-r%C3%BAt-kh%E1%BB%89-lo%E1%BA%A1i-l%E1%BB%9Bn-tumbling-monkeys-board-game-qt500.html', 1, '2015-12-04 03:42:03'),
(150, 8, 'Toy', 'Bộ đồ chơi nấu bếp kitchen set 00858', 310000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/aXlnMTQzNDMyNTQwNC5qcGc-/bo-do-choi-nau-bep-kitchen-set-00858.jpg', 'http://www.vatgia.com/756/5150248/b%E1%BB%99-%C4%91%E1%BB%93-ch%C6%A1i-n%E1%BA%A5u-b%E1%BA%BFp-kitchen-set-00858.html', 1, '2015-12-04 03:42:03'),
(151, 8, 'Toy', 'Đồ chơi tổng hợp khác máy chụp hình thông minh - sáng tạo Leaf Frog - KN 4072', 407150, 'http://g.vatgia.vn/gallery_img/7/chp1410524815.jpg', 'http://www.vatgia.com/756/4421677/%C4%91%E1%BB%93-ch%C6%A1i-t%E1%BB%95ng-h%E1%BB%A3p-kh%C3%A1c-m%C3%A1y-ch%E1%BB%A5p-h%C3%ACnh-th%C3%B4ng-minh-s%C3%A1ng-t%E1%BA%A1o-leaf-frog-kn-4072.html', 1, '2015-12-04 03:42:03'),
(152, 8, 'Toy', 'Tuyệt đỉnh YOYO (Thần Hổ)', 89000, 'http://g.vatgia.vn/gallery_img/4/lml1439187596.jpg', 'http://www.vatgia.com/1231/5283691/tuy%E1%BB%87t-%C4%91%E1%BB%89nh-yoyo-th%E1%BA%A7n-h%E1%BB%95.html', 1, '2015-12-04 03:42:03'),
(153, 8, 'Toy', 'Bộ đồ chơi câu cá No LX685-01 A1B9', 120000, 'http://p.vatgia.vn/pictures_fullsize/mpp1434525620.JPG', 'http://www.vatgia.com/756/5156951/b%E1%BB%99-%C4%91%E1%BB%93-ch%C6%A1i-c%C3%A2u-c%C3%A1-no-lx685-01-a1b9.html', 1, '2015-12-04 03:42:03'),
(154, 8, 'Toy', 'Tháp cầu vòng Fisher Price', 90000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/c21sMTM0Njg2NTMwNC5qcGc-/thap-cau-vong-fisher-price.jpg', 'http://www.vatgia.com/shopmebill&module=product&view=detail&record_id=2476630', 1, '2015-12-04 03:42:03'),
(155, 8, 'Toy', 'Xe ô tô thả hình Huile Toys No.156', 155000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Z3BuMTQzNjMzNzMzMy5qcGc-/xe-o-to-tha-hinh-huile-toys-no-156.jpg', 'http://www.vatgia.com/1507/5202313/xe-%C3%B4-t%C3%B4-th%E1%BA%A3-h%C3%ACnh-huile-toys-no-156.html', 1, '2015-12-04 03:42:03'),
(156, 8, 'Toy', 'Ô tô điện trẻ em Audi B28', 1800000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Ymh1MTM3Mzk1ODk4MS5qcGc-/o-to-dien-tre-em-audi-b28.jpg', 'http://www.vatgia.com/babymamavn&module=product&view=detail&record_id=2892290', 1, '2015-12-04 03:42:03'),
(157, 8, 'Toy', 'Xe trượt Scooter XT2001S', 550000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/enB1MTM0OTE1MTYwNC5qcGc-/xe-truot-scooter-xt2001s.jpg', 'http://www.vatgia.com/chothethao&module=product&view=detail&record_id=2555447', 1, '2015-12-04 03:42:03'),
(158, 8, 'Toy', 'Bảng học chữ và số đa năng 6 trong 1 mẫu số 1', 185000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/a25tMTQxMjgyNTYwMi5qcGc-/bang-hoc-chu-va-so-da-nang-6-trong-1-mau-so-1.jpg', 'http://www.vatgia.com/11195/4518312/b%E1%BA%A3ng-h%E1%BB%8Dc-ch%E1%BB%AF-v%C3%A0-s%E1%BB%91-%C4%91a-n%C4%83ng-6-trong-1-m%E1%BA%ABu-s%E1%BB%91-1.html', 1, '2015-12-04 03:42:03'),
(159, 8, 'Toy', 'Đồ chơi xếp hình Lego Disney 41062 - Lâu đài băng của Elsa', 1799000, 'http://p.vatgia.vn/pictures_fullsize/klp1432690456.jpg', 'http://www.vatgia.com/12425/5106722/%C4%91%E1%BB%93-ch%C6%A1i-x%E1%BA%BFp-h%C3%ACnh-lego-disney-41062-l%C3%A2u-%C4%91%C3%A0i-b%C4%83ng-c%E1%BB%A7a-elsa.html', 1, '2015-12-04 03:42:03'),
(160, 8, 'Toy', 'Đồ chơi trang điểm búp bê cho bé VDS-109', 158000, 'http://p.vatgia.vn/ir/gallery_img/14/7/ZnZ3MTQyODAyNTMwMS5qcGc-/do-choi-trang-diem-bup-be-cho-be-vds-109-anh-2.jpg', 'http://www.vatgia.com/1094/4966963/%C4%91%E1%BB%93-ch%C6%A1i-trang-%C4%91i%E1%BB%83m-b%C3%BAp-b%C3%AA-cho-b%C3%A9-vds-109.html', 1, '2015-12-04 03:42:03'),
(161, 8, 'Toy', 'Mô hình nhà DIY - Butterfly’s Love', 300000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/cHpoMTQyODk3OTA5NS5wbmc-/mo-hinh-nha-diy-butterflys-love.png', 'http://www.vatgia.com/12973/4997434/m%C3%B4-h%C3%ACnh-nh%C3%A0-diy-butterfly-s-love.html', 1, '2015-12-04 03:42:03'),
(162, 8, 'Toy', 'Đồ chơi gỗ Nhật Bản tiệc dâu tây đỏ Mother Garden', 629000, 'http://p.vatgia.vn/pictures_fullsize/vvo1440990971.jpg', 'http://www.vatgia.com/756/5333033/%C4%91%E1%BB%93-ch%C6%A1i-g%E1%BB%97-nh%E1%BA%ADt-b%E1%BA%A3n-ti%E1%BB%87c-d%C3%A2u-t%C3%A2y-%C4%91%E1%BB%8F-mother-garden.html', 1, '2015-12-04 03:42:03'),
(163, 8, 'Toy', 'Đồ chơi gỗ Nhật Bản tiệc sinh nhật dâu tây hồng Mother Garden', 429000, 'http://p.vatgia.vn/pictures_fullsize/npi1440990427.jpg', 'http://www.vatgia.com/756/5332985/%C4%91%E1%BB%93-ch%C6%A1i-g%E1%BB%97-nh%E1%BA%ADt-b%E1%BA%A3n-ti%E1%BB%87c-sinh-nh%E1%BA%ADt-d%C3%A2u-t%C3%A2y-h%E1%BB%93ng-mother-garden.html', 1, '2015-12-04 03:42:03'),
(164, 8, 'Toy', 'Bồ đồ chơi bác sĩ CBE029', 340000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/YndjMTQzNDk0MTk1NC5qcGc-/bo-do-choi-bac-si-cbe029.jpg', 'http://www.vatgia.com/756/5166145/b%E1%BB%93-%C4%91%E1%BB%93-ch%C6%A1i-b%C3%A1c-s%C4%A9-cbe029.html', 1, '2015-12-04 03:42:03'),
(165, 8, 'Toy', 'Đồ chơi yoyo 2015', 39000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dXJwMTQzMDc5NTIyOS5qcGc-/do-choi-yoyo-2015.jpg', 'http://www.vatgia.com/756/5024580/%C4%91%E1%BB%93-ch%C6%A1i-yoyo-2015.html', 1, '2015-12-04 03:42:03'),
(166, 8, 'Toy', 'Bộ đồ chơi thông minh đa chức năng màu xanh lá 5 in 1 Adjustable Gym LT-623196', 1690000, 'http://p.vatgia.vn/pictures_fullsize/lxx1350960883.jpg', 'http://www.vatgia.com/chamsocbesosinh&module=product&view=detail&record_id=2609415&checkclick=1984345388&eTitan=1984345388', 1, '2015-12-04 03:42:03'),
(167, 8, 'Toy', 'Đồ chơi bóng chíp con voi Farlin', 40000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/eGpwMTQyNzI1ODYyMS5qcGc-/do-choi-bong-chip-con-voi-farlin.jpg', 'http://www.vatgia.com/756/4939687/%C4%91%E1%BB%93-ch%C6%A1i-b%C3%B3ng-ch%C3%ADp-con-voi-farlin.html', 1, '2015-12-04 03:42:03'),
(168, 11, 'Cosmetics', 'Cặp dầu gội dầu xả Pháp cao cấp Bondlady 650ml/chai (12188)', 599000, 'http://p.vatgia.vn/pictures_fullsize/jtz1437442454.jpg', 'http://www.vatgia.com/2494/5231085/c%E1%BA%B7p-d%E1%BA%A7u-g%E1%BB%99i-d%E1%BA%A7u-x%E1%BA%A3-ph%C3%A1p-cao-c%E1%BA%A5p-bondlady-650ml-chai-12188.html', 1, '2015-12-04 03:42:04'),
(169, 11, 'Cosmetics', 'Bộ dầu gội + xả Tsubaki - chăm sóc và phục hồi tóc hư tổn', 290000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/YXlzMTQ0MTI1NDE2MC5qcGc-/bo-dau-goi-xa-tsubaki-cham-soc-va-phuc-hoi-toc-hu-ton.jpg', 'http://www.vatgia.com/2494/5338610/b%E1%BB%99-d%E1%BA%A7u-g%E1%BB%99i-%2B-x%E1%BA%A3-tsubaki-ch%C4%83m-s%C3%B3c-v%C3%A0-ph%E1%BB%A5c-h%E1%BB%93i-t%C3%B3c-h%C6%B0-t%E1%BB%95n.html', 1, '2015-12-04 03:42:04'),
(170, 11, 'Cosmetics', 'Bộ sản phẩm làm sạch và dưỡng da Lanopearl', 999000, 'http://p.vatgia.vn/pictures_fullsize/vfp1433474077.jpg', 'http://www.vatgia.com/2493/5131330/b%E1%BB%99-s%E1%BA%A3n-ph%E1%BA%A9m-l%C3%A0m-s%E1%BA%A1ch-v%C3%A0-d%C6%B0%E1%BB%A1ng-da-lanopearl.html', 1, '2015-12-04 03:42:04'),
(171, 11, 'Cosmetics', 'Bộ dưỡng trắng giảm thâm nám L’Oréal White Perfect Laser Ngày – Đêm', 405000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/aWNzMTQzODE1NTE5MS5qcGc-/bo-duong-trang-giam-tham-nam-l-oreal-white-perfect-laser-ngay-dem.jpg', 'http://www.vatgia.com/2493/4485588/b%E1%BB%99-d%C6%B0%E1%BB%A1ng-tr%E1%BA%AFng-gi%E1%BA%A3m-th%C3%A2m-n%C3%A1m-l-or%C3%A9al-white-perfect-laser-ng%C3%A0y-%E2%80%93-%C4%91%C3%AAm.html', 1, '2015-12-04 03:42:04'),
(172, 11, 'Cosmetics', 'Bộ dầu gội - xả Victoria’s secret hair Major shine', 640000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/cnp6MTQyNTg2OTMyMy5qcGVn/bo-dau-goi-xa-victorias-secret-hair-major-shine.jpeg', 'http://www.vatgia.com/2494/4895852/b%E1%BB%99-d%E1%BA%A7u-g%E1%BB%99i-x%E1%BA%A3-victoria-s-secret-hair-major-shine.html', 1, '2015-12-04 03:42:04'),
(173, 11, 'Cosmetics', 'Bộ sữa tắm nữ và kem dưỡng thể - Tesori D’ Oriente Hammam', 485000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/cXh3MTQxMjY1NDYxNi5qcGc-/bo-sua-tam-nu-va-kem-duong-the-tesori-d-oriente-hammam.jpg', 'http://www.vatgia.com/2493/4509315/b%E1%BB%99-s%E1%BB%AFa-t%E1%BA%AFm-n%E1%BB%AF-v%C3%A0-kem-d%C6%B0%E1%BB%A1ng-th%E1%BB%83-tesori-d-oriente-hammam.html', 1, '2015-12-04 03:42:04'),
(174, 11, 'Cosmetics', 'Bộ Suôn Mượt L’Oréal Hair Spa Deep Nourishing Gội - Xã 600ml- Hấp 500ml', 615000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/a2t4MTQ0MDIzNzAyNy5qcGc-/bo-suon-muot-l-oreal-hair-spa-deep-nourishing-goi-xa-600ml-hap-500ml.jpg', 'http://www.vatgia.com/2494/4487475/b%E1%BB%99-su%C3%B4n-m%C6%B0%E1%BB%A3t-l-or%C3%A9al-hair-spa-deep-nourishing-g%E1%BB%99i-x%C3%A3-600ml-h%E1%BA%A5p-500ml.html', 1, '2015-12-04 03:42:04'),
(175, 11, 'Cosmetics', 'Bộ chăm sóc tóc nhuộm L’Oréal Color Vive Protecting Gội 330ml - Xã 170ml & Ủ 200ml', 239000, 'http://p.vatgia.vn/pictures_fullsize/eeu1438152735.jpg', 'http://www.vatgia.com/2494/4486603/b%E1%BB%99-ch%C4%83m-s%C3%B3c-t%C3%B3c-nhu%E1%BB%99m-l-or%C3%A9al-color-vive-protecting-g%E1%BB%99i-330ml-x%C3%A3-170ml-%E1%BB%A7-200ml.html', 1, '2015-12-04 03:42:04'),
(176, 11, 'Cosmetics', 'Keo tạo kiểu tóc - Độ cứng 4 30550', 229000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/ZWxzMTQzOTk2MjYxMC5qcGc-/keo-tao-kieu-toc-do-cung-4-30550.jpg', 'http://www.vatgia.com/2452/5143996/keo-t%E1%BA%A1o-ki%E1%BB%83u-t%C3%B3c-%C4%91%E1%BB%99-c%E1%BB%A9ng-4-30550.html', 1, '2015-12-04 03:42:04'),
(177, 11, 'Cosmetics', 'Bộ dưỡng da tinh chất ốc sên 012', 950000, 'http://p.vatgia.vn/pictures_fullsize/tlv1345115695.jpg', 'http://www.vatgia.com/samlinhchihanquoc&module=product&view=detail&record_id=2420012', 1, '2015-12-04 03:42:04'),
(178, 11, 'Cosmetics', 'Gift Set PERRY ELLIS AQUA', 1200000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/ZWNhMTQwMjM4MzY4Ny5qcGc-/gift-set-perry-ellis-aqua.jpg', 'http://www.vatgia.com/2495/4143309/gift-set-perry-ellis-aqua.html', 1, '2015-12-04 03:42:04'),
(179, 11, 'Cosmetics', 'Bộ set mỹ phẩm 04', 946000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/ampmMTQzMjEwNzQ5MC5qcGc-/bo-set-my-pham-04.jpg', 'http://www.vatgia.com/2497/5086776/b%E1%BB%99-set-m%E1%BB%B9-ph%E1%BA%A9m-04.html', 1, '2015-12-04 03:42:04'),
(180, 11, 'Cosmetics', 'Cặp dầu gội xả tóc siêu mượt Macadamia Mỹ (Tặng tinh dầu 10ml)', 2050000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/d3BpMTQzNTEzNzE4My5qcGc-/cap-dau-goi-xa-toc-sieu-muot-macadamia-my-tang-tinh-dau-10ml.jpg', 'http://www.vatgia.com/2494/5172537/c%E1%BA%B7p-d%E1%BA%A7u-g%E1%BB%99i-x%E1%BA%A3-t%C3%B3c-si%C3%AAu-m%C6%B0%E1%BB%A3t-macadamia-m%E1%BB%B9-t%E1%BA%B7ng-tinh-d%E1%BA%A7u-10ml.html', 1, '2015-12-04 03:42:04'),
(181, 11, 'Cosmetics', 'Dầu dội dưỡng dài - suôn mượt Kracie', 308000, 'http://www.vatgia.com/2494/1499454/d%E1%BA%A7u-d%E1%BB%99i-d%C6%B0%E1%BB%A1ng-d%C3%A0i-su%C3%B4n-m%C6%B0%E1%BB%A3t-kracie.html', 'http://www.vatgia.com/2494/1499454/d%E1%BA%A7u-d%E1%BB%99i-d%C6%B0%E1%BB%A1ng-d%C3%A0i-su%C3%B4n-m%C6%B0%E1%BB%A3t-kracie.html', 1, '2015-12-04 03:42:04'),
(182, 11, 'Cosmetics', 'Bộ 4 sản phẩm của 3 CE Hàn Quốc', 385000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/eGJhMTQzNDAxOTI1MC5qcGc-/bo-4-san-pham-cua-3-ce-han-quoc.jpg', 'http://www.vatgia.com/2497/5144944/b%E1%BB%99-4-s%E1%BA%A3n-ph%E1%BA%A9m-c%E1%BB%A7a-3-ce-h%C3%A0n-qu%E1%BB%91c.html', 1, '2015-12-04 03:42:04'),
(183, 11, 'Cosmetics', 'Euphoria by Calvin Klein for Women Gift Set 188', 1500000, 'http://p.vatgia.vn/pictures_fullsize/ddh1384748316.jpg', 'http://www.vatgia.com/2495/3586323/euphoria-by-calvin-klein-for-women-gift-set-188.html', 1, '2015-12-04 03:42:04'),
(184, 11, 'Cosmetics', 'Bộ chăm sóc và cải thiện tóc thưa - mảnh & rụng L’Oréal Serioxyl Fuller Hair 1', 1533000, 'http://p.vatgia.vn/pictures_fullsize/off1440385390.jpg', 'http://www.vatgia.com/2494/5315747/b%E1%BB%99-ch%C4%83m-s%C3%B3c-v%C3%A0-c%E1%BA%A3i-thi%E1%BB%87n-t%C3%B3c-th%C6%B0a-m%E1%BA%A3nh-r%E1%BB%A5ng-l-or%C3%A9al-serioxyl-fuller-hair-1.html', 1, '2015-12-04 03:42:04'),
(185, 11, 'Cosmetics', 'Bộ trang điểm đầy đủ MAC tặng kèm 1 massacara maybelline', 235000, 'http://p.vatgia.vn/ir/gallery_img/11/7/b252MTQ0MDA0NjgxMC5qcGc-/bo-trang-diem-day-du-mac-tang-kem-1-massacara-maybelline-anh-4.jpg', 'http://www.vatgia.com/2497/5307920/b%E1%BB%99-trang-%C4%91i%E1%BB%83m-%C4%91%E1%BA%A7y-%C4%91%E1%BB%A7-mac-t%E1%BA%B7ng-k%C3%A8m-1-massacara-maybelline.html', 1, '2015-12-04 03:42:04'),
(186, 11, 'Cosmetics', 'Dầu gội và xả Big Sexy Hair 300ml', 400000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/eHR6MTQzMTU4NTk1NS5qcGc-/dau-goi-va-xa-big-sexy-hair-300ml.jpg', 'http://www.vatgia.com/2494/5069911/d%E1%BA%A7u-g%E1%BB%99i-v%C3%A0-x%E1%BA%A3-big-sexy-hair-300ml.html', 1, '2015-12-04 03:42:04'),
(187, 11, 'Cosmetics', 'Bộ gội xả radken duy trì màu tóc nhuộm 300ml', 590000, 'http://p.vatgia.vn/pictures_fullsize/oay1432832987.jpg', 'http://www.vatgia.com/2494/5113325/b%E1%BB%99-g%E1%BB%99i-x%E1%BA%A3-radken-duy-tr%C3%AC-m%C3%A0u-t%C3%B3c-nhu%E1%BB%99m-300ml.html', 1, '2015-12-04 03:42:04'),
(188, 11, 'Cosmetics', 'Bộ trang điểm mắt - môi - má Christan Dior- Pháp', 1200000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/eGNmMTM1MTAwNTk3OS5qcGc-/bo-trang-diem-mat-moi-ma-christan-dior-phap.jpg', 'http://www.vatgia.com/2497/2611913/b%E1%BB%99-trang-%C4%91i%E1%BB%83m-m%E1%BA%AFt-m%C3%B4i-m%C3%A1-christan-dior-ph%C3%A1p.html', 1, '2015-12-04 03:42:04'),
(189, 11, 'Cosmetics', 'Bộ gội xã nashi argan phục hồi tóc hư 500ml', 1128000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/aXZiMTQzMjU2OTY5OC5qcGc-/bo-goi-xa-nashi-argan-phuc-hoi-toc-hu-500ml.jpg', 'http://www.vatgia.com/2494/5103058/b%E1%BB%99-g%E1%BB%99i-x%C3%A3-nashi-argan-ph%E1%BB%A5c-h%E1%BB%93i-t%C3%B3c-h%C6%B0-500ml.html', 1, '2015-12-04 03:42:04'),
(190, 11, 'Cosmetics', 'Bộ 2 chai dầu gội và xả Ichikami Nhật - N2478', 346000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/eGF2MTQxMTc4NTc4My5qcGc-/bo-2-chai-dau-goi-va-xa-ichikami-nhat-n2478.jpg', 'http://www.vatgia.com/2494/4474441/b%E1%BB%99-2-chai-d%E1%BA%A7u-g%E1%BB%99i-v%C3%A0-x%E1%BA%A3-ichikami-nh%E1%BA%ADt-n2478.html', 1, '2015-12-04 03:42:04'),
(191, 11, 'Cosmetics', 'Bộ sản phẩm dành cho da mụn Botani – Rescue Skin Kit', 2009000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/d3pyMTQzMDgyMTU5My5qcGc-/bo-san-pham-danh-cho-da-mun-botani-rescue-skin-kit.jpg', 'http://www.vatgia.com/2493/5049897/b%E1%BB%99-s%E1%BA%A3n-ph%E1%BA%A9m-d%C3%A0nh-cho-da-m%E1%BB%A5n-botani-%E2%80%93-rescue-skin-kit.html', 1, '2015-12-04 03:42:04'),
(192, 11, 'Cosmetics', 'Set gội xả Stubaki đỏ', 370000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Y2trMTQzOTIyNjI1My5qcGc-/set-goi-xa-stubaki-do.jpg', 'http://www.vatgia.com/2494/5285392/set-g%E1%BB%99i-x%E1%BA%A3-stubaki-%C4%91%E1%BB%8F.html', 1, '2015-12-04 03:42:04'),
(193, 11, 'Cosmetics', 'Bộ set mỹ phẩm 03', 507000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Z29rMTQzMjEwNzk3OS5qcGc-/bo-set-my-pham-03.jpg', 'http://www.vatgia.com/2497/5086828/b%E1%BB%99-set-m%E1%BB%B9-ph%E1%BA%A9m-03.html', 1, '2015-12-04 03:42:04'),
(194, 11, 'Cosmetics', 'Kem dưỡng giúp cung cấp ẩm - làm trắng và ngăn ngừa các nếp nhăn', 149000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/eHZkMTQyMDcwMDIyNS5qcGc-/bo-doi-ngay-va-dem-20g-30g-hong-diep-khang.jpg', 'http://www.vatgia.com/2493/5243762/kem-d%C6%B0%E1%BB%A1ng-gi%C3%BAp-cung-c%E1%BA%A5p-%E1%BA%A9m-l%C3%A0m-tr%E1%BA%AFng-v%C3%A0-ng%C4%83n-ng%E1%BB%ABa-c%C3%A1c-n%E1%BA%BFp-nh%C4%83n.html', 1, '2015-12-04 03:42:04'),
(195, 11, 'Cosmetics', 'Bộ đôi ngày và đêm 20g - 30g - Hồng Diệp Khang', 379000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/eHZkMTQyMDcwMDIyNS5qcGc-/bo-doi-ngay-va-dem-20g-30g-hong-diep-khang.jpg', 'http://www.vatgia.com/2493/4780340/b%E1%BB%99-%C4%91%C3%B4i-ng%C3%A0y-v%C3%A0-%C4%91%C3%AAm-20g-30g-h%E1%BB%93ng-di%E1%BB%87p-khang.html', 1, '2015-12-04 03:42:04'),
(196, 11, 'Cosmetics', 'Gift set 3-Bộ chăm sóc da cơ bản dưỡng chất Mật ong-Kustie', 264000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dnZxMTM1MTU3MDQzMy5qcGc-/gift-set-3-bo-cham-soc-da-co-ban-duong-chat-mat-ong-kustie.jpg', 'http://www.vatgia.com/2493/2627318/gift-set-3-b%E1%BB%99-ch%C4%83m-s%C3%B3c-da-c%C6%A1-b%E1%BA%A3n-d%C6%B0%E1%BB%A1ng-ch%E1%BA%A5t-m%E1%BA%ADt-ong-kustie.html', 1, '2015-12-04 03:42:04'),
(197, 11, 'Cosmetics', 'Bộ sản phẩm dưỡng da – Loreal Youth Code', 600000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Z25hMTQxNDQyMjc2Mi5qcGc-/bo-san-pham-duong-da-loreal-youth-code.jpg', 'http://www.vatgia.com/2493/4577277/b%E1%BB%99-s%E1%BA%A3n-ph%E1%BA%A9m-d%C6%B0%E1%BB%A1ng-da-%E2%80%93-loreal-youth-code.html', 1, '2015-12-04 03:42:04');
INSERT INTO `vatgia_products` (`id`, `category_id`, `category_name`, `name`, `price`, `image_url`, `link_detail`, `alive`, `modified_date`) VALUES
(198, 12, 'Perfume', 'Nước hoa Cindy - N5', 95000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/eXN6MTQyNjY0NTkwNC5qcGc-/nuoc-hoa-cindy-n5.jpg', 'http://www.vatgia.com/10683/4919481/n%C6%B0%E1%BB%9Bc-hoa-cindy-n5.html', 1, '2015-12-04 03:42:05'),
(199, 12, 'Perfume', 'Nước hoa Daisy EDT 100ml MS148', 1900000, 'http://p.vatgia.vn/pictures_fullsize/vhk1397704709.jpg', 'http://www.vatgia.com/10683/3429601/n%C6%B0%E1%BB%9Bc-hoa-daisy-edt-100ml-ms148.html', 1, '2015-12-04 03:42:05'),
(200, 12, 'Perfume', 'Nước hoa Euphoria Men CK (Fake 1)', 190000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dmdhMTM3MDMzNjI5Mi5qcGc-/nuoc-hoa-euphoria-men-ck-fake-1.jpg', 'http://www.vatgia.com/330/3122799/n%C6%B0%E1%BB%9Bc-hoa-euphoria-men-ck-fake-1.html', 1, '2015-12-04 03:42:05'),
(201, 12, 'Perfume', 'Nước hoa AQVA pour Homme Marine 100ml', 200000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/cmF2MTQzMDc5MTUzMi5qcGc-/nuoc-hoa-aqva-pour-homme-marine-100ml.jpg', 'http://www.vatgia.com/10682/5047889/n%C6%B0%E1%BB%9Bc-hoa-aqva-pour-homme-marine-100ml.html', 1, '2015-12-04 03:42:05'),
(202, 12, 'Perfume', 'Nước hoa nữ Far Away', 259000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/YWlyMTQzNzA1MjI3My5qcGc-/nuoc-hoa-nu-far-away.jpg', 'http://www.vatgia.com/10683/5221930/n%C6%B0%E1%BB%9Bc-hoa-n%E1%BB%AF-far-away.html', 1, '2015-12-04 03:42:05'),
(203, 12, 'Perfume', 'Nước hoa Polo Double Black 125ml', 200000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/a3VuMTQzMDMwMTAyMS5qcGc-/nuoc-hoa-polo-double-black-125ml.jpg', 'http://www.vatgia.com/10682/5042943/n%C6%B0%E1%BB%9Bc-hoa-polo-double-black-125ml.html', 1, '2015-12-04 03:42:05'),
(204, 12, 'Perfume', 'Nước hoa Idylle for Women MS122', 2150000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dml3MTM3OTU3MDQyNS5qcGc-/nuoc-hoa-idylle-for-women-ms122.jpg', 'http://www.vatgia.com/10683/3416918/n%C6%B0%E1%BB%9Bc-hoa-idylle-for-women-ms122.html', 1, '2015-12-04 03:42:05'),
(205, 12, 'Perfume', 'Nước hoa Lancome Tresor Midnight Rose MS145', 1800000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bXV1MTM3OTk4ODAyMy5qcGc-/nuoc-hoa-lancome-tresor-midnight-rose-ms145.jpg', 'http://www.vatgia.com/10683/3429311/n%C6%B0%E1%BB%9Bc-hoa-lancome-tresor-midnight-rose-ms145.html', 1, '2015-12-04 03:42:05'),
(206, 12, 'Perfume', 'Nước hoa nam Avon Blue for Him', 135000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/YnZ0MTQzNzA1MjA3My5qcGc-/nuoc-hoa-nam-avon-blue-for-him.jpg', 'http://www.vatgia.com/10682/5221926/n%C6%B0%E1%BB%9Bc-hoa-nam-avon-blue-for-him.html', 1, '2015-12-04 03:42:05'),
(207, 12, 'Perfume', 'Nước hoa nam Bleu de Chanel', 195000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/enFjMTQwNDk5ODI4OC5qcGc-/nuoc-hoa-nam-bleu-de-chanel.jpg', 'http://www.vatgia.com/10682/4237804/n%C6%B0%E1%BB%9Bc-hoa-nam-bleu-de-chanel.html', 1, '2015-12-04 03:42:05'),
(208, 12, 'Perfume', 'Nước hoa Miss Dior Chrisie (Fake Sing)', 190000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bXpqMTM3MDMzNTY0Mi5qcGc-/nuoc-hoa-miss-dior-chrisie-fake-sing.jpg', 'http://www.vatgia.com/330/3062704/n%C6%B0%E1%BB%9Bc-hoa-miss-dior-chrisie-fake-sing.html', 1, '2015-12-04 03:42:05'),
(209, 12, 'Perfume', 'Nước hoa Versace Bright Crystal 90ml', 1200000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dWpxMTQwMTg4OTY3OS5qcGc-/nuoc-hoa-versace-bright-crystal-90ml.jpg', 'http://www.vatgia.com/10683/4130021/n%C6%B0%E1%BB%9Bc-hoa-versace-bright-crystal-90ml.html', 1, '2015-12-04 03:42:05'),
(210, 12, 'Perfume', 'Nước hoa Gucci by Gucci EDT 75ml MS116', 1600000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/eXBkMTM4MzI5NTAxMS5qcGc-/nuoc-hoa-gucci-by-gucci-edt-75ml-ms116.jpg', 'http://www.vatgia.com/10683/3542955/n%C6%B0%E1%BB%9Bc-hoa-gucci-by-gucci-edt-75ml-ms116.html', 1, '2015-12-04 03:42:05'),
(211, 12, 'Perfume', 'Bộ nước hoa Miss Saigon Elegance N4', 600000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/c3l2MTQzMjIwMDg0NS5qcGc-/bo-nuoc-hoa-miss-saigon-elegance-n4.jpg', 'http://www.vatgia.com/10683/5091890/b%E1%BB%99-n%C6%B0%E1%BB%9Bc-hoa-miss-saigon-elegance-n4.html', 1, '2015-12-04 03:42:05'),
(212, 12, 'Perfume', 'Nước hoa Gucci Guilty Limited Edition 75ml', 390000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dHB4MTQxODk4MzA4MC5qcGc-/nuoc-hoa-gucci-guilty-limited-edition-75ml.jpg', 'http://www.vatgia.com/10683/4734136/n%C6%B0%E1%BB%9Bc-hoa-gucci-guilty-limited-edition-75ml.html', 1, '2015-12-04 03:42:05'),
(213, 12, 'Perfume', 'Nước hoa Flower by Kenzo 50ml MS51780', 1300000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/aGlmMTQwMjM4OTc4OC5qcGc-/nuoc-hoa-flower-by-kenzo-50ml-ms51780.jpg', 'http://www.vatgia.com/10683/3440020/n%C6%B0%E1%BB%9Bc-hoa-flower-by-kenzo-50ml-ms51780.html', 1, '2015-12-04 03:42:05'),
(214, 12, 'Perfume', 'Nước hoa Nina L’Elixir MS30439', 1195000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/eGpiMTM4MDI0ODU1Ni5qcGc-/nuoc-hoa-nina-lelixir-ms30439.jpg', 'http://www.vatgia.com/10683/3440661/n%C6%B0%E1%BB%9Bc-hoa-nina-l-elixir-ms30439.html', 1, '2015-12-04 03:42:05'),
(215, 12, 'Perfume', 'Nước hoa Bvlgari Jasmin Noir EDP MS40100', 1350000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/YnJvMTM4MDI2Njg3OC5qcGc-/nuoc-hoa-bvlgari-jasmin-noir-edp-ms40100.jpg', 'http://www.vatgia.com/10683/3442608/n%C6%B0%E1%BB%9Bc-hoa-bvlgari-jasmin-noir-edp-ms40100.html', 1, '2015-12-04 03:42:05'),
(216, 12, 'Perfume', 'Nước hoa Bright Crystal MS19156', 850000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/enV6MTM4MDI1NjAxMi5qcGc-/nuoc-hoa-bright-crystal-ms19156.jpg', 'http://www.vatgia.com/10683/3441836/n%C6%B0%E1%BB%9Bc-hoa-bright-crystal-ms19156.html', 1, '2015-12-04 03:42:05'),
(217, 12, 'Perfume', 'Nước hoa Ange ou demon le secret MS106', 1950000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Z2hxMTM3OTU2NzI0MS5qcGc-/nuoc-hoa-ange-ou-demon-le-secret-ms106.jpg', 'http://www.vatgia.com/10683/3416842/n%C6%B0%E1%BB%9Bc-hoa-ange-ou-demon-le-secret-ms106.html', 1, '2015-12-04 03:42:05'),
(218, 12, 'Perfume', 'Nước hoa Hugo Boss Number One MS35715', 1395000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/aHF6MTM4MDI5MDA3NS5qcGc-/nuoc-hoa-hugo-boss-number-one-ms35715.jpg', 'http://www.vatgia.com/10682/3444089/n%C6%B0%E1%BB%9Bc-hoa-hugo-boss-number-one-ms35715.html', 1, '2015-12-04 03:42:05'),
(219, 12, 'Perfume', 'Nước hoa Gucci Guilty MS223', 1795000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/cnNvMTM4MzMyMTIwOS5qcGc-/nuoc-hoa-gucci-guilty-ms223.jpg', 'http://www.vatgia.com/10682/3543635/n%C6%B0%E1%BB%9Bc-hoa-gucci-guilty-ms223.html', 1, '2015-12-04 03:42:05'),
(220, 12, 'Perfume', 'Nước hoa Aqva Amara for men 100ml', 230000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/enNqMTQzMDc5MDM2OS5qcGc-/nuoc-hoa-aqva-amara-for-men-100ml.jpg', 'http://www.vatgia.com/10682/5047848/n%C6%B0%E1%BB%9Bc-hoa-aqva-amara-for-men-100ml.html', 1, '2015-12-04 03:42:05'),
(221, 12, 'Perfume', 'Nước hoa Versace Eros 100ml', 210000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/b2ttMTQzMDcxMzczMS5qcGc-/nuoc-hoa-versace-eros-100ml.jpg', 'http://www.vatgia.com/10682/5046371/n%C6%B0%E1%BB%9Bc-hoa-versace-eros-100ml.html', 1, '2015-12-04 03:42:05'),
(222, 12, 'Perfume', 'Nước hoa Polo Pony 4 125ml', 190000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/eXF1MTQzMDcwMzY2Ni5qcGc-/nuoc-hoa-polo-pony-4-125ml.jpg', 'http://www.vatgia.com/10682/5045771/n%C6%B0%E1%BB%9Bc-hoa-polo-pony-4-125ml.html', 1, '2015-12-04 03:42:05'),
(223, 12, 'Perfume', 'Nước hoa Dune 50ml MS10385', 2100000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dWF3MTM4MDI0NzQzMi5qcGc-/nuoc-hoa-dune-50ml-ms10385.jpg', 'http://www.vatgia.com/10683/3440419/n%C6%B0%E1%BB%9Bc-hoa-dune-50ml-ms10385.html', 1, '2015-12-04 03:42:05'),
(224, 12, 'Perfume', 'Nước hoa Gucci Edition Deluxe EDP MS21200', 1600000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dmRzMTM4MDI1MTk3MS5qcGc-/nuoc-hoa-gucci-edition-deluxe-edp-ms21200.jpg', 'http://www.vatgia.com/10683/3441267/n%C6%B0%E1%BB%9Bc-hoa-gucci-edition-deluxe-edp-ms21200.html', 1, '2015-12-04 03:42:05'),
(225, 12, 'Perfume', 'Nước hoa Bvlgari Omnia Amethyste 65ml MS30', 1150000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/em1jMTQwMjMwMjM3OS5qcGc-/nuoc-hoa-bvlgari-omnia-amethyste-65ml-ms30.jpg', 'http://www.vatgia.com/10683/3413628/n%C6%B0%E1%BB%9Bc-hoa-bvlgari-omnia-amethyste-65ml-ms30.html', 1, '2015-12-04 03:42:05'),
(226, 12, 'Perfume', 'Nước hoa Parisienne By Yves Saint Laurent MS177', 1300000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/d3d2MTM4MDAxMzY1OS5qcGc-/nuoc-hoa-parisienne-by-yves-saint-laurent-ms177.jpg', 'http://www.vatgia.com/10683/3431795/n%C6%B0%E1%BB%9Bc-hoa-parisienne-by-yves-saint-laurent-ms177.html', 1, '2015-12-04 03:42:05'),
(227, 12, 'Perfume', 'Nước hoa Very Irresistible Sensual 50ml MS111', 1300000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bmh0MTM3OTU2ODM1Mi5qcGc-/nuoc-hoa-very-irresistible-sensual-50ml-ms111.jpg', 'http://www.vatgia.com/10683/3416879/n%C6%B0%E1%BB%9Bc-hoa-very-irresistible-sensual-50ml-ms111.html', 1, '2015-12-04 03:42:05'),
(228, 13, 'Flower', 'Hoa Trang Trí FL01', 1670000, 'http://p.vatgia.vn/pictures_fullsize/mxt1439889791.jpg', 'http://www.vatgia.com/4765/5303048/hoa-trang-tr%C3%AD-fl01.html', 1, '2015-12-04 03:42:05'),
(229, 13, 'Flower', 'Hoa tình yêu Bình hoa hồng vĩnh cửu', 1650000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGJoMTQzOTcxNTc5NS5qcGc-/hoa-tinh-yeu-binh-hoa-hong-vinh-cuu.jpg', 'http://www.vatgia.com/2963/5298247/hoa-t%C3%ACnh-y%C3%AAu-b%C3%ACnh-hoa-h%E1%BB%93ng-v%C4%A9nh-c%E1%BB%ADu.html', 1, '2015-12-04 03:42:05'),
(230, 13, 'Flower', 'Hoa trang trí FF14', 1100000, 'http://p.vatgia.vn/pictures_fullsize/irr1439785783.jpg', 'http://www.vatgia.com/4765/5299147/hoa-trang-tr%C3%AD-ff14.html', 1, '2015-12-04 03:42:05'),
(231, 13, 'Flower', 'Lan Hồ Điệp - L0046', 2000000, 'http://p.vatgia.vn/pictures_fullsize/enk1427181623.jpg', 'http://www.vatgia.com/2967/4936770/lan-h%E1%BB%93-%C4%91i%E1%BB%87p-l0046.html', 1, '2015-12-04 03:42:05'),
(232, 13, 'Flower', 'Hoa trang trí Lay Ơn FF01', 800000, 'http://p.vatgia.vn/pictures_fullsize/pem1437108737.jpg', 'http://www.vatgia.com/4765/5296135/hoa-trang-tr%C3%AD-lay-%C6%A1n-ff01.html', 1, '2015-12-04 03:42:05'),
(233, 13, 'Flower', 'Hoa cưới SM02', 350000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/a3p6MTM5NDc5MTczOS5KUEc-/hoa-cuoi-sm02.jpg', 'http://www.vatgia.com/2968/3893776/hoa-c%C6%B0%E1%BB%9Bi-sm02.html', 1, '2015-12-04 03:42:05'),
(234, 13, 'Flower', 'Tuổi hồng trong sáng - MHSN016', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bG5rMTM4MzcwNjc3MC5qcGc-/tuoi-hong-trong-sang-mhsn016.jpg', 'http://www.vatgia.com/2966/3553430/tu%E1%BB%95i-h%E1%BB%93ng-trong-s%C3%A1ng-mhsn016.html', 1, '2015-12-04 03:42:05'),
(235, 13, 'Flower', 'Hoa tươi H0090', 300000, 'http://p.vatgia.vn/pictures_fullsize/hzk1427328500.jpg', 'http://www.vatgia.com/2966/4942365/hoa-t%C6%B0%C6%A1i-h0090.html', 1, '2015-12-04 03:42:05'),
(236, 13, 'Flower', 'Hoa tươi H0080', 700000, 'http://p.vatgia.vn/pictures_fullsize/hfs1427329028.jpg', 'http://www.vatgia.com/2966/4942375/hoa-t%C6%B0%C6%A1i-h0080.html', 1, '2015-12-04 03:42:05'),
(237, 13, 'Flower', 'Hoa tươi H0124', 350000, 'http://p.vatgia.vn/pictures_fullsize/bgw1427293582.jpg', 'http://www.vatgia.com/2966/4942000/hoa-t%C6%B0%C6%A1i-h0124.html', 1, '2015-12-04 03:42:05'),
(238, 13, 'Flower', 'Lan Hồ Điệp - L0028', 1500000, 'http://p.vatgia.vn/pictures_fullsize/pzd1427183727.jpg', 'http://www.vatgia.com/2967/4937024/lan-h%E1%BB%93-%C4%91i%E1%BB%87p-l0028.html', 1, '2015-12-04 03:42:05'),
(239, 13, 'Flower', 'Hoa trang trí - Xương Rồng FF01', 350000, 'http://p.vatgia.vn/pictures_fullsize/eyv1437109372.jpg', 'http://www.vatgia.com/4765/5296128/hoa-trang-tr%C3%AD-x%C6%B0%C6%A1ng-r%E1%BB%93ng-ff01.html', 1, '2015-12-04 03:42:05'),
(240, 13, 'Flower', 'Hoa trang trí hoa Phong Lan trắng', 700000, 'http://p.vatgia.vn/pictures_fullsize/lgh1438418182.jpg', 'http://www.vatgia.com/4765/5263774/hoa-trang-tr%C3%AD-hoa-phong-lan-tr%E1%BA%AFng.html', 1, '2015-12-04 03:42:05'),
(241, 13, 'Flower', 'Hoa Tình yêu hoàn hảo - MHTY037', 715000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGtnMTM4MzcxNzgwNy5qcGc-/hoa-tinh-yeu-trai-tim-hoan-hao-mhty037.jpg', 'http://www.vatgia.com/2963/3554426/hoa-t%C3%ACnh-y%C3%AAu-tr%C3%A1i-tim-ho%C3%A0n-h%E1%BA%A3o-mhty037.html', 1, '2015-12-04 03:42:05'),
(242, 13, 'Flower', 'Vẫn mãi yêu - MHTY055', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/d25hMTM4MzcxOTY2OS5qcGc-/van-mai-yeu-mhty055.jpg', 'http://www.vatgia.com/2963/3554522/v%E1%BA%ABn-m%C3%A3i-y%C3%AAu-mhty055.html', 1, '2015-12-04 03:42:05'),
(243, 13, 'Flower', 'Hoa hồng bất tử – Hộp tim 9 bông hồng', 470000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGxiMTQyNzk0NjQ0Ny5qcGc-/hoa-hong-bat-tu-hop-tim-9-bong-hong.jpg', 'http://www.vatgia.com/2963/4964574/hoa-h%E1%BB%93ng-b%E1%BA%A5t-t%E1%BB%AD-%E2%80%93-h%E1%BB%99p-tim-9-b%C3%B4ng-h%E1%BB%93ng.html', 1, '2015-12-04 03:42:05'),
(244, 13, 'Flower', 'Kỷ niệm xưa - MHSN024', 520000, 'http://p.vatgia.vn/pictures_fullsize/uzl1383707480.jpg', 'http://www.vatgia.com/2966/3553525/k%E1%BB%B7-ni%E1%BB%87m-x%C6%B0a-mhsn024.html', 1, '2015-12-04 03:42:05'),
(245, 13, 'Flower', 'Hoa tươi H0063', 300000, 'http://p.vatgia.vn/pictures_fullsize/kdn1427332108.jpg', 'http://www.vatgia.com/2966/4942409/hoa-t%C6%B0%C6%A1i-h0063.html', 1, '2015-12-04 03:42:05'),
(246, 13, 'Flower', 'Hoa tươi - H0164', 300000, 'http://p.vatgia.vn/pictures_fullsize/iqq1427187776.jpg', 'http://www.vatgia.com/2966/4942436/hoa-t%C6%B0%C6%A1i-h0067.html', 1, '2015-12-04 03:42:05'),
(247, 13, 'Flower', 'Hoa tươi H0067', 250000, 'http://p.vatgia.vn/pictures_fullsize/jdm1427333201.jpg', 'http://www.vatgia.com/2966/4937495/hoa-t%C6%B0%C6%A1i-h0164.html', 1, '2015-12-04 03:42:05'),
(248, 13, 'Flower', 'Hoa tình yêu bó 20 bông hoa hồng xanh tươi 5 năm', 2000000, 'http://p.vatgia.vn/ir/gallery_img/4/7/cG1xMTQzOTY1MjQ2Ni5qcGc-/hoa-tinh-yeu-bo-20-bong-hoa-hong-xanh-tuoi-5-nam-anh-2.jpg', 'http://www.vatgia.com/2963/5297685/hoa-t%C3%ACnh-y%C3%AAu-b%C3%B3-20-b%C3%B4ng-hoa-h%E1%BB%93ng-xanh-t%C6%B0%C6%A1i-5-n%C4%83m.html', 1, '2015-12-04 03:42:05'),
(249, 13, 'Flower', 'Hoa trang trí FF03', 530000, 'http://p.vatgia.vn/pictures_fullsize/mim1439786429.jpg', 'http://www.vatgia.com/4765/5299183/hoa-trang-tr%C3%AD-ff03.html', 1, '2015-12-04 03:42:05'),
(250, 13, 'Flower', 'Đón nắng mùa xuân - MBCM004', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bHZrMTM4MzY1Mzk4OS5qcGc-/don-nang-mua-xuan-mbcm004.jpg', 'http://www.vatgia.com/2967/3552534/%C4%91%C3%B3n-n%E1%BA%AFng-m%C3%B9a-xu%C3%A2n-mbcm004.html', 1, '2015-12-04 03:42:05'),
(251, 13, 'Flower', 'Hoa trang trí nghệ thuật Phong Lan tím FF02', 320000, 'http://p.vatgia.vn/pictures_fullsize/ndx1437031996.jpg', 'http://www.vatgia.com/4765/5296088/hoa-trang-tr%C3%AD-ngh%E1%BB%87-thu%E1%BA%ADt-phong-lan-t%C3%ADm-ff02.html', 1, '2015-12-04 03:42:05'),
(252, 13, 'Flower', 'Ngày xanh tươi - MBCM019', 520000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Ym9xMTM4MzY1MjQ0OC5qcGc-/ngay-xanh-tuoi-mbcm019.jpg', 'http://www.vatgia.com/2967/3552514/ng%C3%A0y-xanh-t%C6%B0%C6%A1i-mbcm019.html', 1, '2015-12-04 03:42:05'),
(253, 13, 'Flower', 'Hoa hồng bất tử – Hộp trụ', 250000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dmh1MTQyNzk0NzkwOS5qcGc-/hoa-hong-bat-tu-hop-tru.jpg', 'http://www.vatgia.com/2963/4964727/hoa-h%E1%BB%93ng-b%E1%BA%A5t-t%E1%BB%AD-%E2%80%93-h%E1%BB%99p-tr%E1%BB%A5.html', 1, '2015-12-04 03:42:05'),
(254, 13, 'Flower', 'Hoa tươi - H0166', 400000, 'http://p.vatgia.vn/pictures_fullsize/xts1427187941.jpg', 'http://www.vatgia.com/2966/4937514/hoa-t%C6%B0%C6%A1i-h0166.html', 1, '2015-12-04 03:42:05'),
(255, 13, 'Flower', 'Hoa tươi - H0148', 400000, 'http://p.vatgia.vn/pictures_fullsize/iyl1427189109.jpg', 'http://www.vatgia.com/2966/4937655/hoa-t%C6%B0%C6%A1i-h0148.html', 1, '2015-12-04 03:42:05'),
(256, 13, 'Flower', 'Hoa tươi H0067', 250000, 'http://p.vatgia.vn/pictures_fullsize/jdm1427333201.jpg', 'http://www.vatgia.com/2966/4942436/hoa-t%C6%B0%C6%A1i-h0067.html', 1, '2015-12-04 03:42:05'),
(257, 13, 'Flower', 'Hoa tươi - H0179', 800000, 'http://p.vatgia.vn/pictures_fullsize/jhe1427187451.jpg', 'http://www.vatgia.com/2966/4937447/hoa-t%C6%B0%C6%A1i-h0179.html', 1, '2015-12-04 03:42:05');

-- --------------------------------------------------------

--
-- Table structure for table `vtc_response_code`
--

CREATE TABLE IF NOT EXISTS `vtc_response_code` (
  `id` bigint(20) NOT NULL,
  `code` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `comment` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vtc_response_code`
--

INSERT INTO `vtc_response_code` (`id`, `code`, `description`, `comment`) VALUES
(1, 1, 'Giao dịch thành công', NULL),
(2, 0, 'Giao dịch chưa xác định', 'Giao dịch nghi vấn, không hoàn tiền\n'),
(3, -1, 'Lỗi hệ thống', 'Giao dịch nghi vấn, không hoàn tiền\r\n'),
(4, -55, 'Số dư tài khoản không đủ để thực hiện giao dịch này', NULL),
(5, -99, 'Lỗi chưa xác định', 'Giao dịch nghi vấn, không hoàn tiền'),
(6, -290, 'Thông tin lệnh nạp tiền hợp lệ. Đang chờ kết quả xử lý', 'Giao dịch đang xử lý. Có thể gọi hàm check \ntrạng thái để kiểm tra\nkết quả giao dịch'),
(7, -302, 'Partner không tồn tại hoặc đang tạm dừng hoạt động', 'Cho phép hoàn tiền'),
(8, -304, ' Dịch vụ này không tồn tại hoặc\r\n đang tạm dừng\r\n', ' Cho phép hoàn tiền\r\n'),
(9, -305, ' Chữ ký không hợp lệ\r\n ', ' Cho phép hoàn tiền\r\n'),
(10, -306, ' Mệnh giá không hợp lệ hoặc đang tạm dừng\r\n', ' Cho phép hoàn tiền'),
(11, -307, ' Tài khoản nạp tiền không tồn tại\r\n hoặc không hợp lệ\r\n', 'Cho phép hoàn tiền\r\n'),
(12, -308, ' RequesData không hợp lệ\r\n ', ' Cho phép hoàn tiền\r\n'),
(13, -309, 'Ngày giao dịch truyền không đúng ', ' Cho phép hoàn tiền\r\n'),
(14, -310, ' Hết hạn mức cho phép sử dụng\r\n dịch vụ này\r\n', ' Cho phép hoàn tiền'),
(15, -311, ' RequesData hoặc PartnerCode\r\n không đúng\r\n', ' Cho phép hoàn tiền\r\n'),
(16, -315, ' Phải truyền CommandType\r\n ', ' Cho phép hoàn tiền'),
(17, -316, ' Phải truyền version\r\n ', ' Cho phép hoàn tiền\r\n'),
(18, -317, 'Số lượng thẻ không hợp lệ\r\n ', ' Cho phép hoàn tiền'),
(19, -318, ' ServiceCode không đúng\r\n ', 'Cho phép hoàn tiền'),
(20, -320, ' Hệ thống gián đoạn\r\n ', 'Cho phép hoàn tiền'),
(21, -348, ' Tài khoản bị Block\r\n ', 'Cho phép hoàn tiền'),
(22, -350, ' Tài khoản không tồn tại\r\n ', 'Cho phép hoàn tiền'),
(23, -500, 'Loại thẻ này trong kho hiện đã hết\r\nhoặc tạm ngừng xuất\r\n', 'Cho phép hoàn tiền'),
(24, 501, 'Giao dịch không thành công\r\n', 'Cho phép hoàn tiền'),
(25, -502, 'Không tồn tại giao dịch\r\n', NULL),
(26, -503, ' Đối tác không đươc thực hiện\r\nchức năng này\r\n', NULL),
(27, -504, ' Mã giao dịch này đã check quá tối\r\nđa số lần cho phép\r\n', NULL),
(28, -505, ' Số lần check vượt quá hạn mức\r\ncho phép trong ngày\r\n', NULL),
(29, -509, ' Giao dịch bị hủy (thất bại)\r\n', NULL),
(30, -600, ' Quá hạn mức\r\n ', ' Cho phép hoàn tiền\r\n');

-- --------------------------------------------------------

--
-- Table structure for table `vtc_service_code`
--

CREATE TABLE IF NOT EXISTS `vtc_service_code` (
  `id` bigint(20) NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `network` bigint(20) NOT NULL,
  `menh_gia` varchar(255) DEFAULT NULL,
  `chuc_nang` varchar(255) DEFAULT NULL,
  `lx_chuc_nang` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vtc_service_code`
--

INSERT INTO `vtc_service_code` (`id`, `code`, `name`, `network`, `menh_gia`, `chuc_nang`, `lx_chuc_nang`, `description`) VALUES
(1, 'VTC0027', 'Thẻ Viettel', 1, NULL, NULL, 'MUA_LAY_THE_CAO', NULL),
(2, 'VTC0028', 'Thẻ Vinafone', 2, NULL, NULL, 'MUA_LAY_THE_CAO', NULL),
(3, 'VTC0029', 'Thẻ Mobile', 3, NULL, NULL, 'MUA_LAY_THE_CAO', NULL),
(4, 'VTC0173', 'Thẻ GMobile', 4, NULL, NULL, 'MUA_LAY_THE_CAO', NULL),
(5, 'VTC0030', 'Mã thẻ SFone', 6, NULL, NULL, 'MUA_LAY_THE_CAO', NULL),
(6, 'VTC0154', 'Mã thẻ Vietnamobile', 5, NULL, NULL, 'MUA_LAY_THE_CAO', NULL),
(7, 'VTC0056', 'Nạp tiền trả trước Viettel', 1, NULL, NULL, 'NAP_TIEN_TRA_TRUOC', NULL),
(8, 'VTC0057', 'Nạp tiền trả trước Vinafone', 2, NULL, NULL, 'NAP_TIEN_TRA_TRUOC', NULL),
(9, 'VTC0058', 'Nạp tiền trả trước Mobifone', 3, NULL, NULL, 'NAP_TIEN_TRA_TRUOC', NULL),
(10, 'VTC0176', 'Nạp tiền trả trước Vietnamobile', 5, NULL, NULL, 'NAP_TIEN_TRA_TRUOC', NULL),
(11, 'VTC0177', 'Nạp tiền trả trước Gmobile', 4, NULL, NULL, 'NAP_TIEN_TRA_TRUOC', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_users`
--
ALTER TABLE `admin_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admin_user_unique_email` (`email`);

--
-- Indexes for table `admin_users_authority`
--
ALTER TABLE `admin_users_authority`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_user_id` (`admin_user_id`);

--
-- Indexes for table `admin_user_password_history`
--
ALTER TABLE `admin_user_password_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_user_id` (`admin_user_id`);

--
-- Indexes for table `authorities`
--
ALTER TABLE `authorities`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `authority` (`authority`);

--
-- Indexes for table `authorize_customer_result`
--
ALTER TABLE `authorize_customer_result`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `authorize_payment_result`
--
ALTER TABLE `authorize_payment_result`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `billing_address`
--
ALTER TABLE `billing_address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `card_id` (`user_id`);

--
-- Indexes for table `buy_card`
--
ALTER TABLE `buy_card`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender` (`order_id`),
  ADD KEY `receiver` (`recipient`),
  ADD KEY `vtc_code` (`vtc_code`);

--
-- Indexes for table `buy_card_result`
--
ALTER TABLE `buy_card_result`
  ADD PRIMARY KEY (`id`),
  ADD KEY `buy_id` (`buy_id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currency_type`
--
ALTER TABLE `currency_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `code_2` (`code`);

--
-- Indexes for table `customer_comment`
--
ALTER TABLE `customer_comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `problem_id` (`problem_id`);

--
-- Indexes for table `customer_problem`
--
ALTER TABLE `customer_problem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `customer_problem_management`
--
ALTER TABLE `customer_problem_management`
  ADD PRIMARY KEY (`id`),
  ADD KEY `prob_id` (`prob_id`);

--
-- Indexes for table `customer_problem_status`
--
ALTER TABLE `customer_problem_status`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `customer_subject`
--
ALTER TABLE `customer_subject`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dau_so`
--
ALTER TABLE `dau_so`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `network` (`network`);

--
-- Indexes for table `exchange_rates`
--
ALTER TABLE `exchange_rates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trader_id` (`trader_id`),
  ADD KEY `currency_id` (`currency_id`);

--
-- Indexes for table `lixi_card_fees`
--
ALTER TABLE `lixi_card_fees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lixi_category`
--
ALTER TABLE `lixi_category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `vatgia_id` (`vatgia_id`);

--
-- Indexes for table `lixi_exchange_rates`
--
ALTER TABLE `lixi_exchange_rates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `currency` (`currency`);

--
-- Indexes for table `lixi_fees`
--
ALTER TABLE `lixi_fees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `lixi_global_fee`
--
ALTER TABLE `lixi_global_fee`
  ADD PRIMARY KEY (`id`),
  ADD KEY `country` (`country`);

--
-- Indexes for table `lixi_handling_fees`
--
ALTER TABLE `lixi_handling_fees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `currency_cde` (`currency_code`);

--
-- Indexes for table `lixi_invoices`
--
ALTER TABLE `lixi_invoices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `lixi_invoice_payment`
--
ALTER TABLE `lixi_invoice_payment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lixi_orders`
--
ALTER TABLE `lixi_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender` (`sender`),
  ADD KEY `lx_exchange_rate_id` (`lx_exchange_rate_id`),
  ADD KEY `card_id` (`card_id`),
  ADD KEY `bank_account_id` (`bank_account_id`);

--
-- Indexes for table `lixi_order_gifts`
--
ALTER TABLE `lixi_order_gifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recipient` (`recipient`),
  ADD KEY `category` (`category`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `money_level`
--
ALTER TABLE `money_level`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `networks`
--
ALTER TABLE `networks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `recipients`
--
ALTER TABLE `recipients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender` (`sender`);

--
-- Indexes for table `support_locale`
--
ALTER TABLE `support_locale`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `top_up_mobile_phone`
--
ALTER TABLE `top_up_mobile_phone`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender` (`order_id`),
  ADD KEY `recipient` (`recipient`);

--
-- Indexes for table `top_up_result`
--
ALTER TABLE `top_up_result`
  ADD PRIMARY KEY (`id`),
  ADD KEY `top_up_id` (`top_up_id`);

--
-- Indexes for table `traders`
--
ALTER TABLE `traders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_bank_accounts`
--
ALTER TABLE `user_bank_accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `bill_address` (`bill_address`);

--
-- Indexes for table `user_cards`
--
ALTER TABLE `user_cards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `bill_address` (`bill_address`);

--
-- Indexes for table `user_money_level`
--
ALTER TABLE `user_money_level`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id_2` (`user_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `money_level` (`money_level`);

--
-- Indexes for table `user_secret_code`
--
ALTER TABLE `user_secret_code`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `user_id` (`user_id`) USING BTREE;

--
-- Indexes for table `vatgia_category`
--
ALTER TABLE `vatgia_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vatgia_products`
--
ALTER TABLE `vatgia_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vtc_response_code`
--
ALTER TABLE `vtc_response_code`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vtc_service_code`
--
ALTER TABLE `vtc_service_code`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code_2` (`code`),
  ADD KEY `code` (`code`),
  ADD KEY `network` (`network`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_users`
--
ALTER TABLE `admin_users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `admin_users_authority`
--
ALTER TABLE `admin_users_authority`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT for table `admin_user_password_history`
--
ALTER TABLE `admin_user_password_history`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `authorities`
--
ALTER TABLE `authorities`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `authorize_customer_result`
--
ALTER TABLE `authorize_customer_result`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `authorize_payment_result`
--
ALTER TABLE `authorize_payment_result`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `billing_address`
--
ALTER TABLE `billing_address`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `buy_card`
--
ALTER TABLE `buy_card`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `buy_card_result`
--
ALTER TABLE `buy_card_result`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `currency_type`
--
ALTER TABLE `currency_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `customer_comment`
--
ALTER TABLE `customer_comment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `customer_problem`
--
ALTER TABLE `customer_problem`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1037;
--
-- AUTO_INCREMENT for table `customer_problem_management`
--
ALTER TABLE `customer_problem_management`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `customer_problem_status`
--
ALTER TABLE `customer_problem_status`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `customer_subject`
--
ALTER TABLE `customer_subject`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `dau_so`
--
ALTER TABLE `dau_so`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=33;
--
-- AUTO_INCREMENT for table `exchange_rates`
--
ALTER TABLE `exchange_rates`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `lixi_card_fees`
--
ALTER TABLE `lixi_card_fees`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `lixi_category`
--
ALTER TABLE `lixi_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=44;
--
-- AUTO_INCREMENT for table `lixi_exchange_rates`
--
ALTER TABLE `lixi_exchange_rates`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `lixi_fees`
--
ALTER TABLE `lixi_fees`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `lixi_global_fee`
--
ALTER TABLE `lixi_global_fee`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `lixi_handling_fees`
--
ALTER TABLE `lixi_handling_fees`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `lixi_invoices`
--
ALTER TABLE `lixi_invoices`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `lixi_invoice_payment`
--
ALTER TABLE `lixi_invoice_payment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `lixi_orders`
--
ALTER TABLE `lixi_orders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `lixi_order_gifts`
--
ALTER TABLE `lixi_order_gifts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=54;
--
-- AUTO_INCREMENT for table `money_level`
--
ALTER TABLE `money_level`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `networks`
--
ALTER TABLE `networks`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `recipients`
--
ALTER TABLE `recipients`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `support_locale`
--
ALTER TABLE `support_locale`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `top_up_mobile_phone`
--
ALTER TABLE `top_up_mobile_phone`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `top_up_result`
--
ALTER TABLE `top_up_result`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `traders`
--
ALTER TABLE `traders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `user_bank_accounts`
--
ALTER TABLE `user_bank_accounts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_cards`
--
ALTER TABLE `user_cards`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `user_money_level`
--
ALTER TABLE `user_money_level`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `user_secret_code`
--
ALTER TABLE `user_secret_code`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `vtc_response_code`
--
ALTER TABLE `vtc_response_code`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT for table `vtc_service_code`
--
ALTER TABLE `vtc_service_code`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_users_authority`
--
ALTER TABLE `admin_users_authority`
  ADD CONSTRAINT `admin_users_authority_ibfk_1` FOREIGN KEY (`admin_user_id`) REFERENCES `admin_users` (`id`);

--
-- Constraints for table `admin_user_password_history`
--
ALTER TABLE `admin_user_password_history`
  ADD CONSTRAINT `admin_user_password_history_ibfk_1` FOREIGN KEY (`admin_user_id`) REFERENCES `admin_users` (`id`);

--
-- Constraints for table `billing_address`
--
ALTER TABLE `billing_address`
  ADD CONSTRAINT `billing_address_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `buy_card`
--
ALTER TABLE `buy_card`
  ADD CONSTRAINT `buy_card_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `lixi_orders` (`id`),
  ADD CONSTRAINT `buy_card_ibfk_2` FOREIGN KEY (`recipient`) REFERENCES `recipients` (`id`),
  ADD CONSTRAINT `buy_card_ibfk_3` FOREIGN KEY (`vtc_code`) REFERENCES `vtc_service_code` (`code`);

--
-- Constraints for table `buy_card_result`
--
ALTER TABLE `buy_card_result`
  ADD CONSTRAINT `buy_card_result_ibfk_1` FOREIGN KEY (`buy_id`) REFERENCES `buy_card` (`id`);

--
-- Constraints for table `customer_comment`
--
ALTER TABLE `customer_comment`
  ADD CONSTRAINT `customer_comment_ibfk_1` FOREIGN KEY (`problem_id`) REFERENCES `customer_problem` (`id`);

--
-- Constraints for table `customer_problem`
--
ALTER TABLE `customer_problem`
  ADD CONSTRAINT `customer_problem_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `customer_subject` (`id`),
  ADD CONSTRAINT `customer_problem_ibfk_2` FOREIGN KEY (`status`) REFERENCES `customer_problem_status` (`id`);

--
-- Constraints for table `customer_problem_management`
--
ALTER TABLE `customer_problem_management`
  ADD CONSTRAINT `customer_problem_management_ibfk_1` FOREIGN KEY (`prob_id`) REFERENCES `customer_problem` (`id`);

--
-- Constraints for table `dau_so`
--
ALTER TABLE `dau_so`
  ADD CONSTRAINT `dau_so_ibfk_1` FOREIGN KEY (`network`) REFERENCES `networks` (`id`);

--
-- Constraints for table `exchange_rates`
--
ALTER TABLE `exchange_rates`
  ADD CONSTRAINT `exchange_rates_ibfk_1` FOREIGN KEY (`trader_id`) REFERENCES `traders` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `exchange_rates_ibfk_2` FOREIGN KEY (`currency_id`) REFERENCES `currency_type` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `lixi_category`
--
ALTER TABLE `lixi_category`
  ADD CONSTRAINT `lixi_category_ibfk_1` FOREIGN KEY (`vatgia_id`) REFERENCES `vatgia_category` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `lixi_exchange_rates`
--
ALTER TABLE `lixi_exchange_rates`
  ADD CONSTRAINT `lixi_exchange_rates_ibfk_1` FOREIGN KEY (`currency`) REFERENCES `currency_type` (`code`);

--
-- Constraints for table `lixi_global_fee`
--
ALTER TABLE `lixi_global_fee`
  ADD CONSTRAINT `lixi_global_fee_ibfk_1` FOREIGN KEY (`country`) REFERENCES `countries` (`id`);

--
-- Constraints for table `lixi_invoices`
--
ALTER TABLE `lixi_invoices`
  ADD CONSTRAINT `lixi_invoices_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `lixi_orders` (`id`);

--
-- Constraints for table `lixi_orders`
--
ALTER TABLE `lixi_orders`
  ADD CONSTRAINT `lixi_orders_ibfk_1` FOREIGN KEY (`sender`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `lixi_orders_ibfk_2` FOREIGN KEY (`lx_exchange_rate_id`) REFERENCES `lixi_exchange_rates` (`id`),
  ADD CONSTRAINT `lixi_orders_ibfk_3` FOREIGN KEY (`card_id`) REFERENCES `user_cards` (`id`),
  ADD CONSTRAINT `lixi_orders_ibfk_4` FOREIGN KEY (`bank_account_id`) REFERENCES `user_bank_accounts` (`id`);

--
-- Constraints for table `lixi_order_gifts`
--
ALTER TABLE `lixi_order_gifts`
  ADD CONSTRAINT `lixi_order_gifts_ibfk_1` FOREIGN KEY (`recipient`) REFERENCES `recipients` (`id`),
  ADD CONSTRAINT `lixi_order_gifts_ibfk_5` FOREIGN KEY (`category`) REFERENCES `lixi_category` (`id`),
  ADD CONSTRAINT `lixi_order_gifts_ibfk_6` FOREIGN KEY (`order_id`) REFERENCES `lixi_orders` (`id`);

--
-- Constraints for table `recipients`
--
ALTER TABLE `recipients`
  ADD CONSTRAINT `recipients_ibfk_1` FOREIGN KEY (`sender`) REFERENCES `users` (`id`);

--
-- Constraints for table `top_up_mobile_phone`
--
ALTER TABLE `top_up_mobile_phone`
  ADD CONSTRAINT `top_up_mobile_phone_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `lixi_orders` (`id`),
  ADD CONSTRAINT `top_up_mobile_phone_ibfk_2` FOREIGN KEY (`recipient`) REFERENCES `recipients` (`id`);

--
-- Constraints for table `top_up_result`
--
ALTER TABLE `top_up_result`
  ADD CONSTRAINT `top_up_result_ibfk_1` FOREIGN KEY (`top_up_id`) REFERENCES `top_up_mobile_phone` (`id`);

--
-- Constraints for table `user_bank_accounts`
--
ALTER TABLE `user_bank_accounts`
  ADD CONSTRAINT `user_bank_accounts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_bank_accounts_ibfk_2` FOREIGN KEY (`bill_address`) REFERENCES `billing_address` (`id`);

--
-- Constraints for table `user_cards`
--
ALTER TABLE `user_cards`
  ADD CONSTRAINT `user_cards_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_cards_ibfk_2` FOREIGN KEY (`bill_address`) REFERENCES `billing_address` (`id`);

--
-- Constraints for table `user_money_level`
--
ALTER TABLE `user_money_level`
  ADD CONSTRAINT `user_money_level_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_money_level_ibfk_2` FOREIGN KEY (`money_level`) REFERENCES `money_level` (`id`);

--
-- Constraints for table `user_secret_code`
--
ALTER TABLE `user_secret_code`
  ADD CONSTRAINT `user_secret_code_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `vtc_service_code`
--
ALTER TABLE `vtc_service_code`
  ADD CONSTRAINT `vtc_service_code_ibfk_1` FOREIGN KEY (`network`) REFERENCES `networks` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
