-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- 主机： 10.53.54.151:12041
-- 生成日期： 2019-06-20 10:22:13
-- 服务器版本： 5.7.18-20170830-log
-- PHP 版本： 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `dev_cnpostair`
--

-- --------------------------------------------------------

--
-- 表的结构 `account_groupdetail`
--

CREATE TABLE `account_groupdetail` (
  `id` int(11) NOT NULL,
  `category` varchar(20) NOT NULL,
  `notes` longtext NOT NULL,
  `link_to_group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `account_groupdetail`
--

INSERT INTO `account_groupdetail` (`id`, `category`, `notes`, `link_to_group_id`) VALUES
(1, 'work_task', '可以添加生产任务，编辑/删除自己创建且尚未生效的任务条目。', 3);

-- --------------------------------------------------------

--
-- 表的结构 `account_user`
--

CREATE TABLE `account_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `name` varchar(14) NOT NULL,
  `address` varchar(100) NOT NULL,
  `birthday` date DEFAULT NULL,
  `careerStartTime` date DEFAULT NULL,
  `education` varchar(10) NOT NULL,
  `gender` varchar(1) NOT NULL,
  `graduateSchool` varchar(30) NOT NULL,
  `ID_No` varchar(18) NOT NULL,
  `joinCPATime` date DEFAULT NULL,
  `major` varchar(40) NOT NULL,
  `mobile` varchar(16) NOT NULL,
  `nationality` varchar(5) NOT NULL,
  `nativePlace` varchar(10) NOT NULL,
  `picture` varchar(100) NOT NULL,
  `politicsStatus` varchar(10) NOT NULL,
  `wechat_account` varchar(50) NOT NULL,
  `wechat_qy_account` varchar(30) NOT NULL,
  `work_number` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `account_user`
--

INSERT INTO `account_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `email`, `is_staff`, `is_active`, `date_joined`, `name`, `address`, `birthday`, `careerStartTime`, `education`, `gender`, `graduateSchool`, `ID_No`, `joinCPATime`, `major`, `mobile`, `nationality`, `nativePlace`, `picture`, `politicsStatus`, `wechat_account`, `wechat_qy_account`, `work_number`) VALUES
(1, 'pbkdf2_sha256$150000$SHL1ThoEE7Zb$7likN6OxiIKA/TmGh1qL6P+JOKB2Zu/Yp1Q9OGNMZmw=', '2019-06-18 16:32:20.701140', 1, 'wangboyuan', 'wangboyuan@126.com', 1, 1, '2019-02-26 10:31:43.000000', '王博源', '南京市江宁区禄口街道颐家春天1栋', '1989-12-07', '2011-08-01', '本科', 'M', '中国民用航空飞行学院', '352225198912070033', '2011-08-01', '电子信息工程', '17715279566', '汉族', '福建', 'static/apps/account/User/picture/DSC03767.JPG', '群众', 'steven1989', 'wangboyuan', '27053'),
(2, 'pbkdf2_sha256$120000$0P5MBGQom8mZ$puzI6XzMcpXouyN0fnVbYuTOEFeapfvGvhVbxh7s5IE=', NULL, 0, 'baizhao', '', 0, 1, '2019-03-01 14:54:30.224737', '', '', NULL, NULL, '', 'M', '', '', NULL, '', '', '', '', '', '', '', '', ''),
(3, '!hEBQGXj2G6DmicA0DnIOfqyNVnCHEafmm75GBjIU', NULL, 0, 'AnonymousUser', '', 0, 1, '2019-03-04 11:35:19.557400', '', '', NULL, NULL, '', 'M', '', '', NULL, '', '', '', '', '', '', '', '', ''),
(4, 'pbkdf2_sha256$120000$OZzrHZexHPQi$zBApJV2f8al7pMg9dXt8XjKmUTDKzSQZpROAz8CT0T4=', '2019-03-22 15:35:03.000000', 0, 'jack', '', 1, 1, '2019-03-04 13:58:02.000000', '测试人', '', NULL, NULL, '', 'M', '', '', NULL, '', '', '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- 表的结构 `account_user_groups`
--

CREATE TABLE `account_user_groups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `account_user_groups`
--

INSERT INTO `account_user_groups` (`id`, `user_id`, `group_id`) VALUES
(4, 1, 3),
(5, 1, 4),
(2, 4, 3),
(3, 4, 4);

-- --------------------------------------------------------

--
-- 表的结构 `account_user_user_permissions`
--

CREATE TABLE `account_user_user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `authtoken_token`
--

CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(4, 'MCC主控'),
(3, 'MCC全员');

-- --------------------------------------------------------

--
-- 表的结构 `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `auth_group_permissions`
--

INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES
(13, 3, 24),
(14, 3, 28),
(8, 3, 32),
(10, 3, 69),
(11, 3, 73),
(15, 3, 105),
(16, 3, 106),
(17, 3, 107),
(18, 3, 108),
(3, 4, 74),
(4, 4, 75),
(5, 4, 76),
(6, 4, 77);

-- --------------------------------------------------------

--
-- 表的结构 `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `auth_permission`
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
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add 站点', 6, 'add_site'),
(22, 'Can change 站点', 6, 'change_site'),
(23, 'Can delete 站点', 6, 'delete_site'),
(24, 'Can view 站点', 6, 'view_site'),
(25, 'Can add 飞机基础信息', 7, 'add_aircraftbasicdata'),
(26, 'Can change 飞机基础信息', 7, 'change_aircraftbasicdata'),
(27, 'Can delete 飞机基础信息', 7, 'delete_aircraftbasicdata'),
(28, 'Can view 飞机基础信息', 7, 'view_aircraftbasicdata'),
(29, 'Can add 机型', 8, 'add_aircrafttype'),
(30, 'Can change 机型', 8, 'change_aircrafttype'),
(31, 'Can delete 机型', 8, 'delete_aircrafttype'),
(32, 'Can view 机型', 8, 'view_aircrafttype'),
(33, 'Can add user', 9, 'add_user'),
(34, 'Can change user', 9, 'change_user'),
(35, 'Can delete user', 9, 'delete_user'),
(36, 'Can view user', 9, 'view_user'),
(37, 'Can add Token', 10, 'add_token'),
(38, 'Can change Token', 10, 'change_token'),
(39, 'Can delete Token', 10, 'delete_token'),
(40, 'Can view Token', 10, 'view_token'),
(41, 'Can add Bookmark', 11, 'add_bookmark'),
(42, 'Can change Bookmark', 11, 'change_bookmark'),
(43, 'Can delete Bookmark', 11, 'delete_bookmark'),
(44, 'Can view Bookmark', 11, 'view_bookmark'),
(45, 'Can add User Setting', 12, 'add_usersettings'),
(46, 'Can change User Setting', 12, 'change_usersettings'),
(47, 'Can delete User Setting', 12, 'delete_usersettings'),
(48, 'Can view User Setting', 12, 'view_usersettings'),
(49, 'Can add User Widget', 13, 'add_userwidget'),
(50, 'Can change User Widget', 13, 'change_userwidget'),
(51, 'Can delete User Widget', 13, 'delete_userwidget'),
(52, 'Can view User Widget', 13, 'view_userwidget'),
(53, 'Can add log entry', 14, 'add_log'),
(54, 'Can change log entry', 14, 'change_log'),
(55, 'Can delete log entry', 14, 'delete_log'),
(56, 'Can view log entry', 14, 'view_log'),
(57, 'Can add revision', 15, 'add_revision'),
(58, 'Can change revision', 15, 'change_revision'),
(59, 'Can delete revision', 15, 'delete_revision'),
(60, 'Can view revision', 15, 'view_revision'),
(61, 'Can add version', 16, 'add_version'),
(62, 'Can change version', 16, 'change_version'),
(63, 'Can delete version', 16, 'delete_version'),
(64, 'Can view version', 16, 'view_version'),
(65, 'you can kill the user right now', 9, 'kill_user'),
(66, 'Can add ata chatper', 17, 'add_atachatper'),
(67, 'Can change ata chatper', 17, 'change_atachatper'),
(68, 'Can delete ata chatper', 17, 'delete_atachatper'),
(69, 'Can view ata chatper', 17, 'view_atachatper'),
(70, 'Can add jobcard', 18, 'add_jobcard'),
(71, 'Can change jobcard', 18, 'change_jobcard'),
(72, 'Can delete jobcard', 18, 'delete_jobcard'),
(73, 'Can view jobcard', 18, 'view_jobcard'),
(74, 'Can add task', 19, 'add_task'),
(75, 'Can change task', 19, 'change_task'),
(76, 'Can delete task', 19, 'delete_task'),
(77, 'Can view task', 19, 'view_task'),
(78, 'Can add task_package', 20, 'add_task_package'),
(79, 'Can change task_package', 20, 'change_task_package'),
(80, 'Can delete task_package', 20, 'delete_task_package'),
(81, 'Can view task_package', 20, 'view_task_package'),
(82, 'Can add task_feedback', 21, 'add_task_feedback'),
(83, 'Can change task_feedback', 21, 'change_task_feedback'),
(84, 'Can delete task_feedback', 21, 'delete_task_feedback'),
(85, 'Can view task_feedback', 21, 'view_task_feedback'),
(86, 'Can add group object permission', 22, 'add_groupobjectpermission'),
(87, 'Can change group object permission', 22, 'change_groupobjectpermission'),
(88, 'Can delete group object permission', 22, 'delete_groupobjectpermission'),
(89, 'Can view group object permission', 22, 'view_groupobjectpermission'),
(90, 'Can add user object permission', 23, 'add_userobjectpermission'),
(91, 'Can change user object permission', 23, 'change_userobjectpermission'),
(92, 'Can delete user object permission', 23, 'delete_userobjectpermission'),
(93, 'Can view user object permission', 23, 'view_userobjectpermission'),
(94, 'Can add 任务标准库', 24, 'add_task_standard_library'),
(95, 'Can change 任务标准库', 24, 'change_task_standard_library'),
(96, 'Can delete 任务标准库', 24, 'delete_task_standard_library'),
(97, 'Can view 任务标准库', 24, 'view_task_standard_library'),
(98, 'Can add group detail', 25, 'add_groupdetail'),
(99, 'Can change group detail', 25, 'change_groupdetail'),
(100, 'Can delete group detail', 25, 'delete_groupdetail'),
(101, 'Can view group detail', 25, 'view_groupdetail'),
(103, '可以生效Task', 19, 'activate_tasks'),
(104, '可以关闭Task', 19, 'close_tasks'),
(105, 'Can add 任务', 26, 'add_task'),
(106, 'Can change 任务', 26, 'change_task'),
(107, 'Can delete 任务', 26, 'delete_task'),
(108, 'Can view 任务', 26, 'view_task'),
(109, '可以生效 task', 26, 'activate_tasks'),
(110, '可以关闭 task', 26, 'close_tasks'),
(111, 'Can add 任务反馈', 27, 'add_task_feedback'),
(112, 'Can change 任务反馈', 27, 'change_task_feedback'),
(113, 'Can delete 任务反馈', 27, 'delete_task_feedback'),
(114, 'Can view 任务反馈', 27, 'view_task_feedback'),
(115, 'Can add 任务标准库', 28, 'add_task_standard_library'),
(116, 'Can change 任务标准库', 28, 'change_task_standard_library'),
(117, 'Can delete 任务标准库', 28, 'delete_task_standard_library'),
(118, 'Can view 任务标准库', 28, 'view_task_standard_library'),
(119, 'Can add 任务包', 29, 'add_task_package'),
(120, 'Can change 任务包', 29, 'change_task_package'),
(121, 'Can delete 任务包', 29, 'delete_task_package'),
(122, 'Can view 任务包', 29, 'view_task_package'),
(123, 'Can add snippet', 30, 'add_snippet'),
(124, 'Can change snippet', 30, 'change_snippet'),
(125, 'Can delete snippet', 30, 'delete_snippet'),
(126, 'Can view snippet', 30, 'view_snippet');

-- --------------------------------------------------------

--
-- 表的结构 `basicdata_aircraftbasicdata`
--

CREATE TABLE `basicdata_aircraftbasicdata` (
  `id` int(11) NOT NULL,
  `aircraft_number` varchar(10) NOT NULL,
  `notes` longtext NOT NULL,
  `type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `basicdata_aircraftbasicdata`
--

INSERT INTO `basicdata_aircraftbasicdata` (`id`, `aircraft_number`, `notes`, `type_id`) VALUES
(1, '2661', '这是2661飞机的备注', 1),
(2, '2882', '这是2882飞机的备注', 1),
(3, '2891', '这是2891飞机的备注', 2),
(4, '2831', '这是2831飞机的备注', 3);

-- --------------------------------------------------------

--
-- 表的结构 `basicdata_aircrafttype`
--

CREATE TABLE `basicdata_aircrafttype` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `valid` tinyint(1) NOT NULL,
  `notes` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `basicdata_aircrafttype`
--

INSERT INTO `basicdata_aircrafttype` (`id`, `name`, `valid`, `notes`) VALUES
(1, '737-300', 1, '这是一条测试用的数据，如果您看见， 请告知开发人员删除1'),
(2, '737-400', 1, ''),
(3, '757-200', 1, '这是一条测试用的数据，如果您看见，请告知开发人员删除2'),
(4, '737-800', 1, '');

-- --------------------------------------------------------

--
-- 表的结构 `basicdata_atachatper`
--

CREATE TABLE `basicdata_atachatper` (
  `id` int(11) NOT NULL,
  `chapter` varchar(3) NOT NULL,
  `section` varchar(20) NOT NULL,
  `subject_cn` varchar(50) NOT NULL,
  `subject_en` varchar(100) NOT NULL,
  `notes` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `basicdata_atachatper`
--

INSERT INTO `basicdata_atachatper` (`id`, `chapter`, `section`, `subject_cn`, `subject_en`, `notes`) VALUES
(6, '12', '', '外场勤务', 'SERVICING', ''),
(7, '12', '00', '概述', 'General', ''),
(8, '12', '10', '充加（液料、油料、气体）', 'Replenishing', ''),
(9, '12', '20', '定期性勤务工作', 'Scheduled Servicing', ''),
(10, '12', '30', '非定期性工作', 'Unscheduled Servicing', '');

-- --------------------------------------------------------

--
-- 表的结构 `basicdata_jobcard`
--

CREATE TABLE `basicdata_jobcard` (
  `id` int(11) NOT NULL,
  `jobcard_number` varchar(20) NOT NULL,
  `version` int(11) NOT NULL,
  `title_cn` varchar(50) NOT NULL,
  `title_en` varchar(100) NOT NULL,
  `notes` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `basicdata_jobcard`
--

INSERT INTO `basicdata_jobcard` (`id`, `jobcard_number`, `version`, `title_cn`, `title_en`, `notes`) VALUES
(1, '37B1222513B1', 11, '润滑 - 后缘襟翼球形蜗杆油槽 - 左 ', 'enaaa', ''),
(2, '37B2915912A2', 11, '更换 - 发动机驱动液压泵油滤 - 右发', 'enbbb', ''),
(3, '37M215881', 1, '更换EFIS冷却主供气风扇', 'enccc', ''),
(4, 'Y737C27100', 4, 'S245襟翼限制电门和S272安定面配平切断电门检查', 'enddd', ''),
(5, '37B1222113A1', 11, '润滑 - 副翼部件 - 左翼', 'no', '');

-- --------------------------------------------------------

--
-- 表的结构 `basicdata_site`
--

CREATE TABLE `basicdata_site` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `valid` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `basicdata_site`
--

INSERT INTO `basicdata_site` (`id`, `name`, `valid`) VALUES
(1, '北京', 1),
(2, '南京', 1),
(3, '浦东', 1),
(4, '温州', 1),
(5, '福州', 1),
(6, '厦门', 1),
(7, '南昌', 1),
(8, '广州', 1),
(9, '南宁', 1),
(10, '武汉', 1);

-- --------------------------------------------------------

--
-- 表的结构 `dev_snippet`
--

CREATE TABLE `dev_snippet` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `title` varchar(100) NOT NULL,
  `code` longtext NOT NULL,
  `linenos` tinyint(1) NOT NULL,
  `language` varchar(100) NOT NULL,
  `style` varchar(100) NOT NULL,
  `highlighted` longtext NOT NULL,
  `owner_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `dev_snippet`
--

INSERT INTO `dev_snippet` (`id`, `created`, `title`, `code`, `linenos`, `language`, `style`, `highlighted`, `owner_id`) VALUES
(1, '2019-03-21 15:56:41.918901', '这是测试标题01690', 'test111223', 0, 'python', 'friendly', '<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01//EN\"\n   \"http://www.w3.org/TR/html4/strict.dtd\">\n\n<html>\n<head>\n  <title>这是测试标题01690</title>\n  <meta http-equiv=\"content-type\" content=\"text/html; charset=None\">\n  <style type=\"text/css\">\ntd.linenos { background-color: #f0f0f0; padding-right: 10px; }\nspan.lineno { background-color: #f0f0f0; padding: 0 5px 0 5px; }\npre { line-height: 125%; }\nbody .hll { background-color: #ffffcc }\nbody  { background: #f0f0f0; }\nbody .c { color: #60a0b0; font-style: italic } /* Comment */\nbody .err { border: 1px solid #FF0000 } /* Error */\nbody .k { color: #007020; font-weight: bold } /* Keyword */\nbody .o { color: #666666 } /* Operator */\nbody .ch { color: #60a0b0; font-style: italic } /* Comment.Hashbang */\nbody .cm { color: #60a0b0; font-style: italic } /* Comment.Multiline */\nbody .cp { color: #007020 } /* Comment.Preproc */\nbody .cpf { color: #60a0b0; font-style: italic } /* Comment.PreprocFile */\nbody .c1 { color: #60a0b0; font-style: italic } /* Comment.Single */\nbody .cs { color: #60a0b0; background-color: #fff0f0 } /* Comment.Special */\nbody .gd { color: #A00000 } /* Generic.Deleted */\nbody .ge { font-style: italic } /* Generic.Emph */\nbody .gr { color: #FF0000 } /* Generic.Error */\nbody .gh { color: #000080; font-weight: bold } /* Generic.Heading */\nbody .gi { color: #00A000 } /* Generic.Inserted */\nbody .go { color: #888888 } /* Generic.Output */\nbody .gp { color: #c65d09; font-weight: bold } /* Generic.Prompt */\nbody .gs { font-weight: bold } /* Generic.Strong */\nbody .gu { color: #800080; font-weight: bold } /* Generic.Subheading */\nbody .gt { color: #0044DD } /* Generic.Traceback */\nbody .kc { color: #007020; font-weight: bold } /* Keyword.Constant */\nbody .kd { color: #007020; font-weight: bold } /* Keyword.Declaration */\nbody .kn { color: #007020; font-weight: bold } /* Keyword.Namespace */\nbody .kp { color: #007020 } /* Keyword.Pseudo */\nbody .kr { color: #007020; font-weight: bold } /* Keyword.Reserved */\nbody .kt { color: #902000 } /* Keyword.Type */\nbody .m { color: #40a070 } /* Literal.Number */\nbody .s { color: #4070a0 } /* Literal.String */\nbody .na { color: #4070a0 } /* Name.Attribute */\nbody .nb { color: #007020 } /* Name.Builtin */\nbody .nc { color: #0e84b5; font-weight: bold } /* Name.Class */\nbody .no { color: #60add5 } /* Name.Constant */\nbody .nd { color: #555555; font-weight: bold } /* Name.Decorator */\nbody .ni { color: #d55537; font-weight: bold } /* Name.Entity */\nbody .ne { color: #007020 } /* Name.Exception */\nbody .nf { color: #06287e } /* Name.Function */\nbody .nl { color: #002070; font-weight: bold } /* Name.Label */\nbody .nn { color: #0e84b5; font-weight: bold } /* Name.Namespace */\nbody .nt { color: #062873; font-weight: bold } /* Name.Tag */\nbody .nv { color: #bb60d5 } /* Name.Variable */\nbody .ow { color: #007020; font-weight: bold } /* Operator.Word */\nbody .w { color: #bbbbbb } /* Text.Whitespace */\nbody .mb { color: #40a070 } /* Literal.Number.Bin */\nbody .mf { color: #40a070 } /* Literal.Number.Float */\nbody .mh { color: #40a070 } /* Literal.Number.Hex */\nbody .mi { color: #40a070 } /* Literal.Number.Integer */\nbody .mo { color: #40a070 } /* Literal.Number.Oct */\nbody .sa { color: #4070a0 } /* Literal.String.Affix */\nbody .sb { color: #4070a0 } /* Literal.String.Backtick */\nbody .sc { color: #4070a0 } /* Literal.String.Char */\nbody .dl { color: #4070a0 } /* Literal.String.Delimiter */\nbody .sd { color: #4070a0; font-style: italic } /* Literal.String.Doc */\nbody .s2 { color: #4070a0 } /* Literal.String.Double */\nbody .se { color: #4070a0; font-weight: bold } /* Literal.String.Escape */\nbody .sh { color: #4070a0 } /* Literal.String.Heredoc */\nbody .si { color: #70a0d0; font-style: italic } /* Literal.String.Interpol */\nbody .sx { color: #c65d09 } /* Literal.String.Other */\nbody .sr { color: #235388 } /* Literal.String.Regex */\nbody .s1 { color: #4070a0 } /* Literal.String.Single */\nbody .ss { color: #517918 } /* Literal.String.Symbol */\nbody .bp { color: #007020 } /* Name.Builtin.Pseudo */\nbody .fm { color: #06287e } /* Name.Function.Magic */\nbody .vc { color: #bb60d5 } /* Name.Variable.Class */\nbody .vg { color: #bb60d5 } /* Name.Variable.Global */\nbody .vi { color: #bb60d5 } /* Name.Variable.Instance */\nbody .vm { color: #bb60d5 } /* Name.Variable.Magic */\nbody .il { color: #40a070 } /* Literal.Number.Integer.Long */\n\n  </style>\n</head>\n<body>\n<h2>这是测试标题01690</h2>\n\n<div class=\"highlight\"><pre><span></span><span class=\"n\">test111223</span>\n</pre></div>\n</body>\n</html>\n', 1),
(2, '2019-03-21 15:57:07.950285', '测试标题2223', 'test2222', 0, 'python', 'friendly', 'test22222', 4),
(3, '2019-03-21 16:06:01.312341', '这是apps/dev/views.py的内容', '# coding:utf-8\r\nfrom django.shortcuts import render,redirect\r\nfrom django.http import HttpResponse\r\n# from django.contrib.auth.models import User\r\nfrom apps.account.models import User\r\nfrom django.contrib import auth\r\nfrom rest_framework.views import APIView\r\nfrom rest_framework.response import Response\r\nimport cpa.cpa_init\r\nimport urllib.request\r\nfrom django.contrib.auth.decorators import login_required\r\n\r\nfrom .models import Snippet\r\nfrom .serializers import SnippetSerializer,UserSerializer\r\nfrom rest_framework import generics,permissions,renderers\r\nfrom .permissions import IsOwnerOrReadOnly\r\nfrom rest_framework.decorators import api_view\r\nfrom rest_framework.reverse import reverse\r\n\r\n# Create your views here.\r\n@login_required\r\ndef index(request):\r\n    return HttpResponse(u\"欢迎开启CPA2019项目\")\r\n\r\ndef login(request):\r\n    url = \"https://open.work.weixin.qq.com/wwopen/sso/qrConnect?appid=\"+cpa.cpa_init.qy_weixin_CorpID+\"&agentid=\"+str(15)+\"&redirect_uri=http://127.0.0.1:8000/login_process&state=STATE\"\r\n    return redirect(url)\r\n\r\n#使用管理组的开发者凭据获得access_token\r\ndef access_token():\r\n    url = \'https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=\'+cpa.cpa_init.qy_weixin_CorpID+\'&corpsecret=\'+cpa.cpa_init.qy_weixin_Secret\r\n    response = urllib.request.urlopen(url)\r\n    text = response.read()\r\n    text = eval(text)                   #str转换为dict\r\n    access_token = text[\'access_token\']\r\n    return access_token\r\n\r\n##################################################################################################################################\r\n#req：传入参数，带有CODE和STATE（参考：http://qydev.weixin.qq.com/wiki/index.php?title=%E4%BC%81%E4%B8%9A%E8%8E%B7%E5%8F%96code）\r\n#返回一个UserId，该请求微信号在企业号中的账号\r\n##################################################################################################################################\r\ndef OAuth(req):\r\n    CODE = req.GET.get(\'code\')\r\n    # state = req.GET.get(\'state\')\r\n    ACCESS_TOKEN = access_token()\r\n    url = \'https://qyapi.weixin.qq.com/cgi-bin/user/getuserinfo?access_token=\'+ACCESS_TOKEN+\'&code=\'+CODE\r\n    response = urllib.request.urlopen(url)\r\n    text = response.read()\r\n    text = eval(text)                   #str转换为dict\r\n    return text[\'UserId\']\r\n\r\n####################################################################################################################################################\r\n#req：传入参数，带有CODE和STATE（参考：http://qydev.weixin.qq.com/wiki/index.php?title=%E4%BC%81%E4%B8%9A%E8%8E%B7%E5%8F%96code）\r\n#返回参数，正确，说明该传入参数为内部微信用户发出的请求，并且指定返回一个公共权限账号cookie，让微信浏览器保存登录，同时返回True，否则返回False\r\n####################################################################################################################################################\r\ndef wechat_logined(req):\r\n    wechat_qy_ID = OAuth(req)\r\n    try:\r\n        YourAccount = User.objects.get(wechat_qy_account = wechat_qy_ID)\r\n    except User.DoesNotExist:\r\n        return HttpResponse(\"不存在此用户\")\r\n    else:\r\n        user = YourAccount\r\n        user.backend=\'django.contrib.auth.backends.ModelBackend\'\r\n        auth.login(req, user)\r\n        return redirect(req.path)\r\n        # return redirect(\'/admin\')\r\n\r\n\r\nclass TestView(APIView):  # CBV模式的视图函数\r\n    def get(self, request, *args, **kwargs):\r\n        # 定义get方法\r\n        # 在django-rest-framework中的request被重新封装了，后续分析源码的时候会有具体体现\r\n        return Response(\'测试api\')  # rest-framework的模板对数据进行渲染\r\n    def post(self, request, *args, **kwargs):\r\n        # 定义get方法\r\n        # 在django-rest-framework中的request被重新封装了，后续分析源码的时候会有具体体现\r\n        return Response(\'post啦\')  # rest-framework的模板对数据进行渲染\r\n    def put(self, request, *args, **kwargs):\r\n        # 定义get方法\r\n        # 在django-rest-framework中的request被重新封装了，后续分析源码的时候会有具体体现\r\n        return Response(\'put啦\')  # rest-framework的模板对数据进行渲染\r\n    def delete(self, request, *args, **kwargs):\r\n        # 定义get方法\r\n        # 在django-rest-framework中的request被重新封装了，后续分析源码的时候会有具体体现\r\n        return Response(\'挖槽，删库跑路～\')  # rest-framework的模板对数据进行渲染\r\n\r\nclass SnippetList(generics.ListCreateAPIView):\r\n    queryset = Snippet.objects.all()\r\n    serializer_class = SnippetSerializer\r\n    permission_classes = (permissions.IsAuthenticatedOrReadOnly,) #必需登录后才有create的权限\r\n    def perform_create(self, serializer):\r\n        serializer.save(owner=self.request.user)\r\n\r\nclass SnippetDetail(generics.RetrieveUpdateDestroyAPIView):\r\n    queryset = Snippet.objects.all()\r\n    serializer_class = SnippetSerializer\r\n    permission_classes = (permissions.IsAuthenticatedOrReadOnly,IsOwnerOrReadOnly)\r\n\r\nclass UserList(generics.ListAPIView):\r\n    queryset = User.objects.all()\r\n    serializer_class = UserSerializer\r\n\r\n\r\nclass UserDetail(generics.RetrieveAPIView):\r\n    queryset = User.objects.all()\r\n    serializer_class = UserSerializer\r\n\r\n@api_view([\'GET\'])\r\ndef api_root(request, format=None):\r\n    return Response({\r\n        \'users\': reverse(\'user-list\', request=request, format=format),\r\n        \'snippets\': reverse(\'snippet-list\', request=request, format=format)\r\n    })\r\n\r\nclass SnippetHighlight(generics.GenericAPIView):\r\n    queryset = Snippet.objects.all()\r\n    renderer_classes = (renderers.StaticHTMLRenderer,)\r\n\r\n    def get(self, request, *args, **kwargs):\r\n        snippet = self.get_object()\r\n        return Response(snippet.highlighted)', 1, 'python', 'tango', '<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01//EN\"\n   \"http://www.w3.org/TR/html4/strict.dtd\">\n\n<html>\n<head>\n  <title>这是apps/dev/views.py的内容</title>\n  <meta http-equiv=\"content-type\" content=\"text/html; charset=None\">\n  <style type=\"text/css\">\ntd.linenos { background-color: #f0f0f0; padding-right: 10px; }\nspan.lineno { background-color: #f0f0f0; padding: 0 5px 0 5px; }\npre { line-height: 125%; }\nbody .hll { background-color: #ffffcc }\nbody  { background: #f8f8f8; }\nbody .c { color: #8f5902; font-style: italic } /* Comment */\nbody .err { color: #a40000; border: 1px solid #ef2929 } /* Error */\nbody .g { color: #000000 } /* Generic */\nbody .k { color: #204a87; font-weight: bold } /* Keyword */\nbody .l { color: #000000 } /* Literal */\nbody .n { color: #000000 } /* Name */\nbody .o { color: #ce5c00; font-weight: bold } /* Operator */\nbody .x { color: #000000 } /* Other */\nbody .p { color: #000000; font-weight: bold } /* Punctuation */\nbody .ch { color: #8f5902; font-style: italic } /* Comment.Hashbang */\nbody .cm { color: #8f5902; font-style: italic } /* Comment.Multiline */\nbody .cp { color: #8f5902; font-style: italic } /* Comment.Preproc */\nbody .cpf { color: #8f5902; font-style: italic } /* Comment.PreprocFile */\nbody .c1 { color: #8f5902; font-style: italic } /* Comment.Single */\nbody .cs { color: #8f5902; font-style: italic } /* Comment.Special */\nbody .gd { color: #a40000 } /* Generic.Deleted */\nbody .ge { color: #000000; font-style: italic } /* Generic.Emph */\nbody .gr { color: #ef2929 } /* Generic.Error */\nbody .gh { color: #000080; font-weight: bold } /* Generic.Heading */\nbody .gi { color: #00A000 } /* Generic.Inserted */\nbody .go { color: #000000; font-style: italic } /* Generic.Output */\nbody .gp { color: #8f5902 } /* Generic.Prompt */\nbody .gs { color: #000000; font-weight: bold } /* Generic.Strong */\nbody .gu { color: #800080; font-weight: bold } /* Generic.Subheading */\nbody .gt { color: #a40000; font-weight: bold } /* Generic.Traceback */\nbody .kc { color: #204a87; font-weight: bold } /* Keyword.Constant */\nbody .kd { color: #204a87; font-weight: bold } /* Keyword.Declaration */\nbody .kn { color: #204a87; font-weight: bold } /* Keyword.Namespace */\nbody .kp { color: #204a87; font-weight: bold } /* Keyword.Pseudo */\nbody .kr { color: #204a87; font-weight: bold } /* Keyword.Reserved */\nbody .kt { color: #204a87; font-weight: bold } /* Keyword.Type */\nbody .ld { color: #000000 } /* Literal.Date */\nbody .m { color: #0000cf; font-weight: bold } /* Literal.Number */\nbody .s { color: #4e9a06 } /* Literal.String */\nbody .na { color: #c4a000 } /* Name.Attribute */\nbody .nb { color: #204a87 } /* Name.Builtin */\nbody .nc { color: #000000 } /* Name.Class */\nbody .no { color: #000000 } /* Name.Constant */\nbody .nd { color: #5c35cc; font-weight: bold } /* Name.Decorator */\nbody .ni { color: #ce5c00 } /* Name.Entity */\nbody .ne { color: #cc0000; font-weight: bold } /* Name.Exception */\nbody .nf { color: #000000 } /* Name.Function */\nbody .nl { color: #f57900 } /* Name.Label */\nbody .nn { color: #000000 } /* Name.Namespace */\nbody .nx { color: #000000 } /* Name.Other */\nbody .py { color: #000000 } /* Name.Property */\nbody .nt { color: #204a87; font-weight: bold } /* Name.Tag */\nbody .nv { color: #000000 } /* Name.Variable */\nbody .ow { color: #204a87; font-weight: bold } /* Operator.Word */\nbody .w { color: #f8f8f8; text-decoration: underline } /* Text.Whitespace */\nbody .mb { color: #0000cf; font-weight: bold } /* Literal.Number.Bin */\nbody .mf { color: #0000cf; font-weight: bold } /* Literal.Number.Float */\nbody .mh { color: #0000cf; font-weight: bold } /* Literal.Number.Hex */\nbody .mi { color: #0000cf; font-weight: bold } /* Literal.Number.Integer */\nbody .mo { color: #0000cf; font-weight: bold } /* Literal.Number.Oct */\nbody .sa { color: #4e9a06 } /* Literal.String.Affix */\nbody .sb { color: #4e9a06 } /* Literal.String.Backtick */\nbody .sc { color: #4e9a06 } /* Literal.String.Char */\nbody .dl { color: #4e9a06 } /* Literal.String.Delimiter */\nbody .sd { color: #8f5902; font-style: italic } /* Literal.String.Doc */\nbody .s2 { color: #4e9a06 } /* Literal.String.Double */\nbody .se { color: #4e9a06 } /* Literal.String.Escape */\nbody .sh { color: #4e9a06 } /* Literal.String.Heredoc */\nbody .si { color: #4e9a06 } /* Literal.String.Interpol */\nbody .sx { color: #4e9a06 } /* Literal.String.Other */\nbody .sr { color: #4e9a06 } /* Literal.String.Regex */\nbody .s1 { color: #4e9a06 } /* Literal.String.Single */\nbody .ss { color: #4e9a06 } /* Literal.String.Symbol */\nbody .bp { color: #3465a4 } /* Name.Builtin.Pseudo */\nbody .fm { color: #000000 } /* Name.Function.Magic */\nbody .vc { color: #000000 } /* Name.Variable.Class */\nbody .vg { color: #000000 } /* Name.Variable.Global */\nbody .vi { color: #000000 } /* Name.Variable.Instance */\nbody .vm { color: #000000 } /* Name.Variable.Magic */\nbody .il { color: #0000cf; font-weight: bold } /* Literal.Number.Integer.Long */\n\n  </style>\n</head>\n<body>\n<h2>这是apps/dev/views.py的内容</h2>\n\n<table class=\"highlighttable\"><tr><td class=\"linenos\"><div class=\"linenodiv\"><pre>  1\n  2\n  3\n  4\n  5\n  6\n  7\n  8\n  9\n 10\n 11\n 12\n 13\n 14\n 15\n 16\n 17\n 18\n 19\n 20\n 21\n 22\n 23\n 24\n 25\n 26\n 27\n 28\n 29\n 30\n 31\n 32\n 33\n 34\n 35\n 36\n 37\n 38\n 39\n 40\n 41\n 42\n 43\n 44\n 45\n 46\n 47\n 48\n 49\n 50\n 51\n 52\n 53\n 54\n 55\n 56\n 57\n 58\n 59\n 60\n 61\n 62\n 63\n 64\n 65\n 66\n 67\n 68\n 69\n 70\n 71\n 72\n 73\n 74\n 75\n 76\n 77\n 78\n 79\n 80\n 81\n 82\n 83\n 84\n 85\n 86\n 87\n 88\n 89\n 90\n 91\n 92\n 93\n 94\n 95\n 96\n 97\n 98\n 99\n100\n101\n102\n103\n104\n105\n106\n107\n108\n109\n110\n111\n112\n113\n114\n115\n116\n117\n118\n119\n120\n121\n122</pre></div></td><td class=\"code\"><div class=\"highlight\"><pre><span></span><span class=\"c1\"># coding:utf-8</span>\n<span class=\"kn\">from</span> <span class=\"nn\">django.shortcuts</span> <span class=\"kn\">import</span> <span class=\"n\">render</span><span class=\"p\">,</span><span class=\"n\">redirect</span>\n<span class=\"kn\">from</span> <span class=\"nn\">django.http</span> <span class=\"kn\">import</span> <span class=\"n\">HttpResponse</span>\n<span class=\"c1\"># from django.contrib.auth.models import User</span>\n<span class=\"kn\">from</span> <span class=\"nn\">apps.account.models</span> <span class=\"kn\">import</span> <span class=\"n\">User</span>\n<span class=\"kn\">from</span> <span class=\"nn\">django.contrib</span> <span class=\"kn\">import</span> <span class=\"n\">auth</span>\n<span class=\"kn\">from</span> <span class=\"nn\">rest_framework.views</span> <span class=\"kn\">import</span> <span class=\"n\">APIView</span>\n<span class=\"kn\">from</span> <span class=\"nn\">rest_framework.response</span> <span class=\"kn\">import</span> <span class=\"n\">Response</span>\n<span class=\"kn\">import</span> <span class=\"nn\">cpa.cpa_init</span>\n<span class=\"kn\">import</span> <span class=\"nn\">urllib.request</span>\n<span class=\"kn\">from</span> <span class=\"nn\">django.contrib.auth.decorators</span> <span class=\"kn\">import</span> <span class=\"n\">login_required</span>\n\n<span class=\"kn\">from</span> <span class=\"nn\">.models</span> <span class=\"kn\">import</span> <span class=\"n\">Snippet</span>\n<span class=\"kn\">from</span> <span class=\"nn\">.serializers</span> <span class=\"kn\">import</span> <span class=\"n\">SnippetSerializer</span><span class=\"p\">,</span><span class=\"n\">UserSerializer</span>\n<span class=\"kn\">from</span> <span class=\"nn\">rest_framework</span> <span class=\"kn\">import</span> <span class=\"n\">generics</span><span class=\"p\">,</span><span class=\"n\">permissions</span><span class=\"p\">,</span><span class=\"n\">renderers</span>\n<span class=\"kn\">from</span> <span class=\"nn\">.permissions</span> <span class=\"kn\">import</span> <span class=\"n\">IsOwnerOrReadOnly</span>\n<span class=\"kn\">from</span> <span class=\"nn\">rest_framework.decorators</span> <span class=\"kn\">import</span> <span class=\"n\">api_view</span>\n<span class=\"kn\">from</span> <span class=\"nn\">rest_framework.reverse</span> <span class=\"kn\">import</span> <span class=\"n\">reverse</span>\n\n<span class=\"c1\"># Create your views here.</span>\n<span class=\"nd\">@login_required</span>\n<span class=\"k\">def</span> <span class=\"nf\">index</span><span class=\"p\">(</span><span class=\"n\">request</span><span class=\"p\">):</span>\n    <span class=\"k\">return</span> <span class=\"n\">HttpResponse</span><span class=\"p\">(</span><span class=\"sa\">u</span><span class=\"s2\">&quot;欢迎开启CPA2019项目&quot;</span><span class=\"p\">)</span>\n\n<span class=\"k\">def</span> <span class=\"nf\">login</span><span class=\"p\">(</span><span class=\"n\">request</span><span class=\"p\">):</span>\n    <span class=\"n\">url</span> <span class=\"o\">=</span> <span class=\"s2\">&quot;https://open.work.weixin.qq.com/wwopen/sso/qrConnect?appid=&quot;</span><span class=\"o\">+</span><span class=\"n\">cpa</span><span class=\"o\">.</span><span class=\"n\">cpa_init</span><span class=\"o\">.</span><span class=\"n\">qy_weixin_CorpID</span><span class=\"o\">+</span><span class=\"s2\">&quot;&amp;agentid=&quot;</span><span class=\"o\">+</span><span class=\"nb\">str</span><span class=\"p\">(</span><span class=\"mi\">15</span><span class=\"p\">)</span><span class=\"o\">+</span><span class=\"s2\">&quot;&amp;redirect_uri=http://127.0.0.1:8000/login_process&amp;state=STATE&quot;</span>\n    <span class=\"k\">return</span> <span class=\"n\">redirect</span><span class=\"p\">(</span><span class=\"n\">url</span><span class=\"p\">)</span>\n\n<span class=\"c1\">#使用管理组的开发者凭据获得access_token</span>\n<span class=\"k\">def</span> <span class=\"nf\">access_token</span><span class=\"p\">():</span>\n    <span class=\"n\">url</span> <span class=\"o\">=</span> <span class=\"s1\">&#39;https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=&#39;</span><span class=\"o\">+</span><span class=\"n\">cpa</span><span class=\"o\">.</span><span class=\"n\">cpa_init</span><span class=\"o\">.</span><span class=\"n\">qy_weixin_CorpID</span><span class=\"o\">+</span><span class=\"s1\">&#39;&amp;corpsecret=&#39;</span><span class=\"o\">+</span><span class=\"n\">cpa</span><span class=\"o\">.</span><span class=\"n\">cpa_init</span><span class=\"o\">.</span><span class=\"n\">qy_weixin_Secret</span>\n    <span class=\"n\">response</span> <span class=\"o\">=</span> <span class=\"n\">urllib</span><span class=\"o\">.</span><span class=\"n\">request</span><span class=\"o\">.</span><span class=\"n\">urlopen</span><span class=\"p\">(</span><span class=\"n\">url</span><span class=\"p\">)</span>\n    <span class=\"n\">text</span> <span class=\"o\">=</span> <span class=\"n\">response</span><span class=\"o\">.</span><span class=\"n\">read</span><span class=\"p\">()</span>\n    <span class=\"n\">text</span> <span class=\"o\">=</span> <span class=\"nb\">eval</span><span class=\"p\">(</span><span class=\"n\">text</span><span class=\"p\">)</span>                   <span class=\"c1\">#str转换为dict</span>\n    <span class=\"n\">access_token</span> <span class=\"o\">=</span> <span class=\"n\">text</span><span class=\"p\">[</span><span class=\"s1\">&#39;access_token&#39;</span><span class=\"p\">]</span>\n    <span class=\"k\">return</span> <span class=\"n\">access_token</span>\n\n<span class=\"c1\">##################################################################################################################################</span>\n<span class=\"c1\">#req：传入参数，带有CODE和STATE（参考：http://qydev.weixin.qq.com/wiki/index.php?title=%E4%BC%81%E4%B8%9A%E8%8E%B7%E5%8F%96code）</span>\n<span class=\"c1\">#返回一个UserId，该请求微信号在企业号中的账号</span>\n<span class=\"c1\">##################################################################################################################################</span>\n<span class=\"k\">def</span> <span class=\"nf\">OAuth</span><span class=\"p\">(</span><span class=\"n\">req</span><span class=\"p\">):</span>\n    <span class=\"n\">CODE</span> <span class=\"o\">=</span> <span class=\"n\">req</span><span class=\"o\">.</span><span class=\"n\">GET</span><span class=\"o\">.</span><span class=\"n\">get</span><span class=\"p\">(</span><span class=\"s1\">&#39;code&#39;</span><span class=\"p\">)</span>\n    <span class=\"c1\"># state = req.GET.get(&#39;state&#39;)</span>\n    <span class=\"n\">ACCESS_TOKEN</span> <span class=\"o\">=</span> <span class=\"n\">access_token</span><span class=\"p\">()</span>\n    <span class=\"n\">url</span> <span class=\"o\">=</span> <span class=\"s1\">&#39;https://qyapi.weixin.qq.com/cgi-bin/user/getuserinfo?access_token=&#39;</span><span class=\"o\">+</span><span class=\"n\">ACCESS_TOKEN</span><span class=\"o\">+</span><span class=\"s1\">&#39;&amp;code=&#39;</span><span class=\"o\">+</span><span class=\"n\">CODE</span>\n    <span class=\"n\">response</span> <span class=\"o\">=</span> <span class=\"n\">urllib</span><span class=\"o\">.</span><span class=\"n\">request</span><span class=\"o\">.</span><span class=\"n\">urlopen</span><span class=\"p\">(</span><span class=\"n\">url</span><span class=\"p\">)</span>\n    <span class=\"n\">text</span> <span class=\"o\">=</span> <span class=\"n\">response</span><span class=\"o\">.</span><span class=\"n\">read</span><span class=\"p\">()</span>\n    <span class=\"n\">text</span> <span class=\"o\">=</span> <span class=\"nb\">eval</span><span class=\"p\">(</span><span class=\"n\">text</span><span class=\"p\">)</span>                   <span class=\"c1\">#str转换为dict</span>\n    <span class=\"k\">return</span> <span class=\"n\">text</span><span class=\"p\">[</span><span class=\"s1\">&#39;UserId&#39;</span><span class=\"p\">]</span>\n\n<span class=\"c1\">####################################################################################################################################################</span>\n<span class=\"c1\">#req：传入参数，带有CODE和STATE（参考：http://qydev.weixin.qq.com/wiki/index.php?title=%E4%BC%81%E4%B8%9A%E8%8E%B7%E5%8F%96code）</span>\n<span class=\"c1\">#返回参数，正确，说明该传入参数为内部微信用户发出的请求，并且指定返回一个公共权限账号cookie，让微信浏览器保存登录，同时返回True，否则返回False</span>\n<span class=\"c1\">####################################################################################################################################################</span>\n<span class=\"k\">def</span> <span class=\"nf\">wechat_logined</span><span class=\"p\">(</span><span class=\"n\">req</span><span class=\"p\">):</span>\n    <span class=\"n\">wechat_qy_ID</span> <span class=\"o\">=</span> <span class=\"n\">OAuth</span><span class=\"p\">(</span><span class=\"n\">req</span><span class=\"p\">)</span>\n    <span class=\"k\">try</span><span class=\"p\">:</span>\n        <span class=\"n\">YourAccount</span> <span class=\"o\">=</span> <span class=\"n\">User</span><span class=\"o\">.</span><span class=\"n\">objects</span><span class=\"o\">.</span><span class=\"n\">get</span><span class=\"p\">(</span><span class=\"n\">wechat_qy_account</span> <span class=\"o\">=</span> <span class=\"n\">wechat_qy_ID</span><span class=\"p\">)</span>\n    <span class=\"k\">except</span> <span class=\"n\">User</span><span class=\"o\">.</span><span class=\"n\">DoesNotExist</span><span class=\"p\">:</span>\n        <span class=\"k\">return</span> <span class=\"n\">HttpResponse</span><span class=\"p\">(</span><span class=\"s2\">&quot;不存在此用户&quot;</span><span class=\"p\">)</span>\n    <span class=\"k\">else</span><span class=\"p\">:</span>\n        <span class=\"n\">user</span> <span class=\"o\">=</span> <span class=\"n\">YourAccount</span>\n        <span class=\"n\">user</span><span class=\"o\">.</span><span class=\"n\">backend</span><span class=\"o\">=</span><span class=\"s1\">&#39;django.contrib.auth.backends.ModelBackend&#39;</span>\n        <span class=\"n\">auth</span><span class=\"o\">.</span><span class=\"n\">login</span><span class=\"p\">(</span><span class=\"n\">req</span><span class=\"p\">,</span> <span class=\"n\">user</span><span class=\"p\">)</span>\n        <span class=\"k\">return</span> <span class=\"n\">redirect</span><span class=\"p\">(</span><span class=\"n\">req</span><span class=\"o\">.</span><span class=\"n\">path</span><span class=\"p\">)</span>\n        <span class=\"c1\"># return redirect(&#39;/admin&#39;)</span>\n\n\n<span class=\"k\">class</span> <span class=\"nc\">TestView</span><span class=\"p\">(</span><span class=\"n\">APIView</span><span class=\"p\">):</span>  <span class=\"c1\"># CBV模式的视图函数</span>\n    <span class=\"k\">def</span> <span class=\"nf\">get</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">request</span><span class=\"p\">,</span> <span class=\"o\">*</span><span class=\"n\">args</span><span class=\"p\">,</span> <span class=\"o\">**</span><span class=\"n\">kwargs</span><span class=\"p\">):</span>\n        <span class=\"c1\"># 定义get方法</span>\n        <span class=\"c1\"># 在django-rest-framework中的request被重新封装了，后续分析源码的时候会有具体体现</span>\n        <span class=\"k\">return</span> <span class=\"n\">Response</span><span class=\"p\">(</span><span class=\"s1\">&#39;测试api&#39;</span><span class=\"p\">)</span>  <span class=\"c1\"># rest-framework的模板对数据进行渲染</span>\n    <span class=\"k\">def</span> <span class=\"nf\">post</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">request</span><span class=\"p\">,</span> <span class=\"o\">*</span><span class=\"n\">args</span><span class=\"p\">,</span> <span class=\"o\">**</span><span class=\"n\">kwargs</span><span class=\"p\">):</span>\n        <span class=\"c1\"># 定义get方法</span>\n        <span class=\"c1\"># 在django-rest-framework中的request被重新封装了，后续分析源码的时候会有具体体现</span>\n        <span class=\"k\">return</span> <span class=\"n\">Response</span><span class=\"p\">(</span><span class=\"s1\">&#39;post啦&#39;</span><span class=\"p\">)</span>  <span class=\"c1\"># rest-framework的模板对数据进行渲染</span>\n    <span class=\"k\">def</span> <span class=\"nf\">put</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">request</span><span class=\"p\">,</span> <span class=\"o\">*</span><span class=\"n\">args</span><span class=\"p\">,</span> <span class=\"o\">**</span><span class=\"n\">kwargs</span><span class=\"p\">):</span>\n        <span class=\"c1\"># 定义get方法</span>\n        <span class=\"c1\"># 在django-rest-framework中的request被重新封装了，后续分析源码的时候会有具体体现</span>\n        <span class=\"k\">return</span> <span class=\"n\">Response</span><span class=\"p\">(</span><span class=\"s1\">&#39;put啦&#39;</span><span class=\"p\">)</span>  <span class=\"c1\"># rest-framework的模板对数据进行渲染</span>\n    <span class=\"k\">def</span> <span class=\"nf\">delete</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">request</span><span class=\"p\">,</span> <span class=\"o\">*</span><span class=\"n\">args</span><span class=\"p\">,</span> <span class=\"o\">**</span><span class=\"n\">kwargs</span><span class=\"p\">):</span>\n        <span class=\"c1\"># 定义get方法</span>\n        <span class=\"c1\"># 在django-rest-framework中的request被重新封装了，后续分析源码的时候会有具体体现</span>\n        <span class=\"k\">return</span> <span class=\"n\">Response</span><span class=\"p\">(</span><span class=\"s1\">&#39;挖槽，删库跑路～&#39;</span><span class=\"p\">)</span>  <span class=\"c1\"># rest-framework的模板对数据进行渲染</span>\n\n<span class=\"k\">class</span> <span class=\"nc\">SnippetList</span><span class=\"p\">(</span><span class=\"n\">generics</span><span class=\"o\">.</span><span class=\"n\">ListCreateAPIView</span><span class=\"p\">):</span>\n    <span class=\"n\">queryset</span> <span class=\"o\">=</span> <span class=\"n\">Snippet</span><span class=\"o\">.</span><span class=\"n\">objects</span><span class=\"o\">.</span><span class=\"n\">all</span><span class=\"p\">()</span>\n    <span class=\"n\">serializer_class</span> <span class=\"o\">=</span> <span class=\"n\">SnippetSerializer</span>\n    <span class=\"n\">permission_classes</span> <span class=\"o\">=</span> <span class=\"p\">(</span><span class=\"n\">permissions</span><span class=\"o\">.</span><span class=\"n\">IsAuthenticatedOrReadOnly</span><span class=\"p\">,)</span> <span class=\"c1\">#必需登录后才有create的权限</span>\n    <span class=\"k\">def</span> <span class=\"nf\">perform_create</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">serializer</span><span class=\"p\">):</span>\n        <span class=\"n\">serializer</span><span class=\"o\">.</span><span class=\"n\">save</span><span class=\"p\">(</span><span class=\"n\">owner</span><span class=\"o\">=</span><span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">request</span><span class=\"o\">.</span><span class=\"n\">user</span><span class=\"p\">)</span>\n\n<span class=\"k\">class</span> <span class=\"nc\">SnippetDetail</span><span class=\"p\">(</span><span class=\"n\">generics</span><span class=\"o\">.</span><span class=\"n\">RetrieveUpdateDestroyAPIView</span><span class=\"p\">):</span>\n    <span class=\"n\">queryset</span> <span class=\"o\">=</span> <span class=\"n\">Snippet</span><span class=\"o\">.</span><span class=\"n\">objects</span><span class=\"o\">.</span><span class=\"n\">all</span><span class=\"p\">()</span>\n    <span class=\"n\">serializer_class</span> <span class=\"o\">=</span> <span class=\"n\">SnippetSerializer</span>\n    <span class=\"n\">permission_classes</span> <span class=\"o\">=</span> <span class=\"p\">(</span><span class=\"n\">permissions</span><span class=\"o\">.</span><span class=\"n\">IsAuthenticatedOrReadOnly</span><span class=\"p\">,</span><span class=\"n\">IsOwnerOrReadOnly</span><span class=\"p\">)</span>\n\n<span class=\"k\">class</span> <span class=\"nc\">UserList</span><span class=\"p\">(</span><span class=\"n\">generics</span><span class=\"o\">.</span><span class=\"n\">ListAPIView</span><span class=\"p\">):</span>\n    <span class=\"n\">queryset</span> <span class=\"o\">=</span> <span class=\"n\">User</span><span class=\"o\">.</span><span class=\"n\">objects</span><span class=\"o\">.</span><span class=\"n\">all</span><span class=\"p\">()</span>\n    <span class=\"n\">serializer_class</span> <span class=\"o\">=</span> <span class=\"n\">UserSerializer</span>\n\n\n<span class=\"k\">class</span> <span class=\"nc\">UserDetail</span><span class=\"p\">(</span><span class=\"n\">generics</span><span class=\"o\">.</span><span class=\"n\">RetrieveAPIView</span><span class=\"p\">):</span>\n    <span class=\"n\">queryset</span> <span class=\"o\">=</span> <span class=\"n\">User</span><span class=\"o\">.</span><span class=\"n\">objects</span><span class=\"o\">.</span><span class=\"n\">all</span><span class=\"p\">()</span>\n    <span class=\"n\">serializer_class</span> <span class=\"o\">=</span> <span class=\"n\">UserSerializer</span>\n\n<span class=\"nd\">@api_view</span><span class=\"p\">([</span><span class=\"s1\">&#39;GET&#39;</span><span class=\"p\">])</span>\n<span class=\"k\">def</span> <span class=\"nf\">api_root</span><span class=\"p\">(</span><span class=\"n\">request</span><span class=\"p\">,</span> <span class=\"n\">format</span><span class=\"o\">=</span><span class=\"bp\">None</span><span class=\"p\">):</span>\n    <span class=\"k\">return</span> <span class=\"n\">Response</span><span class=\"p\">({</span>\n        <span class=\"s1\">&#39;users&#39;</span><span class=\"p\">:</span> <span class=\"n\">reverse</span><span class=\"p\">(</span><span class=\"s1\">&#39;user-list&#39;</span><span class=\"p\">,</span> <span class=\"n\">request</span><span class=\"o\">=</span><span class=\"n\">request</span><span class=\"p\">,</span> <span class=\"n\">format</span><span class=\"o\">=</span><span class=\"n\">format</span><span class=\"p\">),</span>\n        <span class=\"s1\">&#39;snippets&#39;</span><span class=\"p\">:</span> <span class=\"n\">reverse</span><span class=\"p\">(</span><span class=\"s1\">&#39;snippet-list&#39;</span><span class=\"p\">,</span> <span class=\"n\">request</span><span class=\"o\">=</span><span class=\"n\">request</span><span class=\"p\">,</span> <span class=\"n\">format</span><span class=\"o\">=</span><span class=\"n\">format</span><span class=\"p\">)</span>\n    <span class=\"p\">})</span>\n\n<span class=\"k\">class</span> <span class=\"nc\">SnippetHighlight</span><span class=\"p\">(</span><span class=\"n\">generics</span><span class=\"o\">.</span><span class=\"n\">GenericAPIView</span><span class=\"p\">):</span>\n    <span class=\"n\">queryset</span> <span class=\"o\">=</span> <span class=\"n\">Snippet</span><span class=\"o\">.</span><span class=\"n\">objects</span><span class=\"o\">.</span><span class=\"n\">all</span><span class=\"p\">()</span>\n    <span class=\"n\">renderer_classes</span> <span class=\"o\">=</span> <span class=\"p\">(</span><span class=\"n\">renderers</span><span class=\"o\">.</span><span class=\"n\">StaticHTMLRenderer</span><span class=\"p\">,)</span>\n\n    <span class=\"k\">def</span> <span class=\"nf\">get</span><span class=\"p\">(</span><span class=\"bp\">self</span><span class=\"p\">,</span> <span class=\"n\">request</span><span class=\"p\">,</span> <span class=\"o\">*</span><span class=\"n\">args</span><span class=\"p\">,</span> <span class=\"o\">**</span><span class=\"n\">kwargs</span><span class=\"p\">):</span>\n        <span class=\"n\">snippet</span> <span class=\"o\">=</span> <span class=\"bp\">self</span><span class=\"o\">.</span><span class=\"n\">get_object</span><span class=\"p\">()</span>\n        <span class=\"k\">return</span> <span class=\"n\">Response</span><span class=\"p\">(</span><span class=\"n\">snippet</span><span class=\"o\">.</span><span class=\"n\">highlighted</span><span class=\"p\">)</span>\n</pre></div>\n</td></tr></table></body>\n</html>\n', 1),
(4, '2019-03-21 16:16:45.438399', '测试测试，112233', '1122', 0, 'abap', 'abap', '<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01//EN\"\n   \"http://www.w3.org/TR/html4/strict.dtd\">\n\n<html>\n<head>\n  <title>测试测试，112233</title>\n  <meta http-equiv=\"content-type\" content=\"text/html; charset=None\">\n  <style type=\"text/css\">\ntd.linenos { background-color: #f0f0f0; padding-right: 10px; }\nspan.lineno { background-color: #f0f0f0; padding: 0 5px 0 5px; }\npre { line-height: 125%; }\nbody .hll { background-color: #ffffcc }\nbody  { background: #ffffff; }\nbody .c { color: #888888; font-style: italic } /* Comment */\nbody .err { color: #FF0000 } /* Error */\nbody .k { color: #0000ff } /* Keyword */\nbody .n { color: #000000 } /* Name */\nbody .ch { color: #888888; font-style: italic } /* Comment.Hashbang */\nbody .cm { color: #888888; font-style: italic } /* Comment.Multiline */\nbody .cp { color: #888888; font-style: italic } /* Comment.Preproc */\nbody .cpf { color: #888888; font-style: italic } /* Comment.PreprocFile */\nbody .c1 { color: #888888; font-style: italic } /* Comment.Single */\nbody .cs { color: #888888; font-style: italic } /* Comment.Special */\nbody .kc { color: #0000ff } /* Keyword.Constant */\nbody .kd { color: #0000ff } /* Keyword.Declaration */\nbody .kn { color: #0000ff } /* Keyword.Namespace */\nbody .kp { color: #0000ff } /* Keyword.Pseudo */\nbody .kr { color: #0000ff } /* Keyword.Reserved */\nbody .kt { color: #0000ff } /* Keyword.Type */\nbody .m { color: #33aaff } /* Literal.Number */\nbody .s { color: #55aa22 } /* Literal.String */\nbody .na { color: #000000 } /* Name.Attribute */\nbody .nb { color: #000000 } /* Name.Builtin */\nbody .nc { color: #000000 } /* Name.Class */\nbody .no { color: #000000 } /* Name.Constant */\nbody .nd { color: #000000 } /* Name.Decorator */\nbody .ni { color: #000000 } /* Name.Entity */\nbody .ne { color: #000000 } /* Name.Exception */\nbody .nf { color: #000000 } /* Name.Function */\nbody .nl { color: #000000 } /* Name.Label */\nbody .nn { color: #000000 } /* Name.Namespace */\nbody .nx { color: #000000 } /* Name.Other */\nbody .py { color: #000000 } /* Name.Property */\nbody .nt { color: #000000 } /* Name.Tag */\nbody .nv { color: #000000 } /* Name.Variable */\nbody .ow { color: #0000ff } /* Operator.Word */\nbody .mb { color: #33aaff } /* Literal.Number.Bin */\nbody .mf { color: #33aaff } /* Literal.Number.Float */\nbody .mh { color: #33aaff } /* Literal.Number.Hex */\nbody .mi { color: #33aaff } /* Literal.Number.Integer */\nbody .mo { color: #33aaff } /* Literal.Number.Oct */\nbody .sa { color: #55aa22 } /* Literal.String.Affix */\nbody .sb { color: #55aa22 } /* Literal.String.Backtick */\nbody .sc { color: #55aa22 } /* Literal.String.Char */\nbody .dl { color: #55aa22 } /* Literal.String.Delimiter */\nbody .sd { color: #55aa22 } /* Literal.String.Doc */\nbody .s2 { color: #55aa22 } /* Literal.String.Double */\nbody .se { color: #55aa22 } /* Literal.String.Escape */\nbody .sh { color: #55aa22 } /* Literal.String.Heredoc */\nbody .si { color: #55aa22 } /* Literal.String.Interpol */\nbody .sx { color: #55aa22 } /* Literal.String.Other */\nbody .sr { color: #55aa22 } /* Literal.String.Regex */\nbody .s1 { color: #55aa22 } /* Literal.String.Single */\nbody .ss { color: #55aa22 } /* Literal.String.Symbol */\nbody .bp { color: #000000 } /* Name.Builtin.Pseudo */\nbody .fm { color: #000000 } /* Name.Function.Magic */\nbody .vc { color: #000000 } /* Name.Variable.Class */\nbody .vg { color: #000000 } /* Name.Variable.Global */\nbody .vi { color: #000000 } /* Name.Variable.Instance */\nbody .vm { color: #000000 } /* Name.Variable.Magic */\nbody .il { color: #33aaff } /* Literal.Number.Integer.Long */\n\n  </style>\n</head>\n<body>\n<h2>测试测试，112233</h2>\n\n<div class=\"highlight\"><pre><span></span><span class=\"mi\">1122</span>\n</pre></div>\n</body>\n</html>\n', 1),
(5, '2019-03-21 16:21:06.502021', 'abctest', 'ss', 0, 'abap', 'abap', '<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01//EN\"\n   \"http://www.w3.org/TR/html4/strict.dtd\">\n\n<html>\n<head>\n  <title>abctest</title>\n  <meta http-equiv=\"content-type\" content=\"text/html; charset=None\">\n  <style type=\"text/css\">\ntd.linenos { background-color: #f0f0f0; padding-right: 10px; }\nspan.lineno { background-color: #f0f0f0; padding: 0 5px 0 5px; }\npre { line-height: 125%; }\nbody .hll { background-color: #ffffcc }\nbody  { background: #ffffff; }\nbody .c { color: #888888; font-style: italic } /* Comment */\nbody .err { color: #FF0000 } /* Error */\nbody .k { color: #0000ff } /* Keyword */\nbody .n { color: #000000 } /* Name */\nbody .ch { color: #888888; font-style: italic } /* Comment.Hashbang */\nbody .cm { color: #888888; font-style: italic } /* Comment.Multiline */\nbody .cp { color: #888888; font-style: italic } /* Comment.Preproc */\nbody .cpf { color: #888888; font-style: italic } /* Comment.PreprocFile */\nbody .c1 { color: #888888; font-style: italic } /* Comment.Single */\nbody .cs { color: #888888; font-style: italic } /* Comment.Special */\nbody .kc { color: #0000ff } /* Keyword.Constant */\nbody .kd { color: #0000ff } /* Keyword.Declaration */\nbody .kn { color: #0000ff } /* Keyword.Namespace */\nbody .kp { color: #0000ff } /* Keyword.Pseudo */\nbody .kr { color: #0000ff } /* Keyword.Reserved */\nbody .kt { color: #0000ff } /* Keyword.Type */\nbody .m { color: #33aaff } /* Literal.Number */\nbody .s { color: #55aa22 } /* Literal.String */\nbody .na { color: #000000 } /* Name.Attribute */\nbody .nb { color: #000000 } /* Name.Builtin */\nbody .nc { color: #000000 } /* Name.Class */\nbody .no { color: #000000 } /* Name.Constant */\nbody .nd { color: #000000 } /* Name.Decorator */\nbody .ni { color: #000000 } /* Name.Entity */\nbody .ne { color: #000000 } /* Name.Exception */\nbody .nf { color: #000000 } /* Name.Function */\nbody .nl { color: #000000 } /* Name.Label */\nbody .nn { color: #000000 } /* Name.Namespace */\nbody .nx { color: #000000 } /* Name.Other */\nbody .py { color: #000000 } /* Name.Property */\nbody .nt { color: #000000 } /* Name.Tag */\nbody .nv { color: #000000 } /* Name.Variable */\nbody .ow { color: #0000ff } /* Operator.Word */\nbody .mb { color: #33aaff } /* Literal.Number.Bin */\nbody .mf { color: #33aaff } /* Literal.Number.Float */\nbody .mh { color: #33aaff } /* Literal.Number.Hex */\nbody .mi { color: #33aaff } /* Literal.Number.Integer */\nbody .mo { color: #33aaff } /* Literal.Number.Oct */\nbody .sa { color: #55aa22 } /* Literal.String.Affix */\nbody .sb { color: #55aa22 } /* Literal.String.Backtick */\nbody .sc { color: #55aa22 } /* Literal.String.Char */\nbody .dl { color: #55aa22 } /* Literal.String.Delimiter */\nbody .sd { color: #55aa22 } /* Literal.String.Doc */\nbody .s2 { color: #55aa22 } /* Literal.String.Double */\nbody .se { color: #55aa22 } /* Literal.String.Escape */\nbody .sh { color: #55aa22 } /* Literal.String.Heredoc */\nbody .si { color: #55aa22 } /* Literal.String.Interpol */\nbody .sx { color: #55aa22 } /* Literal.String.Other */\nbody .sr { color: #55aa22 } /* Literal.String.Regex */\nbody .s1 { color: #55aa22 } /* Literal.String.Single */\nbody .ss { color: #55aa22 } /* Literal.String.Symbol */\nbody .bp { color: #000000 } /* Name.Builtin.Pseudo */\nbody .fm { color: #000000 } /* Name.Function.Magic */\nbody .vc { color: #000000 } /* Name.Variable.Class */\nbody .vg { color: #000000 } /* Name.Variable.Global */\nbody .vi { color: #000000 } /* Name.Variable.Instance */\nbody .vm { color: #000000 } /* Name.Variable.Magic */\nbody .il { color: #33aaff } /* Literal.Number.Integer.Long */\n\n  </style>\n</head>\n<body>\n<h2>abctest</h2>\n\n<div class=\"highlight\"><pre><span></span><span class=\"nv\">ss</span>\n</pre></div>\n</body>\n</html>\n', 1),
(6, '2019-03-21 16:21:38.917740', 'abctttttd', 'kj', 0, 'abap', 'abap', '<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01//EN\"\n   \"http://www.w3.org/TR/html4/strict.dtd\">\n\n<html>\n<head>\n  <title>abctttttd</title>\n  <meta http-equiv=\"content-type\" content=\"text/html; charset=None\">\n  <style type=\"text/css\">\ntd.linenos { background-color: #f0f0f0; padding-right: 10px; }\nspan.lineno { background-color: #f0f0f0; padding: 0 5px 0 5px; }\npre { line-height: 125%; }\nbody .hll { background-color: #ffffcc }\nbody  { background: #ffffff; }\nbody .c { color: #888888; font-style: italic } /* Comment */\nbody .err { color: #FF0000 } /* Error */\nbody .k { color: #0000ff } /* Keyword */\nbody .n { color: #000000 } /* Name */\nbody .ch { color: #888888; font-style: italic } /* Comment.Hashbang */\nbody .cm { color: #888888; font-style: italic } /* Comment.Multiline */\nbody .cp { color: #888888; font-style: italic } /* Comment.Preproc */\nbody .cpf { color: #888888; font-style: italic } /* Comment.PreprocFile */\nbody .c1 { color: #888888; font-style: italic } /* Comment.Single */\nbody .cs { color: #888888; font-style: italic } /* Comment.Special */\nbody .kc { color: #0000ff } /* Keyword.Constant */\nbody .kd { color: #0000ff } /* Keyword.Declaration */\nbody .kn { color: #0000ff } /* Keyword.Namespace */\nbody .kp { color: #0000ff } /* Keyword.Pseudo */\nbody .kr { color: #0000ff } /* Keyword.Reserved */\nbody .kt { color: #0000ff } /* Keyword.Type */\nbody .m { color: #33aaff } /* Literal.Number */\nbody .s { color: #55aa22 } /* Literal.String */\nbody .na { color: #000000 } /* Name.Attribute */\nbody .nb { color: #000000 } /* Name.Builtin */\nbody .nc { color: #000000 } /* Name.Class */\nbody .no { color: #000000 } /* Name.Constant */\nbody .nd { color: #000000 } /* Name.Decorator */\nbody .ni { color: #000000 } /* Name.Entity */\nbody .ne { color: #000000 } /* Name.Exception */\nbody .nf { color: #000000 } /* Name.Function */\nbody .nl { color: #000000 } /* Name.Label */\nbody .nn { color: #000000 } /* Name.Namespace */\nbody .nx { color: #000000 } /* Name.Other */\nbody .py { color: #000000 } /* Name.Property */\nbody .nt { color: #000000 } /* Name.Tag */\nbody .nv { color: #000000 } /* Name.Variable */\nbody .ow { color: #0000ff } /* Operator.Word */\nbody .mb { color: #33aaff } /* Literal.Number.Bin */\nbody .mf { color: #33aaff } /* Literal.Number.Float */\nbody .mh { color: #33aaff } /* Literal.Number.Hex */\nbody .mi { color: #33aaff } /* Literal.Number.Integer */\nbody .mo { color: #33aaff } /* Literal.Number.Oct */\nbody .sa { color: #55aa22 } /* Literal.String.Affix */\nbody .sb { color: #55aa22 } /* Literal.String.Backtick */\nbody .sc { color: #55aa22 } /* Literal.String.Char */\nbody .dl { color: #55aa22 } /* Literal.String.Delimiter */\nbody .sd { color: #55aa22 } /* Literal.String.Doc */\nbody .s2 { color: #55aa22 } /* Literal.String.Double */\nbody .se { color: #55aa22 } /* Literal.String.Escape */\nbody .sh { color: #55aa22 } /* Literal.String.Heredoc */\nbody .si { color: #55aa22 } /* Literal.String.Interpol */\nbody .sx { color: #55aa22 } /* Literal.String.Other */\nbody .sr { color: #55aa22 } /* Literal.String.Regex */\nbody .s1 { color: #55aa22 } /* Literal.String.Single */\nbody .ss { color: #55aa22 } /* Literal.String.Symbol */\nbody .bp { color: #000000 } /* Name.Builtin.Pseudo */\nbody .fm { color: #000000 } /* Name.Function.Magic */\nbody .vc { color: #000000 } /* Name.Variable.Class */\nbody .vg { color: #000000 } /* Name.Variable.Global */\nbody .vi { color: #000000 } /* Name.Variable.Instance */\nbody .vm { color: #000000 } /* Name.Variable.Magic */\nbody .il { color: #33aaff } /* Literal.Number.Integer.Long */\n\n  </style>\n</head>\n<body>\n<h2>abctttttd</h2>\n\n<div class=\"highlight\"><pre><span></span><span class=\"nv\">kj</span>\n</pre></div>\n</body>\n</html>\n', 1);
INSERT INTO `dev_snippet` (`id`, `created`, `title`, `code`, `linenos`, `language`, `style`, `highlighted`, `owner_id`) VALUES
(7, '2019-03-22 14:53:19.348951', 'ii', 'oo', 0, 'abap', 'abap', '<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01//EN\"\n   \"http://www.w3.org/TR/html4/strict.dtd\">\n\n<html>\n<head>\n  <title>ii</title>\n  <meta http-equiv=\"content-type\" content=\"text/html; charset=None\">\n  <style type=\"text/css\">\ntd.linenos { background-color: #f0f0f0; padding-right: 10px; }\nspan.lineno { background-color: #f0f0f0; padding: 0 5px 0 5px; }\npre { line-height: 125%; }\nbody .hll { background-color: #ffffcc }\nbody  { background: #ffffff; }\nbody .c { color: #888888; font-style: italic } /* Comment */\nbody .err { color: #FF0000 } /* Error */\nbody .k { color: #0000ff } /* Keyword */\nbody .n { color: #000000 } /* Name */\nbody .ch { color: #888888; font-style: italic } /* Comment.Hashbang */\nbody .cm { color: #888888; font-style: italic } /* Comment.Multiline */\nbody .cp { color: #888888; font-style: italic } /* Comment.Preproc */\nbody .cpf { color: #888888; font-style: italic } /* Comment.PreprocFile */\nbody .c1 { color: #888888; font-style: italic } /* Comment.Single */\nbody .cs { color: #888888; font-style: italic } /* Comment.Special */\nbody .kc { color: #0000ff } /* Keyword.Constant */\nbody .kd { color: #0000ff } /* Keyword.Declaration */\nbody .kn { color: #0000ff } /* Keyword.Namespace */\nbody .kp { color: #0000ff } /* Keyword.Pseudo */\nbody .kr { color: #0000ff } /* Keyword.Reserved */\nbody .kt { color: #0000ff } /* Keyword.Type */\nbody .m { color: #33aaff } /* Literal.Number */\nbody .s { color: #55aa22 } /* Literal.String */\nbody .na { color: #000000 } /* Name.Attribute */\nbody .nb { color: #000000 } /* Name.Builtin */\nbody .nc { color: #000000 } /* Name.Class */\nbody .no { color: #000000 } /* Name.Constant */\nbody .nd { color: #000000 } /* Name.Decorator */\nbody .ni { color: #000000 } /* Name.Entity */\nbody .ne { color: #000000 } /* Name.Exception */\nbody .nf { color: #000000 } /* Name.Function */\nbody .nl { color: #000000 } /* Name.Label */\nbody .nn { color: #000000 } /* Name.Namespace */\nbody .nx { color: #000000 } /* Name.Other */\nbody .py { color: #000000 } /* Name.Property */\nbody .nt { color: #000000 } /* Name.Tag */\nbody .nv { color: #000000 } /* Name.Variable */\nbody .ow { color: #0000ff } /* Operator.Word */\nbody .mb { color: #33aaff } /* Literal.Number.Bin */\nbody .mf { color: #33aaff } /* Literal.Number.Float */\nbody .mh { color: #33aaff } /* Literal.Number.Hex */\nbody .mi { color: #33aaff } /* Literal.Number.Integer */\nbody .mo { color: #33aaff } /* Literal.Number.Oct */\nbody .sa { color: #55aa22 } /* Literal.String.Affix */\nbody .sb { color: #55aa22 } /* Literal.String.Backtick */\nbody .sc { color: #55aa22 } /* Literal.String.Char */\nbody .dl { color: #55aa22 } /* Literal.String.Delimiter */\nbody .sd { color: #55aa22 } /* Literal.String.Doc */\nbody .s2 { color: #55aa22 } /* Literal.String.Double */\nbody .se { color: #55aa22 } /* Literal.String.Escape */\nbody .sh { color: #55aa22 } /* Literal.String.Heredoc */\nbody .si { color: #55aa22 } /* Literal.String.Interpol */\nbody .sx { color: #55aa22 } /* Literal.String.Other */\nbody .sr { color: #55aa22 } /* Literal.String.Regex */\nbody .s1 { color: #55aa22 } /* Literal.String.Single */\nbody .ss { color: #55aa22 } /* Literal.String.Symbol */\nbody .bp { color: #000000 } /* Name.Builtin.Pseudo */\nbody .fm { color: #000000 } /* Name.Function.Magic */\nbody .vc { color: #000000 } /* Name.Variable.Class */\nbody .vg { color: #000000 } /* Name.Variable.Global */\nbody .vi { color: #000000 } /* Name.Variable.Instance */\nbody .vm { color: #000000 } /* Name.Variable.Magic */\nbody .il { color: #33aaff } /* Literal.Number.Integer.Long */\n\n  </style>\n</head>\n<body>\n<h2>ii</h2>\n\n<div class=\"highlight\"><pre><span></span><span class=\"nv\">oo</span>\n</pre></div>\n</body>\n</html>\n', 1);

-- --------------------------------------------------------

--
-- 表的结构 `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2019-02-26 10:36:14.441762', '1', 'wangboyuan', 2, '[{\"changed\": {\"fields\": [\"name\"]}}]', 9, 1),
(2, '2019-02-26 14:06:59.101842', '1', 'wangboyuan', 2, '[{\"changed\": {\"fields\": [\"work_number\", \"mobile\", \"wechat_account\", \"wechat_qy_account\", \"birthday\", \"nationality\", \"nativePlace\", \"politicsStatus\", \"idCardNo\", \"careerStartTime\", \"joinCPATime\", \"graduateSchool\", \"education\", \"major\", \"address\"]}}]', 9, 1),
(3, '2019-02-26 14:07:25.800654', '1', 'wangboyuan', 2, '[{\"changed\": {\"fields\": [\"picture\"]}}]', 9, 1),
(4, '2019-02-26 16:02:18.520935', '1', 'wangboyuan', 2, '[{\"changed\": {\"fields\": [\"name\"]}}]', 9, 1),
(5, '2019-02-26 16:02:25.417850', '1', 'wangboyuan', 2, '[{\"changed\": {\"fields\": [\"name\"]}}]', 9, 1),
(6, '2019-02-26 16:09:10.054034', '1', 'wangboyuan', 2, '[{\"changed\": {\"fields\": [\"address\"]}}]', 9, 1),
(7, '2019-02-26 16:09:25.588047', '1', 'wangboyuan', 2, '[{\"changed\": {\"fields\": [\"password\"]}}]', 9, 1),
(8, '2019-02-26 16:14:19.034500', '1', 'wangboyuan', 2, '[{\"changed\": {\"fields\": [\"picture\"]}}]', 9, 1),
(9, '2019-02-26 16:14:47.182035', '1', 'wangboyuan', 2, '[{\"changed\": {\"fields\": [\"picture\"]}}]', 9, 1),
(10, '2019-02-27 15:13:49.837443', '1', '757-PFR9', 1, '[{\"added\": {}}]', 18, 1),
(11, '2019-02-28 14:42:40.229867', '1', '测试更换PC卡', 1, '[{\"added\": {}}]', 19, 1),
(12, '2019-02-28 14:43:43.360546', '2', '排除第一部ATC故障', 1, '[{\"added\": {}}]', 19, 1),
(13, '2019-02-28 14:54:49.052345', '3', '[测试]2019-02-28夜班任务书', 1, '[{\"added\": {}}]', 20, 1),
(14, '2019-02-28 15:05:48.373060', '2', '排除第一部ATC故障', 2, '[{\"changed\": {\"fields\": [\"jobcard\", \"ATAChapter\"]}}]', 19, 1),
(15, '2019-02-28 16:43:22.098178', '1', '[测试更换PC卡][wangboyuan][完成]', 1, '[{\"added\": {}}]', 21, 1),
(16, '2019-03-01 11:02:40.939121', '3', '[737-300:33-44-02]翼身下防撞灯灯泡的更换', 2, '[{\"changed\": {\"fields\": [\"section\"]}}]', 17, 1),
(17, '2019-03-04 14:02:15.863422', '4', '测试人', 2, '[{\"changed\": {\"fields\": [\"groups\", \"name\"]}}]', 9, 1),
(18, '2019-03-04 14:02:33.124228', '4', '测试人', 2, '[{\"changed\": {\"fields\": [\"groups\"]}}]', 9, 1),
(19, '2019-03-04 14:12:08.972462', '4', '测试人', 2, '[{\"changed\": {\"fields\": [\"password\"]}}]', 9, 1),
(20, '2019-03-04 14:12:20.607675', '4', '测试人', 2, '[{\"changed\": {\"fields\": [\"is_staff\"]}}]', 9, 1),
(21, '2019-03-04 14:13:11.613522', '4', '测试人', 2, '[{\"changed\": {\"fields\": [\"user_permissions\"]}}]', 9, 1),
(22, '2019-03-04 14:13:35.574425', '4', '测试人', 2, '[{\"changed\": {\"fields\": [\"user_permissions\"]}}]', 9, 1),
(23, '2019-03-04 14:15:13.447981', '2', 'guests', 1, '[{\"added\": {}}]', 3, 1),
(24, '2019-03-04 14:24:41.185223', '4', '测试人', 2, '[{\"changed\": {\"fields\": [\"user_permissions\"]}}]', 9, 1),
(25, '2019-03-04 14:31:42.465923', '2', '排除第一部ATC故障[2]', 2, '[{\"changed\": {\"fields\": [\"title\"]}}]', 19, 4),
(26, '2019-03-04 14:34:46.661588', '4', '测试人', 2, '[{\"changed\": {\"fields\": [\"user_permissions\"]}}]', 9, 1),
(27, '2019-03-04 14:35:10.895232', '4', '测试人', 2, '[{\"changed\": {\"fields\": [\"user_permissions\"]}}]', 9, 1),
(28, '2019-03-04 14:35:23.985930', '4', '测试人', 2, '[{\"changed\": {\"fields\": [\"user_permissions\"]}}]', 9, 1),
(29, '2019-03-04 14:49:05.968582', '2', '排除第一部ATC故障', 2, '[{\"changed\": {\"fields\": [\"title\"]}}]', 19, 4),
(30, '2019-03-04 14:57:20.143740', '1', 'admins', 3, '', 3, 1),
(31, '2019-03-04 14:57:20.302358', '2', 'guests', 3, '', 3, 1),
(32, '2019-03-06 10:47:14.843068', '1', 'task_standard_library object (1)', 1, '[{\"added\": {}}]', 24, 1),
(33, '2019-03-06 11:04:55.564834', '2', '排除第一部ATC故障', 2, '[{\"changed\": {\"fields\": [\"link_to_standard_library\"]}}]', 19, 1),
(34, '2019-03-06 15:20:27.277509', '5', '[37B1222113A1R11]润滑 - 副翼部件 - 左翼', 1, '[{\"added\": {}}]', 18, 1),
(35, '2019-03-06 15:22:18.702207', '2', '[工卡]润滑飞机左副翼部件', 1, '[{\"added\": {}}]', 24, 1),
(36, '2019-03-06 15:28:55.419373', '1', '测试更换PC卡', 2, '[{\"changed\": {\"fields\": [\"man\"]}}]', 19, 1),
(37, '2019-03-06 15:56:03.292478', '3', 'MCC全员', 1, '[{\"added\": {}}]', 3, 1),
(38, '2019-03-06 15:56:47.724678', '4', 'MCC主控', 1, '[{\"added\": {}}]', 3, 1),
(39, '2019-03-06 16:24:22.213592', '4', '测试人', 2, '[{\"changed\": {\"fields\": [\"groups\"]}}]', 9, 1),
(40, '2019-03-06 16:24:54.757838', '3', 'MCC全员', 2, '[{\"changed\": {\"fields\": [\"permissions\"]}}]', 3, 1),
(41, '2019-03-06 16:25:20.145792', '1', '测试更换PC卡', 2, '[{\"changed\": {\"fields\": [\"hour\"]}}]', 19, 4),
(42, '2019-03-07 09:42:51.788397', '3', '222', 1, '[{\"added\": {}}]', 19, 1),
(43, '2019-03-07 14:18:43.090450', '3', 'MCC全员', 2, '[{\"changed\": {\"fields\": [\"permissions\"]}}]', 3, 1),
(44, '2019-03-07 14:19:57.380986', '4', '测试标题', 1, '[{\"added\": {}}]', 19, 4),
(45, '2019-03-07 14:21:03.322740', '4', '测试标题', 2, '[{\"changed\": {\"fields\": [\"description\"]}}]', 19, 1),
(46, '2019-03-07 14:22:58.654492', '4', '测试标题', 2, '[{\"changed\": {\"fields\": [\"description\"]}}]', 19, 4),
(47, '2019-03-07 14:23:42.565626', '4', '测试标题', 2, '[{\"changed\": {\"fields\": [\"description\"]}}]', 19, 1),
(48, '2019-03-07 15:19:27.193954', '5', '权限测试用', 1, '[{\"added\": {}}]', 19, 4),
(49, '2019-03-07 15:32:34.354590', '4', '测试标题', 3, '', 19, 4),
(50, '2019-03-07 15:33:04.776453', '5', '权限测试用', 3, '', 19, 4),
(51, '2019-03-07 15:48:30.829441', '6', '测试权限用', 1, '[{\"added\": {}}]', 19, 4),
(52, '2019-03-07 15:49:01.831038', '6', '测试权限用', 3, '', 19, 1),
(53, '2019-03-07 15:50:28.524549', '7', '权限测试用2', 1, '[{\"added\": {}}]', 19, 4),
(54, '2019-03-07 15:50:55.520542', '7', '权限测试用2', 3, '', 19, 4),
(55, '2019-03-07 16:02:15.014589', '8', '权限测试3', 1, '[{\"added\": {}}]', 19, 4),
(56, '2019-03-07 16:02:45.062379', '8', '权限测试3', 3, '', 19, 4),
(57, '2019-03-07 16:27:52.735444', '9', '权限测试3', 1, '[{\"added\": {}}]', 19, 4),
(58, '2019-03-07 16:28:15.262998', '9', '权限测试3', 3, '', 19, 4),
(59, '2019-03-07 16:30:40.655520', '10', '权限测试1', 1, '[{\"added\": {}}]', 19, 4),
(60, '2019-03-07 16:31:03.786588', '10', '权限测试1', 3, '', 19, 4),
(61, '2019-03-07 16:36:27.793763', '11', 'ceshi111', 1, '[{\"added\": {}}]', 19, 4),
(62, '2019-03-07 16:37:08.017560', '11', 'ceshi111', 3, '', 19, 4),
(63, '2019-03-07 16:39:04.149168', '12', 'kkk', 1, '[{\"added\": {}}]', 19, 4),
(64, '2019-03-07 16:39:38.016092', '12', 'kkk', 3, '', 19, 4),
(65, '2019-03-07 16:43:02.807003', '13', '009', 1, '[{\"added\": {}}]', 19, 4),
(66, '2019-03-07 16:43:33.216896', '13', '009', 3, '', 19, 4),
(67, '2019-03-07 16:55:19.482850', '14', 'abcccdd', 1, '[{\"added\": {}}]', 19, 4),
(68, '2019-03-07 16:56:01.543070', '14', 'abcccdd', 3, '', 19, 4),
(69, '2019-03-08 10:17:15.855961', '15', '这是一份测试任务', 1, '[{\"added\": {}}]', 19, 4),
(71, '2019-03-08 10:23:20.116918', '15', '这是一份测试任务', 3, '', 19, 1),
(72, '2019-03-08 10:27:47.683912', '16', '三八妇女节快乐', 1, '[{\"added\": {}}]', 19, 4),
(73, '2019-03-08 11:14:36.078633', '16', '三八妇女节快乐', 3, '', 19, 1),
(74, '2019-03-08 11:14:36.218560', '3', '222', 3, '', 19, 1),
(75, '2019-03-08 11:14:36.357761', '2', '排除第一部ATC故障', 3, '', 19, 1),
(76, '2019-03-08 11:14:36.516040', '1', '测试更换PC卡', 3, '', 19, 1),
(77, '2019-03-08 11:15:31.962879', '17', '测试，三八快乐', 1, '[{\"added\": {}}]', 19, 4),
(78, '2019-03-08 11:16:23.597304', '17', '测试，三八快乐', 3, '', 19, 4),
(79, '2019-03-08 11:16:48.981341', '18', '快乐', 1, '[{\"added\": {}}]', 19, 4),
(80, '2019-03-08 11:17:06.077894', '18', '快乐', 3, '', 19, 1),
(81, '2019-03-08 11:17:25.465432', '19', '快乐', 1, '[{\"added\": {}}]', 19, 4),
(82, '2019-03-08 11:18:10.312857', '20', '三八妇女节', 1, '[{\"added\": {}}]', 19, 4),
(83, '2019-03-08 11:18:28.990948', '20', '三八妇女节', 3, '', 19, 1),
(84, '2019-03-08 11:18:29.139659', '19', '快乐', 3, '', 19, 1),
(85, '2019-03-08 11:19:30.522703', '21', '38快乐', 1, '[{\"added\": {}}]', 19, 4),
(86, '2019-03-08 11:19:30.823723', '22', '38快乐', 1, '[{\"added\": {}}]', 19, 4),
(87, '2019-03-08 11:29:07.427771', '22', '38快乐', 3, '', 19, 1),
(88, '2019-03-08 11:29:21.517882', '21', '38快乐', 3, '', 19, 1),
(89, '2019-03-08 11:31:10.714016', '23', '111', 1, '[{\"added\": {}}]', 19, 4),
(90, '2019-03-08 11:31:26.128771', '24', '22', 1, '[{\"added\": {}}]', 19, 4),
(91, '2019-03-08 11:31:50.010350', '24', '22', 3, '', 19, 1),
(92, '2019-03-08 11:31:50.146247', '23', '111', 3, '', 19, 1),
(93, '2019-03-08 11:36:30.449381', '25', '123', 1, '[{\"added\": {}}]', 19, 4),
(94, '2019-03-08 11:36:47.008890', '26', 'abc', 1, '[{\"added\": {}}]', 19, 4),
(95, '2019-03-08 11:37:14.100172', '26', 'abc', 3, '', 19, 1),
(96, '2019-03-08 11:37:14.253194', '25', '123', 3, '', 19, 1),
(97, '2019-03-08 15:21:14.912141', '1', 'GroupDetail object (1)', 1, '[{\"added\": {}}]', 25, 1),
(98, '2019-03-08 15:32:55.304407', '1', 'GroupDetail object (1)', 2, '[]', 25, 1),
(99, '2019-03-08 16:23:15.182806', '27', 'kkj', 1, '[{\"added\": {}}]', 19, 4),
(100, '2019-03-08 16:29:58.301764', '27', 'kkj', 2, '[{\"changed\": {\"fields\": [\"status\"]}}]', 19, 4),
(101, '2019-03-08 16:29:58.431281', '27', 'kkj', 2, '[{\"changed\": {\"fields\": [\"status\"]}}]', 19, 4),
(102, '2019-03-08 16:30:33.551669', '27', 'kkj', 2, '[{\"changed\": {\"fields\": [\"status\"]}}]', 19, 4),
(103, '2019-03-08 16:31:34.642130', '27', 'kkj', 2, '[{\"changed\": {\"fields\": [\"status\"]}}]', 19, 1),
(104, '2019-03-08 16:47:09.080873', '28', '5464367', 1, '[{\"added\": {}}]', 19, 1),
(105, '2019-03-11 15:03:40.324589', '102', 'work | 任务 | 可以激活/关闭Task', 3, '', 2, 1),
(106, '2019-03-11 16:41:27.101198', '28', '5464367', 2, '[{\"changed\": {\"fields\": [\"status\"]}}]', 19, 1),
(107, '2019-03-11 16:51:31.798112', '29', '55566', 1, '[{\"added\": {}}]', 19, 1),
(108, '2019-03-12 14:01:57.258812', '1', 'wangboyuan添加的测试任务', 1, '[{\"added\": {}}]', 26, 1),
(109, '2019-03-12 14:18:13.188665', '3', 'MCC全员', 2, '[{\"changed\": {\"fields\": [\"permissions\"]}}]', 3, 1),
(110, '2019-03-12 14:19:14.868023', '2', 'jack发布的测试任务', 1, '[{\"added\": {}}]', 26, 4),
(111, '2019-03-12 14:19:48.550040', '3', 'jack发布的测试任务2', 1, '[{\"added\": {}}]', 26, 4),
(112, '2019-03-18 14:27:38.110692', '1', '19年3月18日测试工作包', 1, '[{\"added\": {}}]', 29, 1),
(113, '2019-03-18 14:27:57.862328', '1', '19年3月18日测试工作包', 2, '[{\"changed\": {\"fields\": [\"status\"]}}]', 29, 1),
(114, '2019-03-19 16:27:24.911151', '2', '19年3月19日测试工作包', 1, '[{\"added\": {}}]', 29, 1),
(115, '2019-03-19 16:28:15.238822', '3', '19年3月20日测试工作包', 1, '[{\"added\": {}}]', 29, 1),
(116, '2019-03-21 15:56:41.964911', '1', 'Snippet object (1)', 1, '[{\"added\": {}}]', 30, 1),
(117, '2019-03-21 15:57:08.016447', '2', 'Snippet object (2)', 1, '[{\"added\": {}}]', 30, 1),
(118, '2019-03-21 16:06:01.358691', '3', 'Snippet object (3)', 1, '[{\"added\": {}}]', 30, 1),
(119, '2019-03-22 15:35:44.491979', '4', '测试人', 2, '[{\"changed\": {\"fields\": [\"groups\"]}}]', 9, 1),
(120, '2019-04-09 16:45:38.499236', '1', '王博源', 2, '[{\"changed\": {\"fields\": [\"groups\"]}}]', 9, 1),
(121, '2019-04-11 10:53:00.739355', '1', 'wangboyuan添加的测试任务', 2, '[{\"changed\": {\"fields\": [\"status\"]}}]', 26, 1),
(122, '2019-04-19 16:22:05.225380', '1', 'wangboyuan添加的测试任务', 3, '', 26, 1),
(123, '2019-04-19 16:22:17.881070', '5', '34-62-21', 3, '', 17, 1),
(124, '2019-04-19 16:22:18.052435', '4', '34-58-00', 3, '', 17, 1),
(125, '2019-04-19 16:22:18.194350', '3', '34-53-00', 3, '', 17, 1),
(126, '2019-04-19 16:22:18.333619', '2', '34-31-42', 3, '', 17, 1),
(127, '2019-04-19 16:22:18.473455', '1', '34-28-11', 3, '', 17, 1),
(128, '2019-04-19 16:42:47.502175', '6', '12-00', 1, '[{\"added\": {}}]', 17, 1),
(129, '2019-04-19 16:46:38.975832', '6', '12-', 2, '[{\"changed\": {\"fields\": [\"section\"]}}]', 17, 1),
(130, '2019-04-19 16:51:03.401794', '7', '12-00', 1, '[{\"added\": {}}]', 17, 1),
(131, '2019-04-19 16:52:48.176684', '8', '12-10', 1, '[{\"added\": {}}]', 17, 1),
(132, '2019-04-19 16:53:12.993677', '9', '12-20', 1, '[{\"added\": {}}]', 17, 1),
(133, '2019-04-19 16:53:38.403816', '10', '12-30', 1, '[{\"added\": {}}]', 17, 1),
(134, '2019-04-26 10:49:15.166896', '1', '[jack发布的测试任务][王博源][完成]', 1, '[{\"added\": {}}]', 27, 1),
(135, '2019-05-24 09:42:39.496820', '4', '测试任务11', 1, '[{\"added\": {}}]', 26, 1),
(136, '2019-05-24 09:42:57.216916', '1', '19年3月18日测试工作包', 2, '[{\"changed\": {\"fields\": [\"include_task\"]}}]', 29, 1),
(137, '2019-05-30 14:54:47.834182', '4', '测试任务11', 2, '[{\"changed\": {\"fields\": [\"status\"]}}]', 26, 1),
(138, '2019-05-30 15:15:37.330159', '2', '[测试任务11][王博源][on]', 3, '', 27, 1),
(139, '2019-05-30 15:15:37.370137', '1', '[jack发布的测试任务][王博源][完成]', 3, '', 27, 1),
(140, '2019-06-04 15:22:58.770616', '1', '[工卡]更换EFIS冷却主供气风扇', 1, '[{\"added\": {}}]', 28, 1),
(141, '2019-06-04 15:23:11.319340', '4', '测试任务11', 2, '[{\"changed\": {\"fields\": [\"link_to_standard_library\"]}}]', 26, 1),
(142, '2019-06-04 15:26:04.655127', '2', 'jack发布的测试任务', 2, '[{\"changed\": {\"fields\": [\"belong_to_package\"]}}]', 26, 1),
(143, '2019-06-04 15:40:38.927870', '1', '19年3月18日测试工作包', 2, '[{\"changed\": {\"fields\": [\"status\"]}}]', 29, 1),
(144, '2019-06-04 15:44:35.949582', '4', '19年6月1日未生效工作包', 1, '[{\"added\": {}}]', 29, 1),
(145, '2019-06-04 15:45:47.522139', '5', '19年6月2日生效工作包', 1, '[{\"added\": {}}]', 29, 1),
(146, '2019-06-04 15:46:11.892190', '6', '19年6月3日关闭工作包', 1, '[{\"added\": {}}]', 29, 1),
(147, '2019-06-04 15:46:32.379341', '7', '19年6月4日失效工作包', 1, '[{\"added\": {}}]', 29, 1),
(148, '2019-06-04 15:47:34.210280', '3', '19年5月31日[生效]工作包', 2, '[{\"changed\": {\"fields\": [\"name\"]}}]', 29, 1),
(149, '2019-06-04 15:48:03.263829', '2', '19年5月30日[生效]工作包', 2, '[{\"changed\": {\"fields\": [\"name\", \"status\"]}}]', 29, 1),
(150, '2019-06-04 15:48:27.789500', '1', '19年5月29日[未生效]工作包', 2, '[{\"changed\": {\"fields\": [\"name\", \"status\"]}}]', 29, 1),
(151, '2019-06-04 15:58:31.849808', '7', '19年6月4日[失效]工作包', 2, '[{\"changed\": {\"fields\": [\"name\"]}}]', 29, 1),
(152, '2019-06-04 15:58:46.127895', '6', '19年6月3日[关闭]工作包', 2, '[{\"changed\": {\"fields\": [\"name\"]}}]', 29, 1),
(153, '2019-06-04 15:58:54.982477', '5', '19年6月2日[生效]工作包', 2, '[{\"changed\": {\"fields\": [\"name\"]}}]', 29, 1),
(154, '2019-06-04 15:59:05.444203', '4', '19年6月1日[未生效]工作包', 2, '[{\"changed\": {\"fields\": [\"name\"]}}]', 29, 1),
(155, '2019-06-05 10:33:36.136660', '4', '测试任务11', 2, '[{\"changed\": {\"fields\": [\"belong_to_package\"]}}]', 26, 1),
(156, '2019-06-05 10:33:36.283862', '3', 'jack发布的测试任务2', 2, '[{\"changed\": {\"fields\": [\"belong_to_package\"]}}]', 26, 1);

-- --------------------------------------------------------

--
-- 表的结构 `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(25, 'account', 'groupdetail'),
(9, 'account', 'user'),
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(10, 'authtoken', 'token'),
(7, 'basicdata', 'aircraftbasicdata'),
(8, 'basicdata', 'aircrafttype'),
(17, 'basicdata', 'atachatper'),
(18, 'basicdata', 'jobcard'),
(6, 'basicdata', 'site'),
(4, 'contenttypes', 'contenttype'),
(30, 'dev', 'snippet'),
(22, 'guardian', 'groupobjectpermission'),
(23, 'guardian', 'userobjectpermission'),
(15, 'reversion', 'revision'),
(16, 'reversion', 'version'),
(5, 'sessions', 'session'),
(26, 'task', 'task'),
(27, 'task', 'task_feedback'),
(29, 'task', 'task_package'),
(28, 'task', 'task_standard_library'),
(19, 'work', 'task'),
(21, 'work', 'task_feedback'),
(20, 'work', 'task_package'),
(24, 'work', 'task_standard_library'),
(11, 'xadmin', 'bookmark'),
(14, 'xadmin', 'log'),
(12, 'xadmin', 'usersettings'),
(13, 'xadmin', 'userwidget');

-- --------------------------------------------------------

--
-- 表的结构 `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2019-02-26 10:30:31.677887'),
(2, 'contenttypes', '0002_remove_content_type_name', '2019-02-26 10:30:32.097833'),
(3, 'auth', '0001_initial', '2019-02-26 10:30:33.130053'),
(4, 'auth', '0002_alter_permission_name_max_length', '2019-02-26 10:30:33.387622'),
(5, 'auth', '0003_alter_user_email_max_length', '2019-02-26 10:30:33.567592'),
(6, 'auth', '0004_alter_user_username_opts', '2019-02-26 10:30:33.746658'),
(7, 'auth', '0005_alter_user_last_login_null', '2019-02-26 10:30:33.926896'),
(8, 'auth', '0006_require_contenttypes_0002', '2019-02-26 10:30:34.102596'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2019-02-26 10:30:34.285092'),
(10, 'auth', '0008_alter_user_username_max_length', '2019-02-26 10:30:34.463230'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2019-02-26 10:30:34.644141'),
(12, 'account', '0001_initial', '2019-02-26 10:30:36.029760'),
(13, 'account', '0002_auto_20190226_1026', '2019-02-26 10:30:36.512068'),
(14, 'admin', '0001_initial', '2019-02-26 10:30:37.230833'),
(15, 'admin', '0002_logentry_remove_auto_add', '2019-02-26 10:30:37.413512'),
(16, 'admin', '0003_logentry_add_action_flag_choices', '2019-02-26 10:30:37.597157'),
(17, 'authtoken', '0001_initial', '2019-02-26 10:30:38.030890'),
(18, 'authtoken', '0002_auto_20160226_1747', '2019-02-26 10:30:38.468702'),
(19, 'basicdata', '0001_initial', '2019-02-26 10:30:39.397649'),
(20, 'basicdata', '0002_auto_20190222_2212', '2019-02-26 10:30:39.774792'),
(21, 'basicdata', '0003_auto_20190222_2224', '2019-02-26 10:30:40.170860'),
(22, 'basicdata', '0004_auto_20190225_0934', '2019-02-26 10:30:41.004063'),
(23, 'basicdata', '0005_auto_20190226_0841', '2019-02-26 10:30:41.431950'),
(24, 'reversion', '0001_squashed_0004_auto_20160611_1202', '2019-02-26 10:30:42.546108'),
(25, 'sessions', '0001_initial', '2019-02-26 10:30:42.936239'),
(26, 'xadmin', '0001_initial', '2019-02-26 10:30:44.204925'),
(27, 'xadmin', '0002_log', '2019-02-26 10:30:44.921868'),
(28, 'xadmin', '0003_auto_20160715_0100', '2019-02-26 10:30:45.187015'),
(29, 'account', '0003_auto_20190226_1401', '2019-02-26 14:01:48.063939'),
(30, 'account', '0004_auto_20190226_1613', '2019-02-26 16:13:50.085562'),
(31, 'account', '0005_auto_20190226_1700', '2019-02-26 17:00:08.574517'),
(32, 'basicdata', '0006_atachatper_jobcard', '2019-02-27 15:05:19.010216'),
(33, 'basicdata', '0007_auto_20190227_1511', '2019-02-27 15:11:42.709820'),
(34, 'basicdata', '0008_auto_20190227_1649', '2019-02-27 16:50:07.372415'),
(35, 'basicdata', '0009_auto_20190227_1650', '2019-02-27 16:50:07.556066'),
(36, 'work', '0001_initial', '2019-02-28 14:06:47.148568'),
(37, 'work', '0002_auto_20190228_1442', '2019-02-28 14:42:26.700755'),
(38, 'work', '0003_auto_20190228_1453', '2019-02-28 14:53:41.964311'),
(39, 'work', '0004_auto_20190228_1631', '2019-02-28 16:31:21.791502'),
(40, 'work', '0005_auto_20190228_1642', '2019-02-28 16:42:51.506079'),
(41, 'work', '0006_auto_20190228_1659', '2019-02-28 16:59:52.575897'),
(42, 'account', '0006_auto_20190301_1101', '2019-03-01 11:01:57.391449'),
(43, 'work', '0007_auto_20190301_1101', '2019-03-01 11:01:58.384020'),
(44, 'guardian', '0001_initial', '2019-03-04 11:35:06.725946'),
(45, 'work', '0008_auto_20190306_1015', '2019-03-06 10:15:37.720368'),
(46, 'work', '0009_auto_20190306_1059', '2019-03-06 10:59:34.987066'),
(47, 'work', '0010_auto_20190306_1421', '2019-03-06 14:22:39.081231'),
(48, 'work', '0011_auto_20190306_1518', '2019-03-06 15:18:43.170315'),
(49, 'account', '0007_groupdetail', '2019-03-08 15:17:07.102625'),
(50, 'work', '0012_auto_20190308_1517', '2019-03-08 15:17:08.577297'),
(51, 'account', '0008_auto_20190308_1551', '2019-03-08 15:52:02.589963'),
(52, 'work', '0013_auto_20190308_1551', '2019-03-08 15:52:03.356627'),
(53, 'work', '0014_auto_20190308_1608', '2019-03-08 16:08:46.945432'),
(54, 'work', '0015_auto_20190308_1659', '2019-03-08 16:59:59.791397'),
(55, 'work', '0016_auto_20190311_1419', '2019-03-11 14:19:17.644805'),
(56, 'work', '0017_auto_20190311_1509', '2019-03-11 15:09:44.941723'),
(57, 'work', '0018_auto_20190312_1118', '2019-03-12 11:18:16.786792'),
(58, 'work', '0019_auto_20190312_1357', '2019-03-12 13:57:17.796074'),
(59, 'work', '0020_auto_20190312_1358', '2019-03-12 13:58:17.351299'),
(60, 'task', '0001_initial', '2019-03-12 13:59:07.146587'),
(61, 'task', '0002_auto_20190312_1425', '2019-03-12 14:25:06.835196'),
(62, 'task', '0003_auto_20190312_1440', '2019-03-12 14:40:11.756211'),
(63, 'dev', '0001_initial', '2019-03-21 15:08:20.932594'),
(64, 'task', '0004_auto_20190321_1508', '2019-03-21 15:08:21.509697'),
(65, 'task', '0005_auto_20190321_1601', '2019-03-21 16:01:17.006045'),
(66, 'task', '0006_auto_20190322_1118', '2019-03-22 11:19:03.253478'),
(67, 'basicdata', '0010_auto_20190419_1640', '2019-04-19 16:40:47.713866'),
(68, 'task', '0007_auto_20190419_1640', '2019-04-19 16:40:48.248488'),
(69, 'basicdata', '0011_auto_20190419_1644', '2019-04-19 16:44:59.076582'),
(70, 'task', '0008_auto_20190419_1644', '2019-04-19 16:45:00.611510'),
(71, 'task', '0009_auto_20190424_1634', '2019-04-24 16:34:53.233447'),
(72, 'task', '0010_auto_20190424_1639', '2019-04-24 16:39:14.870500'),
(73, 'auth', '0010_alter_group_name_max_length', '2019-06-04 14:29:29.865766'),
(74, 'auth', '0011_update_proxy_permissions', '2019-06-04 14:29:30.116667'),
(75, 'dev', '0002_auto_20190604_1429', '2019-06-04 14:29:30.208615'),
(76, 'task', '0011_auto_20190604_1429', '2019-06-04 14:29:31.130161'),
(77, 'task', '0012_auto_20190605_0938', '2019-06-05 09:38:37.259314'),
(78, 'task', '0013_auto_20190605_1011', '2019-06-05 10:11:55.798301'),
(79, 'task', '0014_auto_20190605_1034', '2019-06-05 10:35:04.752542');

-- --------------------------------------------------------

--
-- 表的结构 `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('6l6nug6of43g336i98k2pnny030n4qdy', 'YWQyZjk2OTZiNTViMmI4YjRmMzk1N2QzZDEwNDc2NGU5MGMzMWZjNjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3MDkzMzkwMGQ4YzE2Mzg3NTlmY2U3MDVjMTg1MTc5MDAxNzY3NWZjIn0=', '2019-05-07 16:46:02.229198'),
('6m8nqgpvlen2o16mkoxn7le404f5ls6r', 'NzA3MzkxZGY3MTdhMzZmNjZlYWNlNGRlMDAxYWY5YjZlNDRiM2FmNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0N2E4YjcwYmM2MjA2MmJmYmM1YzBlMDEwZmM0YWQwMjQxYTIxNTdmIn0=', '2019-07-02 16:32:20.739932'),
('8cv5d5mpj89q8k3vp8z43p78d7zzuxkk', 'NzA3MzkxZGY3MTdhMzZmNjZlYWNlNGRlMDAxYWY5YjZlNDRiM2FmNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0N2E4YjcwYmM2MjA2MmJmYmM1YzBlMDEwZmM0YWQwMjQxYTIxNTdmIn0=', '2019-07-01 10:31:28.889723'),
('eez8p4p7u6bd2uni8or1wonjmobh1vht', 'YWQyZjk2OTZiNTViMmI4YjRmMzk1N2QzZDEwNDc2NGU5MGMzMWZjNjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3MDkzMzkwMGQ4YzE2Mzg3NTlmY2U3MDVjMTg1MTc5MDAxNzY3NWZjIn0=', '2019-04-05 15:04:21.513791'),
('en0bwad57507oa9c0rc0ntqrcvlnd3b1', 'YWQyZjk2OTZiNTViMmI4YjRmMzk1N2QzZDEwNDc2NGU5MGMzMWZjNjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3MDkzMzkwMGQ4YzE2Mzg3NTlmY2U3MDVjMTg1MTc5MDAxNzY3NWZjIn0=', '2019-04-23 09:21:42.001750'),
('fytnmlq55jja6aal5b226uh4vgm0e1yk', 'NzA3MzkxZGY3MTdhMzZmNjZlYWNlNGRlMDAxYWY5YjZlNDRiM2FmNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0N2E4YjcwYmM2MjA2MmJmYmM1YzBlMDEwZmM0YWQwMjQxYTIxNTdmIn0=', '2019-07-01 11:08:48.549700'),
('h1yonk2no89s19je611tjtrxh4hw9kfy', 'ZWVkYWZkOWFjMWZhOGFmYzVmNDU4MmVmMDY2ODAwYTRkMjE0MGM4Nzp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiMTI4NGU1Yzg5NzU4NjIyNmYwYzc1MGRkNmUyYTgxNWIzNTBhNjVlIn0=', '2019-04-05 15:35:03.811213'),
('kaoi4whb5yxwlmn17kn4xm3h4athf9av', 'NzA3MzkxZGY3MTdhMzZmNjZlYWNlNGRlMDAxYWY5YjZlNDRiM2FmNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0N2E4YjcwYmM2MjA2MmJmYmM1YzBlMDEwZmM0YWQwMjQxYTIxNTdmIn0=', '2019-06-05 16:54:37.520813'),
('st4ajmefo9o0emkuwqw40wy5elxffgst', 'NzA3MzkxZGY3MTdhMzZmNjZlYWNlNGRlMDAxYWY5YjZlNDRiM2FmNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0N2E4YjcwYmM2MjA2MmJmYmM1YzBlMDEwZmM0YWQwMjQxYTIxNTdmIn0=', '2019-06-20 08:43:34.722547');

-- --------------------------------------------------------

--
-- 表的结构 `guardian_groupobjectpermission`
--

CREATE TABLE `guardian_groupobjectpermission` (
  `id` int(11) NOT NULL,
  `object_pk` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `guardian_userobjectpermission`
--

CREATE TABLE `guardian_userobjectpermission` (
  `id` int(11) NOT NULL,
  `object_pk` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `guardian_userobjectpermission`
--

INSERT INTO `guardian_userobjectpermission` (`id`, `object_pk`, `content_type_id`, `permission_id`, `user_id`) VALUES
(94, '27', 19, 77, 4),
(95, '27', 19, 74, 4),
(96, '27', 19, 75, 4),
(97, '27', 19, 76, 4),
(98, '2', 26, 108, 4),
(99, '2', 26, 105, 4),
(100, '2', 26, 106, 4),
(101, '2', 26, 107, 4),
(102, '3', 26, 108, 4),
(103, '3', 26, 105, 4),
(104, '3', 26, 106, 4),
(105, '3', 26, 107, 4);

-- --------------------------------------------------------

--
-- 表的结构 `reversion_revision`
--

CREATE TABLE `reversion_revision` (
  `id` int(11) NOT NULL,
  `date_created` datetime(6) NOT NULL,
  `comment` longtext NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `reversion_version`
--

CREATE TABLE `reversion_version` (
  `id` int(11) NOT NULL,
  `object_id` varchar(191) NOT NULL,
  `format` varchar(255) NOT NULL,
  `serialized_data` longtext NOT NULL,
  `object_repr` longtext NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `revision_id` int(11) NOT NULL,
  `db` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `task_task`
--

CREATE TABLE `task_task` (
  `id` int(11) NOT NULL,
  `type` varchar(10) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `hour` decimal(5,2) NOT NULL,
  `man` int(11) NOT NULL,
  `exec_date` date NOT NULL,
  `status` varchar(10) NOT NULL,
  `finish_status` varchar(10) NOT NULL,
  `creation_time` datetime(6) NOT NULL,
  `edit_time` datetime(6) NOT NULL,
  `verify_time` datetime(6) DEFAULT NULL,
  `status_close_time` datetime(6) DEFAULT NULL,
  `ATAChapter_id` int(11) DEFAULT NULL,
  `aircraft_id` int(11) NOT NULL,
  `creator_id` int(11) NOT NULL,
  `editor_id` int(11) NOT NULL,
  `exec_site_id` int(11) NOT NULL,
  `jobcard_id` int(11) DEFAULT NULL,
  `link_to_standard_library_id` int(11) DEFAULT NULL,
  `verifier_id` int(11) DEFAULT NULL,
  `who_close_id` int(11) DEFAULT NULL,
  `belong_to_package_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `task_task`
--

INSERT INTO `task_task` (`id`, `type`, `title`, `description`, `hour`, `man`, `exec_date`, `status`, `finish_status`, `creation_time`, `edit_time`, `verify_time`, `status_close_time`, `ATAChapter_id`, `aircraft_id`, `creator_id`, `editor_id`, `exec_site_id`, `jobcard_id`, `link_to_standard_library_id`, `verifier_id`, `who_close_id`, `belong_to_package_id`) VALUES
(2, '排故', 'jack发布的测试任务', 'jack发布的测试任务', '3.00', 2, '2019-03-12', '生效', '', '2019-03-12 14:19:13.820572', '2019-06-04 15:26:04.607154', NULL, NULL, NULL, 3, 4, 1, 2, NULL, NULL, NULL, NULL, 2),
(3, '其他', 'jack发布的测试任务2', 'jack发布的测试任务2', '3.00', 1, '2019-03-12', '关闭', '', '2019-03-12 14:19:47.439052', '2019-06-05 10:33:36.241711', NULL, NULL, NULL, 4, 4, 1, 2, NULL, NULL, NULL, NULL, 3),
(4, '工卡', '测试任务11', '测试任务11测试任务11', '2.00', 2, '2019-05-24', '生效', '', '2019-05-24 09:42:39.436855', '2019-06-05 10:33:36.098631', NULL, NULL, 8, 2, 1, 1, 2, 4, 1, NULL, NULL, 5);

-- --------------------------------------------------------

--
-- 表的结构 `task_task_feedback`
--

CREATE TABLE `task_task_feedback` (
  `id` int(11) NOT NULL,
  `time` datetime(6) NOT NULL,
  `status` varchar(10) NOT NULL,
  `notes` longtext NOT NULL,
  `needverify` tinyint(1) NOT NULL,
  `verify_result` tinyint(1) DEFAULT NULL,
  `verify_time` datetime(6) DEFAULT NULL,
  `task_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `verifier_id` int(11) DEFAULT NULL,
  `force` decimal(3,1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `task_task_feedback`
--

INSERT INTO `task_task_feedback` (`id`, `time`, `status`, `notes`, `needverify`, `verify_result`, `verify_time`, `task_id`, `user_id`, `verifier_id`, `force`) VALUES
(3, '2019-05-30 15:15:42.845899', '已完成', '', 0, NULL, NULL, 2, 1, NULL, '0.3');

-- --------------------------------------------------------

--
-- 表的结构 `task_task_package`
--

CREATE TABLE `task_task_package` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `status` varchar(10) NOT NULL,
  `creation_time` datetime(6) NOT NULL,
  `edit_time` datetime(6) NOT NULL,
  `verify_time` datetime(6) DEFAULT NULL,
  `creator_id` int(11) NOT NULL,
  `editor_id` int(11) NOT NULL,
  `verifier_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `task_task_package`
--

INSERT INTO `task_task_package` (`id`, `name`, `status`, `creation_time`, `edit_time`, `verify_time`, `creator_id`, `editor_id`, `verifier_id`) VALUES
(1, '19年5月29日[未生效]工作包', '未生效', '2019-03-18 14:27:37.679044', '2019-06-04 15:48:27.717251', NULL, 1, 1, NULL),
(2, '19年5月30日[生效]工作包', '生效', '2019-03-19 16:27:24.626018', '2019-06-04 15:48:03.187872', NULL, 1, 1, NULL),
(3, '19年5月31日[生效]工作包', '生效', '2019-03-19 16:28:15.093534', '2019-06-04 15:47:34.102328', NULL, 1, 1, NULL),
(4, '19年6月1日[未生效]工作包', '未生效', '2019-06-04 15:44:35.697713', '2019-06-04 15:59:05.370244', NULL, 1, 1, NULL),
(5, '19年6月2日[生效]工作包', '生效', '2019-06-04 15:45:47.452097', '2019-06-04 15:58:54.915518', NULL, 1, 1, NULL),
(6, '19年6月3日[关闭]工作包', '关闭', '2019-06-04 15:46:11.821232', '2019-06-04 15:58:46.056935', NULL, 1, 1, NULL),
(7, '19年6月4日[失效]工作包', '失效', '2019-06-04 15:46:32.303614', '2019-06-04 15:58:31.753872', NULL, 1, 1, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `task_task_standard_library`
--

CREATE TABLE `task_task_standard_library` (
  `id` int(11) NOT NULL,
  `task_type` varchar(10) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `hour` decimal(5,2) NOT NULL,
  `man` int(11) NOT NULL,
  `status` varchar(10) NOT NULL,
  `creation_time` datetime(6) NOT NULL,
  `edit_time` datetime(6) NOT NULL,
  `verify_time` datetime(6) DEFAULT NULL,
  `ATAChapter_id` int(11) DEFAULT NULL,
  `creator_id` int(11) NOT NULL,
  `editor_id` int(11) NOT NULL,
  `jobcard_id` int(11) DEFAULT NULL,
  `verifier_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `task_task_standard_library`
--

INSERT INTO `task_task_standard_library` (`id`, `task_type`, `title`, `description`, `hour`, `man`, `status`, `creation_time`, `edit_time`, `verify_time`, `ATAChapter_id`, `creator_id`, `editor_id`, `jobcard_id`, `verifier_id`) VALUES
(1, '工卡', '更换EFIS冷却主供气风扇', '更换EFIS冷却主供气风扇；更换EFIS冷却主供气风扇。', '1.00', 2, '生效', '2019-06-04 15:22:58.420795', '2019-06-04 15:22:58.420795', '2019-06-04 15:22:00.000000', 7, 1, 1, 3, 1);

-- --------------------------------------------------------

--
-- 表的结构 `task_task_standard_library_aircraft_type`
--

CREATE TABLE `task_task_standard_library_aircraft_type` (
  `id` int(11) NOT NULL,
  `task_standard_library_id` int(11) NOT NULL,
  `aircrafttype_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `task_task_standard_library_aircraft_type`
--

INSERT INTO `task_task_standard_library_aircraft_type` (`id`, `task_standard_library_id`, `aircrafttype_id`) VALUES
(1, 1, 1),
(2, 1, 2);

-- --------------------------------------------------------

--
-- 表的结构 `xadmin_bookmark`
--

CREATE TABLE `xadmin_bookmark` (
  `id` int(11) NOT NULL,
  `title` varchar(128) NOT NULL,
  `url_name` varchar(64) NOT NULL,
  `query` varchar(1000) NOT NULL,
  `is_share` tinyint(1) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `xadmin_log`
--

CREATE TABLE `xadmin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `ip_addr` char(39) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` varchar(32) NOT NULL,
  `message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `xadmin_log`
--

INSERT INTO `xadmin_log` (`id`, `action_time`, `ip_addr`, `object_id`, `object_repr`, `action_flag`, `message`, `content_type_id`, `user_id`) VALUES
(1, '2019-03-01 14:54:30.416085', '127.0.0.1', '2', '', 'create', '已添加。', 9, 1);

-- --------------------------------------------------------

--
-- 表的结构 `xadmin_usersettings`
--

CREATE TABLE `xadmin_usersettings` (
  `id` int(11) NOT NULL,
  `key` varchar(256) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `xadmin_usersettings`
--

INSERT INTO `xadmin_usersettings` (`id`, `key`, `value`, `user_id`) VALUES
(1, 'dashboard:home:pos', '', 1),
(2, 'dashboard:home:pos', '', 4);

-- --------------------------------------------------------

--
-- 表的结构 `xadmin_userwidget`
--

CREATE TABLE `xadmin_userwidget` (
  `id` int(11) NOT NULL,
  `page_id` varchar(256) NOT NULL,
  `widget_type` varchar(50) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `xadmin_userwidget`
--

INSERT INTO `xadmin_userwidget` (`id`, `page_id`, `widget_type`, `value`, `user_id`) VALUES
(1, 'test', 'chart', '{\"title\": \"xxx\", \"model\": \"xadmin.userwidget\"}', 1);

--
-- 转储表的索引
--

--
-- 表的索引 `account_groupdetail`
--
ALTER TABLE `account_groupdetail`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `link_to_group_id` (`link_to_group_id`);

--
-- 表的索引 `account_user`
--
ALTER TABLE `account_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- 表的索引 `account_user_groups`
--
ALTER TABLE `account_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_user_groups_user_id_group_id_4d09af3e_uniq` (`user_id`,`group_id`),
  ADD KEY `account_user_groups_group_id_6c71f749_fk_auth_group_id` (`group_id`);

--
-- 表的索引 `account_user_user_permissions`
--
ALTER TABLE `account_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_user_user_permis_user_id_permission_id_48bdd28b_uniq` (`user_id`,`permission_id`),
  ADD KEY `account_user_user_pe_permission_id_66c44191_fk_auth_perm` (`permission_id`);

--
-- 表的索引 `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD PRIMARY KEY (`key`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- 表的索引 `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- 表的索引 `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- 表的索引 `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- 表的索引 `basicdata_aircraftbasicdata`
--
ALTER TABLE `basicdata_aircraftbasicdata`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `aircraft_number` (`aircraft_number`),
  ADD KEY `basicdata_aircraftba_type_id_d35e0452_fk_basicdata` (`type_id`);

--
-- 表的索引 `basicdata_aircrafttype`
--
ALTER TABLE `basicdata_aircrafttype`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `basicdata_aircraft_type_name_60f94096_uniq` (`name`);

--
-- 表的索引 `basicdata_atachatper`
--
ALTER TABLE `basicdata_atachatper`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `basicdata_jobcard`
--
ALTER TABLE `basicdata_jobcard`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `basicdata_site`
--
ALTER TABLE `basicdata_site`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- 表的索引 `dev_snippet`
--
ALTER TABLE `dev_snippet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dev_snippet_owner_id_fdde2cbb_fk_account_user_id` (`owner_id`);

--
-- 表的索引 `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_account_user_id` (`user_id`);

--
-- 表的索引 `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- 表的索引 `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- 表的索引 `guardian_groupobjectpermission`
--
ALTER TABLE `guardian_groupobjectpermission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `guardian_groupobjectperm_group_id_permission_id_o_3f189f7c_uniq` (`group_id`,`permission_id`,`object_pk`),
  ADD KEY `guardian_groupobject_content_type_id_7ade36b8_fk_django_co` (`content_type_id`),
  ADD KEY `guardian_groupobject_permission_id_36572738_fk_auth_perm` (`permission_id`);

--
-- 表的索引 `guardian_userobjectpermission`
--
ALTER TABLE `guardian_userobjectpermission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `guardian_userobjectpermi_user_id_permission_id_ob_b0b3d2fc_uniq` (`user_id`,`permission_id`,`object_pk`),
  ADD KEY `guardian_userobjectp_content_type_id_2e892405_fk_django_co` (`content_type_id`),
  ADD KEY `guardian_userobjectp_permission_id_71807bfc_fk_auth_perm` (`permission_id`);

--
-- 表的索引 `reversion_revision`
--
ALTER TABLE `reversion_revision`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reversion_revision_user_id_17095f45_fk_account_user_id` (`user_id`),
  ADD KEY `reversion_revision_date_created_96f7c20c` (`date_created`);

--
-- 表的索引 `reversion_version`
--
ALTER TABLE `reversion_version`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reversion_version_db_content_type_id_objec_b2c54f65_uniq` (`db`,`content_type_id`,`object_id`,`revision_id`),
  ADD KEY `reversion_version_content_type_id_7d0ff25c_fk_django_co` (`content_type_id`),
  ADD KEY `reversion_version_revision_id_af9f6a9d_fk_reversion_revision_id` (`revision_id`);

--
-- 表的索引 `task_task`
--
ALTER TABLE `task_task`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_task_ATAChapter_id_fc5c62dd_fk_basicdata_atachatper_id` (`ATAChapter_id`),
  ADD KEY `task_task_aircraft_id_8aedf782_fk_basicdata_aircraftbasicdata_id` (`aircraft_id`),
  ADD KEY `task_task_creator_id_9917fc2b_fk_account_user_id` (`creator_id`),
  ADD KEY `task_task_editor_id_36d04957_fk_account_user_id` (`editor_id`),
  ADD KEY `task_task_jobcard_id_3053ab35_fk_basicdata_jobcard_id` (`jobcard_id`),
  ADD KEY `task_task_link_to_standard_lib_92d24f30_fk_task_task` (`link_to_standard_library_id`),
  ADD KEY `task_task_verifier_id_34808360_fk_account_user_id` (`verifier_id`),
  ADD KEY `task_task_who_close_id_63b75258_fk_account_user_id` (`who_close_id`),
  ADD KEY `task_task_belong_to_package_id_2e23ce83_fk_task_task_package_id` (`belong_to_package_id`),
  ADD KEY `task_task_exec_site_id_7a57a460_fk_basicdata_site_id` (`exec_site_id`);

--
-- 表的索引 `task_task_feedback`
--
ALTER TABLE `task_task_feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_task_feedback_verifier_id_26efa169_fk_account_user_id` (`verifier_id`),
  ADD KEY `task_task_feedback_user_id_587a266e_fk_account_user_id` (`user_id`),
  ADD KEY `task_task_feedback_task_id_90729038_fk_task_task_id` (`task_id`);

--
-- 表的索引 `task_task_package`
--
ALTER TABLE `task_task_package`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_task_package_creator_id_47e080d4_fk_account_user_id` (`creator_id`),
  ADD KEY `task_task_package_editor_id_66c40554_fk_account_user_id` (`editor_id`),
  ADD KEY `task_task_package_verifier_id_0767f3a8_fk_account_user_id` (`verifier_id`);

--
-- 表的索引 `task_task_standard_library`
--
ALTER TABLE `task_task_standard_library`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_task_standard_l_ATAChapter_id_edaee0fd_fk_basicdata` (`ATAChapter_id`),
  ADD KEY `task_task_standard_l_creator_id_7e91b5ba_fk_account_u` (`creator_id`),
  ADD KEY `task_task_standard_library_editor_id_8bca01c8_fk_account_user_id` (`editor_id`),
  ADD KEY `task_task_standard_l_jobcard_id_a3f0d7f5_fk_basicdata` (`jobcard_id`),
  ADD KEY `task_task_standard_l_verifier_id_6546672f_fk_account_u` (`verifier_id`);

--
-- 表的索引 `task_task_standard_library_aircraft_type`
--
ALTER TABLE `task_task_standard_library_aircraft_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `task_task_standard_libra_task_standard_library_id_dd22bf48_uniq` (`task_standard_library_id`,`aircrafttype_id`),
  ADD KEY `task_task_standard_l_aircrafttype_id_50936110_fk_basicdata` (`aircrafttype_id`);

--
-- 表的索引 `xadmin_bookmark`
--
ALTER TABLE `xadmin_bookmark`
  ADD PRIMARY KEY (`id`),
  ADD KEY `xadmin_bookmark_content_type_id_60941679_fk_django_co` (`content_type_id`),
  ADD KEY `xadmin_bookmark_user_id_42d307fc_fk_account_user_id` (`user_id`);

--
-- 表的索引 `xadmin_log`
--
ALTER TABLE `xadmin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `xadmin_log_content_type_id_2a6cb852_fk_django_content_type_id` (`content_type_id`),
  ADD KEY `xadmin_log_user_id_bb16a176_fk_account_user_id` (`user_id`);

--
-- 表的索引 `xadmin_usersettings`
--
ALTER TABLE `xadmin_usersettings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `xadmin_usersettings_user_id_edeabe4a_fk_account_user_id` (`user_id`);

--
-- 表的索引 `xadmin_userwidget`
--
ALTER TABLE `xadmin_userwidget`
  ADD PRIMARY KEY (`id`),
  ADD KEY `xadmin_userwidget_user_id_c159233a_fk_account_user_id` (`user_id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `account_groupdetail`
--
ALTER TABLE `account_groupdetail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `account_user`
--
ALTER TABLE `account_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `account_user_groups`
--
ALTER TABLE `account_user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- 使用表AUTO_INCREMENT `account_user_user_permissions`
--
ALTER TABLE `account_user_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- 使用表AUTO_INCREMENT `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- 使用表AUTO_INCREMENT `basicdata_aircraftbasicdata`
--
ALTER TABLE `basicdata_aircraftbasicdata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `basicdata_aircrafttype`
--
ALTER TABLE `basicdata_aircrafttype`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `basicdata_atachatper`
--
ALTER TABLE `basicdata_atachatper`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- 使用表AUTO_INCREMENT `basicdata_jobcard`
--
ALTER TABLE `basicdata_jobcard`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- 使用表AUTO_INCREMENT `basicdata_site`
--
ALTER TABLE `basicdata_site`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- 使用表AUTO_INCREMENT `dev_snippet`
--
ALTER TABLE `dev_snippet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- 使用表AUTO_INCREMENT `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=157;

--
-- 使用表AUTO_INCREMENT `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- 使用表AUTO_INCREMENT `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- 使用表AUTO_INCREMENT `guardian_groupobjectpermission`
--
ALTER TABLE `guardian_groupobjectpermission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `guardian_userobjectpermission`
--
ALTER TABLE `guardian_userobjectpermission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- 使用表AUTO_INCREMENT `reversion_revision`
--
ALTER TABLE `reversion_revision`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `reversion_version`
--
ALTER TABLE `reversion_version`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `task_task`
--
ALTER TABLE `task_task`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `task_task_feedback`
--
ALTER TABLE `task_task_feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用表AUTO_INCREMENT `task_task_package`
--
ALTER TABLE `task_task_package`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- 使用表AUTO_INCREMENT `task_task_standard_library`
--
ALTER TABLE `task_task_standard_library`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `task_task_standard_library_aircraft_type`
--
ALTER TABLE `task_task_standard_library_aircraft_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `xadmin_bookmark`
--
ALTER TABLE `xadmin_bookmark`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `xadmin_log`
--
ALTER TABLE `xadmin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `xadmin_usersettings`
--
ALTER TABLE `xadmin_usersettings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `xadmin_userwidget`
--
ALTER TABLE `xadmin_userwidget`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 限制导出的表
--

--
-- 限制表 `account_groupdetail`
--
ALTER TABLE `account_groupdetail`
  ADD CONSTRAINT `account_groupdetail_link_to_group_id_1ed44a2b_fk_auth_group_id` FOREIGN KEY (`link_to_group_id`) REFERENCES `auth_group` (`id`);

--
-- 限制表 `account_user_groups`
--
ALTER TABLE `account_user_groups`
  ADD CONSTRAINT `account_user_groups_group_id_6c71f749_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `account_user_groups_user_id_14345e7b_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`);

--
-- 限制表 `account_user_user_permissions`
--
ALTER TABLE `account_user_user_permissions`
  ADD CONSTRAINT `account_user_user_pe_permission_id_66c44191_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `account_user_user_pe_user_id_cc42d270_fk_account_u` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`);

--
-- 限制表 `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD CONSTRAINT `authtoken_token_user_id_35299eff_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`);

--
-- 限制表 `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- 限制表 `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- 限制表 `basicdata_aircraftbasicdata`
--
ALTER TABLE `basicdata_aircraftbasicdata`
  ADD CONSTRAINT `basicdata_aircraftba_type_id_d35e0452_fk_basicdata` FOREIGN KEY (`type_id`) REFERENCES `basicdata_aircrafttype` (`id`);

--
-- 限制表 `dev_snippet`
--
ALTER TABLE `dev_snippet`
  ADD CONSTRAINT `dev_snippet_owner_id_fdde2cbb_fk_account_user_id` FOREIGN KEY (`owner_id`) REFERENCES `account_user` (`id`);

--
-- 限制表 `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`);

--
-- 限制表 `guardian_groupobjectpermission`
--
ALTER TABLE `guardian_groupobjectpermission`
  ADD CONSTRAINT `guardian_groupobject_content_type_id_7ade36b8_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `guardian_groupobject_group_id_4bbbfb62_fk_auth_grou` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `guardian_groupobject_permission_id_36572738_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);

--
-- 限制表 `guardian_userobjectpermission`
--
ALTER TABLE `guardian_userobjectpermission`
  ADD CONSTRAINT `guardian_userobjectp_content_type_id_2e892405_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `guardian_userobjectp_permission_id_71807bfc_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `guardian_userobjectp_user_id_d5c1e964_fk_account_u` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`);

--
-- 限制表 `reversion_revision`
--
ALTER TABLE `reversion_revision`
  ADD CONSTRAINT `reversion_revision_user_id_17095f45_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`);

--
-- 限制表 `reversion_version`
--
ALTER TABLE `reversion_version`
  ADD CONSTRAINT `reversion_version_content_type_id_7d0ff25c_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `reversion_version_revision_id_af9f6a9d_fk_reversion_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `reversion_revision` (`id`);

--
-- 限制表 `task_task`
--
ALTER TABLE `task_task`
  ADD CONSTRAINT `task_task_ATAChapter_id_fc5c62dd_fk_basicdata_atachatper_id` FOREIGN KEY (`ATAChapter_id`) REFERENCES `basicdata_atachatper` (`id`),
  ADD CONSTRAINT `task_task_aircraft_id_8aedf782_fk_basicdata_aircraftbasicdata_id` FOREIGN KEY (`aircraft_id`) REFERENCES `basicdata_aircraftbasicdata` (`id`),
  ADD CONSTRAINT `task_task_belong_to_package_id_2e23ce83_fk_task_task_package_id` FOREIGN KEY (`belong_to_package_id`) REFERENCES `task_task_package` (`id`),
  ADD CONSTRAINT `task_task_creator_id_9917fc2b_fk_account_user_id` FOREIGN KEY (`creator_id`) REFERENCES `account_user` (`id`),
  ADD CONSTRAINT `task_task_editor_id_36d04957_fk_account_user_id` FOREIGN KEY (`editor_id`) REFERENCES `account_user` (`id`),
  ADD CONSTRAINT `task_task_exec_site_id_7a57a460_fk_basicdata_site_id` FOREIGN KEY (`exec_site_id`) REFERENCES `basicdata_site` (`id`),
  ADD CONSTRAINT `task_task_jobcard_id_3053ab35_fk_basicdata_jobcard_id` FOREIGN KEY (`jobcard_id`) REFERENCES `basicdata_jobcard` (`id`),
  ADD CONSTRAINT `task_task_link_to_standard_lib_92d24f30_fk_task_task` FOREIGN KEY (`link_to_standard_library_id`) REFERENCES `task_task_standard_library` (`id`),
  ADD CONSTRAINT `task_task_verifier_id_34808360_fk_account_user_id` FOREIGN KEY (`verifier_id`) REFERENCES `account_user` (`id`),
  ADD CONSTRAINT `task_task_who_close_id_63b75258_fk_account_user_id` FOREIGN KEY (`who_close_id`) REFERENCES `account_user` (`id`);

--
-- 限制表 `task_task_feedback`
--
ALTER TABLE `task_task_feedback`
  ADD CONSTRAINT `task_task_feedback_task_id_90729038_fk_task_task_id` FOREIGN KEY (`task_id`) REFERENCES `task_task` (`id`),
  ADD CONSTRAINT `task_task_feedback_user_id_587a266e_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`),
  ADD CONSTRAINT `task_task_feedback_verifier_id_26efa169_fk_account_user_id` FOREIGN KEY (`verifier_id`) REFERENCES `account_user` (`id`);

--
-- 限制表 `task_task_package`
--
ALTER TABLE `task_task_package`
  ADD CONSTRAINT `task_task_package_creator_id_47e080d4_fk_account_user_id` FOREIGN KEY (`creator_id`) REFERENCES `account_user` (`id`),
  ADD CONSTRAINT `task_task_package_editor_id_66c40554_fk_account_user_id` FOREIGN KEY (`editor_id`) REFERENCES `account_user` (`id`),
  ADD CONSTRAINT `task_task_package_verifier_id_0767f3a8_fk_account_user_id` FOREIGN KEY (`verifier_id`) REFERENCES `account_user` (`id`);

--
-- 限制表 `task_task_standard_library`
--
ALTER TABLE `task_task_standard_library`
  ADD CONSTRAINT `task_task_standard_l_ATAChapter_id_edaee0fd_fk_basicdata` FOREIGN KEY (`ATAChapter_id`) REFERENCES `basicdata_atachatper` (`id`),
  ADD CONSTRAINT `task_task_standard_l_creator_id_7e91b5ba_fk_account_u` FOREIGN KEY (`creator_id`) REFERENCES `account_user` (`id`),
  ADD CONSTRAINT `task_task_standard_l_jobcard_id_a3f0d7f5_fk_basicdata` FOREIGN KEY (`jobcard_id`) REFERENCES `basicdata_jobcard` (`id`),
  ADD CONSTRAINT `task_task_standard_l_verifier_id_6546672f_fk_account_u` FOREIGN KEY (`verifier_id`) REFERENCES `account_user` (`id`),
  ADD CONSTRAINT `task_task_standard_library_editor_id_8bca01c8_fk_account_user_id` FOREIGN KEY (`editor_id`) REFERENCES `account_user` (`id`);

--
-- 限制表 `task_task_standard_library_aircraft_type`
--
ALTER TABLE `task_task_standard_library_aircraft_type`
  ADD CONSTRAINT `task_task_standard_l_aircrafttype_id_50936110_fk_basicdata` FOREIGN KEY (`aircrafttype_id`) REFERENCES `basicdata_aircrafttype` (`id`),
  ADD CONSTRAINT `task_task_standard_l_task_standard_librar_989beede_fk_task_task` FOREIGN KEY (`task_standard_library_id`) REFERENCES `task_task_standard_library` (`id`);

--
-- 限制表 `xadmin_bookmark`
--
ALTER TABLE `xadmin_bookmark`
  ADD CONSTRAINT `xadmin_bookmark_content_type_id_60941679_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `xadmin_bookmark_user_id_42d307fc_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`);

--
-- 限制表 `xadmin_log`
--
ALTER TABLE `xadmin_log`
  ADD CONSTRAINT `xadmin_log_content_type_id_2a6cb852_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `xadmin_log_user_id_bb16a176_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`);

--
-- 限制表 `xadmin_usersettings`
--
ALTER TABLE `xadmin_usersettings`
  ADD CONSTRAINT `xadmin_usersettings_user_id_edeabe4a_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`);

--
-- 限制表 `xadmin_userwidget`
--
ALTER TABLE `xadmin_userwidget`
  ADD CONSTRAINT `xadmin_userwidget_user_id_c159233a_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
