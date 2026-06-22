-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 22 Jun 2026 pada 12.17
-- Versi server: 8.0.30
-- Versi PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `facultyware`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `assets`
--

CREATE TABLE `assets` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('equipment','room') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `acquisition_type` enum('procurement','grant') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `acquisition_date` date NOT NULL,
  `acquisition_cost` decimal(14,2) DEFAULT NULL,
  `asset_grant_id` bigint UNSIGNED DEFAULT NULL,
  `condition` enum('good','minor_damage','major_damage') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('available','in_use','maintenance','retired') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `asset_audits`
--

CREATE TABLE `asset_audits` (
  `id` bigint UNSIGNED NOT NULL,
  `audit_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `audit_date` date NOT NULL,
  `conducted_by` bigint UNSIGNED NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `employee_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `asset_audit_details`
--

CREATE TABLE `asset_audit_details` (
  `id` bigint UNSIGNED NOT NULL,
  `asset_audit_id` bigint UNSIGNED NOT NULL,
  `asset_id` bigint UNSIGNED NOT NULL,
  `condition` enum('good','minor_damage','major_damage','missing') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `asset_grants`
--

CREATE TABLE `asset_grants` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `grant_date` date NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `asset_insurances`
--

CREATE TABLE `asset_insurances` (
  `id` bigint UNSIGNED NOT NULL,
  `asset_id` bigint UNSIGNED NOT NULL,
  `policy_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `coverage_amount` decimal(14,2) NOT NULL,
  `premium` decimal(14,2) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` enum('active','expired','claimed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `asset_insurance_claims`
--

CREATE TABLE `asset_insurance_claims` (
  `id` bigint UNSIGNED NOT NULL,
  `asset_insurance_id` bigint UNSIGNED NOT NULL,
  `claim_date` date NOT NULL,
  `claim_amount` decimal(14,2) NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` enum('submitted','approved','rejected','paid') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `asset_trackings`
--

CREATE TABLE `asset_trackings` (
  `id` bigint UNSIGNED NOT NULL,
  `asset_id` bigint UNSIGNED NOT NULL,
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` decimal(10,6) DEFAULT NULL,
  `longitude` decimal(10,6) DEFAULT NULL,
  `tracked_at` timestamp NOT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `asset_tracking_logs`
--

CREATE TABLE `asset_tracking_logs` (
  `id` bigint UNSIGNED NOT NULL,
  `asset_id` bigint UNSIGNED NOT NULL,
  `from_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `moved_at` timestamp NOT NULL,
  `moved_by` bigint UNSIGNED DEFAULT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `assignments`
--

CREATE TABLE `assignments` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `assigned_by` bigint UNSIGNED NOT NULL,
  `assigned_to` bigint UNSIGNED NOT NULL,
  `parent_id` bigint UNSIGNED DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `status` enum('assigned','in_progress','completed','delegated','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `priority` enum('low','medium','high') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `assigned_by_id` bigint UNSIGNED NOT NULL,
  `assigned_to_id` bigint UNSIGNED NOT NULL,
  `parent_id_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `assignment_progress`
--

CREATE TABLE `assignment_progress` (
  `id` bigint UNSIGNED NOT NULL,
  `assignment_id` bigint UNSIGNED DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `progress_date` date NOT NULL,
  `status` enum('in_progress','completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `assignment_progress`
--

INSERT INTO `assignment_progress` (`id`, `assignment_id`, `description`, `progress_date`, `status`, `attachment`, `created_by`, `employee_id`, `created_at`, `updated_at`) VALUES
(5, NULL, 'egerge', '2026-06-16', 'completed', NULL, 2, 2, '2026-06-16 10:59:40', '2026-06-16 15:22:21'),
(8, NULL, 'kjawakjdja', '2026-06-16', 'completed', '1781623531209.jpg', 2, 2, '2026-06-16 15:25:31', '2026-06-16 15:34:05'),
(10, NULL, 'bermain main\n[Ditolak: mau dipecat?]', '2026-06-16', 'in_progress', NULL, 2, 2, '2026-06-16 15:34:41', '2026-06-16 15:35:01'),
(11, NULL, 'Logbook otomatis dari Playwright test', '2026-06-21', 'in_progress', NULL, 2, 2, '2026-06-21 10:36:35', '2026-06-21 10:36:35'),
(12, NULL, 'Logbook otomatis dari Playwright test', '2026-06-21', 'in_progress', NULL, 2, 2, '2026-06-21 11:42:23', '2026-06-21 11:42:23'),
(13, NULL, 'Logbook otomatis dari Playwright test', '2026-06-21', 'in_progress', NULL, 2, 2, '2026-06-21 11:42:30', '2026-06-21 11:42:30'),
(14, NULL, 'Logbook otomatis dari Playwright test', '2026-06-21', 'in_progress', NULL, 2, 2, '2026-06-21 11:42:37', '2026-06-21 11:42:37'),
(15, NULL, 'Logbook otomatis dari Playwright test', '2026-06-21', 'in_progress', NULL, 2, 2, '2026-06-21 11:44:28', '2026-06-21 11:44:28'),
(16, NULL, 'Logbook otomatis dari Playwright test', '2026-06-21', 'in_progress', NULL, 2, 2, '2026-06-21 11:44:54', '2026-06-21 11:44:54'),
(17, NULL, 'Logbook otomatis dari Playwright test', '2026-06-21', 'in_progress', NULL, 2, 2, '2026-06-21 11:46:32', '2026-06-21 11:46:32'),
(18, NULL, 'Logbook otomatis dari Playwright test', '2026-06-22', 'in_progress', NULL, 2, 2, '2026-06-22 08:38:33', '2026-06-22 08:38:33'),
(19, NULL, 'Logbook setelah diedit 1782129468898', '2026-06-21', 'in_progress', NULL, 2, 2, '2026-06-22 08:40:54', '2026-06-22 11:57:48'),
(20, NULL, 'Logbook setelah diedit 1782129412905', '2026-06-21', 'in_progress', NULL, 2, 2, '2026-06-22 08:56:55', '2026-06-22 11:56:52'),
(26, NULL, 'Logbook dengan lampiran 1782129411931', '2026-06-22', 'completed', '1782129412025.txt', 2, 2, '2026-06-22 11:56:52', '2026-06-22 11:56:57'),
(28, NULL, 'Logbook yang akan dihapus 1782129413776', '2026-06-22', 'completed', NULL, 2, 2, '2026-06-22 11:56:53', '2026-06-22 11:57:53'),
(29, NULL, 'Logbook otomatis dari Playwright 1782129466779', '2026-06-22', 'in_progress', NULL, 2, 2, '2026-06-22 11:57:46', '2026-06-22 11:57:46'),
(30, NULL, 'Logbook dengan lampiran 1782129467709\n[Ditolak: Mohon diperbaiki deskripsinya]', '2026-06-22', 'in_progress', '1782129467762.txt', 2, 2, '2026-06-22 11:57:47', '2026-06-22 11:57:54'),
(31, NULL, 'Logbook sebelum diedit 1782129468760', '2026-06-22', 'in_progress', NULL, 2, 2, '2026-06-22 11:57:48', '2026-06-22 11:57:48'),
(32, NULL, 'Logbook yang akan dihapus 1782129470023', '2026-06-22', 'in_progress', NULL, 2, 2, '2026-06-22 11:57:50', '2026-06-22 11:57:50');

-- --------------------------------------------------------

--
-- Struktur dari tabel `attendances`
--

CREATE TABLE `attendances` (
  `id` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `check_in` datetime DEFAULT NULL,
  `check_out` datetime DEFAULT NULL,
  `status` enum('present','absent','leave','overtime','holiday') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `buildings`
--

CREATE TABLE `buildings` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `committees`
--

CREATE TABLE `committees` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `objective` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expected_outcome` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `status` enum('draft','active','completed','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `committee_budgets`
--

CREATE TABLE `committee_budgets` (
  `id` bigint UNSIGNED NOT NULL,
  `committee_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `total_amount` decimal(14,2) NOT NULL,
  `used_amount` decimal(14,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `committee_budget_items`
--

CREATE TABLE `committee_budget_items` (
  `id` bigint UNSIGNED NOT NULL,
  `committee_budget_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(14,2) NOT NULL,
  `total_price` decimal(14,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `committee_expenses`
--

CREATE TABLE `committee_expenses` (
  `id` bigint UNSIGNED NOT NULL,
  `committee_budget_item_id` bigint UNSIGNED NOT NULL,
  `amount` decimal(14,2) NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `receipt_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expense_date` date NOT NULL,
  `status` enum('submitted','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `approved_by` bigint UNSIGNED DEFAULT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `committee_external_members`
--

CREATE TABLE `committee_external_members` (
  `id` bigint UNSIGNED NOT NULL,
  `committee_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `institution` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `committee_members`
--

CREATE TABLE `committee_members` (
  `id` bigint UNSIGNED NOT NULL,
  `committee_id` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_leader` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `committee_tasks`
--

CREATE TABLE `committee_tasks` (
  `id` bigint UNSIGNED NOT NULL,
  `committee_id` bigint UNSIGNED NOT NULL,
  `assigned_to` bigint UNSIGNED DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `start_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `priority` enum('low','medium','high') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('todo','in_progress','done','blocked') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `committee_member_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `committee_task_progress`
--

CREATE TABLE `committee_task_progress` (
  `id` bigint UNSIGNED NOT NULL,
  `committee_task_id` bigint UNSIGNED NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `progress_date` date NOT NULL,
  `status` enum('in_progress','done') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `community_services`
--

CREATE TABLE `community_services` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `funding_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('proposed','ongoing','completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `community_service_members`
--

CREATE TABLE `community_service_members` (
  `id` bigint UNSIGNED NOT NULL,
  `community_service_id` bigint UNSIGNED NOT NULL,
  `lecturer_id` bigint UNSIGNED NOT NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `conference_proceedings`
--

CREATE TABLE `conference_proceedings` (
  `id` bigint UNSIGNED NOT NULL,
  `publication_id` bigint UNSIGNED NOT NULL,
  `conference_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `conference_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `conference_date` date DEFAULT NULL,
  `publisher` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isbn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pages` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `indexing` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `documents`
--

CREATE TABLE `documents` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `document_type_id` bigint UNSIGNED DEFAULT NULL,
  `doc_no` varchar(45) DEFAULT NULL,
  `unit_owner` bigint UNSIGNED DEFAULT NULL,
  `published` tinyint DEFAULT NULL,
  `scope` varchar(45) DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `document_revisions`
--

CREATE TABLE `document_revisions` (
  `id` int NOT NULL,
  `document_id` bigint UNSIGNED NOT NULL,
  `rev_no` int DEFAULT NULL,
  `doc_date` int DEFAULT NULL,
  `doc_month` int DEFAULT NULL,
  `doc_year` int DEFAULT NULL,
  `active` tinyint DEFAULT NULL,
  `uploaded_file` varchar(45) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `document_types`
--

CREATE TABLE `document_types` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `education_histories`
--

CREATE TABLE `education_histories` (
  `id` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `degree` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `institution` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `major` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_year` year NOT NULL,
  `end_year` year DEFAULT NULL,
  `gpa` decimal(3,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `employees`
--

CREATE TABLE `employees` (
  `id` bigint UNSIGNED NOT NULL,
  `employee_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `national_id_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_id_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `birth_place` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `birth_date` date NOT NULL,
  `gender` enum('male','female') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `religion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `marital_status` enum('single','married','divorced') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organization_unit_id` bigint UNSIGNED NOT NULL,
  `hire_date` date NOT NULL,
  `employment_status_id` bigint UNSIGNED NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `employees`
--

INSERT INTO `employees` (`id`, `employee_number`, `national_id_number`, `tax_id_number`, `name`, `birth_place`, `birth_date`, `gender`, `religion`, `marital_status`, `address`, `phone_number`, `organization_unit_id`, `hire_date`, `employment_status_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'EMP001', NULL, NULL, 'Shidiq Maihendra', 'Padang', '1990-01-01', 'male', NULL, 'single', 'Jl. Contoh No.1', NULL, 1, '2020-01-01', 1, 'active', '2026-06-04 00:05:07', '2026-06-04 00:05:07'),
(2, 'EMP002', NULL, NULL, 'Duha Alul Bariq', 'Padang', '1995-03-10', 'male', NULL, 'single', 'Jl. Contoh No.2', NULL, 1, '2021-01-01', 1, 'active', '2026-06-04 00:05:07', '2026-06-04 00:05:07'),
(3, 'EMP003', NULL, NULL, 'Adinda Najwa', 'Padang', '1997-07-15', 'female', NULL, 'single', 'Jl. Contoh No.3', NULL, 1, '2021-06-01', 1, 'active', '2026-06-04 00:05:07', '2026-06-04 00:05:07'),
(4, 'EMP004', NULL, NULL, 'Shifa Khalishah', 'Padang', '1998-11-20', 'female', NULL, 'single', 'Jl. Contoh No.4', NULL, 1, '2022-01-01', 1, 'active', '2026-06-04 00:05:07', '2026-06-04 00:05:07');

-- --------------------------------------------------------

--
-- Struktur dari tabel `employee_grades`
--

CREATE TABLE `employee_grades` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `employment_statuses`
--

CREATE TABLE `employment_statuses` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `employment_statuses`
--

INSERT INTO `employment_statuses` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Tetap', NULL, '2026-06-03 19:35:13', '2026-06-03 19:35:13');

-- --------------------------------------------------------

--
-- Struktur dari tabel `equipments`
--

CREATE TABLE `equipments` (
  `id` bigint UNSIGNED NOT NULL,
  `asset_id` bigint UNSIGNED NOT NULL,
  `brand` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `specification` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `purchase_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `depreciation_value` decimal(14,2) DEFAULT NULL,
  `useful_life` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `equipment_loans`
--

CREATE TABLE `equipment_loans` (
  `id` bigint UNSIGNED NOT NULL,
  `equipment_id` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `status` enum('requested','approved','rejected','returned') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `approved_by` bigint UNSIGNED DEFAULT NULL,
  `approved_by_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `equipment_maintenance_requests`
--

CREATE TABLE `equipment_maintenance_requests` (
  `id` bigint UNSIGNED NOT NULL,
  `equipment_id` bigint UNSIGNED NOT NULL,
  `reported_by` bigint UNSIGNED NOT NULL,
  `issue_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('reported','in_progress','resolved') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reported_at` timestamp NOT NULL,
  `resolved_at` timestamp NULL DEFAULT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `equipment_maintenance_request_log`
--

CREATE TABLE `equipment_maintenance_request_log` (
  `id` bigint NOT NULL,
  `equipment_maintenance_request_id` bigint UNSIGNED DEFAULT NULL,
  `log` varchar(45) DEFAULT NULL,
  `logged_by` bigint UNSIGNED DEFAULT NULL,
  `logged_at` datetime DEFAULT NULL,
  `log_file` varchar(255) DEFAULT NULL,
  `verified_by` bigint UNSIGNED DEFAULT NULL,
  `verified_at` datetime DEFAULT NULL,
  `verification_file` varchar(255) DEFAULT NULL,
  `description` text,
  `status` int DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `equipment_procurements`
--

CREATE TABLE `equipment_procurements` (
  `id` bigint UNSIGNED NOT NULL,
  `request_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('draft','submitted','approved','rejected','completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `equipment_proc_items`
--

CREATE TABLE `equipment_proc_items` (
  `id` bigint UNSIGNED NOT NULL,
  `equipment_proc_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `specification` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `quantity` int NOT NULL,
  `estimated_price` decimal(14,2) DEFAULT NULL,
  `asset_equipment_procurement_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `equipment_requests`
--

CREATE TABLE `equipment_requests` (
  `id` bigint UNSIGNED NOT NULL,
  `request_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `specification` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `purchase_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int NOT NULL,
  `status` enum('pending','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `submitted_at` timestamp NOT NULL,
  `approved_by` bigint UNSIGNED DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `events`
--

CREATE TABLE `events` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `objectives` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `event_type` enum('seminar','workshop','training','conference','webinar','other') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `delivery_mode` enum('offline','online','hybrid') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `venue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `online_platform` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `online_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quota` int DEFAULT NULL,
  `registration_deadline` datetime DEFAULT NULL,
  `cover_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banner_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('draft','published','closed','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `published_by` bigint UNSIGNED DEFAULT NULL,
  `published_at` timestamp NULL DEFAULT NULL,
  `created_by_id` bigint UNSIGNED NOT NULL,
  `published_by_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `event_attendances`
--

CREATE TABLE `event_attendances` (
  `id` bigint UNSIGNED NOT NULL,
  `event_registration_id` bigint UNSIGNED NOT NULL,
  `checked_in_at` timestamp NULL DEFAULT NULL,
  `checked_out_at` timestamp NULL DEFAULT NULL,
  `checked_by` bigint UNSIGNED DEFAULT NULL,
  `attendance_method` enum('manual','qr_scan','system') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('present','absent','partial') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `checked_by_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `event_committee_members`
--

CREATE TABLE `event_committee_members` (
  `id` bigint UNSIGNED NOT NULL,
  `event_id` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_leader` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `event_documents`
--

CREATE TABLE `event_documents` (
  `id` bigint UNSIGNED NOT NULL,
  `event_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `document_type` enum('report','photo','proposal','minutes','attendance','other') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `uploaded_by` bigint UNSIGNED NOT NULL,
  `uploaded_at` timestamp NOT NULL,
  `uploaded_by_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `event_registrations`
--

CREATE TABLE `event_registrations` (
  `id` bigint UNSIGNED NOT NULL,
  `event_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `registration_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `registered_at` timestamp NOT NULL,
  `attendance_status` enum('registered','attended','no_show','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ticket_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `qr_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `issued_at` timestamp NOT NULL,
  `certificate_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generated_by` bigint UNSIGNED DEFAULT NULL,
  `generated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `event_reminders`
--

CREATE TABLE `event_reminders` (
  `id` bigint UNSIGNED NOT NULL,
  `event_id` bigint UNSIGNED NOT NULL,
  `sent_by` bigint UNSIGNED NOT NULL,
  `channel` enum('email','whatsapp','sms','system') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sent_at` timestamp NOT NULL,
  `sent_by_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `functional_positions`
--

CREATE TABLE `functional_positions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `holidays`
--

CREATE TABLE `holidays` (
  `id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `implementation_arrangements`
--

CREATE TABLE `implementation_arrangements` (
  `id` bigint UNSIGNED NOT NULL,
  `partnership_id` bigint UNSIGNED NOT NULL,
  `partnership_impl_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `document_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `partnership_implementation_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `inventories`
--

CREATE TABLE `inventories` (
  `id` bigint UNSIGNED NOT NULL,
  `item_id` bigint UNSIGNED NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `inventory_procurements`
--

CREATE TABLE `inventory_procurements` (
  `id` bigint UNSIGNED NOT NULL,
  `request_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('draft','submitted','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `inventory_procurement_items`
--

CREATE TABLE `inventory_procurement_items` (
  `id` bigint UNSIGNED NOT NULL,
  `inventory_procurement_id` bigint UNSIGNED NOT NULL,
  `item_id` bigint UNSIGNED DEFAULT NULL,
  `item_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `inventory_purchases`
--

CREATE TABLE `inventory_purchases` (
  `id` bigint UNSIGNED NOT NULL,
  `purchase_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `inventory_procurement_id` bigint UNSIGNED DEFAULT NULL,
  `purchase_date` date NOT NULL,
  `supplier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('draft','completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `inventory_purchase_items`
--

CREATE TABLE `inventory_purchase_items` (
  `id` bigint UNSIGNED NOT NULL,
  `inventory_purchase_id` bigint UNSIGNED NOT NULL,
  `item_id` bigint UNSIGNED NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(12,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `inventory_requests`
--

CREATE TABLE `inventory_requests` (
  `id` bigint UNSIGNED NOT NULL,
  `request_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `request_date` date NOT NULL,
  `status` enum('pending','approved','rejected','fulfilled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `approved_by` bigint UNSIGNED DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `approved_by_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `inventory_request_approvals`
--

CREATE TABLE `inventory_request_approvals` (
  `id` bigint UNSIGNED NOT NULL,
  `inventory_request_id` bigint UNSIGNED NOT NULL,
  `approver_id` bigint UNSIGNED NOT NULL,
  `status` enum('approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `action_date` timestamp NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `inventory_request_details`
--

CREATE TABLE `inventory_request_details` (
  `id` bigint UNSIGNED NOT NULL,
  `inventory_request_id` bigint UNSIGNED NOT NULL,
  `item_id` bigint UNSIGNED DEFAULT NULL,
  `item_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `specification` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `quantity` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `inventory_transactions`
--

CREATE TABLE `inventory_transactions` (
  `id` bigint UNSIGNED NOT NULL,
  `item_id` bigint UNSIGNED NOT NULL,
  `type` enum('in','out','adjustment') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  `transaction_date` date NOT NULL,
  `reference` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `items`
--

CREATE TABLE `items` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `minimal_quantity` int NOT NULL DEFAULT '0',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `job_responsibilities`
--

CREATE TABLE `job_responsibilities` (
  `id` bigint UNSIGNED NOT NULL,
  `structural_position_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('main','function') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `journal_publications`
--

CREATE TABLE `journal_publications` (
  `id` bigint UNSIGNED NOT NULL,
  `publication_id` bigint UNSIGNED NOT NULL,
  `journal_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `issn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `publisher` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `volume` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `issue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pages` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `indexing` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quartile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `leave_approvals`
--

CREATE TABLE `leave_approvals` (
  `id` bigint UNSIGNED NOT NULL,
  `leave_request_id` bigint UNSIGNED NOT NULL,
  `approver_id` bigint UNSIGNED NOT NULL,
  `level` int NOT NULL,
  `status` enum('pending','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `action_date` timestamp NULL DEFAULT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `leave_balances`
--

CREATE TABLE `leave_balances` (
  `id` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `leave_type_id` bigint UNSIGNED NOT NULL,
  `year` year NOT NULL,
  `quota` int NOT NULL,
  `used` int NOT NULL DEFAULT '0',
  `remaining` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `leave_requests`
--

CREATE TABLE `leave_requests` (
  `id` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `leave_type_id` bigint UNSIGNED NOT NULL,
  `approver_id` bigint UNSIGNED DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `total_days` int NOT NULL,
  `reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_leave` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_leave` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','approved','rejected','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `submitted_at` timestamp NOT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `approver_id_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `leave_types`
--

CREATE TABLE `leave_types` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_quota` int NOT NULL,
  `requires_attachment` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `lecturers`
--

CREATE TABLE `lecturers` (
  `id` bigint UNSIGNED NOT NULL,
  `academic_rank` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `functional_position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expertise` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `lecturer_functional_positions`
--

CREATE TABLE `lecturer_functional_positions` (
  `id` bigint UNSIGNED NOT NULL,
  `lecturer_id` bigint UNSIGNED NOT NULL,
  `functional_position_id` bigint UNSIGNED NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `decree_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `decree_date` date DEFAULT NULL,
  `sk_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `meetings`
--

CREATE TABLE `meetings` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `organizer_id` bigint UNSIGNED NOT NULL,
  `leader_id` bigint UNSIGNED NOT NULL,
  `meeting_type` enum('offline','online','hybrid') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `meeting_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `asset_room_id` bigint UNSIGNED DEFAULT NULL,
  `online_platform` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `online_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `committee_id` bigint UNSIGNED DEFAULT NULL,
  `is_confidential` tinyint(1) NOT NULL DEFAULT '0',
  `status` enum('draft','scheduled','completed','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `organizer_id_id` bigint UNSIGNED NOT NULL,
  `leader_id_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `meeting_consumption_requests`
--

CREATE TABLE `meeting_consumption_requests` (
  `id` bigint UNSIGNED NOT NULL,
  `meeting_id` bigint UNSIGNED NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `estimated_participants` int NOT NULL,
  `status` enum('requested','approved','rejected','fulfilled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `requested_at` timestamp NOT NULL,
  `approved_by` bigint UNSIGNED DEFAULT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `meeting_documents`
--

CREATE TABLE `meeting_documents` (
  `id` bigint UNSIGNED NOT NULL,
  `meeting_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uploaded_by` bigint UNSIGNED NOT NULL,
  `uploaded_at` timestamp NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `meeting_external_participants`
--

CREATE TABLE `meeting_external_participants` (
  `id` bigint UNSIGNED NOT NULL,
  `meeting_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `institution` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `meeting_minutes`
--

CREATE TABLE `meeting_minutes` (
  `id` bigint UNSIGNED NOT NULL,
  `meeting_id` bigint UNSIGNED NOT NULL,
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_confidential` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `meeting_participants`
--

CREATE TABLE `meeting_participants` (
  `id` bigint UNSIGNED NOT NULL,
  `meeting_id` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `status` enum('invited','confirmed','attended') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2),
(2, 'App\\Models\\User', 3),
(2, 'App\\Models\\User', 4);

-- --------------------------------------------------------

--
-- Struktur dari tabel `nomenclatures`
--

CREATE TABLE `nomenclatures` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `qualification` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `duties` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `grade` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `nomenclature_classifications`
--

CREATE TABLE `nomenclature_classifications` (
  `id` bigint UNSIGNED NOT NULL,
  `nomenclature_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `official_travel`
--

CREATE TABLE `official_travel` (
  `id` bigint UNSIGNED NOT NULL,
  `request_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `purpose` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `destination` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `invitation_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('draft','pending','approved','rejected','completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `submitted_by` bigint UNSIGNED NOT NULL,
  `submitted_at` timestamp NOT NULL,
  `approved_by` bigint UNSIGNED DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `travel_outcome` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `outcome_followup` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `submitted_by_id` bigint UNSIGNED NOT NULL,
  `approved_by_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `official_travel_approvals`
--

CREATE TABLE `official_travel_approvals` (
  `id` bigint UNSIGNED NOT NULL,
  `official_travel_id` bigint UNSIGNED NOT NULL,
  `approver_id` bigint UNSIGNED NOT NULL,
  `status` enum('approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `action_date` timestamp NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `official_travel_documents`
--

CREATE TABLE `official_travel_documents` (
  `id` bigint UNSIGNED NOT NULL,
  `official_travel_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `official_travel_itineraries`
--

CREATE TABLE `official_travel_itineraries` (
  `id` bigint UNSIGNED NOT NULL,
  `official_travel_id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `activity` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `official_travel_members`
--

CREATE TABLE `official_travel_members` (
  `id` bigint UNSIGNED NOT NULL,
  `official_travel_id` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `report_date` date NOT NULL,
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `organization_units`
--

CREATE TABLE `organization_units` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` bigint UNSIGNED DEFAULT NULL,
  `type` enum('university','faculty','department','lab','unit') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `organization_unit_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `organization_units`
--

INSERT INTO `organization_units` (`id`, `name`, `code`, `parent_id`, `type`, `description`, `organization_unit_id`, `created_at`, `updated_at`) VALUES
(1, 'Fakultas Informatika', 'FIF', NULL, 'faculty', NULL, 1, '2026-06-03 19:35:13', '2026-06-03 19:35:13');

-- --------------------------------------------------------

--
-- Struktur dari tabel `overtime_approval_logs`
--

CREATE TABLE `overtime_approval_logs` (
  `id` bigint UNSIGNED NOT NULL,
  `overtime_request_id` bigint UNSIGNED NOT NULL,
  `approver_id` bigint UNSIGNED NOT NULL,
  `status` enum('approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `action_date` timestamp NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `overtime_requests`
--

CREATE TABLE `overtime_requests` (
  `id` bigint UNSIGNED NOT NULL,
  `request_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `request_date` date NOT NULL,
  `planned_start_time` datetime NOT NULL,
  `planned_end_time` datetime NOT NULL,
  `submitted_by` bigint UNSIGNED NOT NULL,
  `approved_by` bigint UNSIGNED DEFAULT NULL,
  `status` enum('draft','pending','approved','rejected','completed','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `submitted_at` timestamp NULL DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `submitted_by_id` bigint UNSIGNED NOT NULL,
  `approved_by_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `overtime_request_members`
--

CREATE TABLE `overtime_request_members` (
  `id` bigint UNSIGNED NOT NULL,
  `overtime_request_id` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `job_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `planned_hours` decimal(5,2) NOT NULL,
  `actual_start_time` datetime NOT NULL,
  `actual_end_time` datetime NOT NULL,
  `actual_hours` decimal(5,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `partners`
--

CREATE TABLE `partners` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('university','company','government','ngo','other') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `partnerships`
--

CREATE TABLE `partnerships` (
  `id` bigint UNSIGNED NOT NULL,
  `partner_id` bigint UNSIGNED NOT NULL,
  `partner_potential_id` bigint UNSIGNED DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `document_type` enum('moa','pks') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `document_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` enum('active','expired','terminated') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `partnership_documents`
--

CREATE TABLE `partnership_documents` (
  `id` bigint UNSIGNED NOT NULL,
  `partnership_id` bigint UNSIGNED NOT NULL,
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `signed_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `partnership_implementations`
--

CREATE TABLE `partnership_implementations` (
  `id` bigint UNSIGNED NOT NULL,
  `partnership_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `status` enum('planned','ongoing','completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `partner_contacts`
--

CREATE TABLE `partner_contacts` (
  `id` bigint UNSIGNED NOT NULL,
  `partner_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT '0',
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `partner_follow_ups`
--

CREATE TABLE `partner_follow_ups` (
  `id` bigint UNSIGNED NOT NULL,
  `partner_potential_id` bigint UNSIGNED NOT NULL,
  `activity_date` date NOT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` enum('planned','ongoing','completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `conducted_by` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `partner_potentials`
--

CREATE TABLE `partner_potentials` (
  `id` bigint UNSIGNED NOT NULL,
  `partner_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` enum('identified','in_discussion','proposed','converted','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `partner_potential_fields`
--

CREATE TABLE `partner_potential_fields` (
  `id` bigint UNSIGNED NOT NULL,
  `partner_potential_id` bigint UNSIGNED NOT NULL,
  `field` enum('research','community_service','internship','training','other') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `publications`
--

CREATE TABLE `publications` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `publication_date` date NOT NULL,
  `doi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `abstract` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `research_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `publication_authors`
--

CREATE TABLE `publication_authors` (
  `id` bigint UNSIGNED NOT NULL,
  `publication_id` bigint UNSIGNED NOT NULL,
  `lecturer_id` bigint UNSIGNED NOT NULL,
  `author_order` int NOT NULL,
  `is_corresponding` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `research`
--

CREATE TABLE `research` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `funding_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `budget` decimal(12,2) DEFAULT NULL,
  `status` enum('proposed','ongoing','completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `research_members`
--

CREATE TABLE `research_members` (
  `id` bigint UNSIGNED NOT NULL,
  `research_id` bigint UNSIGNED NOT NULL,
  `lecturer_id` bigint UNSIGNED NOT NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'pimpinan', 'web', '2026-06-03 19:35:13', '2026-06-03 19:35:13'),
(2, 'pegawai', 'web', '2026-06-03 19:35:13', '2026-06-03 19:35:13');

-- --------------------------------------------------------

--
-- Struktur dari tabel `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `rooms`
--

CREATE TABLE `rooms` (
  `id` bigint UNSIGNED NOT NULL,
  `asset_id` bigint UNSIGNED NOT NULL,
  `building_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `floor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `capacity` int NOT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT '0',
  `responsible_employee_id` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `room_loans`
--

CREATE TABLE `room_loans` (
  `id` bigint UNSIGNED NOT NULL,
  `room_id` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `purpose` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('requested','approved','rejected','completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `approved_by` bigint UNSIGNED DEFAULT NULL,
  `approved_by_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `room_maintenance_requests`
--

CREATE TABLE `room_maintenance_requests` (
  `id` bigint UNSIGNED NOT NULL,
  `room_id` bigint UNSIGNED NOT NULL,
  `reported_by` bigint UNSIGNED NOT NULL,
  `issue_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('reported','in_progress','resolved') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reported_at` timestamp NOT NULL,
  `resolved_at` timestamp NULL DEFAULT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `room_maintenance_request_log`
--

CREATE TABLE `room_maintenance_request_log` (
  `id` bigint NOT NULL,
  `room_maintenance_request_id` bigint UNSIGNED DEFAULT NULL,
  `log` varchar(45) DEFAULT NULL,
  `logged_by` bigint UNSIGNED DEFAULT NULL,
  `logged_at` datetime DEFAULT NULL,
  `log_file` varchar(255) DEFAULT NULL,
  `verified_by` bigint UNSIGNED DEFAULT NULL,
  `verified_at` datetime DEFAULT NULL,
  `verification_file` varchar(255) DEFAULT NULL,
  `description` text,
  `status` int DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('_FSXa6THi6JiRp-hvQbIeziba4-RLNex', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T08:56:55.744Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782205016),
('_o4hyrnLjPE_Ctb12IoSOj5Gk4zerllP', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T08:56:59.456Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\",\"flashSuccess\":\"Penugasan berhasil ditambahkan.\"}', 1782205019),
('_SLMPEGRdS7mg3NdDy5NCe27cMXeJc90', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:57:58.043Z\",\"httpOnly\":true,\"path\":\"/\"}}', 1782215878),
('-n9a2dX7bf8oH6lq9_o4X9rPvY8aKy5x', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:06:12.603Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782205573),
('0ArPFHPeLTz_yu6NepukCAtCz0F70ZZP', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T08:40:54.846Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782204055),
('1AClqdByQCrjV8NA2-BQDK5HMZofCRMd', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:56:54.562Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782215815),
('1gLuj9JdBvmj8uo9s458ZOtwyNj_ZBBJ', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:59:01.960Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782215942),
('2CvPjjKwmidNJk7MgqlNYnkWBEM8L-m4', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:16:58.682Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782206219),
('2CY2S8LwcxHH9tyR1VpvU4sp-secKPEL', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:15:03.082Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782206103),
('2uZo07JKMxkYcklWVu4laOxTCGuniuOe', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:08:11.185Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782205691),
('2XSqMUNmd-OEVIVNHGzEGRRq9q_bue5B', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:51:25.637Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\",\"flashSuccess\":\"Tugas berhasil dikumpulkan.\"}', 1782215486),
('3dpMhRet059lzBFOFfE5mD3EkOt7dyiS', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:50:47.009Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782215447),
('3jXahUyZWbrABAQ-y98RcLljE-rX2x16', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:57:46.878Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782215867),
('3UO7hnk1JdpJlUU-vXrw2qq5hR3NNSqu', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:06:13.343Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782205574),
('3vnHI8wixbCzE_m7051PB-9VJYXzQ6Iv', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:56:53.944Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782215814),
('6I7nb6NKhdMEmsTIRqmTA0WbO1oPGgbL', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:51:47.942Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\",\"flashSuccess\":\"Penugasan berhasil dihapus.\"}', 1782215508),
('87k0DZJa1NjvBCN2YrQEy9TKj5jTzsfQ', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:51:48.522Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782215509),
('9S136Ma0QLMFLWfJ6ykXYNWdCFUFNPfQ', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T08:41:00.334Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782204061),
('9UvA9yXXN__mDW_QbLJ_8nuR-aitNG3V', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T08:38:33.195Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782203913),
('aOuHRmmvlhChaPyM2jWn0Ccn_kUdrQ2f', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:58:00.863Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782215881),
('aQGpkasRDdkkEGBJZ8IE0jnS_QGWA8x0', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:57:47.779Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782215868),
('BAJ5T9624V2TGEpF7LYBS2lYMOsp3mSj', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T12:14:18.742Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782216861),
('bYscAcJvlAKPfAdnTuFdP1ak0mv3HLVa', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:51:46.926Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\",\"flashSuccess\":\"Penugasan berhasil diperbarui.\"}', 1782215507),
('CeOC-z4jlhE6TMPBWHaRb0wqYYgEiE-y', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:50:46.145Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782215446),
('cHTay_jhdFgUAKdYXEsExfSf_6UOj6P5', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:51:44.992Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\",\"flashSuccess\":\"Penugasan berhasil ditambahkan.\"}', 1782215505),
('cIztCpmmXMqb24LmZ5o7I9wiij4ML-46', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:57:59.905Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782215880),
('dbvK4Z1S8QuXdMbLS3Avee41BnX-xShp', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:54:59.509Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782215700),
('dBWzrEAMBZRWKDbdTZah0F49JW2A1jiD', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:08:00.703Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782205681),
('dp5me-7h93PW_mhAaNXbi2mxxHEiJrAg', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:56:51.261Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782215811),
('Dy1TQeYrY2L9PPkFAMneVJnzDjfsk7BM', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:56:50.287Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782215810),
('E1VsQhNpzWNQGnknICBE2Z6tf1K0_l8S', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:56:57.992Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782215818),
('eERrCgYI4O-RxpTV5aWWCzwN_WpzDpRJ', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T08:38:36.397Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\",\"flashSuccess\":\"Penugasan berhasil ditambahkan.\"}', 1782203916),
('eF2InGJ74S2vI9D_Mjo48S2wXBtb76KT', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:50:48.333Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\",\"flashSuccess\":\"Tugas berhasil dikumpulkan.\"}', 1782215448),
('eHYu5tOdn6PXY5u01zTusQy5MeS_HJBv', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:56:58.428Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782215819),
('EikCGXqc-iVTA_JMfJ0alMEk2XVgHnqJ', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:08:09.012Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782205689),
('EMy-yEQaihfy8DvMxA2erwN1NUcZI9JK', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:07:59.376Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782205680),
('F8jlgeokLJvn_UYrq6I9eWk7CwzEfR_C', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:57:50.676Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782215871),
('ffrnYo89HWPhSzQBHUIjFnTCl0jGXBPg', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:56:52.979Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782215813),
('gMmkYhTYKkg-Gx_aLfbrTk9hS2eEqNm9', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:06:53.559Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782205614),
('GMZraiot__0YHpI8pZ-5fvWO2k1O2Qdf', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:57:54.347Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782215874),
('gPU5OuIUfMavgjMEJubrfQ_9Gk7MZgYV', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T08:40:57.010Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782204057),
('GWrBr7ppvva7kUMGT1fhaRYKwlFA0TV2', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:16:38.625Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782206199),
('HGA52DIilctdAvJ59vCidKXYxrQ24Z3t', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:55:01.149Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782215701),
('HMwDJD70p-NGGsMtYo4MaSF2J9MDzzua', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:15:28.717Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782206129),
('hOaV6-o0Dc_y8pmSOtV-rn74mGX3hkT7', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:17:38.017Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782206258),
('hREyIPpWvP489brfeUv1FPqQqmARU4UM', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:56:52.042Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782215812),
('IkCvkIWJA6KuKqmpD26QYficFN_g0huF', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:16:37.442Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782206197),
('iQYFxnnOK-nGqPb9SpBCwoLDGp0eGgL6', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T08:40:59.635Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782204060),
('IuIEnlYtJwZWyFtS-5tSelAoLkz5-DZJ', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:15:02.531Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782206103),
('iVvp8wfjXa09Wv7QtcUcPX2TidyAvYvj', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T08:56:57.039Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782205017),
('jcQxQAXFmOkbME2mefF9ZM1_o1yWqBH1', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:58:48.125Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782215935),
('jGNpa7MFqoHi4QBQZVtUiLyx6A1weeaH', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:08:06.962Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782205687),
('jMYpKluJE1hbwOkyE1tlp2Ekfsbndm8B', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:57:55.786Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782215876),
('Jtc4SYxQKVSZVw5MZN9QWni5CfRVY-cZ', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:51:43.971Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782215504),
('kC0if37lCGTQz27wo7VV-N1R_K-qvw-A', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:57:48.954Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782215869),
('KdenG3wehaaE9FeeasZyYQKWrXa1X6z_', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:08:32.483Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782205712),
('kdlvnRMcAhUnEhkvU6mmNvRKt8j1c7wu', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:57:45.571Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782215866),
('khzY7vXPkyeDG9KhxTVnLZmNeDVTAZ_x', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:16:35.264Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782206196),
('komsZ0t_sSSS7JWYBPo-JHcE-uCLKoke', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:08:51.437Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782205732),
('kQ0Zga1Roz9JgOMITozLDmVqg3ARl-0u', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:16:34.508Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782206195),
('LcUhgbsHSOs7eiiyfISe0cjLSjInt1cX', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T08:40:57.904Z\",\"httpOnly\":true,\"path\":\"/\"}}', 1782204058),
('M4pbOu4nk-r1PA5yB4-wEGLOoTboCUqC', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T08:40:55.556Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782204056),
('Mm0_6BNfPvHYmAMJPpZqKYK_8wZQ4HCF', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:58:14.404Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\",\"flashSuccess\":\"Tugas berhasil dikumpulkan.\"}', 1782215894),
('n6yLAb23nD7SEQs3uyE9GEJNT0H0TUbC', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T08:38:35.203Z\",\"httpOnly\":true,\"path\":\"/\"}}', 1782203915),
('Npo-QI9Lvb7fyo6u4GC477dDStuAS7Ek', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:53:28.297Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782215608),
('NtalUFuhlZLoV1arxPptch4p5aQXom8v', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:15:04.058Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782206104),
('o3V6_EA5jdQNF_vxNsb5XY_4nW-KogMT', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T08:38:33.690Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782203914),
('OibdTZ56L_ZzuZ0uD4f3ObrW3AJvtd03', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:06:17.678Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782205578),
('PA4LQxkLggltmMrvq2s7YUSXpTQWgrt2', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:53:26.295Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782215606),
('PJvCM1AIsTsaB4JH_EzOFRuzMYdswA6l', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:57:51.655Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782215872),
('pSeBWsMTTqpKqSEOeRGNsb8ni1GKv3AK', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:16:50.978Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782206246),
('puueLXHzMX9hoFeivrf0YT6z8wfMPuxV', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T08:56:57.776Z\",\"httpOnly\":true,\"path\":\"/\"}}', 1782205018),
('PZfaeKIQ_p5z3HpxT2mz8aGDvnsMyPP6', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:56:57.096Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782215817),
('Q_Lv3KsAu3LQGLqD46dt9byzbL1O1-M3', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T08:38:34.192Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782203914),
('Ql3SYyParkgsLYvvLkwwHbNVvJQCCayT', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:16:29.407Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782206190),
('QPF232RYgHBW7J186vs98J0y0BSMGU-B', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:53:33.535Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\",\"flashSuccess\":\"Tugas berhasil dikumpulkan.\"}', 1782215614),
('QutYY4rbxw7D3Iwl45h68jU9CJ6eHArP', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T08:57:00.408Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782205021),
('RBS7qCUd_TQWs4XJ0-kPc4E1HW8eCaMW', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:08:02.654Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782205683),
('S_C06LfRBftmzbel_e_n0RJ1GP6ebKmg', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:57:56.835Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782215877),
('S2LV2NgPmGibeNwe-xrsFck7GkXiJ-cO', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:59:03.775Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782215944),
('sRUdGeNT5bdLBOR6FoPzHaY9SJrXRy8r', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:58:21.578Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782215908),
('Sv2HSMfsyX05eM75RHHd1XRfIhkiRFfg', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:06:15.661Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782205576),
('t9BysoC4j24rG35FY82gTCxKcbt7f6wg', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:06:20.201Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782205580),
('tKn7RIg_5vnfcPwjeLc_deIxRoGG59lU', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:56:55.395Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782215816),
('TnBHnq6FnhgBWhCSHzg4Zk4YaJIyOldT', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:07:26.651Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\",\"flashSuccess\":\"Tugas berhasil dikumpulkan.\"}', 1782205647),
('ttxuooX0E11x3Ppz3TUm0vwd838OXDTP', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:15:50.574Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\",\"flashSuccess\":\"Tugas berhasil dikumpulkan.\"}', 1782206151),
('UBRH6Cy35e1lE2S9qcSMUUfyJbbZzD1g', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:08:00.337Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782205680),
('UFNmOJdRo-LgLx4BzZYNpUUno11ZUu9X', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:53:27.004Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782215607),
('upqfGVBqJn5w7ZLoguuIZKYM5Q7PcLZj', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:08:13.463Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782205693),
('UpXzDQDn-6NUZe9Ozl9CY0kdJpR_gecK', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T08:38:34.664Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782203915),
('vdKU3Y_GX35QMJeNzYWqkuHxEPeLYb-Z', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:57:54.863Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782215875),
('Vl-gadxWqxYkpfTkgmDViC9IZTCBKo9A', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:54:58.866Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782215699),
('vUGx_Shplos1wgeJnuGlT5bziP9GLdrB', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T08:38:36.776Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782203917),
('vX5Y5TC1zY1rcT4eHMWcZnlKFECz_7Ck', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T08:40:56.315Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782204056),
('WEJ2571MqmdIDFNEqpnCjKfuyezSaF7X', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:51:45.454Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782215506),
('WhVp5BVOpU9fvcPRhiGPMXF0QTZlEl3j', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:51:06.849Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\",\"flashSuccess\":\"Tugas berhasil dikumpulkan.\"}', 1782215467),
('wXlaTXsMLz65u3p6kNYNzLXmddpkRkHK', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T08:56:56.393Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782205017),
('Y2QdE7p1msjBYq3GQV4wffcvh5EqqivU', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T08:56:55.239Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782205015),
('yeGyYKmEZj5fUylrZmtYoSOd4wqCjVq4', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:58:41.333Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782215921),
('yp0lt5LUUA38g7J06Pz2WYzzkMiOWdIe', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:17:19.020Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782206239),
('YYzZ3wAxJfXEGv-DVaAShYiTflBVhbHq', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:09:10.201Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782205750),
('Z7qvTn9ypfSaTaCpl86A8ZfvZkIQRCf1', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:53:30.954Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\",\"flashSuccess\":\"Tugas berhasil dikumpulkan.\"}', 1782215611),
('ZgMj9q6SmKqWA_NCYOHZ6MR2Evsrhc5W', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:57:53.405Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782215873),
('zlFsc5iALU_PdYNkEOJidEgnIh9AFHhZ', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T09:08:04.676Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782205685),
('ztHs-97Ec1apBK4Gen6xNNnc7gWPCpDu', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:57:50.143Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":2,\"userName\":\"Duha Alul Bariq\",\"userEmail\":\"duha@example.com\",\"userRole\":\"pegawai\"}', 1782215870),
('zyqMFVRpDjsoaN1eofOA0KnIpRqrPvr5', NULL, NULL, NULL, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2026-06-23T11:59:03.231Z\",\"httpOnly\":true,\"path\":\"/\"},\"userId\":1,\"userName\":\"Shidiq Maihendra\",\"userEmail\":\"shidiq@example.com\",\"userRole\":\"pimpinan\"}', 1782215943);

-- --------------------------------------------------------

--
-- Struktur dari tabel `staff`
--

CREATE TABLE `staff` (
  `id` bigint UNSIGNED NOT NULL,
  `position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `department` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `staff_nomenclature_histories`
--

CREATE TABLE `staff_nomenclature_histories` (
  `id` bigint UNSIGNED NOT NULL,
  `staff_id` bigint UNSIGNED NOT NULL,
  `nomenclature_class_id` bigint UNSIGNED NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `nomenclature_classification_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `structural_positions`
--

CREATE TABLE `structural_positions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` bigint UNSIGNED DEFAULT NULL,
  `grade` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `qualification` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `structural_position_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `structural_position_histories`
--

CREATE TABLE `structural_position_histories` (
  `id` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `structural_position_id` bigint UNSIGNED NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `decree_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `decree_date` date DEFAULT NULL,
  `document` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `students`
--

CREATE TABLE `students` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `regno` varchar(255) NOT NULL,
  `birth_date` datetime DEFAULT NULL,
  `birth_place` varchar(45) DEFAULT NULL,
  `gender` int DEFAULT NULL,
  `religion` int DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `campus_email` varchar(255) DEFAULT NULL,
  `phone_no` varchar(45) DEFAULT NULL,
  `home_address` varchar(255) DEFAULT NULL,
  `home_town` varchar(45) DEFAULT NULL,
  `home_province` varchar(45) DEFAULT NULL,
  `home_postalcode` varchar(5) DEFAULT NULL,
  `current_address` varchar(255) DEFAULT NULL,
  `current_town` varchar(45) DEFAULT NULL,
  `current_province` varchar(45) DEFAULT NULL,
  `current_postalcode` varchar(5) DEFAULT NULL,
  `department_id` bigint UNSIGNED DEFAULT NULL,
  `year` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `advisor_id` bigint UNSIGNED DEFAULT NULL,
  `citizenship` varchar(45) DEFAULT NULL,
  `photo` varchar(45) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `student_requests`
--

CREATE TABLE `student_requests` (
  `id` bigint UNSIGNED NOT NULL,
  `request_nunmber` varchar(45) DEFAULT NULL,
  `request_type` varchar(45) DEFAULT NULL,
  `title` varchar(45) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `requested_by` bigint UNSIGNED DEFAULT NULL,
  `requested_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `student_request_active_references`
--

CREATE TABLE `student_request_active_references` (
  `id` bigint UNSIGNED NOT NULL,
  `student_requests_id` bigint UNSIGNED NOT NULL,
  `student_study_plan_file` varchar(45) DEFAULT NULL,
  `parent_decree_file` varchar(45) DEFAULT NULL,
  `checked_by` bigint UNSIGNED NOT NULL,
  `checked_at` datetime DEFAULT NULL,
  `check_reason` text,
  `signed_by` bigint UNSIGNED NOT NULL,
  `signed_at` datetime DEFAULT NULL,
  `sign_reason` text,
  `status` varchar(45) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `student_request_grad_references`
--

CREATE TABLE `student_request_grad_references` (
  `id` bigint UNSIGNED NOT NULL,
  `student_requests_id` bigint UNSIGNED NOT NULL,
  `cover_letter_department_file` varchar(45) DEFAULT NULL,
  `proof_o_grad_registration_file` varchar(45) DEFAULT NULL,
  `checked_by` bigint UNSIGNED NOT NULL,
  `checked_at` datetime DEFAULT NULL,
  `check_reason` text,
  `signed_by` bigint UNSIGNED NOT NULL,
  `signed_at` datetime DEFAULT NULL,
  `sign_reason` text,
  `status` varchar(45) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `student_request_refund`
--

CREATE TABLE `student_request_refund` (
  `id` bigint UNSIGNED NOT NULL,
  `student_request_id` bigint UNSIGNED DEFAULT NULL,
  `refund_type` enum('UKT','PI') DEFAULT NULL,
  `reason` text,
  `refund_nominal` int DEFAULT NULL,
  `application_letter_file` varchar(45) DEFAULT NULL,
  `ukt_payment_receipt_file` varchar(45) DEFAULT NULL,
  `rector_decree_file` varchar(45) DEFAULT NULL,
  `saving_book_fiel` varchar(45) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `student_request_refund_approvals`
--

CREATE TABLE `student_request_refund_approvals` (
  `id` bigint UNSIGNED NOT NULL,
  `student_request_refund_id` bigint UNSIGNED NOT NULL,
  `level` varchar(45) DEFAULT NULL,
  `approved_by` bigint UNSIGNED NOT NULL,
  `approval_reason` varchar(45) DEFAULT NULL,
  `approval_position` varchar(45) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `student_request_resignation`
--

CREATE TABLE `student_request_resignation` (
  `id` bigint UNSIGNED NOT NULL,
  `student_requests_id` bigint UNSIGNED NOT NULL,
  `student_address` text,
  `student_hp` varchar(45) DEFAULT NULL,
  `current_gpa` double DEFAULT NULL,
  `current_credits` int DEFAULT NULL,
  `reasons` varchar(45) DEFAULT NULL,
  `application_letter_file` varchar(45) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `student_request_resignation_approvals`
--

CREATE TABLE `student_request_resignation_approvals` (
  `id` bigint UNSIGNED NOT NULL,
  `student_request_resignation_id` bigint UNSIGNED NOT NULL,
  `level` varchar(45) DEFAULT NULL,
  `approved_by` bigint UNSIGNED NOT NULL,
  `approval_reason` varchar(45) DEFAULT NULL,
  `approval_position` varchar(45) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `surveys`
--

CREATE TABLE `surveys` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `survey_answers`
--

CREATE TABLE `survey_answers` (
  `id` bigint UNSIGNED NOT NULL,
  `survey_response_id` bigint UNSIGNED NOT NULL,
  `survey_question_id` bigint UNSIGNED NOT NULL,
  `answer_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `survey_answer_options`
--

CREATE TABLE `survey_answer_options` (
  `id` bigint UNSIGNED NOT NULL,
  `survey_answer_id` bigint UNSIGNED NOT NULL,
  `survey_question_option_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `survey_invitations`
--

CREATE TABLE `survey_invitations` (
  `id` bigint UNSIGNED NOT NULL,
  `survey_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_used` tinyint(1) NOT NULL DEFAULT '0',
  `used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `survey_questions`
--

CREATE TABLE `survey_questions` (
  `id` bigint UNSIGNED NOT NULL,
  `question_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('single_choice','multiple_choice','short_answer') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `survey_question_assignments`
--

CREATE TABLE `survey_question_assignments` (
  `id` bigint UNSIGNED NOT NULL,
  `survey_id` bigint UNSIGNED NOT NULL,
  `survey_question_id` bigint UNSIGNED NOT NULL,
  `order` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `survey_question_options`
--

CREATE TABLE `survey_question_options` (
  `id` bigint UNSIGNED NOT NULL,
  `survey_question_id` bigint UNSIGNED NOT NULL,
  `option_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `weight` decimal(5,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `survey_responses`
--

CREATE TABLE `survey_responses` (
  `id` bigint UNSIGNED NOT NULL,
  `survey_id` bigint UNSIGNED NOT NULL,
  `survey_invitation_id` bigint UNSIGNED NOT NULL,
  `submitted_at` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `travel_cost_components`
--

CREATE TABLE `travel_cost_components` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `travel_cost_standards`
--

CREATE TABLE `travel_cost_standards` (
  `id` bigint UNSIGNED NOT NULL,
  `city_id` bigint UNSIGNED NOT NULL,
  `structural_position_id` bigint UNSIGNED DEFAULT NULL,
  `employee_grade_id` bigint UNSIGNED DEFAULT NULL,
  `travel_cost_component_id` bigint UNSIGNED NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `travel_expenses`
--

CREATE TABLE `travel_expenses` (
  `id` bigint UNSIGNED NOT NULL,
  `official_travel_id` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `travel_cost_component_id` bigint UNSIGNED NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `receipt_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `submitted_at` timestamp NOT NULL,
  `verified_at` timestamp NULL DEFAULT NULL,
  `status` enum('submitted','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `two_factor_secret` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `two_factor_recovery_codes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Shidiq Maihendra', 'shidiq@example.com', NULL, '$2b$10$Z8O8a8fO07dyTvtA5F1KAOrt0JHTmmmMV1gsY8qFm0wJ.qSr8Lg7i', NULL, NULL, NULL, NULL, '2026-06-04 00:05:07', '2026-06-04 00:05:07'),
(2, 'Duha Alul Bariq', 'duha@example.com', NULL, '$2b$10$9ogZgKeogyq/Bm37YcYzfeRtZvHVdhvY8DeMN56bDs2ogksJLa8Wa', NULL, NULL, NULL, NULL, '2026-06-04 00:05:07', '2026-06-04 00:05:07'),
(3, 'Adinda Najwa', 'adinda@example.com', NULL, '$2b$10$9ogZgKeogyq/Bm37YcYzfeRtZvHVdhvY8DeMN56bDs2ogksJLa8Wa', NULL, NULL, NULL, NULL, '2026-06-04 00:05:07', '2026-06-04 00:05:07'),
(4, 'Shifa Khalishah', 'shifa@example.com', NULL, '$2b$10$9ogZgKeogyq/Bm37YcYzfeRtZvHVdhvY8DeMN56bDs2ogksJLa8Wa', NULL, NULL, NULL, NULL, '2026-06-04 00:05:07', '2026-06-04 00:05:07');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `assets`
--
ALTER TABLE `assets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `assets_code_unique` (`code`),
  ADD KEY `assets_asset_grant_id_foreign` (`asset_grant_id`);

--
-- Indeks untuk tabel `asset_audits`
--
ALTER TABLE `asset_audits`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `asset_audits_audit_number_unique` (`audit_number`),
  ADD KEY `asset_audits_conducted_by_foreign` (`conducted_by`);

--
-- Indeks untuk tabel `asset_audit_details`
--
ALTER TABLE `asset_audit_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `asset_audit_details_asset_audit_id_foreign` (`asset_audit_id`),
  ADD KEY `asset_audit_details_asset_id_foreign` (`asset_id`);

--
-- Indeks untuk tabel `asset_grants`
--
ALTER TABLE `asset_grants`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `asset_insurances`
--
ALTER TABLE `asset_insurances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `asset_insurances_asset_id_foreign` (`asset_id`);

--
-- Indeks untuk tabel `asset_insurance_claims`
--
ALTER TABLE `asset_insurance_claims`
  ADD PRIMARY KEY (`id`),
  ADD KEY `asset_insurance_claims_asset_insurance_id_foreign` (`asset_insurance_id`);

--
-- Indeks untuk tabel `asset_trackings`
--
ALTER TABLE `asset_trackings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `asset_trackings_asset_id_foreign` (`asset_id`);

--
-- Indeks untuk tabel `asset_tracking_logs`
--
ALTER TABLE `asset_tracking_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `asset_tracking_logs_asset_id_foreign` (`asset_id`),
  ADD KEY `asset_tracking_logs_moved_by_foreign` (`moved_by`);

--
-- Indeks untuk tabel `assignments`
--
ALTER TABLE `assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assignments_assigned_by_foreign` (`assigned_by`),
  ADD KEY `assignments_assigned_to_foreign` (`assigned_to`),
  ADD KEY `assignments_parent_id_foreign` (`parent_id`);

--
-- Indeks untuk tabel `assignment_progress`
--
ALTER TABLE `assignment_progress`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assignment_progress_assignment_id_foreign` (`assignment_id`),
  ADD KEY `assignment_progress_created_by_foreign` (`created_by`);

--
-- Indeks untuk tabel `attendances`
--
ALTER TABLE `attendances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attendances_employee_id_foreign` (`employee_id`);

--
-- Indeks untuk tabel `buildings`
--
ALTER TABLE `buildings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `buildings_code_unique` (`code`);

--
-- Indeks untuk tabel `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indeks untuk tabel `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indeks untuk tabel `committees`
--
ALTER TABLE `committees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `committees_created_by_foreign` (`created_by`);

--
-- Indeks untuk tabel `committee_budgets`
--
ALTER TABLE `committee_budgets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `committee_budgets_committee_id_foreign` (`committee_id`);

--
-- Indeks untuk tabel `committee_budget_items`
--
ALTER TABLE `committee_budget_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `committee_budget_items_committee_budget_id_foreign` (`committee_budget_id`);

--
-- Indeks untuk tabel `committee_expenses`
--
ALTER TABLE `committee_expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `committee_expenses_committee_budget_item_id_foreign` (`committee_budget_item_id`),
  ADD KEY `committee_expenses_approved_by_foreign` (`approved_by`);

--
-- Indeks untuk tabel `committee_external_members`
--
ALTER TABLE `committee_external_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `committee_external_members_committee_id_foreign` (`committee_id`);

--
-- Indeks untuk tabel `committee_members`
--
ALTER TABLE `committee_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `committee_members_committee_id_foreign` (`committee_id`),
  ADD KEY `committee_members_employee_id_foreign` (`employee_id`);

--
-- Indeks untuk tabel `committee_tasks`
--
ALTER TABLE `committee_tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `committee_tasks_committee_id_foreign` (`committee_id`),
  ADD KEY `committee_tasks_assigned_to_foreign` (`assigned_to`);

--
-- Indeks untuk tabel `committee_task_progress`
--
ALTER TABLE `committee_task_progress`
  ADD PRIMARY KEY (`id`),
  ADD KEY `committee_task_progress_committee_task_id_foreign` (`committee_task_id`);

--
-- Indeks untuk tabel `community_services`
--
ALTER TABLE `community_services`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `community_service_members`
--
ALTER TABLE `community_service_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `community_service_members_community_service_id_foreign` (`community_service_id`),
  ADD KEY `community_service_members_lecturer_id_foreign` (`lecturer_id`);

--
-- Indeks untuk tabel `conference_proceedings`
--
ALTER TABLE `conference_proceedings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `conference_proceedings_publication_id_foreign` (`publication_id`);

--
-- Indeks untuk tabel `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_documents_users1_idx` (`created_by`),
  ADD KEY `fk_documents_document_types1_idx` (`document_type_id`);

--
-- Indeks untuk tabel `document_revisions`
--
ALTER TABLE `document_revisions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_document_revisions_documents1_idx` (`document_id`);

--
-- Indeks untuk tabel `document_types`
--
ALTER TABLE `document_types`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `education_histories`
--
ALTER TABLE `education_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `education_histories_employee_id_foreign` (`employee_id`);

--
-- Indeks untuk tabel `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employees_employee_number_unique` (`employee_number`),
  ADD KEY `employees_organization_unit_id_foreign` (`organization_unit_id`),
  ADD KEY `employees_employment_status_id_foreign` (`employment_status_id`);

--
-- Indeks untuk tabel `employee_grades`
--
ALTER TABLE `employee_grades`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `employment_statuses`
--
ALTER TABLE `employment_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `equipments`
--
ALTER TABLE `equipments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `asset_equipment_asset_id_foreign` (`asset_id`);

--
-- Indeks untuk tabel `equipment_loans`
--
ALTER TABLE `equipment_loans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `asset_loans_employee_id_foreign` (`employee_id`),
  ADD KEY `asset_loans_approved_by_foreign` (`approved_by`),
  ADD KEY `asset_loans_asset_equipment_id_foreign_idx` (`equipment_id`);

--
-- Indeks untuk tabel `equipment_maintenance_requests`
--
ALTER TABLE `equipment_maintenance_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `asset_maintenance_requests_reported_by_foreign` (`reported_by`),
  ADD KEY `asset_maintenance_requests_asset_equipment_foreign_idx` (`equipment_id`);

--
-- Indeks untuk tabel `equipment_maintenance_request_log`
--
ALTER TABLE `equipment_maintenance_request_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_equipment_maintenance_request_log_equipment_maintenance__idx` (`equipment_maintenance_request_id`),
  ADD KEY `fk_equipment_maintenance_request_log_employees1_idx` (`logged_by`),
  ADD KEY `fk_equipment_maintenance_request_log_employees2_idx` (`verified_by`);

--
-- Indeks untuk tabel `equipment_procurements`
--
ALTER TABLE `equipment_procurements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `asset_equipment_procurements_request_number_unique` (`request_number`),
  ADD KEY `asset_equipment_procurements_created_by_foreign` (`created_by`);

--
-- Indeks untuk tabel `equipment_proc_items`
--
ALTER TABLE `equipment_proc_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `asset_equipment_proc_items_asset_equipment_proc_id_foreign` (`equipment_proc_id`);

--
-- Indeks untuk tabel `equipment_requests`
--
ALTER TABLE `equipment_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `asset_equipment_requests_request_number_unique` (`request_number`),
  ADD KEY `asset_equipment_requests_employee_id_foreign` (`employee_id`),
  ADD KEY `asset_equipment_requests_approved_by_foreign` (`approved_by`);

--
-- Indeks untuk tabel `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `events_slug_unique` (`slug`),
  ADD KEY `events_created_by_foreign` (`created_by`);

--
-- Indeks untuk tabel `event_attendances`
--
ALTER TABLE `event_attendances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_attendances_event_registration_id_foreign` (`event_registration_id`),
  ADD KEY `event_attendances_checked_by_foreign` (`checked_by`);

--
-- Indeks untuk tabel `event_committee_members`
--
ALTER TABLE `event_committee_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_committee_members_event_id_foreign` (`event_id`),
  ADD KEY `event_committee_members_employee_id_foreign` (`employee_id`);

--
-- Indeks untuk tabel `event_documents`
--
ALTER TABLE `event_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_documents_event_id_foreign` (`event_id`),
  ADD KEY `event_documents_uploaded_by_foreign` (`uploaded_by`);

--
-- Indeks untuk tabel `event_registrations`
--
ALTER TABLE `event_registrations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `event_registrations_registration_number_unique` (`registration_number`),
  ADD UNIQUE KEY `event_registrations_ticket_number_unique` (`ticket_number`),
  ADD UNIQUE KEY `event_registrations_certificate_number_unique` (`certificate_number`),
  ADD KEY `event_registrations_user_id_foreign` (`user_id`),
  ADD KEY `event_registrations_generated_by_foreign` (`generated_by`),
  ADD KEY `event_registrations_event_id_foreign_idx` (`event_id`);

--
-- Indeks untuk tabel `event_reminders`
--
ALTER TABLE `event_reminders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_reminders_event_id_foreign` (`event_id`),
  ADD KEY `event_reminders_sent_by_foreign` (`sent_by`);

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indeks untuk tabel `functional_positions`
--
ALTER TABLE `functional_positions`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `holidays`
--
ALTER TABLE `holidays`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `implementation_arrangements`
--
ALTER TABLE `implementation_arrangements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `implementation_arrangements_partnership_id_foreign` (`partnership_id`),
  ADD KEY `implementation_arrangements_partnership_impl_id_foreign` (`partnership_impl_id`);

--
-- Indeks untuk tabel `inventories`
--
ALTER TABLE `inventories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inventories_item_id_foreign` (`item_id`);

--
-- Indeks untuk tabel `inventory_procurements`
--
ALTER TABLE `inventory_procurements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `inventory_procurements_request_number_unique` (`request_number`),
  ADD KEY `inventory_procurements_created_by_foreign` (`created_by`);

--
-- Indeks untuk tabel `inventory_procurement_items`
--
ALTER TABLE `inventory_procurement_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inventory_procurement_items_inventory_procurement_id_foreign` (`inventory_procurement_id`),
  ADD KEY `inventory_procurement_items_item_id_foreign` (`item_id`);

--
-- Indeks untuk tabel `inventory_purchases`
--
ALTER TABLE `inventory_purchases`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `inventory_purchases_purchase_number_unique` (`purchase_number`),
  ADD KEY `inventory_purchases_inventory_procurement_id_foreign` (`inventory_procurement_id`);

--
-- Indeks untuk tabel `inventory_purchase_items`
--
ALTER TABLE `inventory_purchase_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inventory_purchase_items_inventory_purchase_id_foreign` (`inventory_purchase_id`),
  ADD KEY `inventory_purchase_items_item_id_foreign` (`item_id`);

--
-- Indeks untuk tabel `inventory_requests`
--
ALTER TABLE `inventory_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `inventory_requests_request_number_unique` (`request_number`),
  ADD KEY `inventory_requests_employee_id_foreign` (`employee_id`),
  ADD KEY `inventory_requests_approved_by_foreign` (`approved_by`);

--
-- Indeks untuk tabel `inventory_request_approvals`
--
ALTER TABLE `inventory_request_approvals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inventory_request_approvals_inventory_request_id_foreign` (`inventory_request_id`),
  ADD KEY `inventory_request_approvals_approver_id_foreign` (`approver_id`);

--
-- Indeks untuk tabel `inventory_request_details`
--
ALTER TABLE `inventory_request_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inventory_request_details_inventory_request_id_foreign` (`inventory_request_id`),
  ADD KEY `inventory_request_details_item_id_foreign` (`item_id`);

--
-- Indeks untuk tabel `inventory_transactions`
--
ALTER TABLE `inventory_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inventory_transactions_item_id_foreign` (`item_id`);

--
-- Indeks untuk tabel `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `items_code_unique` (`code`);

--
-- Indeks untuk tabel `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indeks untuk tabel `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `job_responsibilities`
--
ALTER TABLE `job_responsibilities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_responsibilities_structural_position_id_foreign` (`structural_position_id`);

--
-- Indeks untuk tabel `journal_publications`
--
ALTER TABLE `journal_publications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `journal_publications_publication_id_foreign` (`publication_id`);

--
-- Indeks untuk tabel `leave_approvals`
--
ALTER TABLE `leave_approvals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `leave_approvals_leave_request_id_foreign` (`leave_request_id`),
  ADD KEY `leave_approvals_approver_id_foreign` (`approver_id`);

--
-- Indeks untuk tabel `leave_balances`
--
ALTER TABLE `leave_balances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `leave_balances_employee_id_foreign` (`employee_id`),
  ADD KEY `leave_balances_leave_type_id_foreign` (`leave_type_id`);

--
-- Indeks untuk tabel `leave_requests`
--
ALTER TABLE `leave_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `leave_requests_employee_id_foreign` (`employee_id`),
  ADD KEY `leave_requests_leave_type_id_foreign` (`leave_type_id`),
  ADD KEY `leave_requests_approver_id_foreign` (`approver_id`);

--
-- Indeks untuk tabel `leave_types`
--
ALTER TABLE `leave_types`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `lecturers`
--
ALTER TABLE `lecturers`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `lecturer_functional_positions`
--
ALTER TABLE `lecturer_functional_positions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lecturer_functional_positions_lecturer_id_foreign` (`lecturer_id`),
  ADD KEY `lecturer_functional_positions_functional_position_id_foreign` (`functional_position_id`);

--
-- Indeks untuk tabel `meetings`
--
ALTER TABLE `meetings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meetings_organizer_id_foreign` (`organizer_id`),
  ADD KEY `meetings_leader_id_foreign` (`leader_id`),
  ADD KEY `meetings_asset_room_id_foreign` (`asset_room_id`),
  ADD KEY `meetings_committee_id_foreign` (`committee_id`);

--
-- Indeks untuk tabel `meeting_consumption_requests`
--
ALTER TABLE `meeting_consumption_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meeting_consumption_requests_meeting_id_foreign` (`meeting_id`),
  ADD KEY `meeting_consumption_requests_approved_by_foreign` (`approved_by`);

--
-- Indeks untuk tabel `meeting_documents`
--
ALTER TABLE `meeting_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meeting_documents_meeting_id_foreign` (`meeting_id`),
  ADD KEY `meeting_documents_uploaded_by_foreign` (`uploaded_by`);

--
-- Indeks untuk tabel `meeting_external_participants`
--
ALTER TABLE `meeting_external_participants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meeting_external_participants_meeting_id_foreign` (`meeting_id`);

--
-- Indeks untuk tabel `meeting_minutes`
--
ALTER TABLE `meeting_minutes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meeting_minutes_meeting_id_foreign` (`meeting_id`),
  ADD KEY `meeting_minutes_created_by_foreign` (`created_by`);

--
-- Indeks untuk tabel `meeting_participants`
--
ALTER TABLE `meeting_participants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meeting_participants_meeting_id_foreign` (`meeting_id`),
  ADD KEY `meeting_participants_employee_id_foreign` (`employee_id`);

--
-- Indeks untuk tabel `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indeks untuk tabel `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indeks untuk tabel `nomenclatures`
--
ALTER TABLE `nomenclatures`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `nomenclature_classifications`
--
ALTER TABLE `nomenclature_classifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nomenclature_classifications_nomenclature_id_foreign` (`nomenclature_id`);

--
-- Indeks untuk tabel `official_travel`
--
ALTER TABLE `official_travel`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `official_travel_request_number_unique` (`request_number`),
  ADD KEY `official_travel_submitted_by_foreign` (`submitted_by`),
  ADD KEY `official_travel_approved_by_foreign` (`approved_by`);

--
-- Indeks untuk tabel `official_travel_approvals`
--
ALTER TABLE `official_travel_approvals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `official_travel_approvals_official_travel_id_foreign` (`official_travel_id`),
  ADD KEY `official_travel_approvals_approver_id_foreign` (`approver_id`);

--
-- Indeks untuk tabel `official_travel_documents`
--
ALTER TABLE `official_travel_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `official_travel_documents_official_travel_id_foreign` (`official_travel_id`);

--
-- Indeks untuk tabel `official_travel_itineraries`
--
ALTER TABLE `official_travel_itineraries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `official_travel_itineraries_official_travel_id_foreign` (`official_travel_id`);

--
-- Indeks untuk tabel `official_travel_members`
--
ALTER TABLE `official_travel_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `official_travel_members_official_travel_id_foreign` (`official_travel_id`),
  ADD KEY `official_travel_members_employee_id_foreign` (`employee_id`);

--
-- Indeks untuk tabel `organization_units`
--
ALTER TABLE `organization_units`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `organization_units_code_unique` (`code`),
  ADD KEY `organization_units_parent_id_foreign` (`parent_id`);

--
-- Indeks untuk tabel `overtime_approval_logs`
--
ALTER TABLE `overtime_approval_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `overtime_approval_logs_overtime_request_id_foreign` (`overtime_request_id`),
  ADD KEY `overtime_approval_logs_approver_id_foreign` (`approver_id`);

--
-- Indeks untuk tabel `overtime_requests`
--
ALTER TABLE `overtime_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `overtime_requests_request_number_unique` (`request_number`),
  ADD KEY `overtime_requests_submitted_by_foreign` (`submitted_by`),
  ADD KEY `overtime_requests_approved_by_foreign` (`approved_by`);

--
-- Indeks untuk tabel `overtime_request_members`
--
ALTER TABLE `overtime_request_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `overtime_request_members_overtime_request_id_foreign` (`overtime_request_id`),
  ADD KEY `overtime_request_members_employee_id_foreign` (`employee_id`);

--
-- Indeks untuk tabel `partners`
--
ALTER TABLE `partners`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `partnerships`
--
ALTER TABLE `partnerships`
  ADD PRIMARY KEY (`id`),
  ADD KEY `partnerships_partner_id_foreign` (`partner_id`),
  ADD KEY `partnerships_partner_potential_id_foreign` (`partner_potential_id`);

--
-- Indeks untuk tabel `partnership_documents`
--
ALTER TABLE `partnership_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `partnership_documents_partnership_id_foreign` (`partnership_id`);

--
-- Indeks untuk tabel `partnership_implementations`
--
ALTER TABLE `partnership_implementations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `partnership_implementations_partnership_id_foreign` (`partnership_id`);

--
-- Indeks untuk tabel `partner_contacts`
--
ALTER TABLE `partner_contacts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `partner_contacts_partner_id_foreign` (`partner_id`);

--
-- Indeks untuk tabel `partner_follow_ups`
--
ALTER TABLE `partner_follow_ups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `partner_follow_ups_partner_potential_id_foreign` (`partner_potential_id`),
  ADD KEY `partner_follow_ups_conducted_by_foreign` (`conducted_by`);

--
-- Indeks untuk tabel `partner_potentials`
--
ALTER TABLE `partner_potentials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `partner_potentials_partner_id_foreign` (`partner_id`);

--
-- Indeks untuk tabel `partner_potential_fields`
--
ALTER TABLE `partner_potential_fields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `partner_potential_fields_partner_potential_id_foreign` (`partner_potential_id`);

--
-- Indeks untuk tabel `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indeks untuk tabel `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indeks untuk tabel `publications`
--
ALTER TABLE `publications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `publications_research_id_foreign` (`research_id`);

--
-- Indeks untuk tabel `publication_authors`
--
ALTER TABLE `publication_authors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `publication_authors_publication_id_foreign` (`publication_id`),
  ADD KEY `publication_authors_lecturer_id_foreign` (`lecturer_id`);

--
-- Indeks untuk tabel `research`
--
ALTER TABLE `research`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `research_members`
--
ALTER TABLE `research_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `research_members_research_id_foreign` (`research_id`),
  ADD KEY `research_members_lecturer_id_foreign` (`lecturer_id`);

--
-- Indeks untuk tabel `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indeks untuk tabel `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indeks untuk tabel `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `asset_rooms_code_unique` (`code`),
  ADD KEY `asset_rooms_asset_id_foreign` (`asset_id`),
  ADD KEY `asset_rooms_building_id_foreign` (`building_id`),
  ADD KEY `asset_rooms_responsible_employee_id_foreign` (`responsible_employee_id`);

--
-- Indeks untuk tabel `room_loans`
--
ALTER TABLE `room_loans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `room_loans_asset_room_id_foreign` (`room_id`),
  ADD KEY `room_loans_employee_id_foreign` (`employee_id`),
  ADD KEY `room_loans_approved_by_foreign` (`approved_by`);

--
-- Indeks untuk tabel `room_maintenance_requests`
--
ALTER TABLE `room_maintenance_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `room_maintenance_requests_asset_room_id_foreign` (`room_id`),
  ADD KEY `room_maintenance_requests_reported_by_foreign` (`reported_by`);

--
-- Indeks untuk tabel `room_maintenance_request_log`
--
ALTER TABLE `room_maintenance_request_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_room_maintenance_request_log_room_maintenance_requests1_idx` (`room_maintenance_request_id`),
  ADD KEY `fk_room_maintenance_request_log_employees1_idx` (`logged_by`),
  ADD KEY `fk_room_maintenance_request_log_employees2_idx` (`verified_by`);

--
-- Indeks untuk tabel `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indeks untuk tabel `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `staff_nomenclature_histories`
--
ALTER TABLE `staff_nomenclature_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `staff_nomenclature_histories_staff_id_foreign` (`staff_id`),
  ADD KEY `staff_nomenclature_histories_nomenclature_class_id_foreign` (`nomenclature_class_id`);

--
-- Indeks untuk tabel `structural_positions`
--
ALTER TABLE `structural_positions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `structural_positions_parent_id_foreign` (`parent_id`);

--
-- Indeks untuk tabel `structural_position_histories`
--
ALTER TABLE `structural_position_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `structural_position_histories_employee_id_foreign` (`employee_id`),
  ADD KEY `structural_position_histories_structural_position_id_foreign` (`structural_position_id`);

--
-- Indeks untuk tabel `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_students_lecturers1_idx` (`advisor_id`),
  ADD KEY `fk_students_organization_units1_idx` (`department_id`);

--
-- Indeks untuk tabel `student_requests`
--
ALTER TABLE `student_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_student_requests_students1_idx` (`requested_by`);

--
-- Indeks untuk tabel `student_request_active_references`
--
ALTER TABLE `student_request_active_references`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_student_request_recomendations_student_requests1_idx` (`student_requests_id`),
  ADD KEY `fk_student_request_recomendations_employees1_idx` (`signed_by`),
  ADD KEY `fk_student_request_recomendations_employees2_idx` (`checked_by`);

--
-- Indeks untuk tabel `student_request_grad_references`
--
ALTER TABLE `student_request_grad_references`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_student_request_recomendations_student_requests1_idx` (`student_requests_id`),
  ADD KEY `fk_student_request_recomendations_employees1_idx` (`signed_by`),
  ADD KEY `fk_student_request_recomendations_employees2_idx` (`checked_by`);

--
-- Indeks untuk tabel `student_request_refund`
--
ALTER TABLE `student_request_refund`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_student_request_refund_student_requests1_idx` (`student_request_id`);

--
-- Indeks untuk tabel `student_request_refund_approvals`
--
ALTER TABLE `student_request_refund_approvals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_student_request_refund_approvals_student_request_refund1_idx` (`student_request_refund_id`),
  ADD KEY `fk_student_request_refund_approvals_employees1_idx` (`approved_by`);

--
-- Indeks untuk tabel `student_request_resignation`
--
ALTER TABLE `student_request_resignation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_student_request_resignation_student_requests1_idx` (`student_requests_id`);

--
-- Indeks untuk tabel `student_request_resignation_approvals`
--
ALTER TABLE `student_request_resignation_approvals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_student_request_refund_approvals_employees1_idx` (`approved_by`),
  ADD KEY `fk_student_request_refund_approvals_student_request_refund1_idx` (`student_request_resignation_id`);

--
-- Indeks untuk tabel `surveys`
--
ALTER TABLE `surveys`
  ADD PRIMARY KEY (`id`),
  ADD KEY `surveys_created_by_foreign` (`created_by`);

--
-- Indeks untuk tabel `survey_answers`
--
ALTER TABLE `survey_answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `survey_answers_survey_response_id_foreign` (`survey_response_id`),
  ADD KEY `survey_answers_survey_question_id_foreign` (`survey_question_id`);

--
-- Indeks untuk tabel `survey_answer_options`
--
ALTER TABLE `survey_answer_options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `survey_answer_options_survey_answer_id_foreign` (`survey_answer_id`),
  ADD KEY `survey_answer_options_survey_question_option_id_foreign` (`survey_question_option_id`);

--
-- Indeks untuk tabel `survey_invitations`
--
ALTER TABLE `survey_invitations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `survey_invitations_pin_unique` (`pin`),
  ADD KEY `survey_invitations_survey_id_foreign` (`survey_id`);

--
-- Indeks untuk tabel `survey_questions`
--
ALTER TABLE `survey_questions`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `survey_question_assignments`
--
ALTER TABLE `survey_question_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `survey_question_assignments_survey_id_foreign` (`survey_id`),
  ADD KEY `survey_question_assignments_survey_question_id_foreign` (`survey_question_id`);

--
-- Indeks untuk tabel `survey_question_options`
--
ALTER TABLE `survey_question_options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `survey_question_options_survey_question_id_foreign` (`survey_question_id`);

--
-- Indeks untuk tabel `survey_responses`
--
ALTER TABLE `survey_responses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `survey_responses_survey_id_foreign` (`survey_id`),
  ADD KEY `survey_responses_survey_invitation_id_foreign` (`survey_invitation_id`);

--
-- Indeks untuk tabel `travel_cost_components`
--
ALTER TABLE `travel_cost_components`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `travel_cost_components_code_unique` (`code`);

--
-- Indeks untuk tabel `travel_cost_standards`
--
ALTER TABLE `travel_cost_standards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `travel_cost_standards_city_id_foreign` (`city_id`),
  ADD KEY `travel_cost_standards_structural_position_id_foreign` (`structural_position_id`),
  ADD KEY `travel_cost_standards_employee_grade_id_foreign` (`employee_grade_id`),
  ADD KEY `travel_cost_standards_travel_cost_component_id_foreign` (`travel_cost_component_id`);

--
-- Indeks untuk tabel `travel_expenses`
--
ALTER TABLE `travel_expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `travel_expenses_official_travel_id_foreign` (`official_travel_id`),
  ADD KEY `travel_expenses_employee_id_foreign` (`employee_id`),
  ADD KEY `travel_expenses_travel_cost_component_id_foreign` (`travel_cost_component_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `assets`
--
ALTER TABLE `assets`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `asset_audits`
--
ALTER TABLE `asset_audits`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `asset_audit_details`
--
ALTER TABLE `asset_audit_details`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `asset_grants`
--
ALTER TABLE `asset_grants`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `asset_insurances`
--
ALTER TABLE `asset_insurances`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `asset_insurance_claims`
--
ALTER TABLE `asset_insurance_claims`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `asset_trackings`
--
ALTER TABLE `asset_trackings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `asset_tracking_logs`
--
ALTER TABLE `asset_tracking_logs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `assignments`
--
ALTER TABLE `assignments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT untuk tabel `assignment_progress`
--
ALTER TABLE `assignment_progress`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT untuk tabel `attendances`
--
ALTER TABLE `attendances`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `buildings`
--
ALTER TABLE `buildings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `committees`
--
ALTER TABLE `committees`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `committee_budgets`
--
ALTER TABLE `committee_budgets`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `committee_budget_items`
--
ALTER TABLE `committee_budget_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `committee_expenses`
--
ALTER TABLE `committee_expenses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `committee_external_members`
--
ALTER TABLE `committee_external_members`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `committee_members`
--
ALTER TABLE `committee_members`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `committee_tasks`
--
ALTER TABLE `committee_tasks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `committee_task_progress`
--
ALTER TABLE `committee_task_progress`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `community_services`
--
ALTER TABLE `community_services`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `community_service_members`
--
ALTER TABLE `community_service_members`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `conference_proceedings`
--
ALTER TABLE `conference_proceedings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `education_histories`
--
ALTER TABLE `education_histories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `employees`
--
ALTER TABLE `employees`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `employee_grades`
--
ALTER TABLE `employee_grades`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `employment_statuses`
--
ALTER TABLE `employment_statuses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `equipments`
--
ALTER TABLE `equipments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `equipment_loans`
--
ALTER TABLE `equipment_loans`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `equipment_maintenance_requests`
--
ALTER TABLE `equipment_maintenance_requests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `equipment_procurements`
--
ALTER TABLE `equipment_procurements`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `equipment_proc_items`
--
ALTER TABLE `equipment_proc_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `equipment_requests`
--
ALTER TABLE `equipment_requests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `events`
--
ALTER TABLE `events`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `event_attendances`
--
ALTER TABLE `event_attendances`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `event_committee_members`
--
ALTER TABLE `event_committee_members`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `event_documents`
--
ALTER TABLE `event_documents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `event_registrations`
--
ALTER TABLE `event_registrations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `event_reminders`
--
ALTER TABLE `event_reminders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `functional_positions`
--
ALTER TABLE `functional_positions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `holidays`
--
ALTER TABLE `holidays`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `implementation_arrangements`
--
ALTER TABLE `implementation_arrangements`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `inventories`
--
ALTER TABLE `inventories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `inventory_procurements`
--
ALTER TABLE `inventory_procurements`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `inventory_procurement_items`
--
ALTER TABLE `inventory_procurement_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `inventory_purchases`
--
ALTER TABLE `inventory_purchases`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `inventory_purchase_items`
--
ALTER TABLE `inventory_purchase_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `inventory_requests`
--
ALTER TABLE `inventory_requests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `inventory_request_approvals`
--
ALTER TABLE `inventory_request_approvals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `inventory_request_details`
--
ALTER TABLE `inventory_request_details`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `inventory_transactions`
--
ALTER TABLE `inventory_transactions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `items`
--
ALTER TABLE `items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `job_responsibilities`
--
ALTER TABLE `job_responsibilities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `journal_publications`
--
ALTER TABLE `journal_publications`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `leave_approvals`
--
ALTER TABLE `leave_approvals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `leave_balances`
--
ALTER TABLE `leave_balances`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `leave_requests`
--
ALTER TABLE `leave_requests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `leave_types`
--
ALTER TABLE `leave_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `lecturers`
--
ALTER TABLE `lecturers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `lecturer_functional_positions`
--
ALTER TABLE `lecturer_functional_positions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `meetings`
--
ALTER TABLE `meetings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `meeting_consumption_requests`
--
ALTER TABLE `meeting_consumption_requests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `meeting_documents`
--
ALTER TABLE `meeting_documents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `meeting_external_participants`
--
ALTER TABLE `meeting_external_participants`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `meeting_minutes`
--
ALTER TABLE `meeting_minutes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `meeting_participants`
--
ALTER TABLE `meeting_participants`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `nomenclatures`
--
ALTER TABLE `nomenclatures`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `nomenclature_classifications`
--
ALTER TABLE `nomenclature_classifications`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `official_travel`
--
ALTER TABLE `official_travel`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `official_travel_approvals`
--
ALTER TABLE `official_travel_approvals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `official_travel_documents`
--
ALTER TABLE `official_travel_documents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `official_travel_itineraries`
--
ALTER TABLE `official_travel_itineraries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `official_travel_members`
--
ALTER TABLE `official_travel_members`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `organization_units`
--
ALTER TABLE `organization_units`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `overtime_approval_logs`
--
ALTER TABLE `overtime_approval_logs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `overtime_requests`
--
ALTER TABLE `overtime_requests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `overtime_request_members`
--
ALTER TABLE `overtime_request_members`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `partners`
--
ALTER TABLE `partners`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `partnerships`
--
ALTER TABLE `partnerships`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `partnership_documents`
--
ALTER TABLE `partnership_documents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `partnership_implementations`
--
ALTER TABLE `partnership_implementations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `partner_contacts`
--
ALTER TABLE `partner_contacts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `partner_follow_ups`
--
ALTER TABLE `partner_follow_ups`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `partner_potentials`
--
ALTER TABLE `partner_potentials`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `partner_potential_fields`
--
ALTER TABLE `partner_potential_fields`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `publications`
--
ALTER TABLE `publications`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `publication_authors`
--
ALTER TABLE `publication_authors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `research`
--
ALTER TABLE `research`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `research_members`
--
ALTER TABLE `research_members`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `room_loans`
--
ALTER TABLE `room_loans`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `room_maintenance_requests`
--
ALTER TABLE `room_maintenance_requests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `staff`
--
ALTER TABLE `staff`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `staff_nomenclature_histories`
--
ALTER TABLE `staff_nomenclature_histories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `structural_positions`
--
ALTER TABLE `structural_positions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `structural_position_histories`
--
ALTER TABLE `structural_position_histories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `surveys`
--
ALTER TABLE `surveys`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `survey_answers`
--
ALTER TABLE `survey_answers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `survey_answer_options`
--
ALTER TABLE `survey_answer_options`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `survey_invitations`
--
ALTER TABLE `survey_invitations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `survey_questions`
--
ALTER TABLE `survey_questions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `survey_question_assignments`
--
ALTER TABLE `survey_question_assignments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `survey_question_options`
--
ALTER TABLE `survey_question_options`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `survey_responses`
--
ALTER TABLE `survey_responses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `travel_cost_components`
--
ALTER TABLE `travel_cost_components`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `travel_cost_standards`
--
ALTER TABLE `travel_cost_standards`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `travel_expenses`
--
ALTER TABLE `travel_expenses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `assets`
--
ALTER TABLE `assets`
  ADD CONSTRAINT `assets_asset_grant_id_foreign` FOREIGN KEY (`asset_grant_id`) REFERENCES `asset_grants` (`id`);

--
-- Ketidakleluasaan untuk tabel `asset_audits`
--
ALTER TABLE `asset_audits`
  ADD CONSTRAINT `asset_audits_conducted_by_foreign` FOREIGN KEY (`conducted_by`) REFERENCES `employees` (`id`);

--
-- Ketidakleluasaan untuk tabel `asset_audit_details`
--
ALTER TABLE `asset_audit_details`
  ADD CONSTRAINT `asset_audit_details_asset_audit_id_foreign` FOREIGN KEY (`asset_audit_id`) REFERENCES `asset_audits` (`id`),
  ADD CONSTRAINT `asset_audit_details_asset_id_foreign` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`);

--
-- Ketidakleluasaan untuk tabel `asset_insurances`
--
ALTER TABLE `asset_insurances`
  ADD CONSTRAINT `asset_insurances_asset_id_foreign` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`);

--
-- Ketidakleluasaan untuk tabel `asset_insurance_claims`
--
ALTER TABLE `asset_insurance_claims`
  ADD CONSTRAINT `asset_insurance_claims_asset_insurance_id_foreign` FOREIGN KEY (`asset_insurance_id`) REFERENCES `asset_insurances` (`id`);

--
-- Ketidakleluasaan untuk tabel `asset_trackings`
--
ALTER TABLE `asset_trackings`
  ADD CONSTRAINT `asset_trackings_asset_id_foreign` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`);

--
-- Ketidakleluasaan untuk tabel `asset_tracking_logs`
--
ALTER TABLE `asset_tracking_logs`
  ADD CONSTRAINT `asset_tracking_logs_asset_id_foreign` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`),
  ADD CONSTRAINT `asset_tracking_logs_moved_by_foreign` FOREIGN KEY (`moved_by`) REFERENCES `employees` (`id`);

--
-- Ketidakleluasaan untuk tabel `assignments`
--
ALTER TABLE `assignments`
  ADD CONSTRAINT `assignments_assigned_by_foreign` FOREIGN KEY (`assigned_by`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `assignments_assigned_to_foreign` FOREIGN KEY (`assigned_to`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `assignments_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `assignments` (`id`);

--
-- Ketidakleluasaan untuk tabel `assignment_progress`
--
ALTER TABLE `assignment_progress`
  ADD CONSTRAINT `assignment_progress_assignment_id_foreign` FOREIGN KEY (`assignment_id`) REFERENCES `assignments` (`id`),
  ADD CONSTRAINT `assignment_progress_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `employees` (`id`);

--
-- Ketidakleluasaan untuk tabel `attendances`
--
ALTER TABLE `attendances`
  ADD CONSTRAINT `attendances_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);

--
-- Ketidakleluasaan untuk tabel `committees`
--
ALTER TABLE `committees`
  ADD CONSTRAINT `committees_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `employees` (`id`);

--
-- Ketidakleluasaan untuk tabel `committee_budgets`
--
ALTER TABLE `committee_budgets`
  ADD CONSTRAINT `committee_budgets_committee_id_foreign` FOREIGN KEY (`committee_id`) REFERENCES `committees` (`id`);

--
-- Ketidakleluasaan untuk tabel `committee_budget_items`
--
ALTER TABLE `committee_budget_items`
  ADD CONSTRAINT `committee_budget_items_committee_budget_id_foreign` FOREIGN KEY (`committee_budget_id`) REFERENCES `committee_budgets` (`id`);

--
-- Ketidakleluasaan untuk tabel `committee_expenses`
--
ALTER TABLE `committee_expenses`
  ADD CONSTRAINT `committee_expenses_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `committee_expenses_committee_budget_item_id_foreign` FOREIGN KEY (`committee_budget_item_id`) REFERENCES `committee_budget_items` (`id`);

--
-- Ketidakleluasaan untuk tabel `committee_external_members`
--
ALTER TABLE `committee_external_members`
  ADD CONSTRAINT `committee_external_members_committee_id_foreign` FOREIGN KEY (`committee_id`) REFERENCES `committees` (`id`);

--
-- Ketidakleluasaan untuk tabel `committee_members`
--
ALTER TABLE `committee_members`
  ADD CONSTRAINT `committee_members_committee_id_foreign` FOREIGN KEY (`committee_id`) REFERENCES `committees` (`id`),
  ADD CONSTRAINT `committee_members_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);

--
-- Ketidakleluasaan untuk tabel `committee_tasks`
--
ALTER TABLE `committee_tasks`
  ADD CONSTRAINT `committee_tasks_assigned_to_foreign` FOREIGN KEY (`assigned_to`) REFERENCES `committee_members` (`id`),
  ADD CONSTRAINT `committee_tasks_committee_id_foreign` FOREIGN KEY (`committee_id`) REFERENCES `committees` (`id`);

--
-- Ketidakleluasaan untuk tabel `committee_task_progress`
--
ALTER TABLE `committee_task_progress`
  ADD CONSTRAINT `committee_task_progress_committee_task_id_foreign` FOREIGN KEY (`committee_task_id`) REFERENCES `committee_tasks` (`id`);

--
-- Ketidakleluasaan untuk tabel `community_service_members`
--
ALTER TABLE `community_service_members`
  ADD CONSTRAINT `community_service_members_community_service_id_foreign` FOREIGN KEY (`community_service_id`) REFERENCES `community_services` (`id`),
  ADD CONSTRAINT `community_service_members_lecturer_id_foreign` FOREIGN KEY (`lecturer_id`) REFERENCES `lecturers` (`id`);

--
-- Ketidakleluasaan untuk tabel `conference_proceedings`
--
ALTER TABLE `conference_proceedings`
  ADD CONSTRAINT `conference_proceedings_publication_id_foreign` FOREIGN KEY (`publication_id`) REFERENCES `publications` (`id`);

--
-- Ketidakleluasaan untuk tabel `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `fk_documents_document_types1` FOREIGN KEY (`document_type_id`) REFERENCES `document_types` (`id`),
  ADD CONSTRAINT `fk_documents_users1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `document_revisions`
--
ALTER TABLE `document_revisions`
  ADD CONSTRAINT `fk_document_revisions_documents1` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`);

--
-- Ketidakleluasaan untuk tabel `education_histories`
--
ALTER TABLE `education_histories`
  ADD CONSTRAINT `education_histories_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);

--
-- Ketidakleluasaan untuk tabel `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_employment_status_id_foreign` FOREIGN KEY (`employment_status_id`) REFERENCES `employment_statuses` (`id`),
  ADD CONSTRAINT `employees_organization_unit_id_foreign` FOREIGN KEY (`organization_unit_id`) REFERENCES `organization_units` (`id`),
  ADD CONSTRAINT `employees_user_id_foreign` FOREIGN KEY (`id`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `equipments`
--
ALTER TABLE `equipments`
  ADD CONSTRAINT `asset_equipment_asset_id_foreign` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`);

--
-- Ketidakleluasaan untuk tabel `equipment_loans`
--
ALTER TABLE `equipment_loans`
  ADD CONSTRAINT `asset_loans_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `asset_loans_asset_equipment_id_foreign` FOREIGN KEY (`equipment_id`) REFERENCES `equipments` (`id`),
  ADD CONSTRAINT `asset_loans_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);

--
-- Ketidakleluasaan untuk tabel `equipment_maintenance_requests`
--
ALTER TABLE `equipment_maintenance_requests`
  ADD CONSTRAINT `asset_maintenance_requests_asset_equipment_foreign` FOREIGN KEY (`equipment_id`) REFERENCES `equipments` (`id`),
  ADD CONSTRAINT `asset_maintenance_requests_reported_by_foreign` FOREIGN KEY (`reported_by`) REFERENCES `employees` (`id`);

--
-- Ketidakleluasaan untuk tabel `equipment_maintenance_request_log`
--
ALTER TABLE `equipment_maintenance_request_log`
  ADD CONSTRAINT `fk_equipment_maintenance_request_log_employees1` FOREIGN KEY (`logged_by`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `fk_equipment_maintenance_request_log_employees2` FOREIGN KEY (`verified_by`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `fk_equipment_maintenance_request_log_equipment_maintenance_re1` FOREIGN KEY (`equipment_maintenance_request_id`) REFERENCES `equipment_maintenance_requests` (`id`);

--
-- Ketidakleluasaan untuk tabel `equipment_procurements`
--
ALTER TABLE `equipment_procurements`
  ADD CONSTRAINT `asset_equipment_procurements_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `employees` (`id`);

--
-- Ketidakleluasaan untuk tabel `equipment_proc_items`
--
ALTER TABLE `equipment_proc_items`
  ADD CONSTRAINT `asset_equipment_proc_items_asset_equipment_proc_id_foreign` FOREIGN KEY (`equipment_proc_id`) REFERENCES `equipment_procurements` (`id`);

--
-- Ketidakleluasaan untuk tabel `equipment_requests`
--
ALTER TABLE `equipment_requests`
  ADD CONSTRAINT `asset_equipment_requests_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `asset_equipment_requests_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);

--
-- Ketidakleluasaan untuk tabel `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `employees` (`id`);

--
-- Ketidakleluasaan untuk tabel `event_attendances`
--
ALTER TABLE `event_attendances`
  ADD CONSTRAINT `event_attendances_checked_by_foreign` FOREIGN KEY (`checked_by`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `event_attendances_event_registration_id_foreign` FOREIGN KEY (`event_registration_id`) REFERENCES `event_registrations` (`id`);

--
-- Ketidakleluasaan untuk tabel `event_committee_members`
--
ALTER TABLE `event_committee_members`
  ADD CONSTRAINT `event_committee_members_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `event_committee_members_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`);

--
-- Ketidakleluasaan untuk tabel `event_documents`
--
ALTER TABLE `event_documents`
  ADD CONSTRAINT `event_documents_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`),
  ADD CONSTRAINT `event_documents_uploaded_by_foreign` FOREIGN KEY (`uploaded_by`) REFERENCES `employees` (`id`);

--
-- Ketidakleluasaan untuk tabel `event_registrations`
--
ALTER TABLE `event_registrations`
  ADD CONSTRAINT `event_registrations_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`),
  ADD CONSTRAINT `event_registrations_generated_by_foreign` FOREIGN KEY (`generated_by`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `event_registrations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `event_reminders`
--
ALTER TABLE `event_reminders`
  ADD CONSTRAINT `event_reminders_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`),
  ADD CONSTRAINT `event_reminders_sent_by_foreign` FOREIGN KEY (`sent_by`) REFERENCES `employees` (`id`);

--
-- Ketidakleluasaan untuk tabel `implementation_arrangements`
--
ALTER TABLE `implementation_arrangements`
  ADD CONSTRAINT `implementation_arrangements_partnership_id_foreign` FOREIGN KEY (`partnership_id`) REFERENCES `partnerships` (`id`),
  ADD CONSTRAINT `implementation_arrangements_partnership_impl_id_foreign` FOREIGN KEY (`partnership_impl_id`) REFERENCES `partnership_implementations` (`id`);

--
-- Ketidakleluasaan untuk tabel `inventories`
--
ALTER TABLE `inventories`
  ADD CONSTRAINT `inventories_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);

--
-- Ketidakleluasaan untuk tabel `inventory_procurements`
--
ALTER TABLE `inventory_procurements`
  ADD CONSTRAINT `inventory_procurements_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `employees` (`id`);

--
-- Ketidakleluasaan untuk tabel `inventory_procurement_items`
--
ALTER TABLE `inventory_procurement_items`
  ADD CONSTRAINT `inventory_procurement_items_inventory_procurement_id_foreign` FOREIGN KEY (`inventory_procurement_id`) REFERENCES `inventory_procurements` (`id`),
  ADD CONSTRAINT `inventory_procurement_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);

--
-- Ketidakleluasaan untuk tabel `inventory_purchases`
--
ALTER TABLE `inventory_purchases`
  ADD CONSTRAINT `inventory_purchases_inventory_procurement_id_foreign` FOREIGN KEY (`inventory_procurement_id`) REFERENCES `inventory_procurements` (`id`);

--
-- Ketidakleluasaan untuk tabel `inventory_purchase_items`
--
ALTER TABLE `inventory_purchase_items`
  ADD CONSTRAINT `inventory_purchase_items_inventory_purchase_id_foreign` FOREIGN KEY (`inventory_purchase_id`) REFERENCES `inventory_purchases` (`id`),
  ADD CONSTRAINT `inventory_purchase_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);

--
-- Ketidakleluasaan untuk tabel `inventory_requests`
--
ALTER TABLE `inventory_requests`
  ADD CONSTRAINT `inventory_requests_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `inventory_requests_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);

--
-- Ketidakleluasaan untuk tabel `inventory_request_approvals`
--
ALTER TABLE `inventory_request_approvals`
  ADD CONSTRAINT `inventory_request_approvals_approver_id_foreign` FOREIGN KEY (`approver_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `inventory_request_approvals_inventory_request_id_foreign` FOREIGN KEY (`inventory_request_id`) REFERENCES `inventory_requests` (`id`);

--
-- Ketidakleluasaan untuk tabel `inventory_request_details`
--
ALTER TABLE `inventory_request_details`
  ADD CONSTRAINT `inventory_request_details_inventory_request_id_foreign` FOREIGN KEY (`inventory_request_id`) REFERENCES `inventory_requests` (`id`),
  ADD CONSTRAINT `inventory_request_details_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);

--
-- Ketidakleluasaan untuk tabel `inventory_transactions`
--
ALTER TABLE `inventory_transactions`
  ADD CONSTRAINT `inventory_transactions_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);

--
-- Ketidakleluasaan untuk tabel `job_responsibilities`
--
ALTER TABLE `job_responsibilities`
  ADD CONSTRAINT `job_responsibilities_structural_position_id_foreign` FOREIGN KEY (`structural_position_id`) REFERENCES `structural_positions` (`id`);

--
-- Ketidakleluasaan untuk tabel `journal_publications`
--
ALTER TABLE `journal_publications`
  ADD CONSTRAINT `journal_publications_publication_id_foreign` FOREIGN KEY (`publication_id`) REFERENCES `publications` (`id`);

--
-- Ketidakleluasaan untuk tabel `leave_approvals`
--
ALTER TABLE `leave_approvals`
  ADD CONSTRAINT `leave_approvals_approver_id_foreign` FOREIGN KEY (`approver_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `leave_approvals_leave_request_id_foreign` FOREIGN KEY (`leave_request_id`) REFERENCES `leave_requests` (`id`);

--
-- Ketidakleluasaan untuk tabel `leave_balances`
--
ALTER TABLE `leave_balances`
  ADD CONSTRAINT `leave_balances_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `leave_balances_leave_type_id_foreign` FOREIGN KEY (`leave_type_id`) REFERENCES `leave_types` (`id`);

--
-- Ketidakleluasaan untuk tabel `leave_requests`
--
ALTER TABLE `leave_requests`
  ADD CONSTRAINT `leave_requests_approver_id_foreign` FOREIGN KEY (`approver_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `leave_requests_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `leave_requests_leave_type_id_foreign` FOREIGN KEY (`leave_type_id`) REFERENCES `leave_types` (`id`);

--
-- Ketidakleluasaan untuk tabel `lecturers`
--
ALTER TABLE `lecturers`
  ADD CONSTRAINT `lecturers_employee_id_foreign` FOREIGN KEY (`id`) REFERENCES `employees` (`id`);

--
-- Ketidakleluasaan untuk tabel `lecturer_functional_positions`
--
ALTER TABLE `lecturer_functional_positions`
  ADD CONSTRAINT `lecturer_functional_positions_functional_position_id_foreign` FOREIGN KEY (`functional_position_id`) REFERENCES `functional_positions` (`id`),
  ADD CONSTRAINT `lecturer_functional_positions_lecturer_id_foreign` FOREIGN KEY (`lecturer_id`) REFERENCES `lecturers` (`id`);

--
-- Ketidakleluasaan untuk tabel `meetings`
--
ALTER TABLE `meetings`
  ADD CONSTRAINT `meetings_asset_room_id_foreign` FOREIGN KEY (`asset_room_id`) REFERENCES `rooms` (`id`),
  ADD CONSTRAINT `meetings_committee_id_foreign` FOREIGN KEY (`committee_id`) REFERENCES `committees` (`id`),
  ADD CONSTRAINT `meetings_leader_id_foreign` FOREIGN KEY (`leader_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `meetings_organizer_id_foreign` FOREIGN KEY (`organizer_id`) REFERENCES `employees` (`id`);

--
-- Ketidakleluasaan untuk tabel `meeting_consumption_requests`
--
ALTER TABLE `meeting_consumption_requests`
  ADD CONSTRAINT `meeting_consumption_requests_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `meeting_consumption_requests_meeting_id_foreign` FOREIGN KEY (`meeting_id`) REFERENCES `meetings` (`id`);

--
-- Ketidakleluasaan untuk tabel `meeting_documents`
--
ALTER TABLE `meeting_documents`
  ADD CONSTRAINT `meeting_documents_meeting_id_foreign` FOREIGN KEY (`meeting_id`) REFERENCES `meetings` (`id`),
  ADD CONSTRAINT `meeting_documents_uploaded_by_foreign` FOREIGN KEY (`uploaded_by`) REFERENCES `employees` (`id`);

--
-- Ketidakleluasaan untuk tabel `meeting_external_participants`
--
ALTER TABLE `meeting_external_participants`
  ADD CONSTRAINT `meeting_external_participants_meeting_id_foreign` FOREIGN KEY (`meeting_id`) REFERENCES `meetings` (`id`);

--
-- Ketidakleluasaan untuk tabel `meeting_minutes`
--
ALTER TABLE `meeting_minutes`
  ADD CONSTRAINT `meeting_minutes_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `meeting_minutes_meeting_id_foreign` FOREIGN KEY (`meeting_id`) REFERENCES `meetings` (`id`);

--
-- Ketidakleluasaan untuk tabel `meeting_participants`
--
ALTER TABLE `meeting_participants`
  ADD CONSTRAINT `meeting_participants_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `meeting_participants_meeting_id_foreign` FOREIGN KEY (`meeting_id`) REFERENCES `meetings` (`id`);

--
-- Ketidakleluasaan untuk tabel `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `nomenclature_classifications`
--
ALTER TABLE `nomenclature_classifications`
  ADD CONSTRAINT `nomenclature_classifications_nomenclature_id_foreign` FOREIGN KEY (`nomenclature_id`) REFERENCES `nomenclatures` (`id`);

--
-- Ketidakleluasaan untuk tabel `official_travel`
--
ALTER TABLE `official_travel`
  ADD CONSTRAINT `official_travel_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `official_travel_submitted_by_foreign` FOREIGN KEY (`submitted_by`) REFERENCES `employees` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
