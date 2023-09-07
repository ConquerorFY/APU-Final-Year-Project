-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 07, 2023 at 06:50 PM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `apu_final_year_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add test model', 7, 'add_testmodel'),
(26, 'Can change test model', 7, 'change_testmodel'),
(27, 'Can delete test model', 7, 'delete_testmodel'),
(28, 'Can view test model', 7, 'view_testmodel'),
(29, 'Can add neighborhood group model', 8, 'add_neighborhoodgroupmodel'),
(30, 'Can change neighborhood group model', 8, 'change_neighborhoodgroupmodel'),
(31, 'Can delete neighborhood group model', 8, 'delete_neighborhoodgroupmodel'),
(32, 'Can view neighborhood group model', 8, 'view_neighborhoodgroupmodel'),
(33, 'Can add resident model', 9, 'add_residentmodel'),
(34, 'Can change resident model', 9, 'change_residentmodel'),
(35, 'Can delete resident model', 9, 'delete_residentmodel'),
(36, 'Can view resident model', 9, 'view_residentmodel'),
(37, 'Can add join request model', 10, 'add_joinrequestmodel'),
(38, 'Can change join request model', 10, 'change_joinrequestmodel'),
(39, 'Can delete join request model', 10, 'delete_joinrequestmodel'),
(40, 'Can view join request model', 10, 'view_joinrequestmodel'),
(41, 'Can add crime post model', 11, 'add_crimepostmodel'),
(42, 'Can change crime post model', 11, 'change_crimepostmodel'),
(43, 'Can delete crime post model', 11, 'delete_crimepostmodel'),
(44, 'Can view crime post model', 11, 'view_crimepostmodel'),
(45, 'Can add complaint post model', 12, 'add_complaintpostmodel'),
(46, 'Can change complaint post model', 12, 'change_complaintpostmodel'),
(47, 'Can delete complaint post model', 12, 'delete_complaintpostmodel'),
(48, 'Can view complaint post model', 12, 'view_complaintpostmodel'),
(49, 'Can add event post model', 13, 'add_eventpostmodel'),
(50, 'Can change event post model', 13, 'change_eventpostmodel'),
(51, 'Can delete event post model', 13, 'delete_eventpostmodel'),
(52, 'Can view event post model', 13, 'view_eventpostmodel'),
(53, 'Can add general post model', 14, 'add_generalpostmodel'),
(54, 'Can change general post model', 14, 'change_generalpostmodel'),
(55, 'Can delete general post model', 14, 'delete_generalpostmodel'),
(56, 'Can view general post model', 14, 'view_generalpostmodel'),
(57, 'Can add general post comment model', 15, 'add_generalpostcommentmodel'),
(58, 'Can change general post comment model', 15, 'change_generalpostcommentmodel'),
(59, 'Can delete general post comment model', 15, 'delete_generalpostcommentmodel'),
(60, 'Can view general post comment model', 15, 'view_generalpostcommentmodel'),
(61, 'Can add crime post comment model', 16, 'add_crimepostcommentmodel'),
(62, 'Can change crime post comment model', 16, 'change_crimepostcommentmodel'),
(63, 'Can delete crime post comment model', 16, 'delete_crimepostcommentmodel'),
(64, 'Can view crime post comment model', 16, 'view_crimepostcommentmodel'),
(65, 'Can add event post comment model', 17, 'add_eventpostcommentmodel'),
(66, 'Can change event post comment model', 17, 'change_eventpostcommentmodel'),
(67, 'Can delete event post comment model', 17, 'delete_eventpostcommentmodel'),
(68, 'Can view event post comment model', 17, 'view_eventpostcommentmodel'),
(69, 'Can add complaint post comment model', 18, 'add_complaintpostcommentmodel'),
(70, 'Can change complaint post comment model', 18, 'change_complaintpostcommentmodel'),
(71, 'Can delete complaint post comment model', 18, 'delete_complaintpostcommentmodel'),
(72, 'Can view complaint post comment model', 18, 'view_complaintpostcommentmodel'),
(73, 'Can add facilities model', 19, 'add_facilitiesmodel'),
(74, 'Can change facilities model', 19, 'change_facilitiesmodel'),
(75, 'Can delete facilities model', 19, 'delete_facilitiesmodel'),
(76, 'Can view facilities model', 19, 'view_facilitiesmodel'),
(77, 'Can add chat model', 20, 'add_chatmodel'),
(78, 'Can change chat model', 20, 'change_chatmodel'),
(79, 'Can delete chat model', 20, 'delete_chatmodel'),
(80, 'Can view chat model', 20, 'view_chatmodel');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$260000$5ZrquFtHwk4EGopNr4vqCf$k62xPv+PXv+XGYiC/VjzCF4rrjJdJAk2xj6mzB7K5Vk=', '2023-09-04 07:47:31.150952', 1, 'admin', '', '', 'tp055343@mail.apu.edu.my', 1, 1, '2023-06-21 14:29:09.963212');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL
) ;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2023-06-22 08:03:27.691386', '1', 'Jason123', 2, '[{\"changed\": {\"fields\": [\"Name\"]}}]', 7, 1),
(2, '2023-06-22 08:03:39.685979', '1', 'Jason', 2, '[{\"changed\": {\"fields\": [\"Name\"]}}]', 7, 1),
(3, '2023-06-22 08:15:02.965679', '2', 'Jason', 3, '', 9, 1),
(4, '2023-06-22 08:15:08.980969', '1', 'Ryan', 3, '', 9, 1),
(5, '2023-06-23 14:29:04.201981', '1', 'Bukit Indah Family', 1, '[{\"added\": {}}]', 8, 1),
(6, '2023-06-23 15:26:10.403592', '3', 'Kuantan Gang', 3, '', 8, 1),
(7, '2023-06-23 15:26:14.140659', '2', 'Kuantan Gang', 3, '', 8, 1),
(8, '2023-06-23 15:26:17.455971', '1', 'Bukit Indah Family', 3, '', 8, 1),
(9, '2023-06-23 15:27:51.741357', '4', 'Kuantan Gang', 3, '', 8, 1),
(10, '2023-06-23 15:31:09.753020', '5', 'Kuantan Gang', 3, '', 8, 1),
(11, '2023-06-23 15:33:01.831824', '6', 'Kuantan Gang', 3, '', 8, 1),
(12, '2023-06-23 15:33:28.006251', '7', 'Kuantan Gang', 3, '', 8, 1),
(13, '2023-06-23 15:34:13.731180', '8', 'Kuantan Gang', 3, '', 8, 1),
(14, '2023-06-24 03:06:18.223993', '1', 'JoinRequestModel object (1)', 2, '[]', 10, 1),
(15, '2023-06-24 03:06:22.125345', '2', 'JoinRequestModel object (2)', 1, '[{\"added\": {}}]', 10, 1),
(16, '2023-06-28 08:01:25.512332', '1', 'ComplaintPostModel object (1)', 3, '', 12, 1),
(17, '2023-06-30 03:39:20.293131', '1', 'EventPostModel object (1)', 2, '[{\"changed\": {\"fields\": [\"Participants\"]}}]', 13, 1),
(18, '2023-06-30 08:12:56.014829', '4', 'Andrew', 2, '[{\"changed\": {\"fields\": [\"UserData\"]}}]', 9, 1),
(19, '2023-06-30 08:13:00.716479', '3', 'Jonathan', 2, '[{\"changed\": {\"fields\": [\"UserData\"]}}]', 9, 1),
(20, '2023-06-30 08:13:05.819197', '2', 'Ryan', 2, '[{\"changed\": {\"fields\": [\"UserData\"]}}]', 9, 1),
(21, '2023-06-30 08:13:10.110238', '1', 'Jason', 2, '[{\"changed\": {\"fields\": [\"UserData\"]}}]', 9, 1),
(22, '2023-07-08 15:56:38.537523', '1', 'EventPostModel object (1)', 2, '[{\"changed\": {\"fields\": [\"Participants\"]}}]', 13, 1),
(23, '2023-07-11 15:26:49.215718', '1', 'CrimePostModel object (1)', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 11, 1),
(24, '2023-07-11 15:50:10.290842', '2', 'CrimePostModel object (2)', 3, '', 11, 1),
(25, '2023-07-11 15:53:05.710262', '1', 'CrimePostModel object (1)', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 11, 1),
(26, '2023-07-15 07:26:28.408395', '9', 'KUANTAN FAMILY', 2, '[{\"changed\": {\"fields\": [\"Street\", \"Postcode\", \"Rules\"]}}]', 8, 1),
(27, '2023-07-17 03:17:59.362090', '6', 'JoinRequestModel object (6)', 3, '', 10, 1),
(28, '2023-07-17 09:20:21.367061', '11', 'Rawang Gang', 2, '[{\"changed\": {\"fields\": [\"Street\", \"Rules\"]}}]', 8, 1),
(29, '2023-07-17 09:24:10.519795', '11', 'Rawang Gang', 3, '', 8, 1),
(30, '2023-07-19 07:26:34.203776', '4', 'Andrew Wiggins', 2, '[{\"changed\": {\"fields\": [\"IsLeader\"]}}]', 9, 1),
(31, '2023-07-19 07:40:02.087950', '16', 'JoinRequestModel object (16)', 3, '', 10, 1),
(32, '2023-07-29 08:14:36.977862', '7', 'EventPostCommentModel object (7)', 3, '', 17, 1),
(33, '2023-07-29 08:19:26.152383', '8', 'EventPostCommentModel object (8)', 3, '', 17, 1),
(34, '2023-07-29 08:27:23.891303', '12', 'EventPostCommentModel object (12)', 3, '', 17, 1),
(35, '2023-07-29 08:27:23.897037', '11', 'EventPostCommentModel object (11)', 3, '', 17, 1),
(36, '2023-07-29 08:27:23.899102', '10', 'EventPostCommentModel object (10)', 3, '', 17, 1),
(37, '2023-07-29 08:27:23.904068', '9', 'EventPostCommentModel object (9)', 3, '', 17, 1),
(38, '2023-07-29 08:28:01.740966', '15', 'EventPostCommentModel object (15)', 3, '', 17, 1),
(39, '2023-07-29 08:28:01.742861', '14', 'EventPostCommentModel object (14)', 3, '', 17, 1),
(40, '2023-07-29 08:28:01.744861', '13', 'EventPostCommentModel object (13)', 3, '', 17, 1),
(41, '2023-07-29 08:36:07.677262', '17', 'EventPostCommentModel object (17)', 3, '', 17, 1),
(42, '2023-07-29 08:36:07.681261', '16', 'EventPostCommentModel object (16)', 3, '', 17, 1),
(43, '2023-08-05 05:21:55.287476', '2', 'ChatModel object (2)', 2, '[{\"changed\": {\"fields\": [\"Previous\"]}}]', 20, 1),
(44, '2023-08-07 09:28:50.555900', '16', 'ChatModel object (16)', 3, '', 20, 1),
(45, '2023-08-07 09:28:50.557899', '15', 'ChatModel object (15)', 3, '', 20, 1),
(46, '2023-08-07 09:28:50.558899', '14', 'ChatModel object (14)', 3, '', 20, 1),
(47, '2023-08-08 07:30:47.458125', '8', 'Jazz', 3, '', 9, 1),
(48, '2023-08-08 15:20:43.359148', '2', 'Ryan', 2, '[{\"changed\": {\"fields\": [\"City\"]}}]', 9, 1),
(49, '2023-08-08 15:20:50.399177', '4', 'Andrew Wiggins', 2, '[{\"changed\": {\"fields\": [\"City\"]}}]', 9, 1),
(50, '2023-08-08 15:23:33.465501', '10', 'KL Family', 2, '[{\"changed\": {\"fields\": [\"City\"]}}]', 8, 1),
(51, '2023-08-18 13:47:32.178495', '3', 'CrimePostModel object (3)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 11, 1),
(52, '2023-08-18 13:47:37.834006', '4', 'CrimePostModel object (4)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 11, 1),
(53, '2023-08-18 13:47:43.076368', '5', 'CrimePostModel object (5)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 11, 1),
(54, '2023-08-18 13:47:53.372997', '6', 'CrimePostCommentModel object (6)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 16, 1),
(55, '2023-08-18 13:47:58.818717', '8', 'CrimePostCommentModel object (8)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 16, 1),
(56, '2023-08-18 13:48:03.196145', '9', 'CrimePostCommentModel object (9)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 16, 1),
(57, '2023-08-18 13:48:07.457791', '10', 'CrimePostCommentModel object (10)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 16, 1),
(58, '2023-08-18 13:48:32.972466', '3', 'ComplaintPostModel object (3)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 12, 1),
(59, '2023-08-18 13:48:37.850206', '4', 'ComplaintPostModel object (4)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 12, 1),
(60, '2023-08-18 13:48:43.846858', '5', 'ComplaintPostModel object (5)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 12, 1),
(61, '2023-08-18 13:48:52.056137', '6', 'ComplaintPostModel object (6)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 12, 1),
(62, '2023-08-18 13:48:57.461051', '5', 'ComplaintPostModel object (5)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 12, 1),
(63, '2023-08-18 13:49:19.937595', '1', 'ComplaintPostCommentModel object (1)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 18, 1),
(64, '2023-08-18 13:49:24.434060', '2', 'ComplaintPostCommentModel object (2)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 18, 1),
(65, '2023-08-18 13:49:28.306043', '3', 'ComplaintPostCommentModel object (3)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 18, 1),
(66, '2023-08-18 13:49:33.630381', '4', 'ComplaintPostCommentModel object (4)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 18, 1),
(67, '2023-08-18 13:49:38.377619', '5', 'ComplaintPostCommentModel object (5)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 18, 1),
(68, '2023-08-18 13:49:55.673626', '2', 'EventPostModel object (2)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 13, 1),
(69, '2023-08-18 13:50:00.871291', '3', 'EventPostModel object (3)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 13, 1),
(70, '2023-08-18 13:50:07.830717', '1', 'EventPostCommentModel object (1)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 17, 1),
(71, '2023-08-18 13:50:12.061108', '2', 'EventPostCommentModel object (2)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 17, 1),
(72, '2023-08-18 13:50:17.178695', '3', 'EventPostCommentModel object (3)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 17, 1),
(73, '2023-08-18 13:50:21.989016', '5', 'EventPostCommentModel object (5)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 17, 1),
(74, '2023-08-18 13:50:26.901170', '18', 'EventPostCommentModel object (18)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 17, 1),
(75, '2023-08-18 13:50:32.316854', '19', 'EventPostCommentModel object (19)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 17, 1),
(76, '2023-08-18 13:50:43.814133', '2', 'GeneralPostModel object (2)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 14, 1),
(77, '2023-08-18 13:50:49.147638', '3', 'GeneralPostModel object (3)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 14, 1),
(78, '2023-08-18 13:50:54.317525', '4', 'GeneralPostModel object (4)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 14, 1),
(79, '2023-08-18 13:50:59.368479', '5', 'GeneralPostModel object (5)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 14, 1),
(80, '2023-08-18 13:51:06.243208', '1', 'GeneralPostCommentModel object (1)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 15, 1),
(81, '2023-08-18 13:51:11.156172', '3', 'GeneralPostCommentModel object (3)', 2, '[{\"changed\": {\"fields\": [\"GroupID\"]}}]', 15, 1),
(82, '2023-08-18 13:54:14.179785', '2', 'ComplaintPostModel object (2)', 2, '[{\"changed\": {\"fields\": [\"Image\", \"GroupID\"]}}]', 12, 1),
(83, '2023-08-18 13:54:30.548936', '1', 'GeneralPostModel object (1)', 2, '[{\"changed\": {\"fields\": [\"Image\", \"GroupID\"]}}]', 14, 1),
(84, '2023-09-06 08:21:45.547255', '5', 'EventPostModel object (5)', 3, '', 13, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(20, 'RESTAPI', 'chatmodel'),
(18, 'RESTAPI', 'complaintpostcommentmodel'),
(12, 'RESTAPI', 'complaintpostmodel'),
(16, 'RESTAPI', 'crimepostcommentmodel'),
(11, 'RESTAPI', 'crimepostmodel'),
(17, 'RESTAPI', 'eventpostcommentmodel'),
(13, 'RESTAPI', 'eventpostmodel'),
(19, 'RESTAPI', 'facilitiesmodel'),
(15, 'RESTAPI', 'generalpostcommentmodel'),
(14, 'RESTAPI', 'generalpostmodel'),
(10, 'RESTAPI', 'joinrequestmodel'),
(8, 'RESTAPI', 'neighborhoodgroupmodel'),
(9, 'RESTAPI', 'residentmodel'),
(7, 'RESTAPI', 'testmodel'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'RESTAPI', '0001_initial', '2023-06-21 14:26:51.509538'),
(2, 'contenttypes', '0001_initial', '2023-06-21 14:26:51.668189'),
(3, 'auth', '0001_initial', '2023-06-21 14:26:52.724763'),
(4, 'admin', '0001_initial', '2023-06-21 14:26:52.933792'),
(5, 'admin', '0002_logentry_remove_auto_add', '2023-06-21 14:26:52.964331'),
(6, 'admin', '0003_logentry_add_action_flag_choices', '2023-06-21 14:26:52.989862'),
(7, 'contenttypes', '0002_remove_content_type_name', '2023-06-21 14:26:53.134903'),
(8, 'auth', '0002_alter_permission_name_max_length', '2023-06-21 14:26:53.234038'),
(9, 'auth', '0003_alter_user_email_max_length', '2023-06-21 14:26:53.289784'),
(10, 'auth', '0004_alter_user_username_opts', '2023-06-21 14:26:53.312548'),
(11, 'auth', '0005_alter_user_last_login_null', '2023-06-21 14:26:53.419848'),
(12, 'auth', '0006_require_contenttypes_0002', '2023-06-21 14:26:53.424363'),
(13, 'auth', '0007_alter_validators_add_error_messages', '2023-06-21 14:26:53.449605'),
(14, 'auth', '0008_alter_user_username_max_length', '2023-06-21 14:26:53.502378'),
(15, 'auth', '0009_alter_user_last_name_max_length', '2023-06-21 14:26:53.559455'),
(16, 'auth', '0010_alter_group_name_max_length', '2023-06-21 14:26:53.609125'),
(17, 'auth', '0011_update_proxy_permissions', '2023-06-21 14:26:53.634819'),
(18, 'auth', '0012_alter_user_first_name_max_length', '2023-06-21 14:26:53.694377'),
(19, 'sessions', '0001_initial', '2023-06-21 14:26:53.844724'),
(21, 'RESTAPI', '0002_neighborhoodgroupmodel_residentmodel', '2023-06-22 08:30:24.537169'),
(22, 'RESTAPI', '0003_alter_neighborhoodgroupmodel_name', '2023-06-23 15:35:52.342867'),
(23, 'RESTAPI', '0004_joinrequestmodel', '2023-06-24 02:36:59.308530'),
(24, 'RESTAPI', '0005_neighborhoodgroupmodel_rules', '2023-06-25 05:08:38.669808'),
(25, 'RESTAPI', '0006_alter_neighborhoodgroupmodel_rules', '2023-06-25 05:10:48.847971'),
(26, 'RESTAPI', '0007_alter_neighborhoodgroupmodel_rules', '2023-06-25 05:34:17.670424'),
(27, 'RESTAPI', '0008_complaintpostmodel_crimepostmodel_eventpostmodel_generalpostmodel', '2023-06-25 14:58:31.519046'),
(28, 'RESTAPI', '0009_auto_20230628_1600', '2023-06-28 08:00:17.221308'),
(29, 'RESTAPI', '0010_auto_20230628_1600', '2023-06-28 08:00:31.309856'),
(30, 'RESTAPI', '0011_complaintpostcommentmodel_crimepostcommentmodel_eventpostcommentmodel_generalpostcommentmodel', '2023-06-29 07:03:07.600470'),
(31, 'RESTAPI', '0012_facilitiesmodel', '2023-06-29 15:34:38.146485'),
(32, 'RESTAPI', '0013_auto_20230630_1542', '2023-06-30 07:42:07.063996'),
(33, 'RESTAPI', '0014_alter_residentmodel_userdata', '2023-06-30 08:11:42.013965'),
(34, 'RESTAPI', '0015_auto_20230711_2258', '2023-07-11 14:58:11.737479'),
(35, 'RESTAPI', '0016_residentmodel_image', '2023-07-20 10:01:01.654063'),
(36, 'RESTAPI', '0017_auto_20230725_0051', '2023-07-24 16:51:31.128413'),
(37, 'RESTAPI', '0018_chatmodel', '2023-08-05 04:57:13.480417'),
(38, 'RESTAPI', '0019_auto_20230818_2146', '2023-08-18 13:46:51.299827'),
(39, 'RESTAPI', '0020_joinrequestmodel_status', '2023-09-04 09:10:51.285901');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('0xr4wcbmy4e8pj7gyvmpbljekwbrv45c', '.eJxVjDsOwjAQBe_iGllef3cp6TmDZXstHECOFCcV4u4QKQW0b2beS8S0rS1uoy5xYnEWIE6_W07lUfsO-J76bZZl7usyZbkr8qBDXmeuz8vh_h20NNq3xqqqQzSYiSBkRdqwZ9CAqVDQAYECInnnFNrgjEFniT0Bg2UdlHh_AJ-kNZY:1qHm9S:ZJ_gA4Uw4eFR_1Jy0ium4UDMJA7losuZVUB9IxXLjQ0', '2023-07-21 14:09:38.251477'),
('1hd8vbjegg1hae57rs0yocmu54uf9qqs', '.eJxVjDsOwjAQBe_iGllef3cp6TmDZXstHECOFCcV4u4QKQW0b2beS8S0rS1uoy5xYnEWIE6_W07lUfsO-J76bZZl7usyZbkr8qBDXmeuz8vh_h20NNq3xqqqQzSYiSBkRdqwZ9CAqVDQAYECInnnFNrgjEFniT0Bg2UdlHh_AJ-kNZY:1qN804:II6112U8CVgHNPDsrgIm4kg-gGd7simn_hvZTcIRizU', '2023-08-05 08:30:04.527099'),
('jrpc3llewkt1n17l5b9q7dacr4mvt6pr', '.eJxVjDsOwjAQBe_iGllef3cp6TmDZXstHECOFCcV4u4QKQW0b2beS8S0rS1uoy5xYnEWIE6_W07lUfsO-J76bZZl7usyZbkr8qBDXmeuz8vh_h20NNq3xqqqQzSYiSBkRdqwZ9CAqVDQAYECInnnFNrgjEFniT0Bg2UdlHh_AJ-kNZY:1qSUry:ZlpgFLufQvZeIKneKL7v6JDYzyUy5HVKDpR1YENqj8w', '2023-08-20 03:55:54.423413'),
('ni8yhe65dil7chu1q5tmljzw9q344408', '.eJxVjDsOwjAQBe_iGllef3cp6TmDZXstHECOFCcV4u4QKQW0b2beS8S0rS1uoy5xYnEWIE6_W07lUfsO-J76bZZl7usyZbkr8qBDXmeuz8vh_h20NNq3xqqqQzSYiSBkRdqwZ9CAqVDQAYECInnnFNrgjEFniT0Bg2UdlHh_AJ-kNZY:1qd4J1:Ui1mVqbnKCSoCH51PrCtLQQI2Nv1cTznm3T2B5DqC5g', '2023-09-18 07:47:31.174957'),
('v7f3apeuuf5fkk1bv7chbh3acj3ync4f', '.eJxVjDsOwjAQBe_iGllef3cp6TmDZXstHECOFCcV4u4QKQW0b2beS8S0rS1uoy5xYnEWIE6_W07lUfsO-J76bZZl7usyZbkr8qBDXmeuz8vh_h20NNq3xqqqQzSYiSBkRdqwZ9CAqVDQAYECInnnFNrgjEFniT0Bg2UdlHh_AJ-kNZY:1qCFGq:oEZ6ACxH2j0Y8wCJSoJzkfKEfUI3EYXxmC0AulJ30Sw', '2023-07-06 08:02:24.478944');

-- --------------------------------------------------------

--
-- Table structure for table `restapi_chatmodel`
--

CREATE TABLE `restapi_chatmodel` (
  `id` bigint(20) NOT NULL,
  `content` varchar(1000) NOT NULL,
  `previous` int(11) NOT NULL,
  `receiver_id` bigint(20) NOT NULL,
  `sender_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `restapi_chatmodel`
