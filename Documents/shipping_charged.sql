-- phpMyAdmin SQL Dump
-- version 4.5.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 17, 2016 at 11:50 AM
-- Server version: 10.1.12-MariaDB
-- PHP Version: 5.6.19

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
-- Table structure for table `shipping_charged`
--

CREATE TABLE `shipping_charged` (
  `id` bigint(20) NOT NULL,
  `order_from` double NOT NULL,
  `order_to_end` double NOT NULL,
  `charged_amount` double NOT NULL,
  `created_date` datetime NOT NULL,
  `created_by` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `shipping_charged`
--

INSERT INTO `shipping_charged` (`id`, `order_from`, `order_to_end`, `charged_amount`, `created_date`, `created_by`) VALUES
(1, 10, 20, 2.99, '2016-08-17 10:43:40', 'yhannart@gmail.com'),
(2, 20, 40, 3.99, '2016-08-17 12:58:03', 'yhannart@gmail.com'),
(3, 40, 60, 4.99, '2016-08-17 12:58:20', 'yhannart@gmail.com'),
(4, 60, 80, 5.99, '2016-08-17 12:58:32', 'yhannart@gmail.com'),
(5, 80, 100, 6.99, '2016-08-17 12:58:50', 'yhannart@gmail.com'),
(6, 100, 120, 7.99, '2016-08-17 12:59:00', 'yhannart@gmail.com'),
(8, 120, 150, 8.99, '2016-08-17 13:42:24', 'yhannart@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `shipping_charged`
--
ALTER TABLE `shipping_charged`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `shipping_charged`
--
ALTER TABLE `shipping_charged`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
