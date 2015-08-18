-- phpMyAdmin SQL Dump
-- version 4.4.13
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 17, 2015 at 11:13 PM
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `admin_users_authority`
--

INSERT INTO `admin_users_authority` (`id`, `admin_user_id`, `authority`) VALUES
(1, 6, 'ACCESS_ADMINISTRATION'),
(2, 6, 'SYSTEM_CONFIG_CONTROLLER'),
(5, 6, 'SYSTEM_USER_CONTROLLER'),
(25, 7, 'ACCESS_ADMINISTRATION'),
(26, 7, 'SYSTEM_CONFIG_CONTROLLER'),
(27, 7, 'SYSTEM_USER_CONTROLLER');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `authorities`
--

INSERT INTO `authorities` (`id`, `authority`, `description`) VALUES
(1, 'ACCESS_ADMINISTRATION', 'message.access_administration'),
(2, 'SYSTEM_CONFIG_CONTROLLER', 'message.system_config'),
(3, 'SYSTEM_USER_CONTROLLER', 'message.system_user');

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
  `buy` double NOT NULL,
  `sell` double NOT NULL,
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
-- Table structure for table `lixi_category`
--

CREATE TABLE IF NOT EXISTS `lixi_category` (
  `id` int(11) NOT NULL,
  `vatgia_id` int(11) NOT NULL,
  `locale_code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `created_date` datetime NOT NULL,
  `created_by` varchar(255) NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `modified_by` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lixi_category`
--

INSERT INTO `lixi_category` (`id`, `vatgia_id`, `locale_code`, `name`, `icon`, `created_date`, `created_by`, `modified_date`, `modified_by`) VALUES
(17, 2, 'en_US', 'Baby Stuffs', 'no_image.jpg', '2015-06-24 20:44:20', 'chonnh@gmail.com', NULL, NULL),
(18, 2, 'vi_VN', 'Đồ trẻ sơ sinh', 'no_image.jpg', '2015-06-24 20:44:20', 'chonnh@gmail.com', NULL, NULL),
(19, 3, 'en_US', 'Clothes', 'no_image.jpg', '2015-06-24 17:36:02', 'chonnh@gmail.com', NULL, NULL),
(20, 3, 'vi_VN', 'Quần áo', 'no_image.jpg', '2015-06-24 17:36:02', 'chonnh@gmail.com', NULL, NULL),
(21, 4, 'en_US', 'Flower box', '1439584592829.jpg', '2015-08-15 03:36:40', 'yhannart@gmail.com', NULL, NULL),
(22, 4, 'vi_VN', 'Lọ đựng hoa', '1439584600787.jpg', '2015-08-15 03:36:40', 'yhannart@gmail.com', NULL, NULL),
(27, 1, 'en_US', 'Accessories', 'no_image.jpg', '2015-08-15 04:28:46', 'yhannart@gmail.com', NULL, NULL),
(28, 1, 'vi_VN', 'Phụ Kiện', 'no_image.jpg', '2015-08-15 04:28:46', 'yhannart@gmail.com', NULL, NULL),
(29, 5, 'en_US', 'Sleep lamp', 'no_image.jpg', '2015-07-02 15:35:44', 'yhannart@gmail.com', NULL, NULL),
(30, 5, 'vi_VN', 'Đèn ngủ', 'no_image.jpg', '2015-07-02 15:35:44', 'yhannart@gmail.com', NULL, NULL),
(31, 6, 'en_US', 'Candies', '1439584539111.jpg', '2015-08-15 03:35:48', 'yhannart@gmail.com', NULL, NULL),
(32, 6, 'vi_VN', 'Sô-cô-la', '1439584539112.jpg', '2015-08-15 03:35:48', 'yhannart@gmail.com', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

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
(13, '2015-08-13', '03:24:56', 'USD', 20000, -9.05, 23000, 4.26, 'yhannart@gmail.com', '2015-08-13 03:24:56');

-- --------------------------------------------------------

--
-- Table structure for table `lixi_orders`
--

CREATE TABLE IF NOT EXISTS `lixi_orders` (
  `id` bigint(20) NOT NULL,
  `sender` bigint(20) NOT NULL,
  `lx_exchange_rate_id` bigint(20) NOT NULL,
  `lixi_status` int(11) DEFAULT NULL,
  `lixi_message` text,
  `modified_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lixi_orders`
--

INSERT INTO `lixi_orders` (`id`, `sender`, `lx_exchange_rate_id`, `lixi_status`, `lixi_message`, `modified_date`) VALUES
(39, 6, 13, 0, NULL, '2015-08-18 05:50:10'),
(40, 6, 13, 0, NULL, '2015-08-18 06:04:56'),
(41, 6, 13, 0, NULL, '2015-08-18 06:11:15');

-- --------------------------------------------------------

--
-- Table structure for table `lixi_order_gifts`
--

CREATE TABLE IF NOT EXISTS `lixi_order_gifts` (
  `id` bigint(20) NOT NULL,
  `recipient` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `amount_currency` varchar(10) NOT NULL,
  `amount` float NOT NULL,
  `category` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `product_price` float DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_image` varchar(255) DEFAULT NULL,
  `product_quantity` int(11) NOT NULL DEFAULT '1',
  `note` text,
  `bk_status` int(11) DEFAULT NULL,
  `bk_message` varchar(255) DEFAULT NULL,
  `bk_receive_method` varchar(255) DEFAULT NULL,
  `bk_updated` datetime DEFAULT NULL,
  `modified_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lixi_order_gifts`
--

INSERT INTO `lixi_order_gifts` (`id`, `recipient`, `order_id`, `amount_currency`, `amount`, `category`, `product_id`, `product_price`, `product_name`, `product_image`, `product_quantity`, `note`, `bk_status`, `bk_message`, `bk_receive_method`, `bk_updated`, `modified_date`) VALUES
(62, 6, 41, 'USD', 50, 21, 34, 250000, 'Man shirt', 'http://p.vatgia.vn/pictures_fullsize/egb1427012162.jpg', 1, 'Hello boy', 0, NULL, NULL, NULL, '2015-08-18 06:11:15');

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
  `phone` varchar(255) NOT NULL,
  `note` text NOT NULL,
  `modified_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `recipients`
--

INSERT INTO `recipients` (`id`, `sender`, `first_name`, `middle_name`, `last_name`, `email`, `phone`, `note`, `modified_date`) VALUES
(2, 6, 'Teo 1', '', 'Nguyen', 'nguyenvanteo@gmail.com', '0967007869', 'Happy Birthday', '2015-08-18 05:45:37'),
(3, 6, 'Dam', '', 'Dao', 'daothidam88@gmail.com', '0967007855', 'Hello', '2015-08-18 06:04:53'),
(5, 6, 'Chien', '', 'Chau', 'chauvanchien@gmail.com', '090912345678', 'Hello baby', '2015-08-18 02:05:06'),
(6, 6, 'Thong', 'Van', 'Chau', 'chauvanthong@gmail.com', '090123456', 'Hello boy', '2015-08-18 06:11:13'),
(7, 6, 'A', 'Van', 'Nguyen', 'nguyenvana@gmail.com', '09123456789', 'he he ddd', '2015-08-18 04:25:20');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `middle_name`, `last_name`, `email`, `password`, `phone`, `account_non_expired`, `account_non_locked`, `credentials_non_expired`, `enabled`, `activated`, `created_date`, `created_by`, `modified_date`, `modified_by`) VALUES
(6, 'Huu', 'Nguyen', 'Chon', 'chonnh@gmail.com', '$2a$10$Wmk7gOTG69sV8/tj6jl6zeSOYKwh5yYEsy85mwYjNxa8qiM7qKEbe', '0909123456', 1, 1, 1, 1, 1, '2015-04-15 04:24:23', 'chonnh@gmail.com', NULL, NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `vatgia_category`
--

CREATE TABLE IF NOT EXISTS `vatgia_category` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vatgia_category`
--

INSERT INTO `vatgia_category` (`id`, `title`) VALUES
(1, 'Accessories'),
(2, 'Baby Stuffs'),
(3, 'Clothes'),
(4, 'Flower box'),
(5, 'Sleep lamp'),
(6, 'Chocolate');

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
-- Indexes for table `currency_type`
--
ALTER TABLE `currency_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `exchange_rates`
--
ALTER TABLE `exchange_rates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trader_id` (`trader_id`),
  ADD KEY `currency_id` (`currency_id`);

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
-- Indexes for table `lixi_orders`
--
ALTER TABLE `lixi_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender` (`sender`),
  ADD KEY `lx_exchange_rate_id` (`lx_exchange_rate_id`);

--
-- Indexes for table `lixi_order_gifts`
--
ALTER TABLE `lixi_order_gifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recipient` (`recipient`),
  ADD KEY `category` (`category`),
  ADD KEY `amount_currency` (`amount_currency`),
  ADD KEY `order_id` (`order_id`);

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT for table `admin_user_password_history`
--
ALTER TABLE `admin_user_password_history`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `authorities`
--
ALTER TABLE `authorities`
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
-- AUTO_INCREMENT for table `lixi_category`
--
ALTER TABLE `lixi_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=33;
--
-- AUTO_INCREMENT for table `lixi_exchange_rates`
--
ALTER TABLE `lixi_exchange_rates`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `lixi_orders`
--
ALTER TABLE `lixi_orders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=42;
--
-- AUTO_INCREMENT for table `lixi_order_gifts`
--
ALTER TABLE `lixi_order_gifts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=63;
--
-- AUTO_INCREMENT for table `recipients`
--
ALTER TABLE `recipients`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `support_locale`
--
ALTER TABLE `support_locale`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `traders`
--
ALTER TABLE `traders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `user_secret_code`
--
ALTER TABLE `user_secret_code`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
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
  ADD CONSTRAINT `lixi_orders_ibfk_2` FOREIGN KEY (`lx_exchange_rate_id`) REFERENCES `lixi_exchange_rates` (`id`),
  ADD CONSTRAINT `lixi_orders_ibfk_1` FOREIGN KEY (`sender`) REFERENCES `users` (`id`);

--
-- Constraints for table `lixi_order_gifts`
--
ALTER TABLE `lixi_order_gifts`
  ADD CONSTRAINT `lixi_order_gifts_ibfk_1` FOREIGN KEY (`recipient`) REFERENCES `recipients` (`id`),
  ADD CONSTRAINT `lixi_order_gifts_ibfk_3` FOREIGN KEY (`amount_currency`) REFERENCES `currency_type` (`code`),
  ADD CONSTRAINT `lixi_order_gifts_ibfk_5` FOREIGN KEY (`category`) REFERENCES `lixi_category` (`id`),
  ADD CONSTRAINT `lixi_order_gifts_ibfk_6` FOREIGN KEY (`order_id`) REFERENCES `lixi_orders` (`id`);

--
-- Constraints for table `recipients`
--
ALTER TABLE `recipients`
  ADD CONSTRAINT `recipients_ibfk_1` FOREIGN KEY (`sender`) REFERENCES `users` (`id`);

--
-- Constraints for table `user_secret_code`
--
ALTER TABLE `user_secret_code`
  ADD CONSTRAINT `user_secret_code_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