--

INSERT INTO `restapi_chatmodel` (`id`, `content`, `previous`, `receiver_id`, `sender_id`) VALUES
(1, 'Hellow there', 0, 4, 2),
(2, 'I mean hello', 1, 4, 2),
(3, 'How are you', 2, 4, 2),
(4, 'I\'m fine', 3, 2, 4),
(5, 'How about you?', 4, 2, 4),
(6, 'Good to hear!', 5, 4, 2),
(7, 'My day was fine too!', 6, 4, 2),
(8, 'I see.', 7, 2, 4),
(9, 'Good for you', 8, 2, 4),
(10, 'Hi there!', 0, 1, 4),
(11, 'Nice to meet you', 10, 1, 4),
(12, 'Yea you too!', 11, 4, 1),
(13, 'Yo my guy', 0, 2, 1),
(17, 'How are you today?', 9, 4, 2),
(18, 'My day was terrible!', 17, 4, 2),
(19, 'Mine was good through!', 18, 2, 4),
(20, 'Got some good advices from my peers', 19, 2, 4),
(21, 'Good for you!', 20, 4, 2),
(22, 'What\'s up bro', 13, 1, 2),
(23, 'How you doing?', 22, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `restapi_complaintpostcommentmodel`
--

CREATE TABLE `restapi_complaintpostcommentmodel` (
  `id` bigint(20) NOT NULL,
  `datetime` datetime(6) NOT NULL,
  `content` varchar(2000) NOT NULL,
  `authorID_id` bigint(20) DEFAULT NULL,
  `postID_id` bigint(20) DEFAULT NULL,
  `groupID_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `restapi_complaintpostcommentmodel`
--

INSERT INTO `restapi_complaintpostcommentmodel` (`id`, `datetime`, `content`, `authorID_id`, `postID_id`, `groupID_id`) VALUES
(1, '2023-06-29 07:25:03.330375', 'Thanks for letting us know of this issue!', 2, 2, 10),
(2, '2023-06-29 07:25:25.347433', 'Thanks for sharing!', 2, 2, 10),
(3, '2023-07-08 15:11:58.105084', 'Hope you would take action on this matter Mr. David!!', 2, 2, 10),
(5, '2023-07-30 08:10:57.314408', 'Please adhere to it!!', 1, 5, 9);

-- --------------------------------------------------------

--
-- Table structure for table `restapi_complaintpostmodel`
--

CREATE TABLE `restapi_complaintpostmodel` (
  `id` bigint(20) NOT NULL,
  `datetime` datetime(6) NOT NULL,
  `title` varchar(500) NOT NULL,
  `description` varchar(2000) NOT NULL,
  `target` varchar(100) NOT NULL,
  `isAnonymous` tinyint(1) NOT NULL,
  `reporterID_id` bigint(20) DEFAULT NULL,
  `dislikes` int(11) NOT NULL,
  `likes` int(11) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `groupID_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `restapi_complaintpostmodel`
--

INSERT INTO `restapi_complaintpostmodel` (`id`, `datetime`, `title`, `description`, `target`, `isAnonymous`, `reporterID_id`, `dislikes`, `likes`, `image`, `groupID_id`) VALUES
(2, '2023-06-28 08:01:27.490374', 'Car Occupying House Front!', 'Your car that is parked in front of my house has caused great incovenience to me and my family', 'Mr David', 0, 2, 1, 1, 'images/complaint/Too_Noisy_at_Night_igzSYK0.jpg', 10),
(5, '2023-07-13 15:32:00.306892', 'Too Noisy at Night', 'Please keep it down during night time', 'Mr Davis', 1, 3, 0, 3, 'images/complaint/Too_Noisy_at_Night.jpg', 9),
(6, '2023-07-13 15:35:12.981066', 'Dog Poop In Front of House', 'Please ensure that your dog would not poop in front of my door', 'Mr James', 1, 3, 0, 1, 'images/complaint/Dog_Poop_In_Front_of_House.jpg', 9),
(13, '2023-09-06 08:19:28.172867', 'Loud music at night', 'Please keep it down at night :(', 'Mr Noah', 0, 4, 0, 0, '', 10);

-- --------------------------------------------------------

--
-- Table structure for table `restapi_crimepostcommentmodel`
--

CREATE TABLE `restapi_crimepostcommentmodel` (
  `id` bigint(20) NOT NULL,
  `datetime` datetime(6) NOT NULL,
  `content` varchar(2000) NOT NULL,
  `authorID_id` bigint(20) DEFAULT NULL,
  `postID_id` bigint(20) DEFAULT NULL,
  `groupID_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `restapi_crimepostcommentmodel`
--

INSERT INTO `restapi_crimepostcommentmodel` (`id`, `datetime`, `content`, `authorID_id`, `postID_id`, `groupID_id`) VALUES
(6, '2023-07-24 17:04:04.319356', 'Noted with thanks!!', 4, 3, 10),
(8, '2023-07-27 09:49:10.109512', 'Nice!', 2, 3, 10),
(9, '2023-07-29 09:42:25.698943', 'Thanks for this!', 4, 3, 10),
(10, '2023-07-29 09:42:58.773936', 'Very grateful!', 4, 3, 10),
(12, '2023-09-05 11:03:31.127629', 'Haizz sad :(', 4, 5, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `restapi_crimepostmodel`
--

CREATE TABLE `restapi_crimepostmodel` (
  `id` bigint(20) NOT NULL,
  `datetime` datetime(6) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `title` varchar(500) NOT NULL,
  `description` varchar(2000) NOT NULL,
  `actions` varchar(2000) NOT NULL,
  `reporterID_id` bigint(20) DEFAULT NULL,
  `dislikes` int(11) NOT NULL,
  `likes` int(11) NOT NULL,
  `groupID_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `restapi_crimepostmodel`
--

INSERT INTO `restapi_crimepostmodel` (`id`, `datetime`, `image`, `title`, `description`, `actions`, `reporterID_id`, `dislikes`, `likes`, `groupID_id`) VALUES
(3, '2023-06-27 01:09:45.000000', 'images/crime/DHCP.png', 'House Burglary!!', 'Mr. John\'s car has been stolen!!', 'Contacted the police', 2, 1, 1, 10),
(4, '2023-07-12 22:37:02.000000', 'images/crime/Car_Tyre_Puncture.jpg', 'Car Tyre Puncture!', 'My car got punctured by someone', 'Called the authorities', 2, 0, 2, 10),
(5, '2023-07-12 22:42:47.000000', 'images/crime/Bicycle_Stolen.jpg', 'Bicycle Stolen', 'My bicycle have been stolen', 'Called the police', 4, 0, 2, 10),
(6, '2023-08-18 21:59:17.000000', 'images/crime/House_Burglary.jpg', 'House Burglary', 'My house was broken in while I was away', 'Called the police', 2, 0, 0, 10);

-- --------------------------------------------------------

--
-- Table structure for table `restapi_eventpostcommentmodel`
--

CREATE TABLE `restapi_eventpostcommentmodel` (
  `id` bigint(20) NOT NULL,
  `datetime` datetime(6) NOT NULL,
  `content` varchar(2000) NOT NULL,
  `authorID_id` bigint(20) DEFAULT NULL,
  `postID_id` bigint(20) DEFAULT NULL,
  `groupID_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `restapi_eventpostcommentmodel`
--

INSERT INTO `restapi_eventpostcommentmodel` (`id`, `datetime`, `content`, `authorID_id`, `postID_id`, `groupID_id`) VALUES
(1, '2023-06-29 07:48:42.538468', 'Thanks for hosting this event!', 2, 1, 10),
(2, '2023-06-29 07:48:51.225279', 'Thanks for organizing!', 2, 1, 10),
(3, '2023-07-08 15:57:40.635247', 'Awesome!', 2, 1, 10),
(5, '2023-07-11 05:41:22.352330', 'I\'m going too!', 4, 1, 10),
(18, '2023-07-29 08:36:31.353430', 'Looking forward to meet you guys!!', 2, 1, 10),
(19, '2023-07-29 08:37:21.716329', 'See you guys there!', 2, 1, 10),
(20, '2023-08-18 14:30:15.571015', 'Come and join!!', 2, 4, NULL),
(21, '2023-09-06 08:45:49.873790', 'Congrats!!', 2, 7, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `restapi_eventpostmodel`
--

CREATE TABLE `restapi_eventpostmodel` (
  `id` bigint(20) NOT NULL,
  `venue` varchar(500) NOT NULL,
  `title` varchar(500) NOT NULL,
  `description` varchar(2000) NOT NULL,
  `participants` varchar(1000) NOT NULL,
  `organizerID_id` bigint(20) DEFAULT NULL,
  `datetime` datetime(6) NOT NULL,
  `dislikes` int(11) NOT NULL,
  `likes` int(11) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `groupID_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `restapi_eventpostmodel`
--

INSERT INTO `restapi_eventpostmodel` (`id`, `venue`, `title`, `description`, `participants`, `organizerID_id`, `datetime`, `dislikes`, `likes`, `image`, `groupID_id`) VALUES
(1, 'Norah\'s House (No. 13)', 'Hari Raya Open House Celebration', 'Open house celebration for hari raya!', '[2, 4]', 2, '2023-06-28 16:13:25.000000', 1, 1, '', NULL),
(2, 'Jason\'s House (No. 15)', 'New Year Celebration', 'Celebration for the 2024 New Years', '[2, 4]', 2, '2024-01-01 00:00:00.000000', 0, 1, 'images/event/ServerFarmLAN.png', 10),
(3, 'Jason House No 17', 'Johnny Birthday Celebration', 'We are organizing a birthday party for Johnny', '[3, 1]', 1, '2023-07-13 16:53:54.000000', 0, 1, 'images/event/Johnny_Birthday_Celebration.jpg', 9),
(4, 'Nora House', 'Grandmother 80th Birthday', 'Come and celebrate together!', '[2]', 4, '2023-08-31 22:00:00.000000', 0, 1, 'images/event/Grandmother_80th_Birthday.jpg', 10),
(7, 'Unit 18', 'SPM Celebration', 'Celebrate my son having good results!', '[2]', 4, '2024-01-03 12:00:00.000000', 0, 1, '', 10);

-- --------------------------------------------------------

--
-- Table structure for table `restapi_facilitiesmodel`
--

CREATE TABLE `restapi_facilitiesmodel` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `status` varchar(100) NOT NULL,
  `groupID_id` bigint(20) DEFAULT NULL,
  `holder_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `restapi_facilitiesmodel`
--

INSERT INTO `restapi_facilitiesmodel` (`id`, `name`, `description`, `status`, `groupID_id`, `holder_id`) VALUES
(1, 'Gym', 'The gymnasium located at Level 5', 'Available', 9, NULL),
(2, 'Swimming Pool', 'The swimming pool located at Level 3', 'Available', 9, NULL),
(7, 'Gym', 'The in door gym at No 15!', 'Available', 10, NULL),
(8, 'Playground', 'The outdoor playground at central park', 'Occupied', 10, 4),
(11, 'Sauna', 'Located at Level 5 Open 10am to 10pm every day', 'Available', 9, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `restapi_generalpostcommentmodel`
--

CREATE TABLE `restapi_generalpostcommentmodel` (
  `id` bigint(20) NOT NULL,
  `datetime` datetime(6) NOT NULL,
  `content` varchar(2000) NOT NULL,
  `authorID_id` bigint(20) DEFAULT NULL,
  `postID_id` bigint(20) DEFAULT NULL,
  `groupID_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `restapi_generalpostcommentmodel`
--

INSERT INTO `restapi_generalpostcommentmodel` (`id`, `datetime`, `content`, `authorID_id`, `postID_id`, `groupID_id`) VALUES
(1, '2023-06-29 07:52:33.381109', 'Thanks for sharing this wonderful information!!!', 2, 1, 10),
(3, '2023-07-28 16:19:01.449376', 'Hold cleanups often!', 4, 1, 10);

-- --------------------------------------------------------

--
-- Table structure for table `restapi_generalpostmodel`
--

CREATE TABLE `restapi_generalpostmodel` (
  `id` bigint(20) NOT NULL,
  `datetime` datetime(6) NOT NULL,
  `title` varchar(500) NOT NULL,
  `description` varchar(2000) NOT NULL,
  `authorID_id` bigint(20) DEFAULT NULL,
  `dislikes` int(11) NOT NULL,
  `likes` int(11) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `groupID_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `restapi_generalpostmodel`
--

INSERT INTO `restapi_generalpostmodel` (`id`, `datetime`, `title`, `description`, `authorID_id`, `dislikes`, `likes`, `image`, `groupID_id`) VALUES
(1, '2023-06-28 08:28:50.825848', 'How to make the neighborhood cleaner?', 'Lately the neighborhood has been getting very dirty and unhygenic. Any suggestions to help solve this issue?', 2, 1, 1, 'images/general/Things_to_buy_a_4_year_old_child_grgWVTq.jpg', 10),
(2, '2023-07-13 07:00:18.271249', 'Advice for low income', 'Anyone has any job recommendations?', 2, 0, 0, 'images/general/VLSM_Table_2.png', 10),
(3, '2023-07-13 09:00:07.553974', 'Things to buy a 4 year old child', 'What to buy for a 4 year old child', 1, 0, 0, 'images/general/Things_to_buy_a_4_year_old_child.jpg', 9),
(4, '2023-07-13 15:11:41.077164', 'Regarding whether to renovate house', 'Should I renovate my house to a bigger and newer one', 3, 0, 0, 'images/general/Regarding_whether_to_renovate_house.jpg', 9),
(5, '2023-07-13 15:22:37.050562', 'Regarding fixing the playground', 'Any ideas on when to conduct maintenance activities for the playground', 3, 0, 0, 'images/general/Regarding_fixing_the_playground.jpg', 9),
(6, '2023-09-05 09:41:39.872718', 'How to increase income?', 'Need some advice for adding my income.', 4, 0, 1, 'images/general/null.jpg', 10);

-- --------------------------------------------------------

--
-- Table structure for table `restapi_joinrequestmodel`
--

CREATE TABLE `restapi_joinrequestmodel` (
  `id` bigint(20) NOT NULL,
  `groupID_id` bigint(20) DEFAULT NULL,
  `residentID_id` bigint(20) DEFAULT NULL,
  `status` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

-- --------------------------------------------------------

--
-- Table structure for table `restapi_neighborhoodgroupmodel`
--

CREATE TABLE `restapi_neighborhoodgroupmodel` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `state` varchar(20) NOT NULL,
  `city` varchar(100) NOT NULL,
  `street` varchar(100) NOT NULL,
  `postcode` int(11) NOT NULL,
  `rules` varchar(10000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `restapi_neighborhoodgroupmodel`
--

INSERT INTO `restapi_neighborhoodgroupmodel` (`id`, `name`, `state`, `city`, `street`, `postcode`, `rules`) VALUES
(9, 'KUANTAN FAMILY', 'Pahang', 'Kuantan', 'Kampung Padang', 25200, 'No advertisements allowed! \n Only matters about the neighborhood!'),
(10, 'Ampang Family', 'Selangor', 'Ampang', 'Jalan Bukit Indah 3/21', 68000, 'Must be relevant to the neighborhood group!'),
(12, 'Rawang Gang', 'Selangor', 'Rawang', 'Jalan AEON Rawang', 48000, 'Be kind and considerate to each other!'),
(13, 'George Town Group', 'Penang', 'George Town', 'Jalan Sultan Ahmad Shah', 10050, 'Be kind!'),
(14, 'Seremban Group', 'Negeri Sembilan', 'Seremban', 'Jalan Rasah', 10800, 'No Spam!');

-- --------------------------------------------------------

--
-- Table structure for table `restapi_residentmodel`
--

CREATE TABLE `restapi_residentmodel` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(1000) NOT NULL,
  `contact` varchar(20) NOT NULL,
  `state` varchar(20) NOT NULL,
  `city` varchar(100) NOT NULL,
  `street` varchar(100) NOT NULL,
  `postcode` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(150) NOT NULL,
  `isLeader` tinyint(1) NOT NULL,
  `groupID_id` bigint(20) DEFAULT NULL,
  `userData` varchar(1000) NOT NULL,
  `image` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `restapi_residentmodel`
--

INSERT INTO `restapi_residentmodel` (`id`, `name`, `email`, `contact`, `state`, `city`, `street`, `postcode`, `username`, `password`, `isLeader`, `groupID_id`, `userData`, `image`) VALUES
(1, 'Jason', 'jason@live.com', '011-2232123', 'Pahang', 'Kuantan', 'Jalan Bentang', 51000, 'jason', '$2b$12$zY9Qa4ubZwsBBq2h5CBcwOYWkPHfNOdav4W/u9j/gCjWnA9eba1R.', 1, 9, '{\"crimePostLikes\": [], \"crimePostDislikes\": [], \"complaintPostLikes\": [5], \"complaintPostDislikes\": [], \"eventPostLikes\": [], \"eventPostDislikes\": [], \"generalPostLikes\": [], \"generalPostDislikes\": []}', ''),
(2, 'Ryan', 'ryan@live.com', '011-2232123', 'Selangor', 'Ampang', 'Jalan Bukit Indah 3/21', 68000, 'ryan', '$2b$12$IVZg1J3Wo.oHZTA7TrOJVOBSS97vdb5r9G/5.hLlXH1Jk/reWgsTm', 0, 10, '{\"crimePostLikes\": [4, 5], \"crimePostDislikes\": [1, 3], \"complaintPostLikes\": [2, 5], \"complaintPostDislikes\": [], \"eventPostLikes\": [2, 1, 4, 7], \"eventPostDislikes\": [], \"generalPostLikes\": [1, 6], \"generalPostDislikes\": []}', 'images/profile/Profile_Image_BuEvqS9.jpg'),
(3, 'Jonathan', 'jona@live.com', '011-3332123', 'Pahang', 'Kuantan', 'Jalan Bentang', 51000, 'jona', '$2b$12$/a7np7icEmcVTwMJzcKyPu5g4VRFp3L4eJ3jLw2QrR35oN3Xmmbui', 0, 9, '{\"crimePostLikes\": [], \"crimePostDislikes\": [], \"complaintPostLikes\": [6, 5], \"complaintPostDislikes\": [], \"eventPostLikes\": [3], \"eventPostDislikes\": [], \"generalPostLikes\": [], \"generalPostDislikes\": []}', ''),
(4, 'Andrew Wiggins', 'jona@live.com', '011-3332123', 'Selangor', 'Ampang', 'Jalan Bukit Indah 3/21', 68000, 'andrew', '$2b$12$5gYZqoAX4FDh/GQ8x7hx0ehXz/DdYKzh9dFUzleqVrvBqd0QPCT/.', 1, 10, '{\"crimePostLikes\": [1, 3, 4, 5], \"crimePostDislikes\": [], \"complaintPostLikes\": [8], \"complaintPostDislikes\": [2], \"eventPostLikes\": [], \"eventPostDislikes\": [1], \"generalPostLikes\": [], \"generalPostDislikes\": [1]}', 'images/profile/Profile_Image_C0J6f9U.jpg'),
(5, 'Giorno', 'jona@live.com', '011-3332123', 'Selangor', 'KL', 'Jalan Bukit Indah 3/21', 68000, 'giorno', '$2b$12$Ufqt72fsZ4GoNLxQKHD1OesnqnI0pDgLIHIt7FLwZIm8Cw7Ttq0mi', 0, NULL, '{\"crimePostLikes\": [],\"crimePostDislikes\": [],\"complaintPostLikes\": [],\"complaintPostDislikes\": [],\"eventPostLikes\": [],\"eventPostDislikes\": [],\"generalPostLikes\": [],\"generalPostDislikes\": []}', NULL),
(6, 'Joshua', 'joshua@mail.com', '0112322212', 'Kelantan', 'Kota Bharu', 'Jalan', 10222, 'joshua', '$2b$12$ddBI82KWFpw/B6DJqnUVmu9L3pgLbdBi0nFff10tODNnI6sOVmV3m', 1, 12, '{\"crimePostLikes\": [],\"crimePostDislikes\": [],\"complaintPostLikes\": [],\"complaintPostDislikes\": [],\"eventPostLikes\": [],\"eventPostDislikes\": [],\"generalPostLikes\": [],\"generalPostDislikes\": []}', NULL),
(7, 'May', 'may@live.com', '011-12121333', 'Penang', 'George Town', 'Jalan Tering', 81000, 'may', '$2b$12$OOm/EWAWWsRDmBVOaCzwfuZapAmGEl0ESFCKVIG1LmVcAn2YBRLva', 1, 13, '{\"crimePostLikes\": [],\"crimePostDislikes\": [],\"complaintPostLikes\": [],\"complaintPostDislikes\": [],\"eventPostLikes\": [],\"eventPostDislikes\": [],\"generalPostLikes\": [],\"generalPostDislikes\": []}', ''),
(9, 'JAzz', 'jazz@mail.com', '011-123123123', 'Negeri Sembilan', 'Seremban', 'Jalan Rasah', 70300, 'jazz', '$2b$12$OoRZmLZdLvO5MBsvr2KO0.GCYdITiOZ4fAmyGQBLqD8luA8ZKkCha', 1, 14, '{\"crimePostLikes\": [],\"crimePostDislikes\": [],\"complaintPostLikes\": [],\"complaintPostDislikes\": [],\"eventPostLikes\": [],\"eventPostDislikes\": [],\"generalPostLikes\": [],\"generalPostDislikes\": []}', ''),
(10, 'dd', '2@mail.com', '1111111111', 'Selangor', 'Ampang', 'Jalan Bukit Indah 3/22', 68000, 'aaa', '$2b$12$3j9NsDgDgv2.mL45sEXPcuir6xmn2Q4J0moELkLRiHtotPr197d.K', 0, NULL, '{\"crimePostLikes\": [],\"crimePostDislikes\": [],\"complaintPostLikes\": [],\"complaintPostDislikes\": [],\"eventPostLikes\": [],\"eventPostDislikes\": [],\"generalPostLikes\": [],\"generalPostDislikes\": []}', '');

-- --------------------------------------------------------

--
-- Table structure for table `restapi_testmodel`
--

CREATE TABLE `restapi_testmodel` (
  `id` bigint(20) NOT NULL,
  `name` varchar(70) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `restapi_testmodel`
--

INSERT INTO `restapi_testmodel` (`id`, `name`) VALUES
(1, 'Ryan');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `restapi_chatmodel`
--
ALTER TABLE `restapi_chatmodel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `RESTAPI_chatmodel_receiver_id_03c95ba5_fk_RESTAPI_r` (`receiver_id`),
  ADD KEY `RESTAPI_chatmodel_sender_id_5e5f1ad8_fk_RESTAPI_residentmodel_id` (`sender_id`);

--
-- Indexes for table `restapi_complaintpostcommentmodel`
--
ALTER TABLE `restapi_complaintpostcommentmodel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `RESTAPI_complaintpos_authorID_id_43407fa7_fk_RESTAPI_r` (`authorID_id`),
  ADD KEY `RESTAPI_complaintpos_postID_id_bb6d00f7_fk_RESTAPI_c` (`postID_id`),
  ADD KEY `RESTAPI_complaintpos_groupID_id_53bb6d53_fk_RESTAPI_n` (`groupID_id`);

--
-- Indexes for table `restapi_complaintpostmodel`
--
ALTER TABLE `restapi_complaintpostmodel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `RESTAPI_complaintpos_reporterID_id_5a3945f4_fk_RESTAPI_r` (`reporterID_id`),
  ADD KEY `RESTAPI_complaintpos_groupID_id_7428f522_fk_RESTAPI_n` (`groupID_id`);

--
-- Indexes for table `restapi_crimepostcommentmodel`
--
ALTER TABLE `restapi_crimepostcommentmodel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `RESTAPI_crimepostcom_authorID_id_b3b8c9bd_fk_RESTAPI_r` (`authorID_id`),
  ADD KEY `RESTAPI_crimepostcom_postID_id_3edeeb92_fk_RESTAPI_c` (`postID_id`),
  ADD KEY `RESTAPI_crimepostcom_groupID_id_e30a48a3_fk_RESTAPI_n` (`groupID_id`);

--
-- Indexes for table `restapi_crimepostmodel`
--
ALTER TABLE `restapi_crimepostmodel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `RESTAPI_crimepostmod_reporterID_id_32e6850b_fk_RESTAPI_r` (`reporterID_id`),
  ADD KEY `RESTAPI_crimepostmod_groupID_id_f35485dc_fk_RESTAPI_n` (`groupID_id`);

--
-- Indexes for table `restapi_eventpostcommentmodel`
--
ALTER TABLE `restapi_eventpostcommentmodel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `RESTAPI_eventpostcom_authorID_id_a8563e8c_fk_RESTAPI_r` (`authorID_id`),
  ADD KEY `RESTAPI_eventpostcom_postID_id_6ba92b90_fk_RESTAPI_e` (`postID_id`),
  ADD KEY `RESTAPI_eventpostcom_groupID_id_a62a1dfe_fk_RESTAPI_n` (`groupID_id`);

--
-- Indexes for table `restapi_eventpostmodel`
--
ALTER TABLE `restapi_eventpostmodel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `RESTAPI_eventpostmod_organizerID_id_37bb27c8_fk_RESTAPI_r` (`organizerID_id`),
  ADD KEY `RESTAPI_eventpostmod_groupID_id_334a5078_fk_RESTAPI_n` (`groupID_id`);

--
-- Indexes for table `restapi_facilitiesmodel`
--
ALTER TABLE `restapi_facilitiesmodel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `RESTAPI_facilitiesmo_groupID_id_084d7f2e_fk_RESTAPI_n` (`groupID_id`),
  ADD KEY `RESTAPI_facilitiesmo_holder_id_d8aa47e7_fk_RESTAPI_r` (`holder_id`);

--
-- Indexes for table `restapi_generalpostcommentmodel`
--
ALTER TABLE `restapi_generalpostcommentmodel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `RESTAPI_generalpostc_authorID_id_17253b8f_fk_RESTAPI_r` (`authorID_id`),
  ADD KEY `RESTAPI_generalpostc_postID_id_06c85ae2_fk_RESTAPI_g` (`postID_id`),
  ADD KEY `RESTAPI_generalpostc_groupID_id_c7e80835_fk_RESTAPI_n` (`groupID_id`);

--
-- Indexes for table `restapi_generalpostmodel`
--
ALTER TABLE `restapi_generalpostmodel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `RESTAPI_generalpostm_authorID_id_0251bf20_fk_RESTAPI_r` (`authorID_id`),
  ADD KEY `RESTAPI_generalpostm_groupID_id_98eb5c36_fk_RESTAPI_n` (`groupID_id`);

--
-- Indexes for table `restapi_joinrequestmodel`
--
ALTER TABLE `restapi_joinrequestmodel`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `residentID_id` (`residentID_id`),
  ADD KEY `RESTAPI_joinrequestm_groupID_id_68649925_fk_RESTAPI_n` (`groupID_id`);

--
-- Indexes for table `restapi_neighborhoodgroupmodel`
--
ALTER TABLE `restapi_neighborhoodgroupmodel`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `RESTAPI_neighborhoodgroupmodel_name_100635eb_uniq` (`name`);

--
-- Indexes for table `restapi_residentmodel`
--
ALTER TABLE `restapi_residentmodel`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `RESTAPI_residentmode_groupID_id_2e4e8efb_fk_RESTAPI_n` (`groupID_id`);

--
-- Indexes for table `restapi_testmodel`
--
ALTER TABLE `restapi_testmodel`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `restapi_chatmodel`
--
ALTER TABLE `restapi_chatmodel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `restapi_complaintpostcommentmodel`
--
ALTER TABLE `restapi_complaintpostcommentmodel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `restapi_complaintpostmodel`
--
ALTER TABLE `restapi_complaintpostmodel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `restapi_crimepostcommentmodel`
--
ALTER TABLE `restapi_crimepostcommentmodel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `restapi_crimepostmodel`
--
ALTER TABLE `restapi_crimepostmodel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `restapi_eventpostcommentmodel`
--
ALTER TABLE `restapi_eventpostcommentmodel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `restapi_eventpostmodel`
--
ALTER TABLE `restapi_eventpostmodel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `restapi_facilitiesmodel`
--
ALTER TABLE `restapi_facilitiesmodel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `restapi_generalpostcommentmodel`
--
ALTER TABLE `restapi_generalpostcommentmodel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `restapi_generalpostmodel`
--
ALTER TABLE `restapi_generalpostmodel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `restapi_joinrequestmodel`
--
ALTER TABLE `restapi_joinrequestmodel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `restapi_neighborhoodgroupmodel`
--
ALTER TABLE `restapi_neighborhoodgroupmodel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `restapi_residentmodel`
--
ALTER TABLE `restapi_residentmodel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `restapi_testmodel`
--
ALTER TABLE `restapi_testmodel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `restapi_chatmodel`
--
ALTER TABLE `restapi_chatmodel`
  ADD CONSTRAINT `RESTAPI_chatmodel_receiver_id_03c95ba5_fk_RESTAPI_r` FOREIGN KEY (`receiver_id`) REFERENCES `restapi_residentmodel` (`id`),
  ADD CONSTRAINT `RESTAPI_chatmodel_sender_id_5e5f1ad8_fk_RESTAPI_residentmodel_id` FOREIGN KEY (`sender_id`) REFERENCES `restapi_residentmodel` (`id`);

--
-- Constraints for table `restapi_complaintpostcommentmodel`
--
ALTER TABLE `restapi_complaintpostcommentmodel`
  ADD CONSTRAINT `RESTAPI_complaintpos_authorID_id_43407fa7_fk_RESTAPI_r` FOREIGN KEY (`authorID_id`) REFERENCES `restapi_residentmodel` (`id`),
  ADD CONSTRAINT `RESTAPI_complaintpos_groupID_id_53bb6d53_fk_RESTAPI_n` FOREIGN KEY (`groupID_id`) REFERENCES `restapi_neighborhoodgroupmodel` (`id`),
  ADD CONSTRAINT `RESTAPI_complaintpos_postID_id_bb6d00f7_fk_RESTAPI_c` FOREIGN KEY (`postID_id`) REFERENCES `restapi_complaintpostmodel` (`id`);

--
-- Constraints for table `restapi_complaintpostmodel`
--
ALTER TABLE `restapi_complaintpostmodel`
  ADD CONSTRAINT `RESTAPI_complaintpos_groupID_id_7428f522_fk_RESTAPI_n` FOREIGN KEY (`groupID_id`) REFERENCES `restapi_neighborhoodgroupmodel` (`id`),
  ADD CONSTRAINT `RESTAPI_complaintpos_reporterID_id_5a3945f4_fk_RESTAPI_r` FOREIGN KEY (`reporterID_id`) REFERENCES `restapi_residentmodel` (`id`);

--
-- Constraints for table `restapi_crimepostcommentmodel`
--
ALTER TABLE `restapi_crimepostcommentmodel`
  ADD CONSTRAINT `RESTAPI_crimepostcom_authorID_id_b3b8c9bd_fk_RESTAPI_r` FOREIGN KEY (`authorID_id`) REFERENCES `restapi_residentmodel` (`id`),
  ADD CONSTRAINT `RESTAPI_crimepostcom_groupID_id_e30a48a3_fk_RESTAPI_n` FOREIGN KEY (`groupID_id`) REFERENCES `restapi_neighborhoodgroupmodel` (`id`),
  ADD CONSTRAINT `RESTAPI_crimepostcom_postID_id_3edeeb92_fk_RESTAPI_c` FOREIGN KEY (`postID_id`) REFERENCES `restapi_crimepostmodel` (`id`);

--
-- Constraints for table `restapi_crimepostmodel`
--
ALTER TABLE `restapi_crimepostmodel`
  ADD CONSTRAINT `RESTAPI_crimepostmod_groupID_id_f35485dc_fk_RESTAPI_n` FOREIGN KEY (`groupID_id`) REFERENCES `restapi_neighborhoodgroupmodel` (`id`),
  ADD CONSTRAINT `RESTAPI_crimepostmod_reporterID_id_32e6850b_fk_RESTAPI_r` FOREIGN KEY (`reporterID_id`) REFERENCES `restapi_residentmodel` (`id`);

--
-- Constraints for table `restapi_eventpostcommentmodel`
--
ALTER TABLE `restapi_eventpostcommentmodel`
  ADD CONSTRAINT `RESTAPI_eventpostcom_authorID_id_a8563e8c_fk_RESTAPI_r` FOREIGN KEY (`authorID_id`) REFERENCES `restapi_residentmodel` (`id`),
  ADD CONSTRAINT `RESTAPI_eventpostcom_groupID_id_a62a1dfe_fk_RESTAPI_n` FOREIGN KEY (`groupID_id`) REFERENCES `restapi_neighborhoodgroupmodel` (`id`),
  ADD CONSTRAINT `RESTAPI_eventpostcom_postID_id_6ba92b90_fk_RESTAPI_e` FOREIGN KEY (`postID_id`) REFERENCES `restapi_eventpostmodel` (`id`);

--
-- Constraints for table `restapi_eventpostmodel`
--
ALTER TABLE `restapi_eventpostmodel`
  ADD CONSTRAINT `RESTAPI_eventpostmod_groupID_id_334a5078_fk_RESTAPI_n` FOREIGN KEY (`groupID_id`) REFERENCES `restapi_neighborhoodgroupmodel` (`id`),
  ADD CONSTRAINT `RESTAPI_eventpostmod_organizerID_id_37bb27c8_fk_RESTAPI_r` FOREIGN KEY (`organizerID_id`) REFERENCES `restapi_residentmodel` (`id`);

--
-- Constraints for table `restapi_facilitiesmodel`
--
ALTER TABLE `restapi_facilitiesmodel`
  ADD CONSTRAINT `RESTAPI_facilitiesmo_groupID_id_084d7f2e_fk_RESTAPI_n` FOREIGN KEY (`groupID_id`) REFERENCES `restapi_neighborhoodgroupmodel` (`id`),
  ADD CONSTRAINT `RESTAPI_facilitiesmo_holder_id_d8aa47e7_fk_RESTAPI_r` FOREIGN KEY (`holder_id`) REFERENCES `restapi_residentmodel` (`id`);

--
-- Constraints for table `restapi_generalpostcommentmodel`
--
ALTER TABLE `restapi_generalpostcommentmodel`
  ADD CONSTRAINT `RESTAPI_generalpostc_authorID_id_17253b8f_fk_RESTAPI_r` FOREIGN KEY (`authorID_id`) REFERENCES `restapi_residentmodel` (`id`),
  ADD CONSTRAINT `RESTAPI_generalpostc_groupID_id_c7e80835_fk_RESTAPI_n` FOREIGN KEY (`groupID_id`) REFERENCES `restapi_neighborhoodgroupmodel` (`id`),
  ADD CONSTRAINT `RESTAPI_generalpostc_postID_id_06c85ae2_fk_RESTAPI_g` FOREIGN KEY (`postID_id`) REFERENCES `restapi_generalpostmodel` (`id`);

--
-- Constraints for table `restapi_generalpostmodel`
--
ALTER TABLE `restapi_generalpostmodel`
  ADD CONSTRAINT `RESTAPI_generalpostm_authorID_id_0251bf20_fk_RESTAPI_r` FOREIGN KEY (`authorID_id`) REFERENCES `restapi_residentmodel` (`id`),
  ADD CONSTRAINT `RESTAPI_generalpostm_groupID_id_98eb5c36_fk_RESTAPI_n` FOREIGN KEY (`groupID_id`) REFERENCES `restapi_neighborhoodgroupmodel` (`id`);

--
-- Constraints for table `restapi_joinrequestmodel`
--
ALTER TABLE `restapi_joinrequestmodel`
  ADD CONSTRAINT `RESTAPI_joinrequestm_groupID_id_68649925_fk_RESTAPI_n` FOREIGN KEY (`groupID_id`) REFERENCES `restapi_neighborhoodgroupmodel` (`id`),
  ADD CONSTRAINT `RESTAPI_joinrequestm_residentID_id_b25a8e83_fk_RESTAPI_r` FOREIGN KEY (`residentID_id`) REFERENCES `restapi_residentmodel` (`id`);

--
-- Constraints for table `restapi_residentmodel`
--
ALTER TABLE `restapi_residentmodel`
  ADD CONSTRAINT `RESTAPI_residentmode_groupID_id_2e4e8efb_fk_RESTAPI_n` FOREIGN KEY (`groupID_id`) REFERENCES `restapi_neighborhoodgroupmodel` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
