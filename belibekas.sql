-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 03, 2024 at 10:24 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `belibekas`
--

-- --------------------------------------------------------

--
-- Table structure for table `alamat`
--

CREATE TABLE `alamat` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `alamat` text NOT NULL,
  `kota` varchar(50) NOT NULL,
  `provinsi` varchar(50) NOT NULL,
  `kode_pos` varchar(10) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `detail_transaksi`
--

CREATE TABLE `detail_transaksi` (
  `id` int(11) NOT NULL,
  `transaksi_id` int(11) NOT NULL,
  `produk_id` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `keranjang`
--

CREATE TABLE `keranjang` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `keranjang_detail`
--

CREATE TABLE `keranjang_detail` (
  `id` int(11) NOT NULL,
  `keranjang_id` int(11) NOT NULL,
  `produk_id` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `nim` varchar(15) NOT NULL,
  `jurusan` varchar(50) DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `notelp` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `penjual`
--

CREATE TABLE `penjual` (
  `id` int(11) NOT NULL,
  `toko_nama` varchar(100) NOT NULL,
  `toko_deskripsi` text DEFAULT NULL,
  `alamat_toko` text NOT NULL,
  `notelp_toko` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id` int(11) NOT NULL,
  `penjual_id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `foto_produk` varchar(255) DEFAULT NULL,
  `harga` decimal(10,2) NOT NULL,
  `stok` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `kategori` enum('fashion','elektronik','perlengkapan','buku','kecantikan','otomotif') DEFAULT NULL,
  `warna` varchar(50) DEFAULT NULL,
  `ukuran` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `review_toko`
--

CREATE TABLE `review_toko` (
  `id` int(11) NOT NULL,
  `penjual_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` between 1 and 5),
  `komentar` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `alamat_id` int(11) NOT NULL,
  `total_harga` decimal(10,2) NOT NULL,
  `status` enum('pending','selesai','dibatalkan') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `ktm` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `notelp` varchar(15) DEFAULT NULL,
  `role` enum('admin','mahasiswa','penjual') DEFAULT 'mahasiswa',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alamat`
--
ALTER TABLE `alamat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaksi_id` (`transaksi_id`),
  ADD KEY `produk_id` (`produk_id`);

--
-- Indexes for table `keranjang`
--
ALTER TABLE `keranjang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `keranjang_detail`
--
ALTER TABLE `keranjang_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `keranjang_id` (`keranjang_id`),
  ADD KEY `produk_id` (`produk_id`);

--
-- Indexes for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nim` (`nim`);

--
-- Indexes for table `penjual`
--
ALTER TABLE `penjual`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id`),
  ADD KEY `penjual_id` (`penjual_id`);

--
-- Indexes for table `review_toko`
--
ALTER TABLE `review_toko`
  ADD PRIMARY KEY (`id`),
  ADD KEY `penjual_id` (`penjual_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `alamat_id` (`alamat_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alamat`
--
ALTER TABLE `alamat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `keranjang`
--
ALTER TABLE `keranjang`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `keranjang_detail`
--
ALTER TABLE `keranjang_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `review_toko`
--
ALTER TABLE `review_toko`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `alamat`
--
ALTER TABLE `alamat`
  ADD CONSTRAINT `alamat_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  ADD CONSTRAINT `detail_transaksi_ibfk_1` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `detail_transaksi_ibfk_2` FOREIGN KEY (`produk_id`) REFERENCES `produk` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `keranjang`
--
ALTER TABLE `keranjang`
  ADD CONSTRAINT `keranjang_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `keranjang_detail`
--
ALTER TABLE `keranjang_detail`
  ADD CONSTRAINT `keranjang_detail_ibfk_1` FOREIGN KEY (`keranjang_id`) REFERENCES `keranjang` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `keranjang_detail_ibfk_2` FOREIGN KEY (`produk_id`) REFERENCES `produk` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD CONSTRAINT `mahasiswa_ibfk_1` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `penjual`
--
ALTER TABLE `penjual`
  ADD CONSTRAINT `penjual_ibfk_1` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `produk`
--
ALTER TABLE `produk`
  ADD CONSTRAINT `produk_ibfk_1` FOREIGN KEY (`penjual_id`) REFERENCES `penjual` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `review_toko`
--
ALTER TABLE `review_toko`
  ADD CONSTRAINT `review_toko_ibfk_1` FOREIGN KEY (`penjual_id`) REFERENCES `penjual` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `review_toko_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`alamat_id`) REFERENCES `alamat` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
