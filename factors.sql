-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 05, 2018 at 02:19 AM
-- Server version: 10.1.35-MariaDB
-- PHP Version: 7.2.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ie332group11`
--

-- --------------------------------------------------------

--
-- Table structure for table `factors`
--

CREATE TABLE `factors` (
  `warehouseID` int(11) NOT NULL,
  `factor1` tinyint(1) NOT NULL,
  `factor2` tinyint(1) NOT NULL,
  `factor3` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `factors`
--

INSERT INTO `factors` (`warehouseID`, `factor1`, `factor2`, `factor3`) VALUES
(1, 1, 1, 1),
(2, 1, 1, 0),
(3, 1, 0, 1),
(4, 1, 0, 0),
(5, 0, 1, 1),
(6, 0, 0, 1),
(7, 0, 1, 0),
(8, 0, 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `factors`
--
ALTER TABLE `factors`
  ADD PRIMARY KEY (`warehouseID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `factors`
--
ALTER TABLE `factors`
  MODIFY `warehouseID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
