-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: localhost
-- Thời gian đã tạo: Th4 22, 2023 lúc 05:00 PM
-- Phiên bản máy phục vụ: 10.4.27-MariaDB
-- Phiên bản PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `Tomato_Pizza`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `Bill`
--

CREATE TABLE `Bill` (
  `id_bill` int(10) NOT NULL,
  `id_user` int(10) NOT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `id_voucher` int(10) DEFAULT NULL,
  `delivery_address` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `Bill`
--

INSERT INTO `Bill` (`id_bill`, `id_user`, `create_at`, `id_voucher`, `delivery_address`) VALUES
(1, 1, '2023-04-22 21:58:08', 2, 'Linh đông'),
(2, 2, '2023-04-22 21:58:08', NULL, 'Thủ đức');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `bill_detail`
--

CREATE TABLE `bill_detail` (
  `id_bill_detail` int(10) NOT NULL,
  `id_bill` int(10) NOT NULL,
  `id_product` int(10) NOT NULL,
  `quantity` int(10) NOT NULL,
  `id product_option` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `bill_detail`
--

INSERT INTO `bill_detail` (`id_bill_detail`, `id_bill`, `id_product`, `quantity`, `id product_option`) VALUES
(1, 1, 30, 5, 1),
(2, 1, 31, 6, 2),
(3, 2, 35, 5, 3),
(4, 2, 37, 6, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `Cart`
--

CREATE TABLE `Cart` (
  `id_cart` int(10) NOT NULL,
  `id_user` int(10) NOT NULL,
  `id_voucher` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `Cart`
--

INSERT INTO `Cart` (`id_cart`, `id_user`, `id_voucher`) VALUES
(1, 1, NULL),
(2, 3, 1),
(3, 2, 3);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `Category`
--

CREATE TABLE `Category` (
  `id_category` int(10) NOT NULL,
  `name_category` varchar(255) NOT NULL,
  `parent_id` int(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `Category`
--

INSERT INTO `Category` (`id_category`, `name_category`, `parent_id`) VALUES
(1, 'Pizza', 0),
(2, 'Món phụ', 0),
(3, 'Tráng miệng', 0),
(4, 'Thức uống', 0),
(5, 'Hải sản', 1),
(6, 'Bò', 1),
(7, 'Gà', 1),
(8, 'Heo', 1),
(9, 'Ăn chay', 1),
(10, 'Gà', 2),
(11, 'Heo', 2),
(12, 'Ăn chay', 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `Detail_Cart`
--

CREATE TABLE `Detail_Cart` (
  `id_detail_cart` int(10) NOT NULL COMMENT 'chi tiết của giỏ hàng',
  `id_cart` int(10) NOT NULL COMMENT 'chỉ tới giỏ hàng, của ai...',
  `id_product` int(10) NOT NULL COMMENT 'sản phẩm gì trong bảng cart',
  `id_product_option` int(10) NOT NULL COMMENT 'lựa chọn của sản phẩm đó',
  `quantity` int(10) NOT NULL DEFAULT 1 COMMENT 'số lượng'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `Detail_Cart`
--

INSERT INTO `Detail_Cart` (`id_detail_cart`, `id_cart`, `id_product`, `id_product_option`, `quantity`) VALUES
(1, 1, 30, 2, 1),
(2, 1, 39, 3, 1),
(3, 1, 42, 1, 1),
(4, 1, 44, 1, 1),
(5, 2, 47, 1, 2),
(6, 2, 45, 1, 1),
(7, 2, 50, 1, 3),
(8, 2, 49, 1, 1),
(9, 2, 31, 1, 5);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `option`
--

CREATE TABLE `option` (
  `id_option` int(10) NOT NULL,
  `name_option` varchar(255) NOT NULL,
  `add_price` int(10) NOT NULL COMMENT 'Giá tiền thêm khi chọn sản phẩm'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `option`
--

INSERT INTO `option` (`id_option`, `name_option`, `add_price`) VALUES
(1, 'Bánh nhỏ', 0),
(2, 'Bánh vừa', 70000),
(3, 'Bánh lớn', 170000);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `Product`
--

CREATE TABLE `Product` (
  `id_product` int(10) NOT NULL,
  `name_product` varchar(255) NOT NULL,
  `image_product` text NOT NULL COMMENT 'hình ảnh của sản phẩm',
  `quanlity_product` int(10) NOT NULL DEFAULT 100 COMMENT 'số lượng sản phẩm còn trong kho',
  `description_product` text DEFAULT NULL COMMENT 'mô tả sản phẩm',
  `price_product` int(10) NOT NULL DEFAULT 100000 COMMENT 'giá sản phẩm',
  `count_buy` int(10) NOT NULL DEFAULT 0 COMMENT 'số lượng mua hàng',
  `id_category` int(10) NOT NULL COMMENT 'khoá ngoại '
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `Product`
--

INSERT INTO `Product` (`id_product`, `name_product`, `image_product`, `quanlity_product`, `description_product`, `price_product`, `count_buy`, `id_category`) VALUES
(1, 'Chocochips (Đế mỏng giòn)', 'MENU-PC_choco-pizza-1.jpg', 519, 'Sô-cô-la chip Đen Và Trắng, Xốt Sô-cô-la Đen, Phô Mai Mozarella, Xốt Kem Chua, Đế Mỏng Giòn\r\n', 39000, 886, 3),
(2, 'Bánh Cuộn Quế Xốt Sữa Đặc', 'PC-Cinnamon-Roll-1.jpg', 92, 'Bánh Cuộn Mềm Xốp, Bột Đường Quế, Bơ, Sữa Đặc\r\n', 49000, 987, 3),
(3, 'Bánh Sô-Cô-La Đút Lò', 'choco.jpg', 986, 'Bánh Sô-Cô-La Nguyên Chất\r\n', 49000, 466, 3),
(4, 'Bánh Cuộn Quế Xốt Sô-Cô-La', 'PC-Chocolate-Roll-1.jpg', 317, 'Bánh Cuộn Mềm Xốp, Sô-cô-la chip Đen Và Trắng, Xốt Sô-cô-la Đen\r\n', 49000, 580, 3),
(5, 'Chocochips (Đế dày xốp)', 'MENU-PC_choco-pizza-1.jpg', 384, 'Sô-cô-la chip Đen Và Trắng, Xốt Sô-cô-la Đen, Phô Mai Mozarella, Xốt Kem Chua, Đế Dày Xốp\r\n', 39000, 479, 3),
(6, 'Bánh Cuộn Quế Xốt Kem Sữa', 'MENU-PC-Cinnamon-Roll-1-nen-xam_360X240px.jpg', 335, 'Bánh Cuộn Mềm Xốp, Bột Đường Quế, Bơ, Xốt Kem Sữa\r\n', 49000, 286, 3),
(7, 'Chai Coca-Cola 1.5L', 'coke-1.5.jpg', 348, NULL, 39000, 578, 4),
(8, 'Lon Coca-Cola zero 320ml', 'coke-zero.jpg', 770, NULL, 25000, 983, 4),
(9, 'Chai Sprite 390ml', 'Sprite-390.jpg', 899, NULL, 25000, 90, 4),
(10, 'Chai Coca-Cola Zero Sugar 1.5L', 'MENU-MB_Coca-Zero-1L5_trang.png', 776, NULL, 39000, 495, 4),
(11, 'Chai Fanta 390ml', 'fanta-390.jpg', 24, NULL, 25000, 133, 4),
(12, 'Nước suối Dasani 510ml', 'daisani.jpg', 628, NULL, 25000, 929, 4),
(13, 'Chai Coca-Cola 390ml', 'coke-390.jpg', 897, NULL, 25000, 800, 4),
(14, 'CHAI SPRITE 1.85L', 'Sprite-1.5L.jpg', 889, NULL, 39000, 476, 4),
(15, 'Nước Suối Dasani 1.5L', 'Dasani15L.jpg', 533, NULL, 39000, 887, 4),
(16, 'Chai Fanta 1.5L', 'fanta-1.5.jpg', 370, NULL, 39000, 887, 4),
(17, 'Lon Coca-Cola plus 320ml', 'coke-light.jpg', 840, NULL, 25000, 470, 4),
(18, 'CHANH DÂY HẠT CHIA 350ML', 'FUZETEA-CHANH-D%C3%82Y-H%E1%BA%A0T-CHIA-PC-nen-trang_360X240px.png', 685, NULL, 25000, 616, 4),
(19, 'Trà đào hạt chia 350ml', 'dao-hat-chia.jpg', 24, NULL, 25000, 461, 4),
(20, 'Khai Vị Tổng Hợp', 'Khai-V%E1%BB%8B-T%E1%BB%95ng-H%E1%BB%A3p-PC-nen-xam_360X240px.jpg', 926, '2 miếng Cánh gà nướng BBQ, 3 miếng Xúc Xích Xông Khói Đút Lò và Khoai tây phô mai đút lò\r\n', 99000, 669, 10),
(21, 'Gà Viên Phô Mai Đút Lò', 'MENU-PC-G%C3%A0-Vi%C3%AAn-Ph%C3%B4-Mai-%C4%90%C3%BAt-L%C3%B2.jpg', 652, 'Gà Viên Popcorn, Thịt Heo Xông Khói, Phô Mai Mozarella, Xốt Pizza\r\n', 69000, 263, 10),
(22, 'Bánh Mì Nướng Phô Mai', 'banh-mi-pho-mai.jpg', 277, 'Bánh Mì, Bơ, Phô Mai, Bột Tỏi, Xốt Pizza\r\n', 59000, 519, 12),
(23, 'Bánh Mì Nướng Bơ Tỏi', 'banh-mi-bo-toi.jpg', 396, 'Bánh Mì, Bơ, Bột Tỏi, Xốt Pizza\r\n', 39000, 64, 12),
(24, 'Cánh Gà BBQ Kiểu Mỹ (4 miếng)', 'MENU-PC_Ca%CC%81nh-Ga%CC%80-BBQ-Kie%CC%82%CC%89u-My%CC%83-.jpg', 645, 'Cánh Gà, Xốt BBQ\r\n', 99000, 840, 10),
(25, 'Gà Không Xương BBQ', 'MENU-MB_GA%CC%80-KHO%CC%82NG-XU%CC%9BO%CC%9BNG-BBQ.jpg', 25, 'Gà Không Xương, Xốt BBQ\r\n', 89000, 308, 10),
(26, 'Xúc Xích Xông Khói Đút Lò (8 miếng)', 'MENU-MB_Xu%CC%81c-Xi%CC%81ch-Xo%CC%82ng-Kho%CC%81i-%C4%90u%CC%81t-Lo%CC%80.jpg', 769, 'Xúc Xích Xông Khói, Xốt BBQ\r\n', 89000, 995, 11),
(27, 'Xúc Xích Xông Khói Đút Lò (4 miếng)', 'MENU-MB_Xu%CC%81c-Xi%CC%81ch-Xo%CC%82ng-Kho%CC%81i-%C4%90u%CC%81t-Lo%CC%80+-+4.jpg', 170, 'Xúc Xích Xông Khói, Xốt BBQ\r\n', 49000, 622, 11),
(28, 'Cánh Gà BBQ Kiểu Mỹ (6 miếng)', 'MENU-PC_Ca%CC%81nh-Ga%CC%80-BBQ-Kie%CC%82%CC%89u-My%CC%83-.jpg', 267, 'Cánh Gà, Xốt BBQ\r\n', 129000, 204, 10),
(29, 'Khoai Tây Phô Mai Đút Lò', 'MENU-PC_Khoai-Ta%CC%82y-Pho%CC%82-Mai-%C4%90u%CC%81t-Lo%CC%80.jpg', 188, 'Khoai Tây, Thịt Heo Xông Khói, Phô Mai\r\n', 49000, 825, 11),
(30, 'Pizza Lạp Xưởng Xốt Trứng Muối Mayonnaise - Saigon Mania', 'Pizza-lap-xuong-1.jpg', 608, 'Lạp xưởng tươi, xốt trứng muối, xốt Mayonnaise dịu ngọt, ruốc khô (tép khô), bắp ngọt, hành lá, phô mai Mozzarella, xốt cà chua.\r\n', 209000, 832, 5),
(31, 'Pizza Thập Cẩm Thượng Hạng - Extravaganza', 'Extravaganza-thong-tin.jpg', 115, 'Xốt Cà Chua, Phô Mai Mozzarella, Xúc Xích Pepperoni, Thịt Dăm Bông, Xúc Xich Ý, Thịt Bò Viên, Ớt Chuông Xanh, Nấm Mỡ, Hành Tây, Ô-liu\r\n', 209000, 382, 8),
(32, 'Pizza Bò &amp; Tôm Nướng Kiểu Mỹ - Surf &amp; Turf', 'Surf-turf-thong-tin.jpg', 448, 'Xốt Cà Chua, Xốt Phô Mai, Phô Mai Mozzarella, Tôm, Thịt Bò Mexico, Cà Chua, Hành Tây\r\n', 209000, 70, 6),
(33, 'Pizza Bò Mê-Hi-Cô Thượng Hạng - Prime Beef', 'Prime-beef-thong-tin.jpg', 815, 'Xốt phô mai, Xốt cà chua, bò viên kiểu Ý, thịt bò Mexico, hành tây, cà chua, phô mai Mozzarella\r\n', 209000, 691, 6),
(34, 'Pizza Rau Củ Thập Cẩm - Veggie Mania', 'Veggie-mania-thong-tin.jpg', 289, 'Xốt Cà Chua, Phô Mai Mozzarella, Hành Tây, Ớt Chuông Xanh, Ô-liu, Nấm Mỡ, Cà Chua, Thơm (dứa)\r\n', 159000, 63, 9),
(35, 'Pizza Xúc Xích Xốt Phô Mai - Sausage Kid Mania', 'Sausage-Kid-Maniat.jpg', 196, 'Xốt phô mai, Phô mai Mozzarella, Xúc Xích, Thịt Heo Muối, Bắp (Ngô), Thơm (Dứa)\r\n', 179000, 470, 8),
(36, 'Pizza Gà Phô Mai Thịt Heo Xông Khói - Cheesy Chicken Bacon', 'Cheesy-chicken-bacon-thong-tin+(2).jpg', 270, 'Xốt Phô Mai, Thịt Gà, Thịt Heo Muối, Phô Mai Mozzarella, Cà Chua\r\n', 179000, 470, 7),
(37, 'Pizza Thập Cẩm Thượng Hạng - Extravaganza', 'Extravaganza-thong-tin.jpg', 858, 'Xốt Cà Chua, Phô Mai Mozzarella, Xúc Xích Pepperoni, Thịt Dăm Bông, Xúc Xich Ý, Thịt Bò Viên, Ớt Chuông Xanh, Nấm Mỡ, Hành Tây, Ô-liu\r\n', 209000, 949, 6),
(38, 'Pizza 5 Loại Thịt Thượng Hạng - Meat Lovers', 'meat-lover-detail.jpg', 459, 'Xốt Cà Chua, Phô Mai Mozzarella, Xúc Xích Pepperoni, Thịt Dăm Bông, Xúc Xich Ý, Thịt Bò Viên, Thịt Heo Muối\r\n', 209000, 413, 8),
(39, 'Pizza Hải Sản Xốt Cà Chua - Seafood Delight', 'Seafood-delight-detail+(1)-compressed.jpg', 134, 'Xốt Cà Chua, Phô Mai Mozzarella, Tôm, Mực, Thanh Cua, Hành Tây\r\n', 209000, 370, 5),
(40, 'Pizza Dăm Bông Dứa Kiểu Hawaii - Hawaiian', 'Hawaiian-detail.jpg', 871, 'Xốt Cà Chua, Phô Mai Mozzarella, Thịt Dăm Bông, Thơm\r\n', 179000, 318, 8),
(41, 'Pizza Lạp Xưởng Xốt Trứng Muối Mayonnaise - Saigon Mania', 'Pizza-lap-xuong-1.jpg', 564, 'Lạp xưởng tươi, xốt trứng muối, xốt Mayonnaise dịu ngọt, ruốc khô (tép khô), bắp ngọt, hành lá, phô mai Mozzarella, xốt cà chua.\r\n', 209000, 669, 8),
(42, 'Pizza Hải Sản Nhiệt Đới', 'Pizzaminsea-thong-tin-1.jpg', 587, 'Xốt Tiêu - Pizzamin Sea\r\n', 209000, 791, 5),
(43, 'Pizza Gà Xốt Tương Kiểu Nhật - Teriyaki Chicken', 'Teriyaki-chicken-detail.jpg', 633, 'Xốt Teriyaki, Phô Mai Mozzarella, Mayonnaise, Gà, Nấm Mỡ, Hành Tây\r\n', 179000, 892, 7),
(44, 'Pizza Bò &amp; Tôm Nướng Kiểu Mỹ - Surf &amp; Turf', 'Surf-turf-thong-tin.jpg', 567, 'Xốt Cà Chua, Xốt Phô Mai, Phô Mai Mozzarella, Tôm, Thịt Bò Mexico, Cà Chua, Hành Tây\r\n', 209000, 964, 5),
(45, 'Pizza Phô Mai Hảo Hạng - Cheese Mania', 'Cheese-mania-detail.jpg', 501, 'Xốt Cà Chua, phô Mai Mozzarella\r\n', 159000, 230, 9),
(46, 'Pizza Xúc Xích Ý Truyền Thống - Pepperoni Feast', 'Pepperoni-feast-thong-tin.jpg', 99, 'Xốt Cà Chua, Phô Mai Mozzarella, Xúc Xích Pepperoni\r\n', 209000, 153, 8),
(47, 'Pizza Gà Phô Mai Thịt Heo Xông Khói - Cheesy Chicken Bacon', 'Cheesy-chicken-bacon-thong-tin+(2).jpg', 19, 'Xốt Phô Mai, Thịt Gà, Thịt Heo Muối, Phô Mai Mozzarella, Cà Chua\r\n', 179000, 450, 8),
(48, 'Pizza Bò Beefsteak Phô Mai Kiểu New York - New York CheeseSteak', 'menu-chi-tie%CC%82%CC%81t-PC_LTO-NewYork.jpg', 560, 'Bò Beefsteak, Xốt Demi-Glace (Xốt Bít Tết), Xốt Kem Chua, Phô Mai Mozzarella, Nấm, Cà Chua, Hành Tây, Bột Rong Biển.\r\n', 219000, 375, 6),
(49, 'Pizza 5 Loại Thịt Thượng Hạng - Meat Lovers', 'meat-lover-detail.jpg', 503, 'Xốt Cà Chua, Phô Mai Mozzarella, Xúc Xích Pepperoni, Thịt Dăm Bông, Xúc Xich Ý, Thịt Bò Viên, Thịt Heo Muối\r\n', 209000, 705, 6),
(50, 'Pizza Hải Sản Xốt Mayonnaise - Ocean Mania', 'Ocean-mania-thong-tin.jpg', 991, 'Xốt Mayonnaise , Phô Mai Mozzarella, Tôm, Mực, Thanh Cua, Hành Tây\r\n', 209000, 597, 5);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `Product_Option`
--

CREATE TABLE `Product_Option` (
  `id_product_option` int(10) NOT NULL,
  `id_product` int(10) NOT NULL,
  `id_option` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `Product_Option`
--

INSERT INTO `Product_Option` (`id_product_option`, `id_product`, `id_option`) VALUES
(1, 30, 1),
(2, 30, 2),
(3, 30, 3),
(4, 31, 1),
(5, 31, 2),
(6, 31, 3),
(7, 32, 1),
(8, 32, 2),
(9, 32, 3),
(10, 33, 1),
(11, 33, 2),
(12, 33, 3),
(13, 34, 1),
(14, 34, 2),
(15, 34, 3),
(16, 35, 1),
(17, 35, 2),
(18, 35, 3),
(19, 36, 1),
(20, 36, 2),
(21, 36, 3),
(22, 37, 1),
(23, 37, 2),
(24, 37, 3),
(25, 38, 1),
(26, 38, 2),
(27, 38, 3),
(28, 39, 1),
(29, 39, 2),
(30, 39, 3),
(31, 40, 1),
(32, 40, 2),
(33, 40, 3),
(34, 41, 1),
(35, 41, 2),
(36, 41, 3),
(37, 42, 1),
(38, 42, 2),
(39, 42, 3),
(40, 43, 1),
(41, 43, 2),
(42, 43, 3),
(43, 44, 1),
(44, 44, 2),
(45, 44, 3),
(46, 45, 1),
(47, 45, 2),
(48, 45, 3),
(49, 46, 1),
(50, 46, 2),
(51, 46, 3),
(52, 47, 1),
(53, 47, 2),
(54, 47, 3),
(55, 48, 1),
(56, 48, 2),
(57, 48, 3),
(58, 49, 1),
(59, 49, 2),
(60, 49, 3),
(61, 50, 1),
(62, 50, 2),
(63, 50, 3);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `User`
--

CREATE TABLE `User` (
  `id_user` int(10) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `role` bit(1) NOT NULL DEFAULT b'0' COMMENT '0:user / 1: admin',
  `gender` bit(1) NOT NULL DEFAULT b'0' COMMENT '0:nam / 1:nữ',
  `create_at` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `User`
--

INSERT INTO `User` (`id_user`, `username`, `email`, `password`, `phone_number`, `avatar`, `role`, `gender`, `create_at`) VALUES
(1, 'Nguyễn Tâm An', '21211TT3528@mail.tdc.edu.vn', '21211TT3528@mail.tdc.edu.vn', '0765443252', NULL, b'1', b'0', '2023-04-22'),
(2, 'Võ Văn Duy', 'vovanduy@mail.tdc.edu.vn', 'vovanduy@mail.tdc.edu.vn', '001122334455', NULL, b'1', b'0', '2023-04-22'),
(3, 'Võ Thị Hồng Tư', 'hongtu@mail.tdc.edu.vn', 'hongtu@mail.tdc.edu.vn', '1234567890', NULL, b'1', b'1', '2023-04-22');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `Voucher`
--

CREATE TABLE `Voucher` (
  `id_voucher` int(10) NOT NULL,
  `code_voucher` text NOT NULL,
  `discount` int(10) NOT NULL COMMENT 'giảm giá xxx,xxx VND',
  `used` bit(8) NOT NULL DEFAULT b'0' COMMENT '0:Chưa dùng / 1:Đã dùng',
  `expiry` date NOT NULL COMMENT 'Hạn sử dụng'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Đang đổ dữ liệu cho bảng `Voucher`
--

INSERT INTO `Voucher` (`id_voucher`, `code_voucher`, `discount`, `used`, `expiry`) VALUES
(1, '123', 123000, b'00000000', '2023-04-19'),
(2, '234', 2000, b'00000001', '2023-04-25'),
(3, '$2b$12$Hhh7IpMvPVIb1AYgOFVGP.6l2NCjzRa.q80p6/NG29Ob27sL43.Fm', 39000, b'00000000', '2023-11-17'),
(4, '$2b$12$dQgHp3qh8VYuOA6KOty3BeQ89JJKsIp0mEZx1GN/PdeOD26thpJ5m', 55000, b'00000001', '2023-07-12'),
(5, '$2b$12$THkeYtvWdJatYDcxi.4u9.cXco2NQicgx38p2/QUrPZ.KVhv9kTE.', 72000, b'00000001', '2023-08-10'),
(6, '$2b$12$BoBA96zB96GRm0ovJCfQXupxM6ehDMesfNjs2Yq3g.cXSB3VrsCqm', 54000, b'00000001', '2023-10-31'),
(7, '$2b$12$FZGuYc2NY4A8XI81hDL.bu72i9KsIJoN3xDvUxDob4WNy.L.CPFKq', 11000, b'00000000', '2023-12-19'),
(8, '$2b$12$wE1twPA.2/x0Pfsw16bmYOhILNZXiyK45rjVXCCUx.w5tdC/aRsZe', 50000, b'00000000', '2023-05-06'),
(9, '$2b$12$pp8axq9Uyppa/F1QkovoaOSx/Q3SaX6ocdHVJLISIhIZy4EhPGjhe', 20000, b'00000000', '2023-12-30'),
(10, '$2b$12$B/hAMzMtD1y.v2BByzI4p.bbVL32T.sABxTYQIG2HZM6RxFxPl4w6', 61000, b'00000000', '2023-07-26'),
(11, '$2b$12$TTMkt1lgEIligGKyAdrE5.Q389CMDXxRZ9FQMdJv2ZZv1zImtQmsO', 35000, b'00000001', '2023-11-26'),
(12, '$2b$12$qgHwiqBqc0qiYf3eqW8i8e0AlPbHWTB0FPtE76fFlKqPbe5xFWsOC', 32000, b'00000000', '2023-07-05'),
(13, '$2b$12$06OzKxOtdWUj8dCGUm9NoeM.vZ6txc8XgeEh9UdT8/I43mo0HMnty', 52000, b'00000001', '2023-08-02'),
(14, '$2b$12$hdZoyvj6B0e1Gibx67X0S.rbT2HBUUK3ijzWTdxV1bxrzR00h.NsG', 46000, b'00000000', '2023-11-06'),
(15, '$2b$12$bSCToBiViwSykAkvE7xCbuKCCn9zn1zoZgsCcH2e.aoUmKK4soB8m', 15000, b'00000000', '2023-08-19'),
(16, '$2b$12$3FH.vgjucfDIuk3FQZ8eLO7N.7864ns6l8aybOYKMfESZSMxeXe9y', 67000, b'00000000', '2023-12-28'),
(17, '$2b$12$iFkr8uXqJvJKn4RWKGlwNOuszOGKCu6yrFRiCd9JMLREopcUkP4Ia', 9000, b'00000000', '2023-10-16'),
(18, '$2b$12$tS5ngy7mW/8jKQiqMUxzAu4I8a0j6uQDjclujKb.mcs3rts700gH.', 22000, b'00000000', '2023-08-15'),
(19, '$2b$12$oeZt2qP8Csn4JJgsmDafhutWqqpsJTswsTWn54I4GFFZmGFzmYhkW', 60000, b'00000000', '2023-07-02'),
(20, '$2b$12$ff9W/KNzf0.KQlG8lJmI9e4bFPSWFRv16VYMyqMrOuLbQ4VUvjP6e', 22000, b'00000001', '2023-10-25'),
(21, '$2b$12$BB/ozkzm51Id7iSU5l4hWe7/5xU4iBRWEZpRA9ZVpNblVMb0N3FYq', 36000, b'00000001', '2023-06-28'),
(22, '$2b$12$N6YvMvFu3kjpyJwNy2kjXOUDRIv1fwuvmf4cLhRm3dgMkLMq.GyCa', 49000, b'00000001', '2023-11-05'),
(23, '$2b$12$VSuBt8ds9dGw8.ULJgpy6uMrnCijjaFsa2EDZwLI5VD/0fDVfYNCO', 20000, b'00000001', '2023-10-27'),
(24, '$2b$12$4gHji.pMXsb8oUk4GA1bkOQ2h6DmiCnu1E.55bDER6ToqZYliZphy', 38000, b'00000001', '2023-09-25'),
(25, '$2b$12$JvaMEPHG3vmnub7WjjxJs.pC94cRxaryn8pj6ty656kjZyNH7Hhru', 42000, b'00000001', '2023-09-15'),
(26, '$2b$12$aamqJ.QawHEkUPvkWtWluugG43mob9ses52o4ipOKx22Xt6EOTY2C', 36000, b'00000001', '2023-10-27'),
(27, '$2b$12$YyAFb0dJwy9xJysqzRIEqemyz3KQUnnl9dTe4QczL1LhbGAkTpUZO', 8000, b'00000001', '2023-11-21'),
(28, '$2b$12$wKtwfMXpizCHmXGYiXJWCOoGt8.nEg0bK2SVrHagAuyAA7wQ25vti', 44000, b'00000001', '2023-09-06'),
(29, '$2b$12$dQgHp3qh8VYuOA6KOty3BeQ89JJKsIp0mEZx1GN/PdeOD26thpJ5m', 55000, b'00000001', '2023-07-12'),
(30, '$2b$12$/PBNGe29I2/I2q7JS1eC..nJWxnwhXrcym7RENVc9dEXDgDWnw8cC', 55000, b'00000000', '2023-08-22'),
(31, '$2b$12$YQxF.Tg3LOH75xvWV27jUeRHprf4rYMqhreIH9VmuJVvhUTamVqAO', 67000, b'00000000', '2023-07-11'),
(32, '$2b$12$kE4WXWjEuK3sk8sNVLjlnOC7OAZL3pNuFUCbcP/RLVWRSCxbslk8q', 29000, b'00000000', '2023-09-20'),
(33, '$2b$12$nUpeeI3DWlghg6Ih8rxClOlulC.XgfeVN//fa084kg5aZbqj2MA56', 65000, b'00000000', '2023-11-18'),
(34, '$2b$12$9gISObP7w9VW3oETjx0TDOIM/U0vGy7xYkiCDM2qDwqZUqO3GJGay', 62000, b'00000001', '2023-08-02'),
(35, '$2b$12$IRPInksWKIyRLWxk2UJLqO5NrOPkit6dJEkmbIncUOr6PjjOp8ASG', 63000, b'00000000', '2023-12-14'),
(36, '$2b$12$THbGTA/gui/jXSPAPO/b6OH./6H5cVI7MylyEhIsAHNSzDpf3RnNu', 16000, b'00000001', '2023-08-26'),
(37, '$2b$12$c95t9h6hvgMn3NB9FRrXZOmXA66L6xZo5VhcmGdkBcnbA0DLk5U2i', 32000, b'00000001', '2023-07-30'),
(38, '$2b$12$ZEeNt1VboLOlu8d9.BCCOujjwsnB002ek67NT97h/b28OsC.zIoly', 51000, b'00000000', '2023-12-31'),
(39, '$2b$12$WuAwPn/DzYTVnplj1s2uduPar1TwzM9JMoRSM.8BK.0KsZoTw00O.', 72000, b'00000001', '2023-11-04'),
(40, '$2b$12$GkV.9PXA4lNh6Nvgm4S1Eu19x/tBrfo1OPUrNFaHJ0NjXAY.Ibfj.', 35000, b'00000000', '2023-12-20'),
(41, '$2b$12$pA3TLIGRf7uWlVT2HxJOf.SH8f5WLGywyn7I0I5T7XQMHQqHg47aG', 36000, b'00000000', '2023-07-02'),
(42, '$2b$12$UptgH2bM7kuy2hEzMrVD3O6psnsvqHyJ.vtkGrs4MqGD3DJsI8Q0C', 71000, b'00000001', '2023-08-31'),
(43, '$2b$12$URC.8Db2YhdQOkSEymS.suo1raMEdOkrdwWfp6qrzN7eOxGbc3a.W', 22000, b'00000000', '2023-10-09'),
(44, '$2b$12$wYk3jtKRCVfLJSO54anoquSrFQFyiHLqZOcP8JV/ySy09HOclDYV.', 18000, b'00000001', '2023-11-12'),
(45, '$2b$12$xqmDAOy7LW7zuuemoZ1kZu0l.ldR.q0LHIFHcqhV561k5xPtIjmoC', 32000, b'00000000', '2023-10-03'),
(46, '$2b$12$2ydJd.SREH.fpBApLdJxBuwnjHTJ6gyv3m/N9eSm7caTeuL4E0Tne', 2000, b'00000001', '2023-10-08'),
(47, '$2b$12$.AwYUehHOvFK16SU6azl1OweVRSWaTvbuVSxV2IR4IcI89O50YCXO', 75000, b'00000001', '2023-06-20'),
(48, '$2b$12$GBqSWhroJzd00VhmFJ4L4eEM.bX6pT95ddk4e8WIpwzwHt1giU4Ty', 56000, b'00000001', '2023-05-26'),
(49, '$2b$12$I59FpBDsrycHLW0AcFiCAu3T2elt1Q.wlwOv9vFCdEUJRGWdbReyy', 25000, b'00000000', '2023-12-22'),
(50, '$2b$12$79gxSBoHS1kfp5f6d.QjBe1ucntkkyAWc2XKyoPRHHjrxd0qo9pWG', 3000, b'00000000', '2023-10-18'),
(51, '$2b$12$FI4fC8lqmNI.ebNjJbN8W.hTWBCJFguskGLQoEeJ9JhxXNX9xHeV6', 70000, b'00000000', '2023-12-07'),
(52, '$2b$12$JvHxK8OZ/fO88M2zHKV6N.iCkJVTmyi5jyoW6PqNiaDtkCTaDcBd6', 30000, b'00000000', '2023-05-15'),
(53, '$2b$12$roQW5yuwXKA86AfnFEm.nue.5s58qM9IaOee.jCK7U.YfGcgg70nG', 51000, b'00000001', '2023-05-18'),
(54, '$2b$12$Q5TTwgRPbZNgW34DBRy27u9OVraeyGDrpZJvYEWVvvPqu5hqZIdX.', 80000, b'00000001', '2023-12-20'),
(55, '$2b$12$DsowHXUVWjwLor5TT5CGnO4kqXwa1zgMXX14eP7yIPoQYaTH7EX6C', 69000, b'00000000', '2023-10-16');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `Bill`
--
ALTER TABLE `Bill`
  ADD PRIMARY KEY (`id_bill`);

--
-- Chỉ mục cho bảng `bill_detail`
--
ALTER TABLE `bill_detail`
  ADD PRIMARY KEY (`id_bill_detail`);

--
-- Chỉ mục cho bảng `Cart`
--
ALTER TABLE `Cart`
  ADD PRIMARY KEY (`id_cart`);

--
-- Chỉ mục cho bảng `Category`
--
ALTER TABLE `Category`
  ADD PRIMARY KEY (`id_category`);

--
-- Chỉ mục cho bảng `Detail_Cart`
--
ALTER TABLE `Detail_Cart`
  ADD PRIMARY KEY (`id_detail_cart`);

--
-- Chỉ mục cho bảng `option`
--
ALTER TABLE `option`
  ADD PRIMARY KEY (`id_option`);

--
-- Chỉ mục cho bảng `Product`
--
ALTER TABLE `Product`
  ADD PRIMARY KEY (`id_product`);

--
-- Chỉ mục cho bảng `Product_Option`
--
ALTER TABLE `Product_Option`
  ADD PRIMARY KEY (`id_product_option`);

--
-- Chỉ mục cho bảng `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`id_user`);

--
-- Chỉ mục cho bảng `Voucher`
--
ALTER TABLE `Voucher`
  ADD PRIMARY KEY (`id_voucher`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `Bill`
--
ALTER TABLE `Bill`
  MODIFY `id_bill` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `bill_detail`
--
ALTER TABLE `bill_detail`
  MODIFY `id_bill_detail` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `Cart`
--
ALTER TABLE `Cart`
  MODIFY `id_cart` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `Category`
--
ALTER TABLE `Category`
  MODIFY `id_category` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT cho bảng `Detail_Cart`
--
ALTER TABLE `Detail_Cart`
  MODIFY `id_detail_cart` int(10) NOT NULL AUTO_INCREMENT COMMENT 'chi tiết của giỏ hàng', AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT cho bảng `option`
--
ALTER TABLE `option`
  MODIFY `id_option` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `Product`
--
ALTER TABLE `Product`
  MODIFY `id_product` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT cho bảng `Product_Option`
--
ALTER TABLE `Product_Option`
  MODIFY `id_product_option` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT cho bảng `User`
--
ALTER TABLE `User`
  MODIFY `id_user` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `Voucher`
--
ALTER TABLE `Voucher`
  MODIFY `id_voucher` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
