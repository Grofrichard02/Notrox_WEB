-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Gép: localhost
-- Létrehozás ideje: 2026. Ápr 01. 03:33
-- Kiszolgáló verziója: 10.11.10-MariaDB-log
-- PHP verzió: 8.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `sql_notrox_hu`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `Addresses`
--

CREATE TABLE `Addresses` (
  `Id` int(11) NOT NULL,
  `City` varchar(255) NOT NULL,
  `Zip` int(11) NOT NULL,
  `Address1` varchar(255) NOT NULL,
  `UserId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- A tábla adatainak kiíratása `Addresses`
--

INSERT INTO `Addresses` (`Id`, `City`, `Zip`, `Address1`, `UserId`, `createdAt`, `updatedAt`) VALUES
(3, 'EWGqegqa', 35235, 'wagwgwa 121', 34, '2026-03-12 19:50:45', '2026-03-12 19:50:45'),
(4, 'Budapest', 2121, 'Egfw ut 3214', 37, '2026-03-13 14:22:43', '2026-03-13 14:22:43'),
(5, 'Budapest', 1145, 'Egressy utca 6', 38, '2026-03-16 11:25:42', '2026-03-16 11:25:42'),
(6, 'Baku', 3561, 'Asdfg 123', 39, '2026-03-17 11:47:42', '2026-03-17 11:47:42'),
(7, 'gjhkuzkuzu', 2120, '201201', 41, '2026-03-18 13:25:54', '2026-03-18 13:26:05'),
(8, 'Alma', 1167, 'Thomas Shelby utca 67.', 47, '2026-03-24 14:02:27', '2026-03-25 09:24:39'),
(9, 'dsadasdsad', 3213131, '3213', 48, '2026-03-27 22:40:08', '2026-03-27 22:40:08'),
(10, 'Biatorbágy', 2051, 'Diófa utca 28', 49, '2026-03-28 18:29:09', '2026-03-28 18:29:09');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `BillingAddresses`
--

CREATE TABLE `BillingAddresses` (
  `Id` int(11) NOT NULL,
  `City` varchar(255) NOT NULL,
  `Zip` int(11) NOT NULL,
  `Address1` varchar(255) NOT NULL,
  `UserId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- A tábla adatainak kiíratása `BillingAddresses`
--

INSERT INTO `BillingAddresses` (`Id`, `City`, `Zip`, `Address1`, `UserId`, `createdAt`, `updatedAt`) VALUES
(1, 'Budapest', 1145, 'Tatla utca 54', 1, '2026-03-12 15:09:07', '2026-03-12 15:09:07'),
(2, 'adssad', 2121, 'asaddsadsas', 2, '2026-03-12 15:13:29', '2026-03-12 15:13:29'),
(3, 'EWGqegqa', 35235, 'wagwgwa 121', 34, '2026-03-12 19:50:45', '2026-03-12 19:50:45'),
(4, 'Budapest', 2121, 'Egfw ut 3214', 37, '2026-03-13 14:22:43', '2026-03-13 14:22:43'),
(5, 'Budapest', 1145, 'Egressy utca 6', 38, '2026-03-16 11:25:42', '2026-03-16 11:25:42'),
(6, 'Baku', 3561, 'Asdfg 123', 39, '2026-03-17 11:47:42', '2026-03-17 11:47:42'),
(7, 'gjhkuzkuzu', 2120, '201201', 41, '2026-03-18 13:25:54', '2026-03-18 13:26:05'),
(8, 'Budapest', 1167, 'Thomas Shelby utca 67.', 47, '2026-03-24 14:02:27', '2026-03-25 09:24:39'),
(9, 'dsadasdsad', 3213131, '3213', 48, '2026-03-27 22:40:08', '2026-03-27 22:40:08'),
(10, 'Biatorbágy', 2051, 'Diófa utca 28', 49, '2026-03-28 18:29:09', '2026-03-28 18:29:09');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `Companies`
--

CREATE TABLE `Companies` (
  `Id` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(255) NOT NULL,
  `Location` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- A tábla adatainak kiíratása `Companies`
--

INSERT INTO `Companies` (`Id`, `Name`, `Description`, `Location`, `createdAt`, `updatedAt`) VALUES
(1, 'SteelSeries', 'A SteelSeries egy dán gaming perifériákat gyártó vállalat, amely billentyűzeteket, egereket, headseteket és egyéb e-sport eszközöket készít játékosok számára.', 'Dánia', '2026-03-10 15:43:00', '2026-03-10 15:43:00'),
(2, 'Logitech', 'A Logitech egy svájci technológiai vállalat, amely számítógépes perifériák, például egerek, billentyűzetek, webkamerák és gaming eszközök fejlesztésével foglalkozik.', 'Svájc', '2026-03-10 15:43:00', '2026-03-10 15:43:00'),
(3, 'HyperX', 'A HyperX egy gamer kiegészítőket gyártó márka, amely memóriáiról, headsetjeiről, billentyűzeteiről és egereiről ismert.', 'USA', '2026-03-10 15:43:00', '2026-03-10 15:43:00'),
(4, 'Secretlab', 'A Secretlab egy prémium gamer székeket gyártó vállalat, amely ergonomikus és e-sport környezethez tervezett székekről ismert.', 'Szingapúr', '2026-03-10 15:43:00', '2026-03-10 15:43:00'),
(5, 'Endorfy', 'Az Endorfy egy lengyel márka, amely számítógépházakat, hűtéseket, tápegységeket és gaming perifériákat gyárt.', 'Lengyelország', '2026-03-10 15:43:00', '2026-03-10 15:43:00'),
(6, 'Razer', 'A Razer egy világszerte ismert gaming márka, amely gamer laptopokat, egereket, billentyűzeteket és egyéb játékosoknak szánt eszközöket gyárt.', 'Szingapúr', '2026-03-10 15:43:00', '2026-03-10 15:43:00'),
(7, 'ASUS', 'Az ASUS egy tajvani technológiai vállalat, amely alaplapokat, laptopokat, videókártyákat és gamer hardvereket fejleszt.', 'Tajvan', '2026-03-10 15:43:00', '2026-03-10 15:43:00');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `Logs`
--

CREATE TABLE `Logs` (
  `Id` int(11) NOT NULL,
  `Message` varchar(255) NOT NULL,
  `OrderId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `OrderItems`
--

CREATE TABLE `OrderItems` (
  `Id` int(11) NOT NULL,
  `OrderId` int(11) NOT NULL,
  `ProductId` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `PriceAtPurchase` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- A tábla adatainak kiíratása `OrderItems`
--

INSERT INTO `OrderItems` (`Id`, `OrderId`, `ProductId`, `Quantity`, `PriceAtPurchase`, `createdAt`, `updatedAt`) VALUES
(46, 9, 56, 1, 6990, '2026-03-16 11:26:12', '2026-03-16 11:26:12'),
(48, 11, 53, 1, 13990, '2026-03-18 13:26:30', '2026-03-18 13:26:30'),
(49, 12, 51, 2, 89990, '2026-03-27 22:41:40', '2026-03-27 22:41:40'),
(50, 13, 53, 5, 13990, '2026-03-28 18:29:42', '2026-03-28 18:29:42'),
(51, 13, 54, 2, 99990, '2026-03-28 18:29:42', '2026-03-28 18:29:42'),
(52, 14, 56, 1, 6990, '2026-03-29 09:57:42', '2026-03-29 09:57:42'),
(53, 14, 59, 3, 49990, '2026-03-29 09:57:42', '2026-03-29 09:57:42'),
(54, 14, 64, 1, 34990, '2026-03-29 09:57:42', '2026-03-29 09:57:42'),
(55, 15, 53, 1, 13990, '2026-03-30 07:46:59', '2026-03-30 07:46:59'),
(56, 15, 57, 1, 28990, '2026-03-30 07:46:59', '2026-03-30 07:46:59'),
(57, 15, 56, 1, 6990, '2026-03-30 07:46:59', '2026-03-30 07:46:59'),
(58, 15, 60, 1, 54990, '2026-03-30 07:46:59', '2026-03-30 07:46:59'),
(59, 15, 59, 1, 49990, '2026-03-30 07:46:59', '2026-03-30 07:46:59'),
(60, 15, 61, 1, 99990, '2026-03-30 07:46:59', '2026-03-30 07:46:59'),
(61, 15, 63, 1, 52990, '2026-03-30 07:46:59', '2026-03-30 07:46:59'),
(62, 15, 62, 1, 55990, '2026-03-30 07:46:59', '2026-03-30 07:46:59'),
(63, 15, 64, 1, 34990, '2026-03-30 07:46:59', '2026-03-30 07:46:59'),
(64, 16, 53, 6, 13990, '2026-03-31 19:31:47', '2026-03-31 19:31:47'),
(65, 16, 57, 2, 28990, '2026-03-31 19:31:47', '2026-03-31 19:31:47'),
(66, 16, 60, 1, 54990, '2026-03-31 19:31:47', '2026-03-31 19:31:47');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `Orders`
--

CREATE TABLE `Orders` (
  `Id` int(11) NOT NULL,
  `Date` datetime DEFAULT NULL,
  `Phase` varchar(255) NOT NULL DEFAULT 'Feldolgozás alatt',
  `UserId` int(11) NOT NULL,
  `AddressId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- A tábla adatainak kiíratása `Orders`
--

INSERT INTO `Orders` (`Id`, `Date`, `Phase`, `UserId`, `AddressId`, `createdAt`, `updatedAt`) VALUES
(9, '2026-03-16 11:26:12', 'Átadva futárnak', 38, 5, '2026-03-16 11:26:12', '2026-03-18 17:16:18'),
(10, '2026-03-17 11:47:54', 'Törölve', 39, 6, '2026-03-17 11:47:54', '2026-03-31 09:27:36'),
(11, '2026-03-18 13:26:30', 'Csomagolás kész', 41, 7, '2026-03-18 13:26:30', '2026-03-25 07:39:59'),
(12, '2026-03-27 22:41:40', 'Kiszállítás alatt', 48, 9, '2026-03-27 22:41:40', '2026-03-27 22:47:36'),
(13, '2026-03-28 18:29:42', 'Feldolgozás alatt', 49, 10, '2026-03-28 18:29:42', '2026-03-28 18:29:42'),
(14, '2026-03-29 09:57:42', 'Feldolgozás alatt', 47, 8, '2026-03-29 09:57:42', '2026-03-29 09:57:42'),
(15, '2026-03-30 07:46:59', 'Feldolgozás alatt', 47, 8, '2026-03-30 07:46:59', '2026-03-30 07:46:59'),
(16, '2026-03-31 19:31:47', 'Feldolgozás alatt', 47, 8, '2026-03-31 19:31:47', '2026-03-31 19:31:47');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `Products`
--

CREATE TABLE `Products` (
  `Id` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(255) NOT NULL,
  `Price` int(11) NOT NULL,
  `Ammount` int(11) NOT NULL,
  `CompanyId` int(11) NOT NULL,
  `IMGURL` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- A tábla adatainak kiíratása `Products`
--

INSERT INTO `Products` (`Id`, `Name`, `Description`, `Price`, `Ammount`, `CompanyId`, `IMGURL`, `createdAt`, `updatedAt`) VALUES
(50, 'SteelSeries Arctis 7', 'Vezeték nélküli gamer headset.', 49990, 0, 1, 'https://media.steelseriescdn.com/blog/posts/best-steelseries-headsets-for-pc-gaming/98b51dc311264711b4eed447d37dd75f.png', '2026-03-12 15:01:41', '2026-03-27 22:46:38'),
(51, 'SteelSeries Arctis Pro', 'Prémium gamer headset.', 89990, 0, 1, 'https://images.ctfassets.net/hmm5mo4qf4mf/i5ccdags5WckwDfYUVk7W/03a59ccd1a3f7fc5931624aedbaf7a2e/imgbuy_arctis_nova_pro_black_3_v2.png__1920x1080_crop-fit_optimize_subsampling-2-260.png', '2026-03-12 15:01:41', '2026-03-27 22:41:40'),
(52, 'SteelSeries Rival 600', 'Két szenzoros gamer egér.', 80000, 0, 1, 'https://images.ctfassets.net/hmm5mo4qf4mf/40YXOfd920tkMqbv4fdUin/ef3f925af8f9144d848c4392d25c0b3a/05_rival600_kv_top_hero.png__1920x1080_crop-fit_optimize_subsampling-2-859.png', '2026-03-12 15:01:41', '2026-03-31 09:27:25'),
(53, 'SteelSeries Rival 3', 'Könnyű gamer egér.', 13990, 26, 1, 'https://images.ctfassets.net/hmm5mo4qf4mf/6JeTt3A36dChpcazQKyHbB/ad71640570dea931c42f1114b92d9993/rival_3_gen_2_black_pdp_img_buy_02.png?fm=webp&q=90&fit=scale&w=1920', '2026-03-12 15:01:41', '2026-03-31 19:31:47'),
(54, 'SteelSeries Apex Pro', 'Mechanikus gamer billentyűzet.', 99990, 0, 1, 'https://images.ctfassets.net/hmm5mo4qf4mf/4JowI26eF16rzKZ2fMJpI7/30f8b3e7ee6f957b5a927f526ada0185/apex_pro_tkl_gen_3_black_img_buy_01.png__1920x1080_crop-fit_optimize_subsampling-2-3759.png?fm=webp&q=90&fit=scale&w=1920', '2026-03-12 15:01:41', '2026-03-28 18:29:42'),
(55, 'SteelSeries Apex 7', 'RGB gamer billentyűzet.', 69990, 0, 1, 'https://images.ctfassets.net/hmm5mo4qf4mf/5KIXRGmJTRNzH3goaM8pj4/de430f6ed123c583e947fb7cd9bce0cd/buyimg_apex7_006_us.png__1920x1080_crop-fit_optimize_subsampling-2-3067.png', '2026-03-12 15:01:41', '2026-03-13 14:19:32'),
(56, 'SteelSeries QcK Mousepad', 'Nagy gamer egérpad.', 6990, 46, 1, 'https://images.ctfassets.net/hmm5mo4qf4mf/4XYFbpZ65pegjKa8NNR1Z7/0fd2c868ce057f4f5021c27771b3285d/1200x_buy_qck-edge_m_02.png__1920x1080_crop-fit_optimize_subsampling-2-3501.png', '2026-03-12 15:01:41', '2026-03-30 07:46:59'),
(57, 'Logitech G502 Hero', 'Precíz gamer egér.', 28990, 30, 2, 'https://resource.logitechg.com/c_fill,q_auto,f_auto,dpr_1.0/d_transparent.gif/content/dam/gaming/en/non-braid/hyjal-g502-hero/2025/g502-hero-mouse-top-angle-gallery-1.png', '2026-03-12 15:01:41', '2026-03-31 19:31:47'),
(58, 'Logitech G203', 'RGB gamer egér.', 10990, 59, 2, 'https://resource.logitechg.com/c_fill,q_auto,f_auto,dpr_1.0/d_transparent.gif/content/dam/gaming/en/products/refreshed-g203/2025-update/g203-mouse-top-angle-black-gallery-1.png', '2026-03-12 15:01:41', '2026-03-12 16:44:40'),
(59, 'Logitech G903', 'Vezeték nélküli gamer egér.', 49990, 10, 2, 'https://resource.logitechg.com/c_fill,q_auto,f_auto,dpr_1.0/d_transparent.gif/content/dam/gaming/en/products/g903-hero/2025-update/g903-lightspeed-mouse-top-angle-gallery-1.png', '2026-03-12 15:01:41', '2026-03-30 07:46:59'),
(60, 'Logitech G Pro Wireless', 'Pro gamer egér.', 54990, 14, 2, 'https://www.logitechg.com/content/dam/gaming/en/products/pro-wireless-gaming-mouse/pro-wireless-carbon-gallery-1.png', '2026-03-12 15:01:41', '2026-03-31 19:31:47'),
(61, 'Logitech G915', 'Mechanikus gamer billentyűzet.', 99990, 10, 2, 'https://www.logitechg.com/content/dam/gaming/en/products/g915-x-wired/gallery/g915-x-mechanical-gaming-keyboard-carbon-gallery-1-uk.png', '2026-03-12 15:01:41', '2026-03-30 07:46:59'),
(62, 'Logitech G513', 'RGB mechanikus billentyűzet.', 55990, 18, 2, 'https://www.logitechg.com/content/dam/gaming/en/products/g513/g513-carbon-gallery-2.png', '2026-03-12 15:01:41', '2026-03-30 07:46:59'),
(63, 'Logitech G733', 'Vezeték nélküli gamer headset.', 52990, 23, 2, 'https://www.logitechg.com/content/dam/gaming/en/products/g733/gallery/g733-black-gallery-1.png', '2026-03-12 15:01:41', '2026-03-30 07:46:59'),
(64, 'HyperX Cloud II', 'Klasszikus gamer headset.', 34990, 36, 3, 'https://hp.widen.net/content/ajq9mfi99d/png/ajq9mfi99d.png?w=800&h=600&dpi=72&color=ffffff00', '2026-03-12 15:01:41', '2026-03-30 07:46:59'),
(65, 'HyperX Cloud Alpha', 'Erős basszus gamer headset.', 39990, 28, 3, 'https://hp.widen.net/content/rxnjkhxvqr/png/rxnjkhxvqr.png?w=800&h=600&dpi=72&color=ffffff00', '2026-03-12 15:01:41', '2026-03-13 14:19:32'),
(66, 'HyperX Pulsefire FPS', 'Precíz gamer egér.', 19990, 34, 3, 'https://techcart.com.au/wp-content/uploads/2024/06/78955-HyperX-Pulsefire-FPS-Mouse-Black.png', '2026-03-12 15:01:41', '2026-03-12 15:24:45'),
(67, 'HyperX Pulsefire Surge', 'RGB gamer egér.', 24990, 30, 3, 'https://s13emagst.akamaized.net/products/55046/55045107/images/res_36fac647319caf784f04793c8507fc3f.png?width=300&height=300&hash=CFA334306EC9F41E421B67C9E486878C', '2026-03-12 15:01:41', '2026-03-12 15:07:09'),
(68, 'HyperX Alloy FPS', 'Mechanikus gamer billentyűzet.', 45990, 20, 3, 'https://gnd-tech.com/content/2018/09/hyperx-alloy-fps-rgb-gaming-keyboard.png', '2026-03-12 15:01:41', '2026-03-12 15:07:28'),
(69, 'HyperX Alloy Core', 'RGB gamer billentyűzet.', 23990, 25, 3, 'https://cdn11.bigcommerce.com/s-alitpcfiof/images/stencil/1280x1280/products/23140/23850/840104369784__47759.1692773254.png?c=1', '2026-03-12 15:01:41', '2026-03-12 15:07:48'),
(70, 'HyperX QuadCast', 'USB streaming mikrofon.', 52990, 18, 3, 'https://hp.widen.net/content/vapvtnsevt/png/vapvtnsevt.png?w=800&h=600&dpi=72&color=ffffff00', '2026-03-12 15:01:41', '2026-03-12 15:08:26'),
(71, 'Secretlab Titan', 'Prémium gamer szék.', 219990, 10, 4, 'https://images.secretlab.co/theme/common/chair-compare-titan-evo-lite.png', '2026-03-12 15:01:41', '2026-03-12 19:51:37'),
(72, 'Secretlab Omega', 'Ergonomikus gamer szék.', 199990, 8, 4, 'https://static0.xdaimages.com/wordpress/wp-content/uploads/2024/10/secretlab-titan-evo-nanogen-edition-product.png?q=70&fit=contain&w=280&dpr=1', '2026-03-12 15:01:41', '2026-03-12 15:07:43'),
(73, 'Secretlab Titan Evo', 'Új generációs gamer szék.', 229990, 6, 4, 'https://static0.xdaimages.com/wordpress/wp-content/uploads/2024/10/secretlab-titan-evo-nanogen-edition-product.png?q=70&fit=contain&w=280&dpr=1', '2026-03-12 15:01:41', '2026-03-12 15:07:16'),
(77, 'Secretlab Magnus Desk', 'Prémium gamer asztal.', 259990, 6, 4, 'https://images.secretlab.co/theme/common/desk-compare-magnus-pro.png', '2026-03-12 15:01:41', '2026-03-12 15:06:52'),
(78, 'Endorfy Thock', 'Mechanikus gamer billentyűzet.', 46990, 20, 5, 'https://endorfy.com/wp-content/uploads/2025/09/EY5A129-endorfy-thock-v2-wireless-10a-png-www.png', '2026-03-12 15:01:41', '2026-03-12 15:06:39'),
(79, 'Endorfy Lix', 'Könnyű gamer egér.', 21990, 34, 5, 'https://endorfy.com/wp-content/products/EY6A002_LIX/Media%20(pictures)/WebP/EY6A002-endorfy-lix-07a-webp95.d20250930-u223338.webp', '2026-03-12 15:01:41', '2026-03-12 15:24:45'),
(80, 'Endorfy Ventum 200', 'Szellős számítógépház.', 32990, 22, 5, 'https://endorfy.com/wp-content/products/EY2A013_Arx-700-ARGB/Media%20(pictures)/_PRODUCT-HERO/EY2A013-endorfy-arx-700-argb-product-hero.d20230510-u130125.webp', '2026-03-12 15:01:41', '2026-03-12 15:24:45'),
(81, 'Endorfy Spartan 5', 'CPU hűtő.', 17990, 30, 5, 'https://endorfy.com/wp-content/products/EY3A001_Spartan-5/Media%20(pictures)/WebP/EY3A001-endorfy-spartan-5-13a-webp95.d20250930-u222605.webp', '2026-03-12 15:01:41', '2026-03-12 15:05:45'),
(82, 'Endorfy Fortis 5', 'Torony CPU hűtő.', 24990, 18, 5, 'https://endorfy.com/wp-content/products/EY3A010_Fortis-5-ARGB/Media%20(pictures)/WebP/EY3A010-endorfy-fortis-5-argb-04b-webp95.d20250930-u222631.webp', '2026-03-12 15:01:41', '2026-03-12 15:05:33'),
(83, 'Endorfy Arx 700', 'RGB számítógépház.', 48990, 11, 5, 'https://endorfy.com/wp-content/products/EY2A013_Arx-700-ARGB/Media%20(pictures)/WebP/EY2A013-endorfy-arx-700-argb-01a-webp95.d20250930-u222528.webp', '2026-03-12 15:01:41', '2026-03-12 15:24:45'),
(84, 'Endorfy Vero L5', 'PC tápegység.', 34990, 15, 5, 'https://cdn-reichelt.de/resize/600%2F-/web/xxl_ws/E910%2FENDORFY_EY7A005_02.png?type=ProductXxl&resize=600%252F-&', '2026-03-12 15:01:41', '2026-03-12 15:05:12'),
(85, 'Razer DeathAdder Elite', 'Ergonomikus gamer egér.', 32990, 30, 6, 'https://assets.razerzone.com/eeimages/support/products/724/724_deathadderelite_500x500.png', '2026-03-12 15:01:41', '2026-03-12 15:04:57'),
(86, 'Razer Basilisk', 'Programozható gamer egér.', 37990, 24, 6, 'https://assets.razerzone.com/eeimages/support/products/1617/1617_basilisk-v2.png', '2026-03-12 15:01:41', '2026-03-12 15:24:45'),
(87, 'Razer Viper', 'Ultrakönnyű gamer egér.', 34990, 22, 6, 'https://dl.razerzone.com/Images/Viper%208KHz/Viper8khz.png', '2026-03-12 15:01:41', '2026-03-12 15:04:33'),
(88, 'Razer Kraken', 'Klasszikus gamer headset.', 34990, 34, 6, 'https://assets.razerzone.com/press/kraken/razer-kraken-71-v2.png', '2026-03-12 15:01:41', '2026-03-12 15:24:45'),
(89, 'Razer BlackWidow', 'Mechanikus gamer billentyűzet.', 64990, 18, 6, 'https://assets.razerzone.com/eeimages/support/products/1501/1501-blackwidow2019.png', '2026-03-12 15:01:41', '2026-03-12 15:04:12'),
(90, 'Razer Huntsman', 'Optikai kapcsolós billentyűzet.', 74990, 11, 6, 'https://assets3.razerzone.com/v0JcnWkmdZDjLe74IrnRjIH_Jto=/1500x1000/https%3A%2F%2Fmedias-p1.phoenix.razer.com%2Fsys-master-phoenix-images-container%2Fh2d%2Fh6d%2F9533910614046%2Fhuntsman-v2-4-500x500.png', '2026-03-12 15:01:41', '2026-03-12 15:24:45'),
(91, 'Razer Firefly', 'RGB egérpad.', 21990, 40, 6, 'https://assets.razerzone.com/press/firefly/razer-firefly.png', '2026-03-12 15:01:41', '2026-03-12 15:03:47'),
(92, 'ASUS ROG Strix Laptop', 'Gamer laptop.', 699990, 7, 7, 'https://dlcdnwebimgs.asus.com/gain/BCAD66DB-F343-4722-AEDF-E8B3E2326362/w1000/h732', '2026-03-12 15:01:41', '2026-03-12 15:24:45'),
(93, 'ASUS ROG Chakram', 'Vezeték nélküli gamer egér.', 57990, 20, 7, 'https://media.tatacroma.com/Croma%20Assets/Computers%20Peripherals/Computer%20Accessories%20and%20Tablets%20Accessories/Images/233932_0_pwkj5j.png', '2026-03-12 15:01:41', '2026-03-12 15:03:22'),
(94, 'ASUS ROG Falchion', 'Kompakt gamer billentyűzet.', 69990, 15, 7, 'https://dlcdnwebimgs.asus.com/gain/BB5CFB46-150B-468C-AAD4-A16811BDA7E8', '2026-03-12 15:01:41', '2026-03-12 15:24:45'),
(95, 'ASUS ROG Delta', 'Prémium gamer headset.', 49990, 18, 7, 'https://dlcdnimgs.asus.com/websites/global/products/19XBVhYmxv7uJCVP/img/rog_delta.png', '2026-03-12 15:01:41', '2026-03-12 15:02:52'),
(96, 'ASUS TUF VG27AQ', '144Hz gamer monitor.', 129990, 11, 7, 'https://dlcdnwebimgs.asus.com/gain/2c0a0931-5470-419c-8273-ef372cb457c6/w185', '2026-03-12 15:01:41', '2026-03-12 15:24:45'),
(97, 'ASUS ROG Router', 'Gamer router.', 119990, 9, 7, 'https://dlcdnwebimgs.asus.com/gain/1BB9AD26-5858-42DB-82F9-8AB4D7EE31B2', '2026-03-12 15:01:41', '2026-03-12 15:24:45'),
(98, 'ASUS ROG Sheath', 'Nagy gamer egérpad.', 19990, 34, 7, 'https://dlcdnwebimgs.asus.com/gain/A1867040-475F-48AA-A1F3-94B51A7AC26F', '2026-03-12 15:01:41', '2026-03-12 15:24:45');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `Users`
--

CREATE TABLE `Users` (
  `Id` int(11) NOT NULL,
  `Username` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Pfp` varchar(255) DEFAULT NULL,
  `isAdmin` tinyint(1) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- A tábla adatainak kiíratása `Users`
--

INSERT INTO `Users` (`Id`, `Username`, `Email`, `Password`, `Pfp`, `isAdmin`, `createdAt`, `updatedAt`) VALUES
(4, 'Emma Williams', 'emma.williams@example.com', 'pass123', 'https://i.pravatar.cc/150?img=2', NULL, '2025-11-02 09:15:20', '2025-11-02 09:15:20'),
(5, 'Noah Brown', 'noah.brown@example.com', 'pass123', 'https://i.pravatar.cc/150?img=3', NULL, '2025-11-03 14:21:11', '2025-11-03 14:21:11'),
(7, 'William Garcia', 'william.garcia@example.com', 'pass123', 'https://i.pravatar.cc/150?img=5', NULL, '2025-11-05 16:11:09', '2025-11-05 16:11:09'),
(8, 'Ava Miller', 'ava.miller@example.com', 'pass123', 'https://i.pravatar.cc/150?img=6', NULL, '2025-11-06 12:33:48', '2025-11-06 12:33:48'),
(10, 'Sophia Rodriguez', 'sophia.rodriguez@example.com', 'pass123', 'https://i.pravatar.cc/150?img=8', NULL, '2025-11-08 07:55:12', '2025-11-08 07:55:12'),
(11, 'Benjamin Martinez', 'benjamin.martinez@example.com', 'pass123', 'https://i.pravatar.cc/150?img=9', NULL, '2025-11-09 11:42:37', '2025-11-09 11:42:37'),
(12, 'Isabella Hernandez', 'isabella.hernandez@example.com', 'pass123', 'https://i.pravatar.cc/150?img=10', NULL, '2025-11-10 15:14:29', '2025-11-10 15:14:29'),
(14, 'Mia Gonzalez', 'mia.gonzalez@example.com', 'pass123', 'https://i.pravatar.cc/150?img=12', NULL, '2025-11-12 17:25:16', '2025-11-12 17:25:16'),
(15, 'Henry Wilson', 'henry.wilson@example.com', 'pass123', 'https://i.pravatar.cc/150?img=13', NULL, '2025-11-13 09:07:44', '2025-11-13 09:07:44'),
(16, 'Charlotte Anderson', 'charlotte.anderson@example.com', 'pass123', 'https://i.pravatar.cc/150?img=14', NULL, '2025-11-14 20:11:38', '2025-11-14 20:11:38'),
(17, 'Alexander Thomas', 'alexander.thomas@example.com', 'pass123', 'https://i.pravatar.cc/150?img=15', NULL, '2025-11-15 06:33:51', '2025-11-15 06:33:51'),
(18, 'Amelia Taylor', 'amelia.taylor@example.com', 'pass123', 'https://i.pravatar.cc/150?img=16', NULL, '2025-11-16 10:55:02', '2025-11-16 10:55:02'),
(19, 'Michael Moore', 'michael.moore@example.com', 'pass123', 'https://i.pravatar.cc/150?img=17', NULL, '2025-11-17 14:40:27', '2025-11-17 14:40:27'),
(20, 'Harper Jackson', 'harper.jackson@example.com', 'pass123', 'https://i.pravatar.cc/150?img=18', NULL, '2025-11-18 19:01:59', '2025-11-18 19:01:59'),
(21, 'Daniel Martin', 'daniel.martin@example.com', 'pass123', 'https://i.pravatar.cc/150?img=19', NULL, '2025-11-19 12:19:46', '2025-11-19 12:19:46'),
(22, 'Evelyn Lee', 'evelyn.lee@example.com', 'pass123', 'https://i.pravatar.cc/150?img=20', NULL, '2025-11-20 16:44:33', '2025-11-20 16:44:33'),
(24, 'Abigail Thompson', 'abigail.thompson@example.com', 'pass123', 'https://i.pravatar.cc/150?img=22', NULL, '2025-11-22 11:51:07', '2025-11-22 11:51:07'),
(25, 'Joseph White', 'joseph.white@example.com', 'pass123', 'https://i.pravatar.cc/150?img=23', NULL, '2025-11-23 18:07:55', '2025-11-23 18:07:55'),
(26, 'Emily Harris', 'emily.harris@example.com', 'pass123', 'https://i.pravatar.cc/150?img=24', NULL, '2025-11-24 07:41:22', '2025-11-24 07:41:22'),
(27, 'David Sanchez', 'david.sanchez@example.com', 'pass123', 'https://i.pravatar.cc/150?img=25', NULL, '2025-11-25 15:10:09', '2025-11-25 15:10:09'),
(28, 'Elizabeth Clark', 'elizabeth.clark@example.com', 'pass123', 'https://i.pravatar.cc/150?img=26', NULL, '2025-11-26 13:37:41', '2025-11-26 13:37:41'),
(29, 'Samuel Ramirez', 'samuel.ramirez@example.com', 'pass123', 'https://i.pravatar.cc/150?img=27', NULL, '2025-11-27 08:22:54', '2025-11-27 08:22:54'),
(30, 'Sofia Lewis', 'sofia.lewis@example.com', 'pass123', 'https://i.pravatar.cc/150?img=28', 1, '2025-11-28 17:09:30', '2025-11-28 17:09:30'),
(31, 'Andrew Robinson', 'andrew.robinson@example.com', 'pass123', 'https://i.pravatar.cc/150?img=29', NULL, '2025-11-29 10:14:18', '2025-11-29 10:14:18'),
(32, 'Victoria Walker', 'victoria.walker@example.com', 'pass123', 'https://i.pravatar.cc/150?img=30', 1, '2025-11-30 21:33:06', '2025-11-30 21:33:06'),
(33, 'Ader', 'ader@gmail.com', '$2b$15$Kf/AKuAxEH4aiJfUozcVP.pG/rP9TbzcyOvIZpmYc1RdSyAuLmE6W', '/uploads/default-avatar.png', NULL, '2026-03-12 16:17:57', '2026-03-12 16:17:57'),
(34, 'Haha', 'haha@gmail.com', '$2b$15$wLr2N447MLCRj78b2O.6sOeeN6HqtEKx/06e.akrTILKJwARVn5SW', '/uploads/default-avatar.png', NULL, '2026-03-12 19:49:42', '2026-03-12 19:49:42'),
(35, 'belepes', 'a@gmail.com', '$2b$15$X/VSYWD3PQ3lFy35m0UPa.MfARLjZz9yPZtt9DxPL1ZV3Mjdw6pRG', '/uploads/default-avatar.png', NULL, '2026-03-13 14:00:01', '2026-03-13 14:00:01'),
(36, 'ab', 'ab@gmail.com', '$2b$15$XXxHsbgTzVxx4YTTf9N.puPsuW.QuOHiWIjs8E2/EMtxIKZo.bM1a', '/uploads/default-avatar.png', 1, '2026-03-13 14:07:07', '2026-03-18 07:37:02'),
(37, 'aa', 'aa@aa.hu', '$2b$15$V4BFkb/mw0zX/UfXrL/B2ORspEMVnHv5NIaIAUKU25HTw7YBa2Hpq', '/uploads/default-avatar.png', NULL, '2026-03-13 14:21:29', '2026-03-13 14:21:29'),
(38, 'Asderr', 'almafa@gmail.com', '$2b$15$9nAoO5N31iVyPFjkt2e.c.itTvyyi7KElIxZOmH7HajqnnSdBh41G', '/uploads/default-avatar.png', NULL, '2026-03-16 11:24:27', '2026-03-16 11:24:27'),
(39, 'Abdul Rahim', 'abdulrahim@gmail.com', '$2b$15$/l8R6gTlOSieqjjOhDS4TOTbGktVvD8tul2ZtEaD5How6civgj5V6', '/uploads/default-avatar.png', NULL, '2026-03-17 11:45:53', '2026-03-17 11:45:53'),
(40, 'Dani', 'valami@gmail.com', '$2b$15$tWu3JxSaPYgtZMdDKdj3kOPDEl7L6HJuap9PzsHaPk.RrxyQXeHHW', '/uploads/profile-40-1773767449035.jpg', NULL, '2026-03-17 17:10:16', '2026-03-17 17:10:49'),
(41, 'Komjáti Gábor Kornél', 'komjati.gabor.kornel.21i@egressy.info', '$2b$15$9NxWvnFdI/VhHkZve.PRbeJe3AWtsC07lSNnFkzAIQpY.0eztP3f.', '/uploads/default-avatar.png', NULL, '2026-03-18 13:24:24', '2026-03-18 13:24:24'),
(47, 'Alma', 'alma@alma.hu', '$2b$15$/mqKLyAxafw8X0OIfGviZ.DlxhTFy7o8hGmoEBJdwSNeUj/.xjaGm', '/uploads/profile-47-1774777872876.jpg', 1, '2026-03-24 14:00:55', '2026-03-29 09:51:12'),
(48, 'koxonium', 'ceszty@gmail.com', '$2b$15$yQoOJdqBlYiOrt.KAI./Z.GHA2rfDD/hm2rjjyBriPko2x7O9UYLq', '/uploads/profile-48-1774651148816.png', NULL, '2026-03-27 22:37:54', '2026-03-27 22:43:25'),
(49, 'kubinyi', 'kubinyigabor2@gmail.com', '$2b$15$nCQLBlAN8chZ.xYwGVzlm.32uu2sFTjEF8Y6Hcu96HHCh//qJcqUW', '/uploads/default-avatar.png', NULL, '2026-03-28 18:28:20', '2026-03-28 18:28:20'),
(50, 'Admin', 'admin@notrox.hu', '$2b$15$93ZW4791szBSc5vmJYqmo.H.Dfs9SPa/s7UNbIiUE9LFxS7aWRVQq', '/uploads/default-avatar.png', 1, '2026-03-31 19:07:29', '2026-03-31 19:07:29'),
(51, 'TesztElek', 'tesztelek@notrox.hu', '$2b$15$yCvhDtDVDPSbpC5tIvDLJ.HBwjkZEGxdsoesgl.6tComUrNXX4HMG', '/uploads/default-avatar.png', NULL, '2026-03-31 19:08:41', '2026-03-31 19:08:41');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `Addresses`
--
ALTER TABLE `Addresses`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `UserId` (`UserId`);

--
-- A tábla indexei `BillingAddresses`
--
ALTER TABLE `BillingAddresses`
  ADD PRIMARY KEY (`Id`);

--
-- A tábla indexei `Companies`
--
ALTER TABLE `Companies`
  ADD PRIMARY KEY (`Id`);

--
-- A tábla indexei `Logs`
--
ALTER TABLE `Logs`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `OrderId` (`OrderId`);

--
-- A tábla indexei `OrderItems`
--
ALTER TABLE `OrderItems`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `OrderId` (`OrderId`),
  ADD KEY `ProductId` (`ProductId`);

--
-- A tábla indexei `Orders`
--
ALTER TABLE `Orders`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `UserId` (`UserId`),
  ADD KEY `AddressId` (`AddressId`);

--
-- A tábla indexei `Products`
--
ALTER TABLE `Products`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `CompanyId` (`CompanyId`);

--
-- A tábla indexei `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`Id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `Addresses`
--
ALTER TABLE `Addresses`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `BillingAddresses`
--
ALTER TABLE `BillingAddresses`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `Companies`
--
ALTER TABLE `Companies`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT a táblához `Logs`
--
ALTER TABLE `Logs`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `OrderItems`
--
ALTER TABLE `OrderItems`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT a táblához `Orders`
--
ALTER TABLE `Orders`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT a táblához `Products`
--
ALTER TABLE `Products`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT a táblához `Users`
--
ALTER TABLE `Users`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `Addresses`
--
ALTER TABLE `Addresses`
  ADD CONSTRAINT `Addresses_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `Users` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `Logs`
--
ALTER TABLE `Logs`
  ADD CONSTRAINT `Logs_ibfk_1` FOREIGN KEY (`OrderId`) REFERENCES `Orders` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `OrderItems`
--
ALTER TABLE `OrderItems`
  ADD CONSTRAINT `OrderItems_ibfk_1` FOREIGN KEY (`OrderId`) REFERENCES `Orders` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `OrderItems_ibfk_2` FOREIGN KEY (`ProductId`) REFERENCES `Products` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `Orders`
--
ALTER TABLE `Orders`
  ADD CONSTRAINT `Orders_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `Users` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Orders_ibfk_2` FOREIGN KEY (`AddressId`) REFERENCES `Addresses` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `Products`
--
ALTER TABLE `Products`
  ADD CONSTRAINT `Products_ibfk_1` FOREIGN KEY (`CompanyId`) REFERENCES `Companies` (`Id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
