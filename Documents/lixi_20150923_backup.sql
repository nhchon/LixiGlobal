-- phpMyAdmin SQL Dump
-- version 4.4.14.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 22, 2015 at 07:33 PM
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
CREATE DATABASE IF NOT EXISTS `lixi` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `lixi`;

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
-- Table structure for table `billing_address`
--

CREATE TABLE IF NOT EXISTS `billing_address` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `add1` varchar(255) NOT NULL,
  `add2` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `zip_code` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `billing_address`
--

INSERT INTO `billing_address` (`id`, `user_id`, `full_name`, `add1`, `add2`, `city`, `state`, `zip_code`, `phone`) VALUES
(31, 11, 'Nguyen Thi Tam Tung', '76 Ngo May', '', 'Quy Nhon', 'Binh Dinh', '56000', '+84967007869'),
(32, 6, 'Nguyen Thi Tam Tung', '76 Ngo May', '', 'Quy Nhon', 'Binh Dinh', '56000', '+84967007869');

-- --------------------------------------------------------

--
-- Table structure for table `buy_phone_card`
--

CREATE TABLE IF NOT EXISTS `buy_phone_card` (
  `id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `recipient` bigint(20) NOT NULL,
  `vtc_code` varchar(10) NOT NULL,
  `num_of_card` int(11) NOT NULL,
  `value_of_card` int(11) NOT NULL,
  `modified_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `buy_phone_card`
--

INSERT INTO `buy_phone_card` (`id`, `order_id`, `recipient`, `vtc_code`, `num_of_card`, `value_of_card`, `modified_date`) VALUES
(3, 25, 6, 'VTC0027', 1, 100000, '2015-09-19 10:07:21');

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
-- Table structure for table `exchange_rates`
--

CREATE TABLE IF NOT EXISTS `exchange_rates` (
  `id` bigint(20) NOT NULL,
  `trader_id` bigint(20) NOT NULL,
  `currency_id` bigint(20) NOT NULL,
  `buy` decimal(10,0) NOT NULL,
  `sell` decimal(10,0) NOT NULL,
  `vcb_buy` double NOT NULL,
  `vcb_sell` double NOT NULL,
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
  `locale_code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `activated` int(11) NOT NULL DEFAULT '1',
  `sort_order` int(11) NOT NULL DEFAULT '9999',
  `created_date` datetime NOT NULL,
  `created_by` varchar(255) NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `modified_by` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lixi_category`
--

INSERT INTO `lixi_category` (`id`, `vatgia_id`, `locale_code`, `name`, `icon`, `activated`, `sort_order`, `created_date`, `created_by`, `modified_date`, `modified_by`) VALUES
(17, 2, 'en_US', 'Baby Stuffs', 'no_image.jpg', 1, 9999, '2015-06-24 20:44:20', 'chonnh@gmail.com', NULL, NULL),
(18, 2, 'vi_VN', 'Đồ trẻ sơ sinh', 'no_image.jpg', 1, 9999, '2015-06-24 20:44:20', 'chonnh@gmail.com', NULL, NULL),
(19, 3, 'en_US', 'Clothes', 'no_image.jpg', 1, 9999, '2015-06-24 17:36:02', 'chonnh@gmail.com', NULL, NULL),
(20, 3, 'vi_VN', 'Quần áo', 'no_image.jpg', 1, 9999, '2015-06-24 17:36:02', 'chonnh@gmail.com', NULL, NULL),
(27, 1, 'en_US', 'Accessories', 'no_image.jpg', 0, 9999, '2015-08-15 04:28:46', 'yhannart@gmail.com', NULL, NULL),
(28, 1, 'vi_VN', 'Phụ Kiện', 'no_image.jpg', 0, 9999, '2015-08-15 04:28:46', 'yhannart@gmail.com', NULL, NULL),
(29, 5, 'en_US', 'Sleep lamp', 'no_image.jpg', 1, 9999, '2015-07-02 15:35:44', 'yhannart@gmail.com', NULL, NULL),
(30, 5, 'vi_VN', 'Đèn ngủ', 'no_image.jpg', 1, 9999, '2015-07-02 15:35:44', 'yhannart@gmail.com', NULL, NULL),
(31, 6, 'en_US', 'Candies', '1439584539111.jpg', 1, 9999, '2015-08-15 03:35:48', 'yhannart@gmail.com', NULL, NULL),
(32, 6, 'vi_VN', 'Sô-cô-la', '1439584539112.jpg', 1, 9999, '2015-08-15 03:35:48', 'yhannart@gmail.com', NULL, NULL),
(33, 13, 'en_US', 'Flower', '1442201903059.jpg', 1, 1, '2015-09-14 10:38:23', 'yhannart@gmail.com', NULL, NULL),
(34, 13, 'vi_VN', 'Hoa tươi', '1442201903060.jpg', 1, 1, '2015-09-14 10:38:23', 'yhannart@gmail.com', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lixi_exchange_rates`
--

CREATE TABLE IF NOT EXISTS `lixi_exchange_rates` (
  `id` bigint(20) NOT NULL,
  `date_input` date NOT NULL,
  `time_input` time NOT NULL,
  `currency` varchar(10) NOT NULL,
  `buy` double NOT NULL,
  `buy_percentage` double NOT NULL,
  `sell` double NOT NULL,
  `sell_percentage` double NOT NULL,
  `created_by` varchar(255) NOT NULL,
  `created_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lixi_exchange_rates`
--

INSERT INTO `lixi_exchange_rates` (`id`, `date_input`, `time_input`, `currency`, `buy`, `buy_percentage`, `sell`, `sell_percentage`, `created_by`, `created_date`) VALUES
(1, '2015-06-17', '16:07:20', 'USD', 20691, -5, 20748, -5, 'chonnh@gmail.com', '2015-06-17 16:07:20'),
(2, '2015-06-17', '16:10:22', 'USD', 20691, -5, 20748, -5, 'chonnh@gmail.com', '2015-06-17 16:10:23'),
(3, '2015-06-17', '16:17:18', 'USD', 20691, -5, 20748, -5, 'chonnh@gmail.com', '2015-06-17 16:17:18'),
(4, '2015-06-17', '16:51:28', 'USD', 20686.25, -5, 20743.25, -5, 'yhannart@gmail.com', '2015-06-17 16:51:28'),
(5, '2015-06-17', '20:54:59', 'USD', 20000, -8.15, 20000, -8.4, 'chonnh@gmail.com', '2015-06-17 20:54:59'),
(6, '2015-06-17', '20:55:31', 'USD', 20000, -8.15, 20000, -8.4, 'chonnh@gmail.com', '2015-06-17 20:55:31'),
(7, '2015-06-18', '15:54:05', 'USD', 20686.25, -5, 22926.75, 5, 'chonnh@gmail.com', '2015-06-18 15:54:05'),
(8, '2015-06-18', '15:54:05', 'USD', 20686.25, -5, 22926.75, 5, 'chonnh@gmail.com', '2015-06-18 15:54:21'),
(9, '2015-06-18', '15:57:44', 'USD', 20686.25, -5, 23000, 5.34, 'chonnh@gmail.com', '2015-06-18 15:57:45'),
(10, '2015-06-18', '15:57:52', 'USD', 20686.25, -5, 23000, 5.34, 'chonnh@gmail.com', '2015-06-18 15:57:52'),
(11, '2015-08-12', '15:00:40', 'USD', 20000, -9.09, 23000, 4.21, 'yhannart@gmail.com', '2015-08-12 15:00:41'),
(12, '2015-08-13', '03:24:43', 'USD', 20890.5, -5, 23163, 5, 'yhannart@gmail.com', '2015-08-13 03:24:44'),
(13, '2015-08-13', '03:24:56', 'USD', 20000, -9.05, 23000, 4.26, 'yhannart@gmail.com', '2015-08-13 03:24:56'),
(14, '2015-08-20', '22:23:45', 'USD', 20500, -8.24, 23500, 4.82, 'yhannart@gmail.com', '2015-08-20 22:23:46');

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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lixi_orders`
--

INSERT INTO `lixi_orders` (`id`, `sender`, `lx_exchange_rate_id`, `card_id`, `bank_account_id`, `lixi_status`, `lixi_message`, `setting`, `modified_date`) VALUES
(25, 6, 14, 2, NULL, -2, NULL, 1, '2015-09-19 10:06:54');

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
  `product_price` decimal(10,0) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_image` varchar(255) DEFAULT NULL,
  `product_quantity` int(11) NOT NULL DEFAULT '1',
  `bk_status` int(11) DEFAULT NULL,
  `bk_message` varchar(255) DEFAULT NULL,
  `bk_receive_method` varchar(255) DEFAULT NULL,
  `bk_updated` datetime DEFAULT NULL,
  `modified_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lixi_order_gifts`
--

INSERT INTO `lixi_order_gifts` (`id`, `recipient`, `order_id`, `category`, `product_id`, `product_price`, `product_name`, `product_image`, `product_quantity`, `bk_status`, `bk_message`, `bk_receive_method`, `bk_updated`, `modified_date`) VALUES
(1, 5, 25, 33, 232, 800000, 'Hoa trang trí Lay Ơn FF01', 'http://p.vatgia.vn/pictures_fullsize/pem1437108737.jpg', 2, -1, NULL, NULL, NULL, '2015-09-22 09:50:51'),
(2, 6, 25, 19, 26, 550000, 'Dress set', 'http://p.vatgia.vn/ir/pictures_fullsize/7/cW1oMTQwODU0NDc0Mi5qcGc-/set-bo-vay-zara-sang-trong-dv380.jpg', 1, -1, NULL, NULL, NULL, '2015-09-23 01:22:41');

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `recipients`
--

INSERT INTO `recipients` (`id`, `sender`, `first_name`, `middle_name`, `last_name`, `email`, `dial_code`, `phone`, `note`, `modified_date`) VALUES
(2, 6, 'Teo 1', '', 'Nguyen', 'nguyenvanteo1@gmail.com', '+84', '96700786911', 'Happy Birthday', '2015-09-17 02:30:25'),
(5, 6, 'Chiến', 'Van', 'Chau', 'chauvanchien1@gmail.com', '+84', '169262318834567890', 'Chiến', '2015-09-22 10:09:08'),
(6, 6, 'Thong', 'Van', 'Chau', 'chauvanthong1@gmail.com', '+84', '9670078693456789', 'xin chào việt nam', '2015-09-23 01:22:22'),
(9, 11, 'Chơn', '', 'Nguyen', 'chonnh@gmail.com', '+84', '967007869', 'Happy Birthday', '2015-09-04 02:00:27'),
(10, 6, 'Dam', 'Thi', 'Dao', 'daothidam88@gmail.com', '+84', '1692623188', 'Happy Birthday', '2015-09-17 08:45:48');

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
  `modified_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `top_up_mobile_phone`
--

INSERT INTO `top_up_mobile_phone` (`id`, `order_id`, `recipient`, `amount`, `currency`, `phone`, `modified_date`) VALUES
(9, 25, 6, 10, 'USD', '9670078693456789', '2015-09-19 10:06:54'),
(10, 25, 6, 10, 'USD', '9670078693456789', '2015-09-20 04:21:45'),
(11, 25, 5, 10, 'USD', '169262318834567890', '2015-09-22 09:50:46'),
(12, 25, 5, 10, 'USD', '169262318834567890', '2015-09-22 09:51:01');

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
  `activated` tinyint(1) NOT NULL,
  `created_date` datetime NOT NULL,
  `created_by` varchar(255) NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `modified_by` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `middle_name`, `last_name`, `email`, `password`, `phone`, `account_non_expired`, `account_non_locked`, `credentials_non_expired`, `enabled`, `activated`, `created_date`, `created_by`, `modified_date`, `modified_by`) VALUES
(6, 'Huu', 'Nguyen', 'Chon', 'chonnh@gmail.com', '$2a$10$v/i2prMjgZ4CQhDyjDCls.ibbHzBf87/LQNhXnmp.iURfNevVtMD2', '0909123456', 1, 1, 1, 1, 1, '2015-04-15 04:24:23', 'chonnh@gmail.com', NULL, NULL),
(7, 'Thong', 'Van', 'Chau', 'chonnh@lacnghiep.com', '$2a$10$HSScUdjxegpDmqMThFJp6.FzZ5MoZgaMDa69ii2UFXpf1cxmP7zF6', '0901234567', 1, 1, 1, 1, 1, '2015-08-21 21:09:13', 'chonnh@lacnghiep.com', NULL, NULL),
(8, 'Tien', 'Trong', 'To', 'totrongtien@gmail.com', '$2a$10$U/aaXISWeJAuu/qvWp0zMu.UaiJEmVbvEhA2EnCZxkVS28bC72VSy', '0901234567', 1, 1, 1, 1, 0, '2015-08-28 00:07:30', 'totrongtien@gmail.com', NULL, NULL),
(9, 'CHon', 'Huu', 'Nguyen', 'nguyenhuuchon@gmail.com', '$2a$10$QOYaq7iErTKpuQ6EMwjjT.gs9aLJ9.iHFaZtBeKb1WV2tGivmkCBa', '', 1, 1, 1, 1, 0, '2015-08-28 00:58:05', 'nguyenhuuchon@gmail.com', NULL, NULL),
(11, 'Dao', '', 'Dam', 'daothidam88@gmail.com', '$2a$10$ZH8hZ5LmuxCw8JxFyI5v9.JiMrsQs2.T66a1riqGl8BQgC96ZkGxi', '01692623188', 1, 1, 1, 1, 1, '2015-09-04 00:11:36', 'daothidam88@gmail.com', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_bank_accounts`
--

INSERT INTO `user_bank_accounts` (`id`, `user_id`, `name`, `bank_rounting`, `checking_account`, `driver_license`, `state`, `bill_address`, `modified_date`) VALUES
(6, 6, 'yhannart', '32432432423', '435435435345345345345', '435435435345345345345', 'Binh Dinh', 32, '2015-09-11 04:42:33');

-- --------------------------------------------------------

--
-- Table structure for table `user_cards`
--

CREATE TABLE IF NOT EXISTS `user_cards` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `card_type` int(11) NOT NULL,
  `card_name` varchar(255) NOT NULL,
  `card_number` varchar(255) NOT NULL,
  `exp_month` int(11) NOT NULL,
  `exp_year` int(11) NOT NULL,
  `card_cvv` int(11) NOT NULL,
  `bill_address` bigint(20) DEFAULT NULL,
  `modified_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_cards`
--

INSERT INTO `user_cards` (`id`, `user_id`, `card_type`, `card_name`, `card_number`, `exp_month`, `exp_year`, `card_cvv`, `bill_address`, `modified_date`) VALUES
(1, 6, 1, 'NGUYEN HUU CHON', '11111111122333678', 9, 2015, 123, 32, '2015-09-12 02:54:22'),
(2, 6, 1, 'NGUYEN HUU CHON', '1111111112233367800000', 9, 2015, 123, 32, '2015-09-12 02:59:13');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_money_level`
--

INSERT INTO `user_money_level` (`id`, `user_id`, `money_level`, `modified_date`, `modified_by`) VALUES
(1, 6, 1, '2015-08-19 04:15:31', 'chonnh@gmail.com'),
(2, 7, 1, '2015-08-21 21:09:13', 'SYSTEM_AUTO'),
(3, 8, 1, '2015-08-28 00:07:30', 'SYSTEM_AUTO'),
(4, 9, 1, '2015-08-28 00:58:05', 'SYSTEM_AUTO'),
(6, 11, 1, '2015-09-04 00:11:36', 'SYSTEM_AUTO');

-- --------------------------------------------------------

--
-- Table structure for table `user_secret_code`
--

CREATE TABLE IF NOT EXISTS `user_secret_code` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_date` datetime NOT NULL,
  `expired_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_secret_code`
--

INSERT INTO `user_secret_code` (`id`, `user_id`, `code`, `created_date`, `expired_date`) VALUES
(1, 8, 'd87477dc-fbbd-4e63-b542-716696821e12', '2015-08-28 00:07:30', '2015-08-29 00:07:30'),
(2, 9, '2b38a6f5-72cc-4ec5-bcd4-81a05dd55b67', '2015-08-28 00:58:05', '2015-08-29 00:58:05');

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
(2, 'Baby Stuffs', 1, 9999),
(3, 'Clothes', 1, 9999),
(5, 'Sleep lamp', 1, 9999),
(6, 'Chocolate', 1, 9999),
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
) ENGINE=InnoDB AUTO_INCREMENT=258 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vatgia_products`
--

INSERT INTO `vatgia_products` (`id`, `category_id`, `category_name`, `name`, `price`, `image_url`, `link_detail`, `alive`, `modified_date`) VALUES
(1, 1, 'Accessories', 'Mini fan', 75000, 'http://p.vatgia.vn/pictures_fullsize/dia1334650616.jpg', 'http://vatgia.com/shoptuancua&module=product&view=detail&record_id=2087683', 1, '2015-09-18 05:06:41'),
(2, 1, 'Accessories', 'Laptop table ', 280000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dXV6MTM0MDI2Mjk4Mi5qcGc-/ban-de-laptop-da-nang-m-lucky.jpg', 'http://vatgia.com/shoptuancua&module=product&view=detail&record_id=2260052', 1, '2015-09-18 05:06:41'),
(3, 1, 'Accessories', 'Laptop fan', 518000, 'http://p.vatgia.vn/pictures_fullsize/xzz1340185187.jpg', 'http://vatgia.com/shoptuancua&module=product&view=detail&record_id=2257148', 1, '2015-09-18 05:06:41'),
(4, 1, 'Accessories', 'Bracelet', 160000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/c3ZpMTQyODg5MTc0Ni5qcGc-/vong-tay-meo-than-tai-3-meo.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4994218', 1, '2015-09-18 05:06:41'),
(5, 1, 'Accessories', 'Bracelet', 220000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Y29hMTQyODg5MTcwOS5qcGc-/vong-tay-meo-than-tai-5-meo.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4994214', 1, '2015-09-18 05:06:41'),
(6, 1, 'Accessories', 'Alarm ', 280000, 'http://p.vatgia.vn/pictures_fullsize/oxx1429067798.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=5000799', 1, '2015-09-18 05:06:41'),
(7, 1, 'Accessories', 'Alarm ', 280000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/b3h6MTQyODk3OTUwOS5qcGc-/dong-ho-dien-tu-bang-viet-huynh-quang-kitty.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4997490', 1, '2015-09-18 05:06:41'),
(8, 1, 'Accessories', 'Alarm ', 340000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Z3FiMTQyODk3OTMxNS5qcGc-/dong-ho-bao-thuc-go-chieng.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4997462', 1, '2015-09-18 05:06:41'),
(9, 1, 'Accessories', 'Alarm ', 400000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/YnlxMTQyODk3NTk2Mi5qcGc-/dong-ho-xe-dap-co-dien.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4997177', 1, '2015-09-18 05:06:41'),
(10, 1, 'Accessories', 'Clock', 350000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/cndlMTQyODk0ODkwMC5qcGc-/dong-ho-treo-tuong-moc-treo-hinh-hoa.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4997024', 1, '2015-09-18 05:06:41'),
(11, 2, 'Baby Stuffs', 'Piano for kid', 330000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dHdjMTM2NjYxNDE1Ni5qcGc-/dan-hoc-nhac-37-phim.jpg', 'http://vatgia.com/shoptuancua&module=product&view=detail&record_id=3041229', 1, '2015-09-18 05:06:43'),
(12, 2, 'Baby Stuffs', 'roller skates', 780000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/d3VhMTM2MTc4MjM3OS5qcGc-/giay-patin-flying-eagle-x2-xanh-den.jpg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=2501410', 1, '2015-09-18 05:06:43'),
(13, 2, 'Baby Stuffs', 'roller skates', 680000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGhyMTM0NzYxMDkyOS5qcGVn/giay-truot-patin-flying-eagle-x1.jpeg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=2501465', 1, '2015-09-18 05:06:43'),
(14, 2, 'Baby Stuffs', 'roller skates', 1100000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bnllMTQyNzk0NTgzNy5wbmc-/giay-truot-patin-seba-f5166-xanh.png', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=4964528', 1, '2015-09-18 05:06:43'),
(15, 2, 'Baby Stuffs', 'roller skates', 1160000, 'http://p.vatgia.vn/ir/user_product_fullsize/7/cG1tMTQyNjU3NTIyOC5KUEc-/giay-truot-patin-tre-em-ibord.jpg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=4747941', 1, '2015-09-18 05:06:43'),
(16, 2, 'Baby Stuffs', 'roller skates', 1680000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dHFvMTQyNzI2NzE3OC5wbmc-/giay-truot-patin-golden-2.png', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=4940146', 1, '2015-09-18 05:06:43'),
(17, 2, 'Baby Stuffs', 'roller skates', 1089000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/YmN1MTQyNzk0NTk0MS5qcGc-/giay-truot-patin-seba-f5166-vang.jpg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=4964535', 1, '2015-09-18 05:06:43'),
(18, 2, 'Baby Stuffs', 'roller skates', 1089000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/aWtxMTQyNzk0NjA4OS5qcGc-/giay-truot-patin-seba-f5166-den-trang.jpg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=4964553', 1, '2015-09-18 05:06:43'),
(19, 2, 'Baby Stuffs', 'Skate board', 850000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Z2pjMTM5MzgzMTk0OS5qcGc-/van-truot-penny-mklong-v1.jpg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=3859291', 1, '2015-09-18 05:06:43'),
(20, 2, 'Baby Stuffs', 'Skate board', 764400, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Z2pjMTM5MzgzMTk0OS5qcGc-/van-truot-penny-mklong-v1.jpg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=3844730', 1, '2015-09-18 05:06:43'),
(21, 2, 'Baby Stuffs', 'Skate board', 880000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Z2xrMTM4NDIyNjQxMi5qcGc-/van-truot-rap-san-1.jpg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=3569224', 1, '2015-09-18 05:06:43'),
(22, 2, 'Baby Stuffs', 'Skate board', 880000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/d3F0MTM4NDIyNjU5Ny5qcGc-/van-truot-rap-san-3.jpg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=3569233', 1, '2015-09-18 05:06:43'),
(23, 2, 'Baby Stuffs', 'Skate board', 680000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/emZkMTM5MzMxMjQ0NS5qcGc-/van-truot-fire-skateboard.jpg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=3844743', 1, '2015-09-18 05:06:43'),
(24, 2, 'Baby Stuffs', 'Skate board', 760000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/aHNlMTM4NDIyNjI1Ni5qcGc-/van-lac.jpg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=3569214', 1, '2015-09-18 05:06:43'),
(25, 2, 'Baby Stuffs', 'Skate board', 1250000, 'http://p.vatgia.vn/pictures_fullsize/fyu1402282628.jpg', 'http://vatgia.com/PatinHalo&module=product&view=detail&record_id=4139681', 1, '2015-09-18 05:06:43'),
(26, 3, 'Clothes', 'Dress set', 550000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/cW1oMTQwODU0NDc0Mi5qcGc-/set-bo-vay-zara-sang-trong-dv380.jpg', 'http://vatgia.com/thoitranglady&module=product&view=detail&record_id=4357758', 1, '2015-09-18 05:06:44'),
(27, 3, 'Clothes', 'Dress', 490000, 'http://g.vatgia.vn/gallery_img/9/iih1407229481.jpg', 'http://vatgia.com/thoitranglady&module=product&view=detail&record_id=4310794', 1, '2015-09-18 05:06:44'),
(28, 3, 'Clothes', 'dress', 340000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/eWltMTM5ODIzOTg2MC5qcGc-/dam-cong-so-dv331.jpg', 'http://vatgia.com/thoitranglady&module=product&view=detail&record_id=4011674', 1, '2015-09-18 05:06:44'),
(29, 3, 'Clothes', 'Maxi', 255000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/YWV5MTM2Nzk5ODc5My5qcGc-/dam-maxi-hai-day-dv195.jpg', 'http://vatgia.com/thoitranglady&module=product&view=detail&record_id=3075098', 1, '2015-09-18 05:06:44'),
(30, 3, 'Clothes', 'Maxi', 250000, 'http://p.vatgia.vn/pictures_fullsize/feu1366643972.jpg', 'http://vatgia.com/thoitranglady&module=product&view=detail&record_id=3042878', 1, '2015-09-18 05:06:44'),
(31, 3, 'Clothes', 'dress', 139000, '', 'http://vatgia.com/xbibishop&module=product&view=detail&record_id=4128631', 1, '2015-09-18 05:06:44'),
(32, 3, 'Clothes', 'dress', 129000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/cGJpMTM5OTUyNTYxOC5qcGc-/vay-suong-hoa-tiet-thuy-thu-xb-492.jpg', 'http://vatgia.com/xbibishop&module=product&view=detail&record_id=4046024', 1, '2015-09-18 05:06:44'),
(33, 3, 'Clothes', 'Man shirt', 250000, 'http://p.vatgia.vn/pictures_fullsize/csy1427008904.jpg', 'http://vatgia.com/xbibishop&module=product&view=detail&record_id=4931307', 1, '2015-09-18 05:06:44'),
(34, 3, 'Clothes', 'Man shirt', 250000, 'http://p.vatgia.vn/pictures_fullsize/egb1427012162.jpg', 'http://vatgia.com/xbibishop&module=product&view=detail&record_id=4931386', 1, '2015-09-18 05:06:44'),
(35, 3, 'Clothes', 'Man shirt', 250000, 'http://p.vatgia.vn/pictures_fullsize/gxq1427009792.jpg', 'http://vatgia.com/xbibishop&module=product&view=detail&record_id=4931371', 1, '2015-09-18 05:06:44'),
(36, 4, 'Flower box', 'Rose box', 423000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGxiMTQyNzk0NjQ0Ny5qcGc-/hoa-hong-bat-tu-hop-tim-9-bong-hong.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4964574', 1, '2015-09-14 02:29:24'),
(37, 4, 'Flower box', 'Gold rose', 780000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/emNuMTQyNzk0Njc1Ni5qcGc-/hoa-hong-ma-vang-19cm.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4964609', 1, '2015-09-14 02:29:24'),
(38, 4, 'Flower box', 'flower in shoes', 400000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/c2h3MTQyOTA4MTUzMS5wbmc-/hoa-hong-bat-tu-giay-thuy-tinh.png', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=5001686', 1, '2015-09-14 02:29:24'),
(39, 4, 'Flower box', 'flower', 740000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/cmdlMTQyODk4Mzk2NS5qcGc-/hoa-hong-bat-tu-cung-dan-tinh-yeu.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4997988', 1, '2015-09-14 02:29:24'),
(40, 4, 'Flower box', 'flower', 108000, 'http://p.vatgia.vn/pictures_fullsize/xrb1427946194.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4964556', 1, '2015-09-14 02:29:24'),
(41, 4, 'Flower box', 'flower', 225000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dnJ0MTQyNzk0NjY4NS5qcGc-/hoa-hong-bat-tu-binh-dieu-uoc.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4964597', 1, '2015-09-14 02:29:24'),
(42, 5, 'Sleep lamp', 'Sleep lamp', 120000, 'http://p.vatgia.vn/pictures_fullsize/pps1428996903.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4998814', 1, '2015-09-18 05:06:44'),
(43, 5, 'Sleep lamp', 'Sleep lamp', 170000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/cWpiMTQyODk5Njg2OS5qcGc-/den-ngu-phi-hanh-gia.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4998811', 1, '2015-09-18 05:06:44'),
(44, 5, 'Sleep lamp', 'Alarm lamp', 270000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/ZmdsMTQyODk5Njc3OS5qcGc-/den-ngu-bao-thuc-cho-snoopy.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4998796', 1, '2015-09-18 05:06:44'),
(45, 5, 'Sleep lamp', '3D lamp', 290000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bHJoMTQyODk5NjY5OC5qcGc-/den-ngu-3d-dan-tuong-hinh-cho-dom.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4998791', 1, '2015-09-18 05:06:44'),
(46, 5, 'Sleep lamp', 'Cat familylamp', 380000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/a3VnMTQyODk5Njg4NS5qcGc-/den-ngu-gia-dinh-meo-con.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4998812', 1, '2015-09-18 05:06:44'),
(47, 6, 'Chocolate\r\n', 'Chocolate', 90000, 'http://p.vatgia.vn/pictures_fullsize/wsr1428980714.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4997641', 1, '2015-09-18 05:06:45'),
(48, 6, 'Chocolate\r\n', 'Chocolate', 90000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/c2JrMTQyOTAzMDA4OC5qcGc-/socola-valentine-hop-1-vien-vtn-3.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=5000092', 1, '2015-09-18 05:06:45'),
(49, 6, 'Chocolate\r\n', 'Chocolate', 180000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/ZXV3MTQyODk4MDg1My5qcGc-/socola-valentine-hop-1-vien-vtn-5.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=4997658', 1, '2015-09-18 05:06:45'),
(50, 6, 'Chocolate\r\n', 'Chocolate', 180000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/ZW9yMTQyOTAzMDk4OC5qcGc-/socola-valentine-hop-1-vien-vtn-7.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=5000098', 1, '2015-09-18 05:06:45'),
(51, 6, 'Chocolate\r\n', 'Chocolate', 250000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dmtrMTQyOTAzMDg3OS5qcGc-/socola-valentine-hop-1-vien-vtn-8.jpg', 'http://vatgia.com/quatructuyen&module=product&view=detail&record_id=5000096', 1, '2015-09-18 05:06:45'),
(52, 13, 'Flower', 'Hoa Trang Trí FL01', 1670000, 'http://p.vatgia.vn/pictures_fullsize/mxt1439889791.jpg', 'http://www.vatgia.com/4765/5303048/hoa-trang-tr%C3%AD-fl01.html', 0, '2015-09-14 03:00:27'),
(53, 13, 'Flower', 'Hoa tình yêu Bình hoa hồng vĩnh cửu', 1650000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGJoMTQzOTcxNTc5NS5qcGc-/hoa-tinh-yeu-binh-hoa-hong-vinh-cuu.jpg', 'http://www.vatgia.com/2963/5298247/hoa-t%C3%ACnh-y%C3%AAu-b%C3%ACnh-hoa-h%E1%BB%93ng-v%C4%A9nh-c%E1%BB%ADu.html', 0, '2015-09-14 03:00:27'),
(54, 13, 'Flower', 'Hoa trang trí FF14', 1100000, 'http://p.vatgia.vn/pictures_fullsize/irr1439785783.jpg', 'http://www.vatgia.com/4765/5299147/hoa-trang-tr%C3%AD-ff14.html', 0, '2015-09-14 03:00:27'),
(55, 13, 'Flower', 'Lan Hồ Điệp - L0046', 2000000, 'http://p.vatgia.vn/pictures_fullsize/enk1427181623.jpg', 'http://www.vatgia.com/2967/4936770/lan-h%E1%BB%93-%C4%91i%E1%BB%87p-l0046.html', 0, '2015-09-14 03:00:27'),
(56, 13, 'Flower', 'Hoa trang trí Lay Ơn FF01', 800000, 'http://p.vatgia.vn/pictures_fullsize/pem1437108737.jpg', 'http://www.vatgia.com/4765/5296135/hoa-trang-tr%C3%AD-lay-%C6%A1n-ff01.html', 0, '2015-09-14 03:00:27'),
(57, 13, 'Flower', 'Hoa cưới SM02', 350000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/a3p6MTM5NDc5MTczOS5KUEc-/hoa-cuoi-sm02.jpg', 'http://www.vatgia.com/2968/3893776/hoa-c%C6%B0%E1%BB%9Bi-sm02.html', 0, '2015-09-14 03:00:27'),
(58, 13, 'Flower', 'Tuổi hồng trong sáng - MHSN016', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bG5rMTM4MzcwNjc3MC5qcGc-/tuoi-hong-trong-sang-mhsn016.jpg', 'http://www.vatgia.com/2966/3553430/tu%E1%BB%95i-h%E1%BB%93ng-trong-s%C3%A1ng-mhsn016.html', 0, '2015-09-14 03:00:27'),
(59, 13, 'Flower', 'Hoa tươi H0090', 300000, 'http://p.vatgia.vn/pictures_fullsize/hzk1427328500.jpg', 'http://www.vatgia.com/2966/4942365/hoa-t%C6%B0%C6%A1i-h0090.html', 0, '2015-09-14 03:00:27'),
(60, 13, 'Flower', 'Hoa tươi H0080', 700000, 'http://p.vatgia.vn/pictures_fullsize/hfs1427329028.jpg', 'http://www.vatgia.com/2966/4942375/hoa-t%C6%B0%C6%A1i-h0080.html', 0, '2015-09-14 03:00:27'),
(61, 13, 'Flower', 'Hoa tươi H0124', 350000, 'http://p.vatgia.vn/pictures_fullsize/bgw1427293582.jpg', 'http://www.vatgia.com/2966/4942000/hoa-t%C6%B0%C6%A1i-h0124.html', 0, '2015-09-14 03:00:27'),
(62, 13, 'Flower', 'Lan Hồ Điệp - L0028', 1500000, 'http://p.vatgia.vn/pictures_fullsize/pzd1427183727.jpg', 'http://www.vatgia.com/2967/4937024/lan-h%E1%BB%93-%C4%91i%E1%BB%87p-l0028.html', 0, '2015-09-14 03:00:27'),
(63, 13, 'Flower', 'Hoa trang trí - Xương Rồng FF01', 350000, 'http://p.vatgia.vn/pictures_fullsize/eyv1437109372.jpg', 'http://www.vatgia.com/4765/5296128/hoa-trang-tr%C3%AD-x%C6%B0%C6%A1ng-r%E1%BB%93ng-ff01.html', 0, '2015-09-14 03:00:27'),
(64, 13, 'Flower', 'Hoa trang trí hoa Phong Lan trắng', 700000, 'http://p.vatgia.vn/pictures_fullsize/lgh1438418182.jpg', 'http://www.vatgia.com/4765/5263774/hoa-trang-tr%C3%AD-hoa-phong-lan-tr%E1%BA%AFng.html', 0, '2015-09-14 03:00:27'),
(65, 13, 'Flower', 'Hoa Tình yêu hoàn hảo - MHTY037', 715000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGtnMTM4MzcxNzgwNy5qcGc-/hoa-tinh-yeu-trai-tim-hoan-hao-mhty037.jpg', 'http://www.vatgia.com/2963/3554426/hoa-t%C3%ACnh-y%C3%AAu-tr%C3%A1i-tim-ho%C3%A0n-h%E1%BA%A3o-mhty037.html', 0, '2015-09-14 03:00:27'),
(66, 13, 'Flower', 'Vẫn mãi yêu - MHTY055', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/d25hMTM4MzcxOTY2OS5qcGc-/van-mai-yeu-mhty055.jpg', 'http://www.vatgia.com/2963/3554522/v%E1%BA%ABn-m%C3%A3i-y%C3%AAu-mhty055.html', 0, '2015-09-14 03:00:27'),
(67, 13, 'Flower', 'Hoa hồng bất tử – Hộp tim 9 bông hồng', 470000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGxiMTQyNzk0NjQ0Ny5qcGc-/hoa-hong-bat-tu-hop-tim-9-bong-hong.jpg', 'http://www.vatgia.com/2963/4964574/hoa-h%E1%BB%93ng-b%E1%BA%A5t-t%E1%BB%AD-%E2%80%93-h%E1%BB%99p-tim-9-b%C3%B4ng-h%E1%BB%93ng.html', 0, '2015-09-14 03:00:27'),
(68, 13, 'Flower', 'Kỷ niệm xưa - MHSN024', 520000, 'http://p.vatgia.vn/pictures_fullsize/uzl1383707480.jpg', 'http://www.vatgia.com/2966/3553525/k%E1%BB%B7-ni%E1%BB%87m-x%C6%B0a-mhsn024.html', 0, '2015-09-14 03:00:27'),
(69, 13, 'Flower', 'Hoa tươi H0063', 300000, 'http://p.vatgia.vn/pictures_fullsize/kdn1427332108.jpg', 'http://www.vatgia.com/2966/4942409/hoa-t%C6%B0%C6%A1i-h0063.html', 0, '2015-09-14 03:00:27'),
(70, 13, 'Flower', 'Hoa tươi - H0164', 300000, 'http://p.vatgia.vn/pictures_fullsize/iqq1427187776.jpg', 'http://www.vatgia.com/2966/4942436/hoa-t%C6%B0%C6%A1i-h0067.html', 0, '2015-09-14 03:00:27'),
(71, 13, 'Flower', 'Hoa tươi H0067', 250000, 'http://p.vatgia.vn/pictures_fullsize/jdm1427333201.jpg', 'http://www.vatgia.com/2966/4937495/hoa-t%C6%B0%C6%A1i-h0164.html', 0, '2015-09-14 03:00:27'),
(72, 13, 'Flower', 'Hoa tình yêu bó 20 bông hoa hồng xanh tươi 5 năm', 2000000, 'http://p.vatgia.vn/ir/gallery_img/4/7/cG1xMTQzOTY1MjQ2Ni5qcGc-/hoa-tinh-yeu-bo-20-bong-hoa-hong-xanh-tuoi-5-nam-anh-2.jpg', 'http://www.vatgia.com/2963/5297685/hoa-t%C3%ACnh-y%C3%AAu-b%C3%B3-20-b%C3%B4ng-hoa-h%E1%BB%93ng-xanh-t%C6%B0%C6%A1i-5-n%C4%83m.html', 0, '2015-09-14 03:00:27'),
(73, 13, 'Flower', 'Hoa trang trí FF03', 530000, 'http://p.vatgia.vn/pictures_fullsize/mim1439786429.jpg', 'http://www.vatgia.com/4765/5299183/hoa-trang-tr%C3%AD-ff03.html', 0, '2015-09-14 03:00:27'),
(74, 13, 'Flower', 'Đón nắng mùa xuân - MBCM004', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bHZrMTM4MzY1Mzk4OS5qcGc-/don-nang-mua-xuan-mbcm004.jpg', 'http://www.vatgia.com/2967/3552534/%C4%91%C3%B3n-n%E1%BA%AFng-m%C3%B9a-xu%C3%A2n-mbcm004.html', 0, '2015-09-14 03:00:27'),
(75, 13, 'Flower', 'Hoa trang trí nghệ thuật Phong Lan tím FF02', 320000, 'http://p.vatgia.vn/pictures_fullsize/ndx1437031996.jpg', 'http://www.vatgia.com/4765/5296088/hoa-trang-tr%C3%AD-ngh%E1%BB%87-thu%E1%BA%ADt-phong-lan-t%C3%ADm-ff02.html', 0, '2015-09-14 03:00:27'),
(76, 13, 'Flower', 'Ngày xanh tươi - MBCM019', 520000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Ym9xMTM4MzY1MjQ0OC5qcGc-/ngay-xanh-tuoi-mbcm019.jpg', 'http://www.vatgia.com/2967/3552514/ng%C3%A0y-xanh-t%C6%B0%C6%A1i-mbcm019.html', 0, '2015-09-14 03:00:27'),
(77, 13, 'Flower', 'Hoa hồng bất tử – Hộp trụ', 250000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dmh1MTQyNzk0NzkwOS5qcGc-/hoa-hong-bat-tu-hop-tru.jpg', 'http://www.vatgia.com/2963/4964727/hoa-h%E1%BB%93ng-b%E1%BA%A5t-t%E1%BB%AD-%E2%80%93-h%E1%BB%99p-tr%E1%BB%A5.html', 0, '2015-09-14 03:00:27'),
(78, 13, 'Flower', 'Hoa tươi - H0166', 400000, 'http://p.vatgia.vn/pictures_fullsize/xts1427187941.jpg', 'http://www.vatgia.com/2966/4937514/hoa-t%C6%B0%C6%A1i-h0166.html', 0, '2015-09-14 03:00:27'),
(79, 13, 'Flower', 'Hoa tươi - H0148', 400000, 'http://p.vatgia.vn/pictures_fullsize/iyl1427189109.jpg', 'http://www.vatgia.com/2966/4937655/hoa-t%C6%B0%C6%A1i-h0148.html', 0, '2015-09-14 03:00:27'),
(80, 13, 'Flower', 'Hoa tươi H0067', 250000, 'http://p.vatgia.vn/pictures_fullsize/jdm1427333201.jpg', 'http://www.vatgia.com/2966/4942436/hoa-t%C6%B0%C6%A1i-h0067.html', 0, '2015-09-14 03:00:27'),
(81, 13, 'Flower', 'Hoa tươi - H0179', 800000, 'http://p.vatgia.vn/pictures_fullsize/jhe1427187451.jpg', 'http://www.vatgia.com/2966/4937447/hoa-t%C6%B0%C6%A1i-h0179.html', 0, '2015-09-14 03:00:27'),
(82, 13, 'Flower', 'Hoa Trang Trí FL01', 1670000, 'http://p.vatgia.vn/pictures_fullsize/mxt1439889791.jpg', 'http://www.vatgia.com/4765/5303048/hoa-trang-tr%C3%AD-fl01.html', 0, '2015-09-14 05:03:34'),
(83, 13, 'Flower', 'Hoa tình yêu Bình hoa hồng vĩnh cửu', 1650000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGJoMTQzOTcxNTc5NS5qcGc-/hoa-tinh-yeu-binh-hoa-hong-vinh-cuu.jpg', 'http://www.vatgia.com/2963/5298247/hoa-t%C3%ACnh-y%C3%AAu-b%C3%ACnh-hoa-h%E1%BB%93ng-v%C4%A9nh-c%E1%BB%ADu.html', 0, '2015-09-14 05:03:34'),
(84, 13, 'Flower', 'Hoa trang trí FF14', 1100000, 'http://p.vatgia.vn/pictures_fullsize/irr1439785783.jpg', 'http://www.vatgia.com/4765/5299147/hoa-trang-tr%C3%AD-ff14.html', 0, '2015-09-14 05:03:34'),
(85, 13, 'Flower', 'Lan Hồ Điệp - L0046', 2000000, 'http://p.vatgia.vn/pictures_fullsize/enk1427181623.jpg', 'http://www.vatgia.com/2967/4936770/lan-h%E1%BB%93-%C4%91i%E1%BB%87p-l0046.html', 0, '2015-09-14 05:03:34'),
(86, 13, 'Flower', 'Hoa trang trí Lay Ơn FF01', 800000, 'http://p.vatgia.vn/pictures_fullsize/pem1437108737.jpg', 'http://www.vatgia.com/4765/5296135/hoa-trang-tr%C3%AD-lay-%C6%A1n-ff01.html', 0, '2015-09-14 05:03:34'),
(87, 13, 'Flower', 'Hoa cưới SM02', 350000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/a3p6MTM5NDc5MTczOS5KUEc-/hoa-cuoi-sm02.jpg', 'http://www.vatgia.com/2968/3893776/hoa-c%C6%B0%E1%BB%9Bi-sm02.html', 0, '2015-09-14 05:03:34'),
(88, 13, 'Flower', 'Tuổi hồng trong sáng - MHSN016', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bG5rMTM4MzcwNjc3MC5qcGc-/tuoi-hong-trong-sang-mhsn016.jpg', 'http://www.vatgia.com/2966/3553430/tu%E1%BB%95i-h%E1%BB%93ng-trong-s%C3%A1ng-mhsn016.html', 0, '2015-09-14 05:03:34'),
(89, 13, 'Flower', 'Hoa tươi H0090', 300000, 'http://p.vatgia.vn/pictures_fullsize/hzk1427328500.jpg', 'http://www.vatgia.com/2966/4942365/hoa-t%C6%B0%C6%A1i-h0090.html', 0, '2015-09-14 05:03:34'),
(90, 13, 'Flower', 'Hoa tươi H0080', 700000, 'http://p.vatgia.vn/pictures_fullsize/hfs1427329028.jpg', 'http://www.vatgia.com/2966/4942375/hoa-t%C6%B0%C6%A1i-h0080.html', 0, '2015-09-14 05:03:34'),
(91, 13, 'Flower', 'Hoa tươi H0124', 350000, 'http://p.vatgia.vn/pictures_fullsize/bgw1427293582.jpg', 'http://www.vatgia.com/2966/4942000/hoa-t%C6%B0%C6%A1i-h0124.html', 0, '2015-09-14 05:03:34'),
(92, 13, 'Flower', 'Lan Hồ Điệp - L0028', 1500000, 'http://p.vatgia.vn/pictures_fullsize/pzd1427183727.jpg', 'http://www.vatgia.com/2967/4937024/lan-h%E1%BB%93-%C4%91i%E1%BB%87p-l0028.html', 0, '2015-09-14 05:03:34'),
(93, 13, 'Flower', 'Hoa trang trí - Xương Rồng FF01', 350000, 'http://p.vatgia.vn/pictures_fullsize/eyv1437109372.jpg', 'http://www.vatgia.com/4765/5296128/hoa-trang-tr%C3%AD-x%C6%B0%C6%A1ng-r%E1%BB%93ng-ff01.html', 0, '2015-09-14 05:03:34'),
(94, 13, 'Flower', 'Hoa trang trí hoa Phong Lan trắng', 700000, 'http://p.vatgia.vn/pictures_fullsize/lgh1438418182.jpg', 'http://www.vatgia.com/4765/5263774/hoa-trang-tr%C3%AD-hoa-phong-lan-tr%E1%BA%AFng.html', 0, '2015-09-14 05:03:34'),
(95, 13, 'Flower', 'Hoa Tình yêu hoàn hảo - MHTY037', 715000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGtnMTM4MzcxNzgwNy5qcGc-/hoa-tinh-yeu-trai-tim-hoan-hao-mhty037.jpg', 'http://www.vatgia.com/2963/3554426/hoa-t%C3%ACnh-y%C3%AAu-tr%C3%A1i-tim-ho%C3%A0n-h%E1%BA%A3o-mhty037.html', 0, '2015-09-14 05:03:34'),
(96, 13, 'Flower', 'Vẫn mãi yêu - MHTY055', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/d25hMTM4MzcxOTY2OS5qcGc-/van-mai-yeu-mhty055.jpg', 'http://www.vatgia.com/2963/3554522/v%E1%BA%ABn-m%C3%A3i-y%C3%AAu-mhty055.html', 0, '2015-09-14 05:03:34'),
(97, 13, 'Flower', 'Hoa hồng bất tử – Hộp tim 9 bông hồng', 470000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGxiMTQyNzk0NjQ0Ny5qcGc-/hoa-hong-bat-tu-hop-tim-9-bong-hong.jpg', 'http://www.vatgia.com/2963/4964574/hoa-h%E1%BB%93ng-b%E1%BA%A5t-t%E1%BB%AD-%E2%80%93-h%E1%BB%99p-tim-9-b%C3%B4ng-h%E1%BB%93ng.html', 0, '2015-09-14 05:03:34'),
(98, 13, 'Flower', 'Kỷ niệm xưa - MHSN024', 520000, 'http://p.vatgia.vn/pictures_fullsize/uzl1383707480.jpg', 'http://www.vatgia.com/2966/3553525/k%E1%BB%B7-ni%E1%BB%87m-x%C6%B0a-mhsn024.html', 0, '2015-09-14 05:03:34'),
(99, 13, 'Flower', 'Hoa tươi H0063', 300000, 'http://p.vatgia.vn/pictures_fullsize/kdn1427332108.jpg', 'http://www.vatgia.com/2966/4942409/hoa-t%C6%B0%C6%A1i-h0063.html', 0, '2015-09-14 05:03:34'),
(100, 13, 'Flower', 'Hoa tươi - H0164', 300000, 'http://p.vatgia.vn/pictures_fullsize/iqq1427187776.jpg', 'http://www.vatgia.com/2966/4942436/hoa-t%C6%B0%C6%A1i-h0067.html', 0, '2015-09-14 05:03:34'),
(101, 13, 'Flower', 'Hoa tươi H0067', 250000, 'http://p.vatgia.vn/pictures_fullsize/jdm1427333201.jpg', 'http://www.vatgia.com/2966/4937495/hoa-t%C6%B0%C6%A1i-h0164.html', 0, '2015-09-14 05:03:34'),
(102, 13, 'Flower', 'Hoa tình yêu bó 20 bông hoa hồng xanh tươi 5 năm', 2000000, 'http://p.vatgia.vn/ir/gallery_img/4/7/cG1xMTQzOTY1MjQ2Ni5qcGc-/hoa-tinh-yeu-bo-20-bong-hoa-hong-xanh-tuoi-5-nam-anh-2.jpg', 'http://www.vatgia.com/2963/5297685/hoa-t%C3%ACnh-y%C3%AAu-b%C3%B3-20-b%C3%B4ng-hoa-h%E1%BB%93ng-xanh-t%C6%B0%C6%A1i-5-n%C4%83m.html', 0, '2015-09-14 05:03:34'),
(103, 13, 'Flower', 'Hoa trang trí FF03', 530000, 'http://p.vatgia.vn/pictures_fullsize/mim1439786429.jpg', 'http://www.vatgia.com/4765/5299183/hoa-trang-tr%C3%AD-ff03.html', 0, '2015-09-14 05:03:34'),
(104, 13, 'Flower', 'Đón nắng mùa xuân - MBCM004', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bHZrMTM4MzY1Mzk4OS5qcGc-/don-nang-mua-xuan-mbcm004.jpg', 'http://www.vatgia.com/2967/3552534/%C4%91%C3%B3n-n%E1%BA%AFng-m%C3%B9a-xu%C3%A2n-mbcm004.html', 0, '2015-09-14 05:03:34'),
(105, 13, 'Flower', 'Hoa trang trí nghệ thuật Phong Lan tím FF02', 320000, 'http://p.vatgia.vn/pictures_fullsize/ndx1437031996.jpg', 'http://www.vatgia.com/4765/5296088/hoa-trang-tr%C3%AD-ngh%E1%BB%87-thu%E1%BA%ADt-phong-lan-t%C3%ADm-ff02.html', 0, '2015-09-14 05:03:34'),
(106, 13, 'Flower', 'Ngày xanh tươi - MBCM019', 520000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Ym9xMTM4MzY1MjQ0OC5qcGc-/ngay-xanh-tuoi-mbcm019.jpg', 'http://www.vatgia.com/2967/3552514/ng%C3%A0y-xanh-t%C6%B0%C6%A1i-mbcm019.html', 0, '2015-09-14 05:03:34'),
(107, 13, 'Flower', 'Hoa hồng bất tử – Hộp trụ', 250000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dmh1MTQyNzk0NzkwOS5qcGc-/hoa-hong-bat-tu-hop-tru.jpg', 'http://www.vatgia.com/2963/4964727/hoa-h%E1%BB%93ng-b%E1%BA%A5t-t%E1%BB%AD-%E2%80%93-h%E1%BB%99p-tr%E1%BB%A5.html', 0, '2015-09-14 05:03:34'),
(108, 13, 'Flower', 'Hoa tươi - H0166', 400000, 'http://p.vatgia.vn/pictures_fullsize/xts1427187941.jpg', 'http://www.vatgia.com/2966/4937514/hoa-t%C6%B0%C6%A1i-h0166.html', 0, '2015-09-14 05:03:34'),
(109, 13, 'Flower', 'Hoa tươi - H0148', 400000, 'http://p.vatgia.vn/pictures_fullsize/iyl1427189109.jpg', 'http://www.vatgia.com/2966/4937655/hoa-t%C6%B0%C6%A1i-h0148.html', 0, '2015-09-14 05:03:34'),
(110, 13, 'Flower', 'Hoa tươi H0067', 250000, 'http://p.vatgia.vn/pictures_fullsize/jdm1427333201.jpg', 'http://www.vatgia.com/2966/4942436/hoa-t%C6%B0%C6%A1i-h0067.html', 0, '2015-09-14 05:03:34'),
(111, 13, 'Flower', 'Hoa tươi - H0179', 800000, 'http://p.vatgia.vn/pictures_fullsize/jhe1427187451.jpg', 'http://www.vatgia.com/2966/4937447/hoa-t%C6%B0%C6%A1i-h0179.html', 0, '2015-09-14 05:03:34'),
(112, 13, 'Flower', 'Hoa Trang Trí FL01', 1670000, 'http://p.vatgia.vn/pictures_fullsize/mxt1439889791.jpg', 'http://www.vatgia.com/4765/5303048/hoa-trang-tr%C3%AD-fl01.html', 0, '2015-09-14 06:01:38'),
(113, 13, 'Flower', 'Hoa tình yêu Bình hoa hồng vĩnh cửu', 1650000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGJoMTQzOTcxNTc5NS5qcGc-/hoa-tinh-yeu-binh-hoa-hong-vinh-cuu.jpg', 'http://www.vatgia.com/2963/5298247/hoa-t%C3%ACnh-y%C3%AAu-b%C3%ACnh-hoa-h%E1%BB%93ng-v%C4%A9nh-c%E1%BB%ADu.html', 0, '2015-09-14 06:01:38'),
(114, 13, 'Flower', 'Hoa trang trí FF14', 1100000, 'http://p.vatgia.vn/pictures_fullsize/irr1439785783.jpg', 'http://www.vatgia.com/4765/5299147/hoa-trang-tr%C3%AD-ff14.html', 0, '2015-09-14 06:01:38'),
(115, 13, 'Flower', 'Lan Hồ Điệp - L0046', 2000000, 'http://p.vatgia.vn/pictures_fullsize/enk1427181623.jpg', 'http://www.vatgia.com/2967/4936770/lan-h%E1%BB%93-%C4%91i%E1%BB%87p-l0046.html', 0, '2015-09-14 06:01:38'),
(116, 13, 'Flower', 'Hoa trang trí Lay Ơn FF01', 800000, 'http://p.vatgia.vn/pictures_fullsize/pem1437108737.jpg', 'http://www.vatgia.com/4765/5296135/hoa-trang-tr%C3%AD-lay-%C6%A1n-ff01.html', 0, '2015-09-14 06:01:38'),
(117, 13, 'Flower', 'Hoa cưới SM02', 350000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/a3p6MTM5NDc5MTczOS5KUEc-/hoa-cuoi-sm02.jpg', 'http://www.vatgia.com/2968/3893776/hoa-c%C6%B0%E1%BB%9Bi-sm02.html', 0, '2015-09-14 06:01:38'),
(118, 13, 'Flower', 'Tuổi hồng trong sáng - MHSN016', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bG5rMTM4MzcwNjc3MC5qcGc-/tuoi-hong-trong-sang-mhsn016.jpg', 'http://www.vatgia.com/2966/3553430/tu%E1%BB%95i-h%E1%BB%93ng-trong-s%C3%A1ng-mhsn016.html', 0, '2015-09-14 06:01:38'),
(119, 13, 'Flower', 'Hoa tươi H0090', 300000, 'http://p.vatgia.vn/pictures_fullsize/hzk1427328500.jpg', 'http://www.vatgia.com/2966/4942365/hoa-t%C6%B0%C6%A1i-h0090.html', 0, '2015-09-14 06:01:38'),
(120, 13, 'Flower', 'Hoa tươi H0080', 700000, 'http://p.vatgia.vn/pictures_fullsize/hfs1427329028.jpg', 'http://www.vatgia.com/2966/4942375/hoa-t%C6%B0%C6%A1i-h0080.html', 0, '2015-09-14 06:01:38'),
(121, 13, 'Flower', 'Hoa tươi H0124', 350000, 'http://p.vatgia.vn/pictures_fullsize/bgw1427293582.jpg', 'http://www.vatgia.com/2966/4942000/hoa-t%C6%B0%C6%A1i-h0124.html', 0, '2015-09-14 06:01:38'),
(122, 13, 'Flower', 'Lan Hồ Điệp - L0028', 1500000, 'http://p.vatgia.vn/pictures_fullsize/pzd1427183727.jpg', 'http://www.vatgia.com/2967/4937024/lan-h%E1%BB%93-%C4%91i%E1%BB%87p-l0028.html', 0, '2015-09-14 06:01:38'),
(123, 13, 'Flower', 'Hoa trang trí - Xương Rồng FF01', 350000, 'http://p.vatgia.vn/pictures_fullsize/eyv1437109372.jpg', 'http://www.vatgia.com/4765/5296128/hoa-trang-tr%C3%AD-x%C6%B0%C6%A1ng-r%E1%BB%93ng-ff01.html', 0, '2015-09-14 06:01:38'),
(124, 13, 'Flower', 'Hoa trang trí hoa Phong Lan trắng', 700000, 'http://p.vatgia.vn/pictures_fullsize/lgh1438418182.jpg', 'http://www.vatgia.com/4765/5263774/hoa-trang-tr%C3%AD-hoa-phong-lan-tr%E1%BA%AFng.html', 0, '2015-09-14 06:01:38'),
(125, 13, 'Flower', 'Hoa Tình yêu hoàn hảo - MHTY037', 715000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGtnMTM4MzcxNzgwNy5qcGc-/hoa-tinh-yeu-trai-tim-hoan-hao-mhty037.jpg', 'http://www.vatgia.com/2963/3554426/hoa-t%C3%ACnh-y%C3%AAu-tr%C3%A1i-tim-ho%C3%A0n-h%E1%BA%A3o-mhty037.html', 0, '2015-09-14 06:01:38'),
(126, 13, 'Flower', 'Vẫn mãi yêu - MHTY055', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/d25hMTM4MzcxOTY2OS5qcGc-/van-mai-yeu-mhty055.jpg', 'http://www.vatgia.com/2963/3554522/v%E1%BA%ABn-m%C3%A3i-y%C3%AAu-mhty055.html', 0, '2015-09-14 06:01:38'),
(127, 13, 'Flower', 'Hoa hồng bất tử – Hộp tim 9 bông hồng', 470000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGxiMTQyNzk0NjQ0Ny5qcGc-/hoa-hong-bat-tu-hop-tim-9-bong-hong.jpg', 'http://www.vatgia.com/2963/4964574/hoa-h%E1%BB%93ng-b%E1%BA%A5t-t%E1%BB%AD-%E2%80%93-h%E1%BB%99p-tim-9-b%C3%B4ng-h%E1%BB%93ng.html', 0, '2015-09-14 06:01:38'),
(128, 13, 'Flower', 'Kỷ niệm xưa - MHSN024', 520000, 'http://p.vatgia.vn/pictures_fullsize/uzl1383707480.jpg', 'http://www.vatgia.com/2966/3553525/k%E1%BB%B7-ni%E1%BB%87m-x%C6%B0a-mhsn024.html', 0, '2015-09-14 06:01:38'),
(129, 13, 'Flower', 'Hoa tươi H0063', 300000, 'http://p.vatgia.vn/pictures_fullsize/kdn1427332108.jpg', 'http://www.vatgia.com/2966/4942409/hoa-t%C6%B0%C6%A1i-h0063.html', 0, '2015-09-14 06:01:38'),
(130, 13, 'Flower', 'Hoa tươi - H0164', 300000, 'http://p.vatgia.vn/pictures_fullsize/iqq1427187776.jpg', 'http://www.vatgia.com/2966/4942436/hoa-t%C6%B0%C6%A1i-h0067.html', 0, '2015-09-14 06:01:38'),
(131, 13, 'Flower', 'Hoa tươi H0067', 250000, 'http://p.vatgia.vn/pictures_fullsize/jdm1427333201.jpg', 'http://www.vatgia.com/2966/4937495/hoa-t%C6%B0%C6%A1i-h0164.html', 0, '2015-09-14 06:01:38'),
(132, 13, 'Flower', 'Hoa tình yêu bó 20 bông hoa hồng xanh tươi 5 năm', 2000000, 'http://p.vatgia.vn/ir/gallery_img/4/7/cG1xMTQzOTY1MjQ2Ni5qcGc-/hoa-tinh-yeu-bo-20-bong-hoa-hong-xanh-tuoi-5-nam-anh-2.jpg', 'http://www.vatgia.com/2963/5297685/hoa-t%C3%ACnh-y%C3%AAu-b%C3%B3-20-b%C3%B4ng-hoa-h%E1%BB%93ng-xanh-t%C6%B0%C6%A1i-5-n%C4%83m.html', 0, '2015-09-14 06:01:38'),
(133, 13, 'Flower', 'Hoa trang trí FF03', 530000, 'http://p.vatgia.vn/pictures_fullsize/mim1439786429.jpg', 'http://www.vatgia.com/4765/5299183/hoa-trang-tr%C3%AD-ff03.html', 0, '2015-09-14 06:01:38'),
(134, 13, 'Flower', 'Đón nắng mùa xuân - MBCM004', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bHZrMTM4MzY1Mzk4OS5qcGc-/don-nang-mua-xuan-mbcm004.jpg', 'http://www.vatgia.com/2967/3552534/%C4%91%C3%B3n-n%E1%BA%AFng-m%C3%B9a-xu%C3%A2n-mbcm004.html', 0, '2015-09-14 06:01:38'),
(135, 13, 'Flower', 'Hoa trang trí nghệ thuật Phong Lan tím FF02', 320000, 'http://p.vatgia.vn/pictures_fullsize/ndx1437031996.jpg', 'http://www.vatgia.com/4765/5296088/hoa-trang-tr%C3%AD-ngh%E1%BB%87-thu%E1%BA%ADt-phong-lan-t%C3%ADm-ff02.html', 0, '2015-09-14 06:01:38'),
(136, 13, 'Flower', 'Ngày xanh tươi - MBCM019', 520000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Ym9xMTM4MzY1MjQ0OC5qcGc-/ngay-xanh-tuoi-mbcm019.jpg', 'http://www.vatgia.com/2967/3552514/ng%C3%A0y-xanh-t%C6%B0%C6%A1i-mbcm019.html', 0, '2015-09-14 06:01:38'),
(137, 13, 'Flower', 'Hoa hồng bất tử – Hộp trụ', 250000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dmh1MTQyNzk0NzkwOS5qcGc-/hoa-hong-bat-tu-hop-tru.jpg', 'http://www.vatgia.com/2963/4964727/hoa-h%E1%BB%93ng-b%E1%BA%A5t-t%E1%BB%AD-%E2%80%93-h%E1%BB%99p-tr%E1%BB%A5.html', 0, '2015-09-14 06:01:38'),
(138, 13, 'Flower', 'Hoa tươi - H0166', 400000, 'http://p.vatgia.vn/pictures_fullsize/xts1427187941.jpg', 'http://www.vatgia.com/2966/4937514/hoa-t%C6%B0%C6%A1i-h0166.html', 0, '2015-09-14 06:01:38'),
(139, 13, 'Flower', 'Hoa tươi - H0148', 400000, 'http://p.vatgia.vn/pictures_fullsize/iyl1427189109.jpg', 'http://www.vatgia.com/2966/4937655/hoa-t%C6%B0%C6%A1i-h0148.html', 0, '2015-09-14 06:01:38'),
(140, 13, 'Flower', 'Hoa tươi H0067', 250000, 'http://p.vatgia.vn/pictures_fullsize/jdm1427333201.jpg', 'http://www.vatgia.com/2966/4942436/hoa-t%C6%B0%C6%A1i-h0067.html', 0, '2015-09-14 06:01:38'),
(141, 13, 'Flower', 'Hoa tươi - H0179', 800000, 'http://p.vatgia.vn/pictures_fullsize/jhe1427187451.jpg', 'http://www.vatgia.com/2966/4937447/hoa-t%C6%B0%C6%A1i-h0179.html', 0, '2015-09-14 06:01:38'),
(142, 13, 'Flower', 'Hoa Trang Trí FL01', 1670000, 'http://p.vatgia.vn/pictures_fullsize/mxt1439889791.jpg', 'http://www.vatgia.com/4765/5303048/hoa-trang-tr%C3%AD-fl01.html', 0, '2015-09-14 07:02:03'),
(143, 13, 'Flower', 'Hoa tình yêu Bình hoa hồng vĩnh cửu', 1650000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGJoMTQzOTcxNTc5NS5qcGc-/hoa-tinh-yeu-binh-hoa-hong-vinh-cuu.jpg', 'http://www.vatgia.com/2963/5298247/hoa-t%C3%ACnh-y%C3%AAu-b%C3%ACnh-hoa-h%E1%BB%93ng-v%C4%A9nh-c%E1%BB%ADu.html', 0, '2015-09-14 07:02:03'),
(144, 13, 'Flower', 'Hoa trang trí FF14', 1100000, 'http://p.vatgia.vn/pictures_fullsize/irr1439785783.jpg', 'http://www.vatgia.com/4765/5299147/hoa-trang-tr%C3%AD-ff14.html', 0, '2015-09-14 07:02:03'),
(145, 13, 'Flower', 'Lan Hồ Điệp - L0046', 2000000, 'http://p.vatgia.vn/pictures_fullsize/enk1427181623.jpg', 'http://www.vatgia.com/2967/4936770/lan-h%E1%BB%93-%C4%91i%E1%BB%87p-l0046.html', 0, '2015-09-14 07:02:03'),
(146, 13, 'Flower', 'Hoa trang trí Lay Ơn FF01', 800000, 'http://p.vatgia.vn/pictures_fullsize/pem1437108737.jpg', 'http://www.vatgia.com/4765/5296135/hoa-trang-tr%C3%AD-lay-%C6%A1n-ff01.html', 0, '2015-09-14 07:02:03'),
(147, 13, 'Flower', 'Hoa cưới SM02', 350000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/a3p6MTM5NDc5MTczOS5KUEc-/hoa-cuoi-sm02.jpg', 'http://www.vatgia.com/2968/3893776/hoa-c%C6%B0%E1%BB%9Bi-sm02.html', 0, '2015-09-14 07:02:03'),
(148, 13, 'Flower', 'Tuổi hồng trong sáng - MHSN016', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bG5rMTM4MzcwNjc3MC5qcGc-/tuoi-hong-trong-sang-mhsn016.jpg', 'http://www.vatgia.com/2966/3553430/tu%E1%BB%95i-h%E1%BB%93ng-trong-s%C3%A1ng-mhsn016.html', 0, '2015-09-14 07:02:03'),
(149, 13, 'Flower', 'Hoa tươi H0090', 300000, 'http://p.vatgia.vn/pictures_fullsize/hzk1427328500.jpg', 'http://www.vatgia.com/2966/4942365/hoa-t%C6%B0%C6%A1i-h0090.html', 0, '2015-09-14 07:02:03'),
(150, 13, 'Flower', 'Hoa tươi H0080', 700000, 'http://p.vatgia.vn/pictures_fullsize/hfs1427329028.jpg', 'http://www.vatgia.com/2966/4942375/hoa-t%C6%B0%C6%A1i-h0080.html', 0, '2015-09-14 07:02:03'),
(151, 13, 'Flower', 'Hoa tươi H0124', 350000, 'http://p.vatgia.vn/pictures_fullsize/bgw1427293582.jpg', 'http://www.vatgia.com/2966/4942000/hoa-t%C6%B0%C6%A1i-h0124.html', 0, '2015-09-14 07:02:03'),
(152, 13, 'Flower', 'Lan Hồ Điệp - L0028', 1500000, 'http://p.vatgia.vn/pictures_fullsize/pzd1427183727.jpg', 'http://www.vatgia.com/2967/4937024/lan-h%E1%BB%93-%C4%91i%E1%BB%87p-l0028.html', 0, '2015-09-14 07:02:03'),
(153, 13, 'Flower', 'Hoa trang trí - Xương Rồng FF01', 350000, 'http://p.vatgia.vn/pictures_fullsize/eyv1437109372.jpg', 'http://www.vatgia.com/4765/5296128/hoa-trang-tr%C3%AD-x%C6%B0%C6%A1ng-r%E1%BB%93ng-ff01.html', 0, '2015-09-14 07:02:03'),
(154, 13, 'Flower', 'Hoa trang trí hoa Phong Lan trắng', 700000, 'http://p.vatgia.vn/pictures_fullsize/lgh1438418182.jpg', 'http://www.vatgia.com/4765/5263774/hoa-trang-tr%C3%AD-hoa-phong-lan-tr%E1%BA%AFng.html', 0, '2015-09-14 07:02:03'),
(155, 13, 'Flower', 'Hoa Tình yêu hoàn hảo - MHTY037', 715000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGtnMTM4MzcxNzgwNy5qcGc-/hoa-tinh-yeu-trai-tim-hoan-hao-mhty037.jpg', 'http://www.vatgia.com/2963/3554426/hoa-t%C3%ACnh-y%C3%AAu-tr%C3%A1i-tim-ho%C3%A0n-h%E1%BA%A3o-mhty037.html', 0, '2015-09-14 07:02:03'),
(156, 13, 'Flower', 'Vẫn mãi yêu - MHTY055', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/d25hMTM4MzcxOTY2OS5qcGc-/van-mai-yeu-mhty055.jpg', 'http://www.vatgia.com/2963/3554522/v%E1%BA%ABn-m%C3%A3i-y%C3%AAu-mhty055.html', 0, '2015-09-14 07:02:03'),
(157, 13, 'Flower', 'Hoa hồng bất tử – Hộp tim 9 bông hồng', 470000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGxiMTQyNzk0NjQ0Ny5qcGc-/hoa-hong-bat-tu-hop-tim-9-bong-hong.jpg', 'http://www.vatgia.com/2963/4964574/hoa-h%E1%BB%93ng-b%E1%BA%A5t-t%E1%BB%AD-%E2%80%93-h%E1%BB%99p-tim-9-b%C3%B4ng-h%E1%BB%93ng.html', 0, '2015-09-14 07:02:03'),
(158, 13, 'Flower', 'Kỷ niệm xưa - MHSN024', 520000, 'http://p.vatgia.vn/pictures_fullsize/uzl1383707480.jpg', 'http://www.vatgia.com/2966/3553525/k%E1%BB%B7-ni%E1%BB%87m-x%C6%B0a-mhsn024.html', 0, '2015-09-14 07:02:03'),
(159, 13, 'Flower', 'Hoa tươi H0063', 300000, 'http://p.vatgia.vn/pictures_fullsize/kdn1427332108.jpg', 'http://www.vatgia.com/2966/4942409/hoa-t%C6%B0%C6%A1i-h0063.html', 0, '2015-09-14 07:02:03'),
(160, 13, 'Flower', 'Hoa tươi - H0164', 300000, 'http://p.vatgia.vn/pictures_fullsize/iqq1427187776.jpg', 'http://www.vatgia.com/2966/4942436/hoa-t%C6%B0%C6%A1i-h0067.html', 0, '2015-09-14 07:02:03'),
(161, 13, 'Flower', 'Hoa tươi H0067', 250000, 'http://p.vatgia.vn/pictures_fullsize/jdm1427333201.jpg', 'http://www.vatgia.com/2966/4937495/hoa-t%C6%B0%C6%A1i-h0164.html', 0, '2015-09-14 07:02:03'),
(162, 13, 'Flower', 'Hoa tình yêu bó 20 bông hoa hồng xanh tươi 5 năm', 2000000, 'http://p.vatgia.vn/ir/gallery_img/4/7/cG1xMTQzOTY1MjQ2Ni5qcGc-/hoa-tinh-yeu-bo-20-bong-hoa-hong-xanh-tuoi-5-nam-anh-2.jpg', 'http://www.vatgia.com/2963/5297685/hoa-t%C3%ACnh-y%C3%AAu-b%C3%B3-20-b%C3%B4ng-hoa-h%E1%BB%93ng-xanh-t%C6%B0%C6%A1i-5-n%C4%83m.html', 0, '2015-09-14 07:02:03'),
(163, 13, 'Flower', 'Hoa trang trí FF03', 530000, 'http://p.vatgia.vn/pictures_fullsize/mim1439786429.jpg', 'http://www.vatgia.com/4765/5299183/hoa-trang-tr%C3%AD-ff03.html', 0, '2015-09-14 07:02:03'),
(164, 13, 'Flower', 'Đón nắng mùa xuân - MBCM004', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bHZrMTM4MzY1Mzk4OS5qcGc-/don-nang-mua-xuan-mbcm004.jpg', 'http://www.vatgia.com/2967/3552534/%C4%91%C3%B3n-n%E1%BA%AFng-m%C3%B9a-xu%C3%A2n-mbcm004.html', 0, '2015-09-14 07:02:03'),
(165, 13, 'Flower', 'Hoa trang trí nghệ thuật Phong Lan tím FF02', 320000, 'http://p.vatgia.vn/pictures_fullsize/ndx1437031996.jpg', 'http://www.vatgia.com/4765/5296088/hoa-trang-tr%C3%AD-ngh%E1%BB%87-thu%E1%BA%ADt-phong-lan-t%C3%ADm-ff02.html', 0, '2015-09-14 07:02:03'),
(166, 13, 'Flower', 'Ngày xanh tươi - MBCM019', 520000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Ym9xMTM4MzY1MjQ0OC5qcGc-/ngay-xanh-tuoi-mbcm019.jpg', 'http://www.vatgia.com/2967/3552514/ng%C3%A0y-xanh-t%C6%B0%C6%A1i-mbcm019.html', 0, '2015-09-14 07:02:03'),
(167, 13, 'Flower', 'Hoa hồng bất tử – Hộp trụ', 250000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dmh1MTQyNzk0NzkwOS5qcGc-/hoa-hong-bat-tu-hop-tru.jpg', 'http://www.vatgia.com/2963/4964727/hoa-h%E1%BB%93ng-b%E1%BA%A5t-t%E1%BB%AD-%E2%80%93-h%E1%BB%99p-tr%E1%BB%A5.html', 0, '2015-09-14 07:02:03'),
(168, 13, 'Flower', 'Hoa tươi - H0166', 400000, 'http://p.vatgia.vn/pictures_fullsize/xts1427187941.jpg', 'http://www.vatgia.com/2966/4937514/hoa-t%C6%B0%C6%A1i-h0166.html', 0, '2015-09-14 07:02:03'),
(169, 13, 'Flower', 'Hoa tươi - H0148', 400000, 'http://p.vatgia.vn/pictures_fullsize/iyl1427189109.jpg', 'http://www.vatgia.com/2966/4937655/hoa-t%C6%B0%C6%A1i-h0148.html', 0, '2015-09-14 07:02:03'),
(170, 13, 'Flower', 'Hoa tươi H0067', 250000, 'http://p.vatgia.vn/pictures_fullsize/jdm1427333201.jpg', 'http://www.vatgia.com/2966/4942436/hoa-t%C6%B0%C6%A1i-h0067.html', 0, '2015-09-14 07:02:03'),
(171, 13, 'Flower', 'Hoa tươi - H0179', 800000, 'http://p.vatgia.vn/pictures_fullsize/jhe1427187451.jpg', 'http://www.vatgia.com/2966/4937447/hoa-t%C6%B0%C6%A1i-h0179.html', 0, '2015-09-14 07:02:03'),
(172, 13, 'Flower', 'Hoa Trang Trí FL01', 1670000, 'http://p.vatgia.vn/pictures_fullsize/mxt1439889791.jpg', 'http://www.vatgia.com/4765/5303048/hoa-trang-tr%C3%AD-fl01.html', 0, '2015-09-14 08:45:21'),
(173, 13, 'Flower', 'Hoa tình yêu Bình hoa hồng vĩnh cửu', 1650000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGJoMTQzOTcxNTc5NS5qcGc-/hoa-tinh-yeu-binh-hoa-hong-vinh-cuu.jpg', 'http://www.vatgia.com/2963/5298247/hoa-t%C3%ACnh-y%C3%AAu-b%C3%ACnh-hoa-h%E1%BB%93ng-v%C4%A9nh-c%E1%BB%ADu.html', 0, '2015-09-14 08:45:21'),
(174, 13, 'Flower', 'Hoa trang trí FF14', 1100000, 'http://p.vatgia.vn/pictures_fullsize/irr1439785783.jpg', 'http://www.vatgia.com/4765/5299147/hoa-trang-tr%C3%AD-ff14.html', 0, '2015-09-14 08:45:21'),
(175, 13, 'Flower', 'Lan Hồ Điệp - L0046', 2000000, 'http://p.vatgia.vn/pictures_fullsize/enk1427181623.jpg', 'http://www.vatgia.com/2967/4936770/lan-h%E1%BB%93-%C4%91i%E1%BB%87p-l0046.html', 0, '2015-09-14 08:45:21'),
(176, 13, 'Flower', 'Hoa trang trí Lay Ơn FF01', 800000, 'http://p.vatgia.vn/pictures_fullsize/pem1437108737.jpg', 'http://www.vatgia.com/4765/5296135/hoa-trang-tr%C3%AD-lay-%C6%A1n-ff01.html', 0, '2015-09-14 08:45:21'),
(177, 13, 'Flower', 'Hoa cưới SM02', 350000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/a3p6MTM5NDc5MTczOS5KUEc-/hoa-cuoi-sm02.jpg', 'http://www.vatgia.com/2968/3893776/hoa-c%C6%B0%E1%BB%9Bi-sm02.html', 0, '2015-09-14 08:45:21'),
(178, 13, 'Flower', 'Tuổi hồng trong sáng - MHSN016', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bG5rMTM4MzcwNjc3MC5qcGc-/tuoi-hong-trong-sang-mhsn016.jpg', 'http://www.vatgia.com/2966/3553430/tu%E1%BB%95i-h%E1%BB%93ng-trong-s%C3%A1ng-mhsn016.html', 0, '2015-09-14 08:45:21'),
(179, 13, 'Flower', 'Hoa tươi H0090', 300000, 'http://p.vatgia.vn/pictures_fullsize/hzk1427328500.jpg', 'http://www.vatgia.com/2966/4942365/hoa-t%C6%B0%C6%A1i-h0090.html', 0, '2015-09-14 08:45:21'),
(180, 13, 'Flower', 'Hoa tươi H0080', 700000, 'http://p.vatgia.vn/pictures_fullsize/hfs1427329028.jpg', 'http://www.vatgia.com/2966/4942375/hoa-t%C6%B0%C6%A1i-h0080.html', 0, '2015-09-14 08:45:21'),
(181, 13, 'Flower', 'Hoa tươi H0124', 350000, 'http://p.vatgia.vn/pictures_fullsize/bgw1427293582.jpg', 'http://www.vatgia.com/2966/4942000/hoa-t%C6%B0%C6%A1i-h0124.html', 0, '2015-09-14 08:45:21'),
(182, 13, 'Flower', 'Lan Hồ Điệp - L0028', 1500000, 'http://p.vatgia.vn/pictures_fullsize/pzd1427183727.jpg', 'http://www.vatgia.com/2967/4937024/lan-h%E1%BB%93-%C4%91i%E1%BB%87p-l0028.html', 0, '2015-09-14 08:45:21'),
(183, 13, 'Flower', 'Hoa trang trí - Xương Rồng FF01', 350000, 'http://p.vatgia.vn/pictures_fullsize/eyv1437109372.jpg', 'http://www.vatgia.com/4765/5296128/hoa-trang-tr%C3%AD-x%C6%B0%C6%A1ng-r%E1%BB%93ng-ff01.html', 0, '2015-09-14 08:45:21'),
(184, 13, 'Flower', 'Hoa trang trí hoa Phong Lan trắng', 700000, 'http://p.vatgia.vn/pictures_fullsize/lgh1438418182.jpg', 'http://www.vatgia.com/4765/5263774/hoa-trang-tr%C3%AD-hoa-phong-lan-tr%E1%BA%AFng.html', 0, '2015-09-14 08:45:21'),
(185, 13, 'Flower', 'Hoa Tình yêu hoàn hảo - MHTY037', 715000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGtnMTM4MzcxNzgwNy5qcGc-/hoa-tinh-yeu-trai-tim-hoan-hao-mhty037.jpg', 'http://www.vatgia.com/2963/3554426/hoa-t%C3%ACnh-y%C3%AAu-tr%C3%A1i-tim-ho%C3%A0n-h%E1%BA%A3o-mhty037.html', 0, '2015-09-14 08:45:21'),
(186, 13, 'Flower', 'Vẫn mãi yêu - MHTY055', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/d25hMTM4MzcxOTY2OS5qcGc-/van-mai-yeu-mhty055.jpg', 'http://www.vatgia.com/2963/3554522/v%E1%BA%ABn-m%C3%A3i-y%C3%AAu-mhty055.html', 0, '2015-09-14 08:45:21'),
(187, 13, 'Flower', 'Hoa hồng bất tử – Hộp tim 9 bông hồng', 470000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGxiMTQyNzk0NjQ0Ny5qcGc-/hoa-hong-bat-tu-hop-tim-9-bong-hong.jpg', 'http://www.vatgia.com/2963/4964574/hoa-h%E1%BB%93ng-b%E1%BA%A5t-t%E1%BB%AD-%E2%80%93-h%E1%BB%99p-tim-9-b%C3%B4ng-h%E1%BB%93ng.html', 0, '2015-09-14 08:45:21'),
(188, 13, 'Flower', 'Kỷ niệm xưa - MHSN024', 520000, 'http://p.vatgia.vn/pictures_fullsize/uzl1383707480.jpg', 'http://www.vatgia.com/2966/3553525/k%E1%BB%B7-ni%E1%BB%87m-x%C6%B0a-mhsn024.html', 0, '2015-09-14 08:45:21'),
(189, 13, 'Flower', 'Hoa tươi H0063', 300000, 'http://p.vatgia.vn/pictures_fullsize/kdn1427332108.jpg', 'http://www.vatgia.com/2966/4942409/hoa-t%C6%B0%C6%A1i-h0063.html', 0, '2015-09-14 08:45:21'),
(190, 13, 'Flower', 'Hoa tươi - H0164', 300000, 'http://p.vatgia.vn/pictures_fullsize/iqq1427187776.jpg', 'http://www.vatgia.com/2966/4942436/hoa-t%C6%B0%C6%A1i-h0067.html', 0, '2015-09-14 08:45:21'),
(191, 13, 'Flower', 'Hoa tươi H0067', 250000, 'http://p.vatgia.vn/pictures_fullsize/jdm1427333201.jpg', 'http://www.vatgia.com/2966/4937495/hoa-t%C6%B0%C6%A1i-h0164.html', 0, '2015-09-14 08:45:21'),
(192, 13, 'Flower', 'Hoa tình yêu bó 20 bông hoa hồng xanh tươi 5 năm', 2000000, 'http://p.vatgia.vn/ir/gallery_img/4/7/cG1xMTQzOTY1MjQ2Ni5qcGc-/hoa-tinh-yeu-bo-20-bong-hoa-hong-xanh-tuoi-5-nam-anh-2.jpg', 'http://www.vatgia.com/2963/5297685/hoa-t%C3%ACnh-y%C3%AAu-b%C3%B3-20-b%C3%B4ng-hoa-h%E1%BB%93ng-xanh-t%C6%B0%C6%A1i-5-n%C4%83m.html', 0, '2015-09-14 08:45:21'),
(193, 13, 'Flower', 'Hoa trang trí FF03', 530000, 'http://p.vatgia.vn/pictures_fullsize/mim1439786429.jpg', 'http://www.vatgia.com/4765/5299183/hoa-trang-tr%C3%AD-ff03.html', 0, '2015-09-14 08:45:21'),
(194, 13, 'Flower', 'Đón nắng mùa xuân - MBCM004', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bHZrMTM4MzY1Mzk4OS5qcGc-/don-nang-mua-xuan-mbcm004.jpg', 'http://www.vatgia.com/2967/3552534/%C4%91%C3%B3n-n%E1%BA%AFng-m%C3%B9a-xu%C3%A2n-mbcm004.html', 0, '2015-09-14 08:45:21'),
(195, 13, 'Flower', 'Hoa trang trí nghệ thuật Phong Lan tím FF02', 320000, 'http://p.vatgia.vn/pictures_fullsize/ndx1437031996.jpg', 'http://www.vatgia.com/4765/5296088/hoa-trang-tr%C3%AD-ngh%E1%BB%87-thu%E1%BA%ADt-phong-lan-t%C3%ADm-ff02.html', 0, '2015-09-14 08:45:21'),
(196, 13, 'Flower', 'Ngày xanh tươi - MBCM019', 520000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Ym9xMTM4MzY1MjQ0OC5qcGc-/ngay-xanh-tuoi-mbcm019.jpg', 'http://www.vatgia.com/2967/3552514/ng%C3%A0y-xanh-t%C6%B0%C6%A1i-mbcm019.html', 0, '2015-09-14 08:45:21'),
(197, 13, 'Flower', 'Hoa hồng bất tử – Hộp trụ', 250000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dmh1MTQyNzk0NzkwOS5qcGc-/hoa-hong-bat-tu-hop-tru.jpg', 'http://www.vatgia.com/2963/4964727/hoa-h%E1%BB%93ng-b%E1%BA%A5t-t%E1%BB%AD-%E2%80%93-h%E1%BB%99p-tr%E1%BB%A5.html', 0, '2015-09-14 08:45:21'),
(198, 13, 'Flower', 'Hoa tươi - H0166', 400000, 'http://p.vatgia.vn/pictures_fullsize/xts1427187941.jpg', 'http://www.vatgia.com/2966/4937514/hoa-t%C6%B0%C6%A1i-h0166.html', 0, '2015-09-14 08:45:21'),
(199, 13, 'Flower', 'Hoa tươi - H0148', 400000, 'http://p.vatgia.vn/pictures_fullsize/iyl1427189109.jpg', 'http://www.vatgia.com/2966/4937655/hoa-t%C6%B0%C6%A1i-h0148.html', 0, '2015-09-14 08:45:21'),
(200, 13, 'Flower', 'Hoa tươi H0067', 250000, 'http://p.vatgia.vn/pictures_fullsize/jdm1427333201.jpg', 'http://www.vatgia.com/2966/4942436/hoa-t%C6%B0%C6%A1i-h0067.html', 0, '2015-09-14 08:45:21'),
(201, 13, 'Flower', 'Hoa tươi - H0179', 800000, 'http://p.vatgia.vn/pictures_fullsize/jhe1427187451.jpg', 'http://www.vatgia.com/2966/4937447/hoa-t%C6%B0%C6%A1i-h0179.html', 0, '2015-09-14 08:45:21'),
(202, 13, 'Flower', 'Hoa Trang Trí FL01', 1670000, 'http://p.vatgia.vn/pictures_fullsize/mxt1439889791.jpg', 'http://www.vatgia.com/4765/5303048/hoa-trang-tr%C3%AD-fl01.html', 0, '2015-09-14 09:48:34'),
(203, 13, 'Flower', 'Hoa tình yêu Bình hoa hồng vĩnh cửu', 1650000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGJoMTQzOTcxNTc5NS5qcGc-/hoa-tinh-yeu-binh-hoa-hong-vinh-cuu.jpg', 'http://www.vatgia.com/2963/5298247/hoa-t%C3%ACnh-y%C3%AAu-b%C3%ACnh-hoa-h%E1%BB%93ng-v%C4%A9nh-c%E1%BB%ADu.html', 0, '2015-09-14 09:48:34'),
(204, 13, 'Flower', 'Hoa trang trí FF14', 1100000, 'http://p.vatgia.vn/pictures_fullsize/irr1439785783.jpg', 'http://www.vatgia.com/4765/5299147/hoa-trang-tr%C3%AD-ff14.html', 0, '2015-09-14 09:48:34'),
(205, 13, 'Flower', 'Lan Hồ Điệp - L0046', 2000000, 'http://p.vatgia.vn/pictures_fullsize/enk1427181623.jpg', 'http://www.vatgia.com/2967/4936770/lan-h%E1%BB%93-%C4%91i%E1%BB%87p-l0046.html', 0, '2015-09-14 09:48:34'),
(206, 13, 'Flower', 'Hoa trang trí Lay Ơn FF01', 800000, 'http://p.vatgia.vn/pictures_fullsize/pem1437108737.jpg', 'http://www.vatgia.com/4765/5296135/hoa-trang-tr%C3%AD-lay-%C6%A1n-ff01.html', 0, '2015-09-14 09:48:34'),
(207, 13, 'Flower', 'Hoa cưới SM02', 350000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/a3p6MTM5NDc5MTczOS5KUEc-/hoa-cuoi-sm02.jpg', 'http://www.vatgia.com/2968/3893776/hoa-c%C6%B0%E1%BB%9Bi-sm02.html', 0, '2015-09-14 09:48:34'),
(208, 13, 'Flower', 'Tuổi hồng trong sáng - MHSN016', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bG5rMTM4MzcwNjc3MC5qcGc-/tuoi-hong-trong-sang-mhsn016.jpg', 'http://www.vatgia.com/2966/3553430/tu%E1%BB%95i-h%E1%BB%93ng-trong-s%C3%A1ng-mhsn016.html', 0, '2015-09-14 09:48:34'),
(209, 13, 'Flower', 'Hoa tươi H0090', 300000, 'http://p.vatgia.vn/pictures_fullsize/hzk1427328500.jpg', 'http://www.vatgia.com/2966/4942365/hoa-t%C6%B0%C6%A1i-h0090.html', 0, '2015-09-14 09:48:34'),
(210, 13, 'Flower', 'Hoa tươi H0080', 700000, 'http://p.vatgia.vn/pictures_fullsize/hfs1427329028.jpg', 'http://www.vatgia.com/2966/4942375/hoa-t%C6%B0%C6%A1i-h0080.html', 0, '2015-09-14 09:48:34');
INSERT INTO `vatgia_products` (`id`, `category_id`, `category_name`, `name`, `price`, `image_url`, `link_detail`, `alive`, `modified_date`) VALUES
(211, 13, 'Flower', 'Hoa tươi H0124', 350000, 'http://p.vatgia.vn/pictures_fullsize/bgw1427293582.jpg', 'http://www.vatgia.com/2966/4942000/hoa-t%C6%B0%C6%A1i-h0124.html', 0, '2015-09-14 09:48:34'),
(212, 13, 'Flower', 'Lan Hồ Điệp - L0028', 1500000, 'http://p.vatgia.vn/pictures_fullsize/pzd1427183727.jpg', 'http://www.vatgia.com/2967/4937024/lan-h%E1%BB%93-%C4%91i%E1%BB%87p-l0028.html', 0, '2015-09-14 09:48:34'),
(213, 13, 'Flower', 'Hoa trang trí - Xương Rồng FF01', 350000, 'http://p.vatgia.vn/pictures_fullsize/eyv1437109372.jpg', 'http://www.vatgia.com/4765/5296128/hoa-trang-tr%C3%AD-x%C6%B0%C6%A1ng-r%E1%BB%93ng-ff01.html', 0, '2015-09-14 09:48:34'),
(214, 13, 'Flower', 'Hoa trang trí hoa Phong Lan trắng', 700000, 'http://p.vatgia.vn/pictures_fullsize/lgh1438418182.jpg', 'http://www.vatgia.com/4765/5263774/hoa-trang-tr%C3%AD-hoa-phong-lan-tr%E1%BA%AFng.html', 0, '2015-09-14 09:48:34'),
(215, 13, 'Flower', 'Hoa Tình yêu hoàn hảo - MHTY037', 715000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGtnMTM4MzcxNzgwNy5qcGc-/hoa-tinh-yeu-trai-tim-hoan-hao-mhty037.jpg', 'http://www.vatgia.com/2963/3554426/hoa-t%C3%ACnh-y%C3%AAu-tr%C3%A1i-tim-ho%C3%A0n-h%E1%BA%A3o-mhty037.html', 0, '2015-09-14 09:48:34'),
(216, 13, 'Flower', 'Vẫn mãi yêu - MHTY055', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/d25hMTM4MzcxOTY2OS5qcGc-/van-mai-yeu-mhty055.jpg', 'http://www.vatgia.com/2963/3554522/v%E1%BA%ABn-m%C3%A3i-y%C3%AAu-mhty055.html', 0, '2015-09-14 09:48:34'),
(217, 13, 'Flower', 'Hoa hồng bất tử – Hộp tim 9 bông hồng', 470000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGxiMTQyNzk0NjQ0Ny5qcGc-/hoa-hong-bat-tu-hop-tim-9-bong-hong.jpg', 'http://www.vatgia.com/2963/4964574/hoa-h%E1%BB%93ng-b%E1%BA%A5t-t%E1%BB%AD-%E2%80%93-h%E1%BB%99p-tim-9-b%C3%B4ng-h%E1%BB%93ng.html', 0, '2015-09-14 09:48:34'),
(218, 13, 'Flower', 'Kỷ niệm xưa - MHSN024', 520000, 'http://p.vatgia.vn/pictures_fullsize/uzl1383707480.jpg', 'http://www.vatgia.com/2966/3553525/k%E1%BB%B7-ni%E1%BB%87m-x%C6%B0a-mhsn024.html', 0, '2015-09-14 09:48:34'),
(219, 13, 'Flower', 'Hoa tươi H0063', 300000, 'http://p.vatgia.vn/pictures_fullsize/kdn1427332108.jpg', 'http://www.vatgia.com/2966/4942409/hoa-t%C6%B0%C6%A1i-h0063.html', 0, '2015-09-14 09:48:34'),
(220, 13, 'Flower', 'Hoa tươi - H0164', 300000, 'http://p.vatgia.vn/pictures_fullsize/iqq1427187776.jpg', 'http://www.vatgia.com/2966/4942436/hoa-t%C6%B0%C6%A1i-h0067.html', 0, '2015-09-14 09:48:34'),
(221, 13, 'Flower', 'Hoa tươi H0067', 250000, 'http://p.vatgia.vn/pictures_fullsize/jdm1427333201.jpg', 'http://www.vatgia.com/2966/4937495/hoa-t%C6%B0%C6%A1i-h0164.html', 0, '2015-09-14 09:48:34'),
(222, 13, 'Flower', 'Hoa tình yêu bó 20 bông hoa hồng xanh tươi 5 năm', 2000000, 'http://p.vatgia.vn/ir/gallery_img/4/7/cG1xMTQzOTY1MjQ2Ni5qcGc-/hoa-tinh-yeu-bo-20-bong-hoa-hong-xanh-tuoi-5-nam-anh-2.jpg', 'http://www.vatgia.com/2963/5297685/hoa-t%C3%ACnh-y%C3%AAu-b%C3%B3-20-b%C3%B4ng-hoa-h%E1%BB%93ng-xanh-t%C6%B0%C6%A1i-5-n%C4%83m.html', 0, '2015-09-14 09:48:34'),
(223, 13, 'Flower', 'Hoa trang trí FF03', 530000, 'http://p.vatgia.vn/pictures_fullsize/mim1439786429.jpg', 'http://www.vatgia.com/4765/5299183/hoa-trang-tr%C3%AD-ff03.html', 0, '2015-09-14 09:48:34'),
(224, 13, 'Flower', 'Đón nắng mùa xuân - MBCM004', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bHZrMTM4MzY1Mzk4OS5qcGc-/don-nang-mua-xuan-mbcm004.jpg', 'http://www.vatgia.com/2967/3552534/%C4%91%C3%B3n-n%E1%BA%AFng-m%C3%B9a-xu%C3%A2n-mbcm004.html', 0, '2015-09-14 09:48:34'),
(225, 13, 'Flower', 'Hoa trang trí nghệ thuật Phong Lan tím FF02', 320000, 'http://p.vatgia.vn/pictures_fullsize/ndx1437031996.jpg', 'http://www.vatgia.com/4765/5296088/hoa-trang-tr%C3%AD-ngh%E1%BB%87-thu%E1%BA%ADt-phong-lan-t%C3%ADm-ff02.html', 0, '2015-09-14 09:48:34'),
(226, 13, 'Flower', 'Ngày xanh tươi - MBCM019', 520000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Ym9xMTM4MzY1MjQ0OC5qcGc-/ngay-xanh-tuoi-mbcm019.jpg', 'http://www.vatgia.com/2967/3552514/ng%C3%A0y-xanh-t%C6%B0%C6%A1i-mbcm019.html', 0, '2015-09-14 09:48:34'),
(227, 13, 'Flower', 'Hoa hồng bất tử – Hộp trụ', 250000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dmh1MTQyNzk0NzkwOS5qcGc-/hoa-hong-bat-tu-hop-tru.jpg', 'http://www.vatgia.com/2963/4964727/hoa-h%E1%BB%93ng-b%E1%BA%A5t-t%E1%BB%AD-%E2%80%93-h%E1%BB%99p-tr%E1%BB%A5.html', 0, '2015-09-14 09:48:34'),
(228, 13, 'Flower', 'Hoa Trang Trí FL01', 1670000, 'http://p.vatgia.vn/pictures_fullsize/mxt1439889791.jpg', 'http://www.vatgia.com/4765/5303048/hoa-trang-tr%C3%AD-fl01.html', 1, '2015-09-18 05:06:46'),
(229, 13, 'Flower', 'Hoa tình yêu Bình hoa hồng vĩnh cửu', 1650000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGJoMTQzOTcxNTc5NS5qcGc-/hoa-tinh-yeu-binh-hoa-hong-vinh-cuu.jpg', 'http://www.vatgia.com/2963/5298247/hoa-t%C3%ACnh-y%C3%AAu-b%C3%ACnh-hoa-h%E1%BB%93ng-v%C4%A9nh-c%E1%BB%ADu.html', 1, '2015-09-18 05:06:46'),
(230, 13, 'Flower', 'Hoa trang trí FF14', 1100000, 'http://p.vatgia.vn/pictures_fullsize/irr1439785783.jpg', 'http://www.vatgia.com/4765/5299147/hoa-trang-tr%C3%AD-ff14.html', 1, '2015-09-18 05:06:46'),
(231, 13, 'Flower', 'Lan Hồ Điệp - L0046', 2000000, 'http://p.vatgia.vn/pictures_fullsize/enk1427181623.jpg', 'http://www.vatgia.com/2967/4936770/lan-h%E1%BB%93-%C4%91i%E1%BB%87p-l0046.html', 1, '2015-09-18 05:06:46'),
(232, 13, 'Flower', 'Hoa trang trí Lay Ơn FF01', 800000, 'http://p.vatgia.vn/pictures_fullsize/pem1437108737.jpg', 'http://www.vatgia.com/4765/5296135/hoa-trang-tr%C3%AD-lay-%C6%A1n-ff01.html', 1, '2015-09-18 05:06:46'),
(233, 13, 'Flower', 'Hoa cưới SM02', 350000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/a3p6MTM5NDc5MTczOS5KUEc-/hoa-cuoi-sm02.jpg', 'http://www.vatgia.com/2968/3893776/hoa-c%C6%B0%E1%BB%9Bi-sm02.html', 1, '2015-09-18 05:06:46'),
(234, 13, 'Flower', 'Tuổi hồng trong sáng - MHSN016', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bG5rMTM4MzcwNjc3MC5qcGc-/tuoi-hong-trong-sang-mhsn016.jpg', 'http://www.vatgia.com/2966/3553430/tu%E1%BB%95i-h%E1%BB%93ng-trong-s%C3%A1ng-mhsn016.html', 1, '2015-09-18 05:06:46'),
(235, 13, 'Flower', 'Hoa tươi H0090', 300000, 'http://p.vatgia.vn/pictures_fullsize/hzk1427328500.jpg', 'http://www.vatgia.com/2966/4942365/hoa-t%C6%B0%C6%A1i-h0090.html', 1, '2015-09-18 05:06:46'),
(236, 13, 'Flower', 'Hoa tươi H0080', 700000, 'http://p.vatgia.vn/pictures_fullsize/hfs1427329028.jpg', 'http://www.vatgia.com/2966/4942375/hoa-t%C6%B0%C6%A1i-h0080.html', 1, '2015-09-18 05:06:46'),
(237, 13, 'Flower', 'Hoa tươi H0124', 350000, 'http://p.vatgia.vn/pictures_fullsize/bgw1427293582.jpg', 'http://www.vatgia.com/2966/4942000/hoa-t%C6%B0%C6%A1i-h0124.html', 1, '2015-09-18 05:06:46'),
(238, 13, 'Flower', 'Lan Hồ Điệp - L0028', 1500000, 'http://p.vatgia.vn/pictures_fullsize/pzd1427183727.jpg', 'http://www.vatgia.com/2967/4937024/lan-h%E1%BB%93-%C4%91i%E1%BB%87p-l0028.html', 1, '2015-09-18 05:06:46'),
(239, 13, 'Flower', 'Hoa trang trí - Xương Rồng FF01', 350000, 'http://p.vatgia.vn/pictures_fullsize/eyv1437109372.jpg', 'http://www.vatgia.com/4765/5296128/hoa-trang-tr%C3%AD-x%C6%B0%C6%A1ng-r%E1%BB%93ng-ff01.html', 1, '2015-09-18 05:06:46'),
(240, 13, 'Flower', 'Hoa trang trí hoa Phong Lan trắng', 700000, 'http://p.vatgia.vn/pictures_fullsize/lgh1438418182.jpg', 'http://www.vatgia.com/4765/5263774/hoa-trang-tr%C3%AD-hoa-phong-lan-tr%E1%BA%AFng.html', 1, '2015-09-18 05:06:46'),
(241, 13, 'Flower', 'Hoa Tình yêu hoàn hảo - MHTY037', 715000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGtnMTM4MzcxNzgwNy5qcGc-/hoa-tinh-yeu-trai-tim-hoan-hao-mhty037.jpg', 'http://www.vatgia.com/2963/3554426/hoa-t%C3%ACnh-y%C3%AAu-tr%C3%A1i-tim-ho%C3%A0n-h%E1%BA%A3o-mhty037.html', 1, '2015-09-18 05:06:46'),
(242, 13, 'Flower', 'Vẫn mãi yêu - MHTY055', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/d25hMTM4MzcxOTY2OS5qcGc-/van-mai-yeu-mhty055.jpg', 'http://www.vatgia.com/2963/3554522/v%E1%BA%ABn-m%C3%A3i-y%C3%AAu-mhty055.html', 1, '2015-09-18 05:06:46'),
(243, 13, 'Flower', 'Hoa hồng bất tử – Hộp tim 9 bông hồng', 470000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bGxiMTQyNzk0NjQ0Ny5qcGc-/hoa-hong-bat-tu-hop-tim-9-bong-hong.jpg', 'http://www.vatgia.com/2963/4964574/hoa-h%E1%BB%93ng-b%E1%BA%A5t-t%E1%BB%AD-%E2%80%93-h%E1%BB%99p-tim-9-b%C3%B4ng-h%E1%BB%93ng.html', 1, '2015-09-18 05:06:46'),
(244, 13, 'Flower', 'Kỷ niệm xưa - MHSN024', 520000, 'http://p.vatgia.vn/pictures_fullsize/uzl1383707480.jpg', 'http://www.vatgia.com/2966/3553525/k%E1%BB%B7-ni%E1%BB%87m-x%C6%B0a-mhsn024.html', 1, '2015-09-18 05:06:46'),
(245, 13, 'Flower', 'Hoa tươi H0063', 300000, 'http://p.vatgia.vn/pictures_fullsize/kdn1427332108.jpg', 'http://www.vatgia.com/2966/4942409/hoa-t%C6%B0%C6%A1i-h0063.html', 1, '2015-09-18 05:06:46'),
(246, 13, 'Flower', 'Hoa tươi - H0164', 300000, 'http://p.vatgia.vn/pictures_fullsize/iqq1427187776.jpg', 'http://www.vatgia.com/2966/4942436/hoa-t%C6%B0%C6%A1i-h0067.html', 1, '2015-09-18 05:06:46'),
(247, 13, 'Flower', 'Hoa tươi H0067', 250000, 'http://p.vatgia.vn/pictures_fullsize/jdm1427333201.jpg', 'http://www.vatgia.com/2966/4937495/hoa-t%C6%B0%C6%A1i-h0164.html', 1, '2015-09-18 05:06:46'),
(248, 13, 'Flower', 'Hoa tình yêu bó 20 bông hoa hồng xanh tươi 5 năm', 2000000, 'http://p.vatgia.vn/ir/gallery_img/4/7/cG1xMTQzOTY1MjQ2Ni5qcGc-/hoa-tinh-yeu-bo-20-bong-hoa-hong-xanh-tuoi-5-nam-anh-2.jpg', 'http://www.vatgia.com/2963/5297685/hoa-t%C3%ACnh-y%C3%AAu-b%C3%B3-20-b%C3%B4ng-hoa-h%E1%BB%93ng-xanh-t%C6%B0%C6%A1i-5-n%C4%83m.html', 1, '2015-09-18 05:06:46'),
(249, 13, 'Flower', 'Hoa trang trí FF03', 530000, 'http://p.vatgia.vn/pictures_fullsize/mim1439786429.jpg', 'http://www.vatgia.com/4765/5299183/hoa-trang-tr%C3%AD-ff03.html', 1, '2015-09-18 05:06:46'),
(250, 13, 'Flower', 'Đón nắng mùa xuân - MBCM004', 468000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/bHZrMTM4MzY1Mzk4OS5qcGc-/don-nang-mua-xuan-mbcm004.jpg', 'http://www.vatgia.com/2967/3552534/%C4%91%C3%B3n-n%E1%BA%AFng-m%C3%B9a-xu%C3%A2n-mbcm004.html', 1, '2015-09-18 05:06:46'),
(251, 13, 'Flower', 'Hoa trang trí nghệ thuật Phong Lan tím FF02', 320000, 'http://p.vatgia.vn/pictures_fullsize/ndx1437031996.jpg', 'http://www.vatgia.com/4765/5296088/hoa-trang-tr%C3%AD-ngh%E1%BB%87-thu%E1%BA%ADt-phong-lan-t%C3%ADm-ff02.html', 1, '2015-09-18 05:06:46'),
(252, 13, 'Flower', 'Ngày xanh tươi - MBCM019', 520000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/Ym9xMTM4MzY1MjQ0OC5qcGc-/ngay-xanh-tuoi-mbcm019.jpg', 'http://www.vatgia.com/2967/3552514/ng%C3%A0y-xanh-t%C6%B0%C6%A1i-mbcm019.html', 1, '2015-09-18 05:06:46'),
(253, 13, 'Flower', 'Hoa hồng bất tử – Hộp trụ', 250000, 'http://p.vatgia.vn/ir/pictures_fullsize/7/dmh1MTQyNzk0NzkwOS5qcGc-/hoa-hong-bat-tu-hop-tru.jpg', 'http://www.vatgia.com/2963/4964727/hoa-h%E1%BB%93ng-b%E1%BA%A5t-t%E1%BB%AD-%E2%80%93-h%E1%BB%99p-tr%E1%BB%A5.html', 1, '2015-09-18 05:06:46'),
(254, 13, 'Flower', 'Hoa tươi - H0166', 400000, 'http://p.vatgia.vn/pictures_fullsize/xts1427187941.jpg', 'http://www.vatgia.com/2966/4937514/hoa-t%C6%B0%C6%A1i-h0166.html', 1, '2015-09-18 05:06:46'),
(255, 13, 'Flower', 'Hoa tươi - H0148', 400000, 'http://p.vatgia.vn/pictures_fullsize/iyl1427189109.jpg', 'http://www.vatgia.com/2966/4937655/hoa-t%C6%B0%C6%A1i-h0148.html', 1, '2015-09-18 05:06:46'),
(256, 13, 'Flower', 'Hoa tươi H0067', 250000, 'http://p.vatgia.vn/pictures_fullsize/jdm1427333201.jpg', 'http://www.vatgia.com/2966/4942436/hoa-t%C6%B0%C6%A1i-h0067.html', 1, '2015-09-18 05:06:46'),
(257, 13, 'Flower', 'Hoa tươi - H0179', 800000, 'http://p.vatgia.vn/pictures_fullsize/jhe1427187451.jpg', 'http://www.vatgia.com/2966/4937447/hoa-t%C6%B0%C6%A1i-h0179.html', 1, '2015-09-18 05:06:46');

-- --------------------------------------------------------

--
-- Table structure for table `vtc_response_code`
--

CREATE TABLE IF NOT EXISTS `vtc_response_code` (
  `id` bigint(20) NOT NULL,
  `code` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `comment` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vtc_response_code`
--

INSERT INTO `vtc_response_code` (`id`, `code`, `description`, `comment`) VALUES
(1, 1, 'Giao dịch thành công', NULL),
(2, 0, 'Giao dịch chưa xác định', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vtc_service_code`
--

CREATE TABLE IF NOT EXISTS `vtc_service_code` (
  `id` bigint(20) NOT NULL,
  `code` varchar(255) NOT NULL,
  `code_type` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vtc_service_code`
--

INSERT INTO `vtc_service_code` (`id`, `code`, `code_type`, `name`, `description`) VALUES
(1, 'VTC0027', NULL, 'Thẻ Viettel', ''),
(2, 'VTC0028', NULL, 'Thẻ Vina', ''),
(3, 'VTC0029', NULL, 'Thẻ Mobile', ''),
(4, 'VTC0173', NULL, 'Thẻ GMobile', '');

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
-- Indexes for table `billing_address`
--
ALTER TABLE `billing_address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `card_id` (`user_id`);

--
-- Indexes for table `buy_phone_card`
--
ALTER TABLE `buy_phone_card`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender` (`order_id`),
  ADD KEY `receiver` (`recipient`),
  ADD KEY `vtc_code` (`vtc_code`);

--
-- Indexes for table `currency_type`
--
ALTER TABLE `currency_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `code_2` (`code`);

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
  ADD KEY `vatgia_id` (`vatgia_id`),
  ADD KEY `locale_code` (`locale_code`);

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
-- Indexes for table `lixi_handling_fees`
--
ALTER TABLE `lixi_handling_fees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `currency_cde` (`currency_code`);

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
-- Indexes for table `recipients`
--
ALTER TABLE `recipients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
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
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_unique_email` (`email`);

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
  ADD UNIQUE KEY `card_number` (`card_number`),
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
  ADD KEY `code` (`code`);

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
-- AUTO_INCREMENT for table `billing_address`
--
ALTER TABLE `billing_address`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=33;
--
-- AUTO_INCREMENT for table `buy_phone_card`
--
ALTER TABLE `buy_phone_card`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `currency_type`
--
ALTER TABLE `currency_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT for table `lixi_exchange_rates`
--
ALTER TABLE `lixi_exchange_rates`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `lixi_fees`
--
ALTER TABLE `lixi_fees`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `lixi_handling_fees`
--
ALTER TABLE `lixi_handling_fees`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `lixi_orders`
--
ALTER TABLE `lixi_orders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT for table `lixi_order_gifts`
--
ALTER TABLE `lixi_order_gifts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `money_level`
--
ALTER TABLE `money_level`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `recipients`
--
ALTER TABLE `recipients`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `support_locale`
--
ALTER TABLE `support_locale`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `top_up_mobile_phone`
--
ALTER TABLE `top_up_mobile_phone`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `traders`
--
ALTER TABLE `traders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `user_bank_accounts`
--
ALTER TABLE `user_bank_accounts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `user_cards`
--
ALTER TABLE `user_cards`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `user_money_level`
--
ALTER TABLE `user_money_level`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `user_secret_code`
--
ALTER TABLE `user_secret_code`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `vatgia_products`
--
ALTER TABLE `vatgia_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=258;
--
-- AUTO_INCREMENT for table `vtc_response_code`
--
ALTER TABLE `vtc_response_code`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `vtc_service_code`
--
ALTER TABLE `vtc_service_code`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
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
-- Constraints for table `buy_phone_card`
--
ALTER TABLE `buy_phone_card`
  ADD CONSTRAINT `buy_phone_card_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `lixi_orders` (`id`),
  ADD CONSTRAINT `buy_phone_card_ibfk_2` FOREIGN KEY (`recipient`) REFERENCES `recipients` (`id`),
  ADD CONSTRAINT `buy_phone_card_ibfk_3` FOREIGN KEY (`vtc_code`) REFERENCES `vtc_service_code` (`code`);

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
  ADD CONSTRAINT `lixi_category_ibfk_1` FOREIGN KEY (`vatgia_id`) REFERENCES `vatgia_category` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `lixi_category_ibfk_2` FOREIGN KEY (`locale_code`) REFERENCES `support_locale` (`code`);

--
-- Constraints for table `lixi_exchange_rates`
--
ALTER TABLE `lixi_exchange_rates`
  ADD CONSTRAINT `lixi_exchange_rates_ibfk_1` FOREIGN KEY (`currency`) REFERENCES `currency_type` (`code`);

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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
