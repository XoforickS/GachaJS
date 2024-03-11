-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 11 mars 2024 à 13:02
-- Version du serveur : 8.0.31
-- Version de PHP : 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `gacha`
--

-- --------------------------------------------------------

--
-- Structure de la table `account_cards`
--

DROP TABLE IF EXISTS `account_cards`;
CREATE TABLE IF NOT EXISTS `account_cards` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_user` int DEFAULT NULL,
  `id_card` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_id_card` (`id_card`),
  KEY `fk_id_user` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=1067 DEFAULT CHARSET=utf32;

--
-- Déchargement des données de la table `account_cards`
--

INSERT INTO `account_cards` (`id`, `id_user`, `id_card`) VALUES
(40, 1, 4),
(41, 1, 5),
(42, 1, 4),
(43, 1, 5),
(44, 1, 4),
(45, 1, 5),
(46, 1, 4),
(47, 1, 5),
(48, 1, 5),
(49, 1, 5),
(50, 1, 2),
(51, 1, 2),
(52, 1, 2),
(53, 1, 2),
(54, 1, 5),
(55, 1, 5),
(56, 1, 5),
(57, 1, 3),
(58, 1, 5),
(59, 1, 4),
(60, 1, 5),
(61, 1, 5),
(62, 1, 3),
(63, 1, 2),
(64, 1, 2),
(65, 1, 3),
(66, 1, 3),
(67, 1, 2),
(68, 1, 6),
(69, 1, 6),
(70, 1, 4),
(71, 1, 7),
(72, 1, 5),
(73, 1, 1),
(74, 1, 7),
(75, 1, 5),
(76, 1, 6),
(77, 1, 2),
(78, 1, 5),
(79, 1, 2),
(80, 1, 3),
(81, 1, 4),
(82, 1, 3),
(83, 1, 2),
(84, 1, 3),
(85, 1, 2),
(86, 1, 2),
(87, 1, 3),
(88, 1, 2),
(89, 1, 6),
(90, 1, 4),
(91, 1, 2),
(92, 1, 7),
(93, 1, 7),
(94, 1, 7),
(95, 1, 5),
(96, 1, 2),
(97, 1, 2),
(98, 1, 6),
(99, 1, 2),
(100, 1, 5),
(101, 1, 2),
(102, 1, 6),
(103, 1, 6),
(104, 1, 7),
(105, 1, 6),
(106, 1, 7),
(107, 1, 2),
(108, 1, 2),
(109, 1, 7),
(110, 1, 5),
(111, 1, 4),
(112, 1, 3),
(113, 1, 5),
(114, 1, 2),
(115, 1, 3),
(116, 1, 3),
(117, 1, 7),
(118, 1, 6),
(119, 1, 2),
(120, 1, 3),
(121, 1, 2),
(122, 1, 3),
(123, 1, 7),
(124, 1, 5),
(125, 1, 6),
(126, 1, 2),
(127, 1, 4),
(128, 1, 5),
(129, 1, 7),
(130, 1, 1),
(131, 1, 5),
(132, 1, 2),
(133, 1, 7),
(134, 1, 2),
(135, 1, 7),
(136, 1, 2),
(137, 1, 3),
(138, 1, 7),
(139, 1, 2),
(140, 1, 1),
(141, 1, 7),
(142, 1, 2),
(143, 1, 7),
(144, 1, 6),
(145, 1, 3),
(146, 1, 6),
(147, 1, 6),
(148, 1, 6),
(149, 1, 6),
(150, 1, 4),
(151, 1, 7),
(152, 1, 5),
(153, 1, 5),
(154, 1, 2),
(155, 1, 2),
(156, 1, 2),
(157, 1, 2),
(158, 1, 7),
(159, 1, 2),
(160, 1, 6),
(161, 1, 7),
(162, 1, 7),
(163, 1, 2),
(164, 1, 5),
(165, 1, 6),
(166, 1, 5),
(167, 1, 3),
(168, 1, 5),
(169, 1, 6),
(170, 1, 6),
(171, 1, 3),
(172, 1, 2),
(173, 1, 2),
(174, 1, 7),
(175, 1, 6),
(176, 1, 3),
(177, 1, 5),
(178, 1, 5),
(179, 1, 7),
(180, 1, 1),
(181, 1, 7),
(182, 1, 3),
(183, 1, 7),
(184, 1, 7),
(185, 1, 7),
(186, 1, 7),
(187, 1, 2),
(188, 1, 4),
(189, 1, 3),
(190, 1, 2),
(191, 1, 2),
(192, 1, 3),
(193, 1, 1),
(194, 1, 6),
(195, 1, 7),
(196, 1, 3),
(197, 1, 7),
(198, 1, 6),
(199, 1, 7),
(200, 1, 3),
(201, 1, 7),
(202, 1, 5),
(203, 1, 2),
(204, 1, 2),
(205, 1, 1),
(206, 1, 7),
(207, 1, 1),
(208, 1, 5),
(209, 1, 6),
(210, 1, 2),
(211, 1, 3),
(212, 1, 5),
(213, 1, 4),
(214, 1, 2),
(215, 1, 7),
(216, 1, 6),
(217, 1, 5),
(218, 1, 6),
(219, 1, 5),
(220, 1, 3),
(221, 1, 3),
(222, 1, 5),
(223, 1, 6),
(224, 1, 7),
(225, 1, 6),
(226, 1, 5),
(227, 1, 7),
(228, 1, 6),
(229, 1, 2),
(230, 1, 6),
(231, 1, 3),
(232, 1, 4),
(233, 1, 6),
(234, 1, 2),
(235, 1, 5),
(236, 1, 2),
(237, 1, 2),
(238, 1, 6),
(239, 1, 4),
(240, 1, 5),
(241, 1, 2),
(242, 1, 5),
(243, 1, 2),
(244, 1, 5),
(245, 1, 3),
(246, 1, 2),
(247, 1, 3),
(248, 1, 6),
(249, 1, 5),
(250, 1, 7),
(251, 1, 7),
(252, 1, 5),
(253, 1, 5),
(254, 1, 6),
(255, 1, 6),
(256, 1, 7),
(257, 1, 6),
(258, 1, 2),
(259, 1, 5),
(260, 1, 7),
(261, 1, 6),
(262, 1, 2),
(263, 1, 7),
(264, 1, 5),
(265, 1, 6),
(266, 1, 6),
(267, 1, 2),
(268, 1, 6),
(269, 1, 6),
(270, 1, 6),
(271, 1, 7),
(272, 1, 6),
(273, 1, 7),
(274, 1, 7),
(275, 1, 3),
(276, 1, 3),
(277, 1, 7),
(278, 1, 2),
(279, 1, 5),
(280, 1, 2),
(281, 1, 4),
(282, 1, 2),
(283, 1, 7),
(284, 1, 6),
(285, 1, 7),
(286, 1, 2),
(287, 1, 7),
(288, 1, 1),
(289, 1, 5),
(290, 1, 4),
(291, 1, 5),
(292, 1, 3),
(293, 1, 1),
(294, 1, 2),
(295, 1, 7),
(296, 1, 5),
(297, 1, 6),
(298, 1, 6),
(299, 1, 5),
(300, 1, 7),
(301, 1, 2),
(302, 1, 6),
(303, 1, 7),
(304, 1, 3),
(305, 1, 6),
(306, 1, 3),
(307, 1, 6),
(308, 1, 6),
(309, 1, 2),
(310, 1, 2),
(311, 1, 4),
(312, 1, 3),
(313, 1, 7),
(314, 1, 2),
(315, 1, 5),
(316, 1, 6),
(317, 1, 6),
(318, 1, 6),
(319, 1, 4),
(320, 1, 7),
(321, 1, 3),
(322, 1, 6),
(323, 1, 6),
(324, 1, 7),
(325, 1, 1),
(326, 1, 3),
(327, 1, 6),
(328, 1, 7),
(329, 1, 5),
(330, 1, 7),
(331, 1, 5),
(332, 1, 6),
(333, 1, 3),
(334, 1, 6),
(335, 1, 7),
(336, 1, 7),
(337, 1, 5),
(338, 1, 7),
(339, 1, 2),
(340, 1, 1),
(341, 1, 7),
(342, 1, 2),
(343, 1, 1),
(344, 1, 5),
(345, 1, 7),
(346, 1, 2),
(347, 1, 2),
(348, 1, 7),
(349, 1, 7),
(350, 1, 3),
(351, 1, 6),
(352, 1, 3),
(353, 1, 4),
(354, 1, 2),
(355, 1, 7),
(356, 1, 1),
(357, 1, 2),
(358, 1, 2),
(359, 1, 7),
(360, 1, 7),
(361, 1, 2),
(362, 1, 3),
(363, 1, 7),
(364, 1, 6),
(365, 1, 2),
(366, 1, 7),
(367, 1, 5),
(368, 1, 7),
(369, 1, 2),
(370, 1, 6),
(371, 1, 2),
(372, 1, 2),
(373, 1, 5),
(374, 1, 6),
(375, 1, 7),
(376, 1, 5),
(377, 1, 2),
(378, 1, 3),
(379, 1, 3),
(380, 1, 7),
(381, 1, 5),
(382, 1, 5),
(383, 1, 5),
(384, 1, 7),
(385, 1, 2),
(386, 1, 5),
(387, 1, 2),
(388, 1, 6),
(389, 1, 1),
(390, 1, 3),
(391, 1, 4),
(392, 1, 2),
(393, 1, 7),
(394, 1, 7),
(395, 1, 7),
(396, 1, 3),
(397, 1, 2),
(398, 1, 7),
(399, 1, 7),
(400, 1, 2),
(401, 1, 5),
(402, 1, 6),
(403, 1, 7),
(404, 1, 5),
(405, 1, 7),
(406, 1, 6),
(407, 1, 7),
(408, 1, 1),
(409, 1, 7),
(410, 1, 5),
(411, 1, 7),
(412, 1, 7),
(413, 1, 3),
(414, 1, 7),
(415, 1, 4),
(416, 1, 7),
(417, 1, 7),
(418, 1, 7),
(419, 1, 6),
(420, 1, 2),
(421, 1, 7),
(422, 1, 7),
(423, 1, 7),
(424, 1, 4),
(425, 1, 3),
(426, 1, 7),
(427, 1, 3),
(428, 1, 7),
(429, 1, 3),
(430, 1, 6),
(431, 1, 1),
(432, 1, 2),
(433, 1, 5),
(434, 1, 2),
(435, 1, 6),
(436, 1, 5),
(437, 1, 1),
(438, 1, 3),
(439, 1, 5),
(440, 1, 4),
(441, 1, 3),
(442, 1, 6),
(443, 1, 7),
(444, 1, 7),
(445, 1, 2),
(446, 1, 6),
(447, 1, 7),
(448, 1, 7),
(449, 1, 6),
(450, 1, 5),
(451, 1, 7),
(452, 1, 3),
(453, 1, 6),
(454, 1, 5),
(455, 1, 1),
(456, 1, 6),
(457, 1, 3),
(458, 1, 3),
(459, 1, 6),
(460, 1, 3),
(461, 1, 7),
(462, 1, 1),
(463, 1, 6),
(464, 1, 6),
(465, 1, 6),
(466, 1, 3),
(467, 1, 3),
(468, 1, 6),
(469, 1, 2),
(470, 1, 5),
(471, 1, 3),
(472, 1, 7),
(473, 1, 1),
(474, 1, 4),
(475, 1, 7),
(476, 1, 4),
(477, 1, 1),
(478, 1, 5),
(479, 1, 7),
(480, 1, 3),
(481, 1, 6),
(482, 1, 6),
(483, 1, 2),
(484, 1, 2),
(485, 1, 3),
(486, 1, 6),
(487, 1, 6),
(488, 1, 5),
(489, 1, 3),
(490, 1, 1),
(491, 1, 7),
(492, 1, 7),
(493, 1, 3),
(494, 1, 9),
(495, 1, 7),
(496, 1, 9),
(497, 1, 7),
(498, 1, 5),
(499, 1, 6),
(500, 1, 8),
(501, 1, 7),
(502, 1, 6),
(503, 1, 2),
(504, 1, 9),
(505, 1, 3),
(506, 1, 9),
(507, 1, 8),
(508, 1, 10),
(509, 1, 3),
(510, 1, 9),
(511, 1, 8),
(512, 1, 9),
(513, 1, 9),
(514, 1, 7),
(515, 1, 12),
(516, 1, 3),
(517, 1, 1),
(518, 1, 3),
(519, 1, 2),
(520, 1, 1),
(521, 1, 8),
(522, 1, 2),
(523, 1, 7),
(524, 1, 9),
(525, 1, 6),
(526, 1, 2),
(527, 1, 3),
(528, 1, 10),
(529, 1, 11),
(530, 1, 3),
(531, 1, 10),
(532, 1, 3),
(533, 1, 2),
(534, 1, 5),
(535, 1, 7),
(536, 1, 11),
(537, 1, 11),
(538, 1, 9),
(539, 1, 5),
(540, 1, 5),
(541, 1, 10),
(542, 1, 12),
(543, 1, 2),
(544, 1, 9),
(545, 1, 10),
(546, 1, 10),
(547, 1, 5),
(548, 1, 3),
(549, 1, 10),
(550, 1, 9),
(551, 1, 2),
(552, 1, 8),
(553, 1, 2),
(554, 1, 7),
(555, 1, 6),
(556, 1, 8),
(557, 1, 5),
(558, 1, 8),
(559, 1, 12),
(560, 1, 11),
(561, 1, 9),
(562, 1, 13),
(563, 1, 5),
(564, 1, 10),
(565, 1, 7),
(566, 1, 9),
(567, 1, 8),
(568, 1, 1),
(569, 1, 11),
(570, 1, 3),
(571, 1, 11),
(572, 1, 13),
(573, 1, 2),
(574, 1, 8),
(575, 1, 2),
(576, 1, 9),
(577, 1, 9),
(578, 1, 11),
(579, 1, 10),
(580, 1, 3),
(581, 1, 6),
(582, 1, 6),
(583, 1, 8),
(584, 1, 6),
(585, 1, 5),
(586, 1, 5),
(587, 1, 6),
(588, 1, 10),
(589, 1, 6),
(590, 1, 12),
(591, 1, 3),
(592, 1, 9),
(593, 1, 10),
(594, 1, 6),
(595, 1, 5),
(596, 1, 2),
(597, 1, 5),
(598, 1, 3),
(599, 1, 2),
(600, 1, 10),
(601, 1, 9),
(602, 1, 9),
(603, 1, 12),
(604, 1, 10),
(605, 1, 6),
(606, 1, 6),
(607, 1, 9),
(608, 1, 6),
(609, 1, 10),
(610, 1, 7),
(611, 1, 3),
(612, 1, 9),
(613, 1, 9),
(614, 1, 7),
(615, 1, 3),
(616, 1, 9),
(617, 1, 13),
(618, 1, 7),
(619, 1, 9),
(620, 1, 8),
(621, 1, 5),
(622, 1, 8),
(623, 1, 9),
(624, 1, 10),
(625, 1, 3),
(626, 1, 7),
(627, 1, 6),
(628, 1, 8),
(629, 1, 2),
(630, 1, 6),
(631, 1, 2),
(632, 1, 9),
(633, 1, 9),
(634, 1, 3),
(635, 1, 7),
(636, 1, 6),
(637, 1, 8),
(638, 1, 9),
(639, 1, 13),
(640, 1, 12),
(641, 1, 5),
(642, 1, 1),
(643, 1, 12),
(644, 1, 2),
(645, 1, 2),
(646, 1, 5),
(647, 1, 7),
(648, 1, 10),
(649, 1, 7),
(650, 1, 8),
(651, 1, 2),
(652, 1, 6),
(653, 1, 10),
(654, 1, 6),
(655, 1, 13),
(656, 1, 9),
(657, 1, 2),
(658, 1, 7),
(659, 1, 7),
(660, 1, 9),
(661, 1, 3),
(662, 1, 5),
(663, 1, 10),
(664, 1, 3),
(665, 1, 5),
(666, 1, 3),
(667, 1, 10),
(668, 1, 10),
(669, 1, 9),
(670, 1, 9),
(671, 1, 2),
(672, 1, 3),
(673, 1, 2),
(674, 1, 7),
(675, 1, 10),
(676, 1, 6),
(677, 1, 6),
(678, 1, 9),
(679, 1, 5),
(680, 1, 6),
(681, 1, 8),
(682, 1, 5),
(683, 1, 6),
(684, 1, 5),
(685, 1, 3),
(686, 1, 1),
(687, 1, 1),
(688, 1, 7),
(689, 1, 8),
(690, 1, 10),
(691, 1, 10),
(692, 1, 3),
(693, 1, 5),
(694, 1, 10),
(695, 1, 7),
(696, 1, 6),
(697, 1, 10),
(698, 1, 10),
(699, 1, 8),
(700, 1, 3),
(701, 1, 1),
(702, 1, 5),
(703, 1, 10),
(704, 1, 1),
(705, 1, 5),
(706, 1, 7),
(707, 1, 3),
(708, 1, 9),
(709, 1, 7),
(710, 1, 8),
(711, 1, 10),
(712, 1, 7),
(713, 1, 6),
(714, 1, 8),
(715, 1, 6),
(716, 1, 10),
(717, 1, 7),
(718, 1, 2),
(719, 1, 7),
(720, 1, 5),
(721, 1, 3),
(722, 1, 2),
(723, 1, 8),
(724, 1, 9),
(725, 1, 6),
(726, 1, 6),
(727, 1, 5),
(728, 1, 9),
(729, 1, 9),
(730, 1, 3),
(731, 1, 1),
(732, 1, 3),
(733, 1, 9),
(734, 1, 12),
(735, 1, 10),
(736, 1, 6),
(737, 1, 7),
(738, 1, 9),
(739, 1, 9),
(740, 1, 7),
(741, 1, 8),
(742, 1, 9),
(743, 1, 1),
(744, 1, 7),
(745, 1, 6),
(746, 1, 6),
(747, 1, 9),
(748, 1, 9),
(749, 1, 5),
(750, 1, 10),
(751, 1, 6),
(752, 1, 9),
(753, 1, 7),
(754, 1, 5),
(755, 1, 13),
(756, 1, 5),
(757, 1, 9),
(758, 1, 9),
(759, 1, 2),
(760, 1, 12),
(761, 1, 2),
(762, 1, 2),
(763, 1, 2),
(764, 1, 2),
(765, 1, 2),
(766, 1, 9),
(767, 1, 3),
(768, 1, 3),
(769, 1, 11),
(770, 1, 11),
(771, 1, 9),
(772, 1, 10),
(773, 1, 7),
(774, 1, 8),
(775, 1, 3),
(776, 1, 9),
(777, 1, 2),
(778, 1, 7),
(779, 1, 9),
(780, 1, 6),
(781, 1, 6),
(782, 1, 6),
(783, 1, 2),
(784, 1, 1),
(785, 1, 2),
(786, 1, 3),
(787, 1, 6),
(788, 1, 7),
(789, 1, 9),
(790, 1, 6),
(791, 1, 6),
(792, 1, 2),
(793, 1, 10),
(794, 1, 3),
(795, 1, 3),
(796, 1, 3),
(797, 1, 10),
(798, 1, 7),
(799, 1, 10),
(800, 1, 2),
(801, 1, 8),
(802, 1, 10),
(803, 1, 2),
(804, 1, 6),
(805, 1, 2),
(806, 1, 2),
(807, 1, 3),
(808, 1, 5),
(809, 1, 7),
(810, 1, 14),
(811, 1, 6),
(812, 1, 8),
(813, 1, 10),
(814, 1, 6),
(815, 1, 10),
(816, 1, 8),
(817, 1, 2),
(818, 1, 12),
(819, 1, 8),
(820, 1, 1),
(821, 1, 5),
(822, 1, 10),
(823, 1, 9),
(824, 1, 3),
(825, 1, 9),
(826, 1, 9),
(827, 1, 2),
(828, 1, 11),
(829, 1, 8),
(830, 1, 6),
(831, 1, 12),
(832, 1, 3),
(833, 1, 6),
(834, 1, 9),
(835, 1, 13),
(836, 1, 11),
(837, 1, 4),
(838, 1, 7),
(839, 1, 9),
(840, 1, 5),
(841, 1, 10),
(842, 1, 10),
(843, 1, 14),
(844, 1, 2),
(845, 1, 2),
(846, 1, 7),
(847, 1, 3),
(848, 1, 10),
(849, 1, 6),
(850, 1, 14),
(851, 1, 5),
(852, 1, 2),
(853, 1, 9),
(854, 1, 6),
(855, 1, 9),
(856, 1, 7),
(857, 1, 8),
(858, 1, 10),
(859, 1, 8),
(860, 1, 10),
(861, 1, 14),
(862, 1, 11),
(863, 1, 2),
(864, 1, 9),
(865, 1, 10),
(866, 1, 5),
(867, 1, 9),
(868, 1, 2),
(869, 1, 2),
(870, 1, 6),
(871, 1, 9),
(872, 1, 9),
(873, 1, 9),
(874, 1, 7),
(875, 1, 7),
(876, 1, 2),
(877, 1, 9),
(878, 1, 9),
(879, 1, 2),
(880, 1, 14),
(881, 1, 2),
(882, 1, 10),
(883, 1, 5),
(884, 1, 5),
(885, 1, 5),
(886, 1, 10),
(887, 1, 14),
(888, 1, 8),
(889, 1, 14),
(890, 1, 8),
(891, 1, 2),
(892, 1, 8),
(893, 1, 13),
(894, 1, 9),
(895, 1, 12),
(896, 1, 9),
(897, 1, 1),
(898, 1, 9),
(899, 1, 9),
(900, 1, 13),
(901, 1, 5),
(902, 1, 2),
(903, 1, 7),
(904, 1, 9),
(905, 1, 6),
(906, 1, 3),
(907, 1, 8),
(908, 1, 10),
(909, 1, 5),
(910, 1, 12),
(911, 1, 13),
(912, 1, 2),
(913, 1, 2),
(914, 1, 2),
(915, 1, 6),
(916, 1, 6),
(917, 1, 10),
(918, 1, 3),
(919, 1, 2),
(920, 1, 7),
(921, 1, 2),
(922, 1, 14),
(923, 1, 9),
(924, 1, 10),
(925, 1, 6),
(926, 1, 1),
(927, 1, 8),
(928, 1, 2),
(929, 1, 11),
(930, 1, 8),
(931, 1, 9),
(932, 1, 13),
(933, 1, 10),
(934, 1, 9),
(935, 1, 14),
(936, 1, 9),
(937, 1, 7),
(938, 1, 1),
(939, 1, 9),
(940, 1, 2),
(941, 1, 7),
(942, 1, 2),
(943, 1, 14),
(944, 1, 2),
(945, 1, 16),
(946, 1, 7),
(947, 1, 7),
(948, 1, 19),
(949, 1, 13),
(950, 1, 4),
(951, 1, 13),
(952, 1, 7),
(953, 1, 4),
(954, 1, 7),
(955, 1, 13),
(956, 1, 5),
(957, 1, 16),
(958, 1, 19),
(959, 1, 4),
(960, 1, 7),
(961, 1, 4),
(962, 1, 7),
(963, 1, 2),
(964, 1, 6),
(965, 1, 19),
(966, 1, 7),
(967, 1, 7),
(968, 1, 19),
(969, 1, 20),
(970, 1, 15),
(971, 1, 13),
(972, 1, 11),
(973, 1, 11),
(974, 1, 19),
(975, 1, 19),
(976, 1, 11),
(977, 1, 19),
(978, 1, 11),
(979, 1, 5),
(980, 1, 4),
(981, 1, 7),
(982, 1, 1),
(983, 1, 7),
(984, 1, 5),
(985, 1, 4),
(986, 1, 7),
(987, 1, 13),
(988, 1, 13),
(989, 4, 19),
(990, 4, 19),
(991, 4, 14),
(992, 4, 4),
(993, 4, 15),
(994, 4, 19),
(995, 4, 7),
(996, 4, 13),
(997, 4, 11),
(998, 4, 11),
(999, 4, 2),
(1000, 4, 13),
(1001, 4, 13),
(1002, 4, 11),
(1003, 4, 13),
(1004, 4, 14),
(1005, 4, 13),
(1006, 4, 4),
(1007, 4, 11),
(1008, 4, 4),
(1009, 4, 12),
(1010, 4, 4),
(1011, 4, 19),
(1012, 4, 13),
(1013, 4, 19),
(1014, 4, 13),
(1015, 4, 7),
(1016, 4, 10),
(1017, 4, 2),
(1018, 4, 4),
(1019, 4, 4),
(1020, 4, 19),
(1021, 4, 10),
(1022, 4, 11),
(1023, 4, 4),
(1024, 4, 19),
(1025, 4, 4),
(1026, 4, 19),
(1027, 4, 5),
(1028, 4, 11),
(1029, 4, 19),
(1030, 4, 7),
(1031, 4, 13),
(1032, 4, 4),
(1033, 4, 13),
(1034, 4, 13),
(1035, 4, 13),
(1036, 4, 19),
(1037, 4, 13),
(1038, 4, 19),
(1039, 4, 2),
(1040, 4, 11),
(1041, 4, 4),
(1042, 4, 19),
(1043, 4, 4),
(1044, 4, 4),
(1045, 4, 11),
(1046, 4, 4),
(1047, 4, 13),
(1048, 4, 13),
(1049, 4, 7),
(1050, 4, 7),
(1051, 4, 19),
(1052, 4, 7),
(1053, 1, 4),
(1054, 6, 4),
(1055, 6, 11),
(1056, 6, 13),
(1057, 6, 19),
(1058, 6, 4),
(1059, 6, 7),
(1060, 6, 13),
(1061, 6, 11),
(1062, 6, 4),
(1063, 6, 9),
(1064, 6, 19),
(1065, 6, 7),
(1066, 6, 7);

-- --------------------------------------------------------

--
-- Structure de la table `account_equipments`
--

DROP TABLE IF EXISTS `account_equipments`;
CREATE TABLE IF NOT EXISTS `account_equipments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `id_equipment` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_account_equipments_id` (`id`),
  KEY `ix_account_equipments_id_equipment` (`id_equipment`),
  KEY `ix_account_equipments_id_user` (`id_user`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf32;

--
-- Déchargement des données de la table `account_equipments`
--

INSERT INTO `account_equipments` (`id`, `id_user`, `id_equipment`) VALUES
(1, 1, 7),
(2, 1, 3),
(3, 1, 3),
(4, 1, 3),
(5, 1, 6),
(6, 1, 5),
(7, 1, 11),
(8, 1, 8),
(9, 1, 8),
(10, 1, 13),
(11, 1, 8),
(12, 1, 20),
(13, 1, 3),
(14, 6, 12);

-- --------------------------------------------------------

--
-- Structure de la table `cards`
--

DROP TABLE IF EXISTS `cards`;
CREATE TABLE IF NOT EXISTS `cards` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) CHARACTER SET utf32 COLLATE utf32_general_ci DEFAULT NULL,
  `image_w_border` varchar(255) NOT NULL,
  `attack` int NOT NULL,
  `defense` int NOT NULL,
  `speed` int NOT NULL,
  `percentage_drop` float DEFAULT '0',
  `rarity` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf32;

--
-- Déchargement des données de la table `cards`
--

INSERT INTO `cards` (`id`, `name`, `image`, `image_w_border`, `attack`, `defense`, `speed`, `percentage_drop`, `rarity`) VALUES
(1, 'Boudah', 'http://localhost:5173/personnages/boudah.png', 'http://localhost:5173/without_border/boudah.png', 1500, 3000, 1000, 1.5, 1),
(2, 'Bruce Lee', 'http://localhost:5173/personnages/bruce lee.png', 'http://localhost:5173/without_border/bruce lee.png', 1500, 3000, 1000, 1.5, 1),
(3, 'Jules Cesar', 'http://localhost:5173/personnages/ceasar.png', 'http://localhost:5173/without_border/ceasar.png', 1500, 3000, 1000, 1.5, 1),
(4, 'Ernesto Che Guevara', 'http://localhost:5173/personnages/che guevara.png', 'http://localhost:5173/without_border/che guevara.png', 1300, 2000, 750, 16, 0),
(5, 'Cleopatre', 'http://localhost:5173/personnages/cleopatre.png', 'http://localhost:5173/without_border/cleopatre.png', 1500, 3000, 1000, 1.5, 1),
(6, 'Elvis Presley', 'http://localhost:5173/personnages/elvis.png', 'http://localhost:5173/without_border/elvis.png', 2100, 5100, 1250, 1, 2),
(7, 'Jeanne d\'Arc', 'http://localhost:5173/personnages/jeanne d\'arc.png', 'http://localhost:5173/without_border/jeanne d\'arc.png', 1300, 2000, 750, 16, 0),
(8, 'Leonard de Vinci', 'http://localhost:5173/personnages/leonard de vinci.png', 'http://localhost:5173/without_border/leonard de vinci.png', 2100, 5100, 1250, 1, 2),
(9, 'Abraham Lincoln', 'http://localhost:5173/personnages/lincoln.png', 'http://localhost:5173/without_border/lincoln.png', 2100, 5100, 1250, 1, 2),
(10, 'Louis XIV', 'http://localhost:5173/personnages/louix xiv.png', 'http://localhost:5173/without_border/louix xiv.png', 1500, 3000, 1000, 1.5, 1),
(11, 'Marylin Monroe', 'http://localhost:5173/personnages/marylin monroe.png', 'http://localhost:5173/without_border/marylin monroe.png', 1300, 2000, 750, 16, 0),
(12, 'Les trois mousquetaires', 'http://localhost:5173/personnages/mousquetaires.png', 'http://localhost:5173/without_border/mousquetaires.png', 1500, 3000, 1000, 1.5, 1),
(13, 'Napoleon Ier', 'http://localhost:5173/personnages/napoleon.png', 'http://localhost:5173/without_border/napoleon.png', 1500, 2000, 1000, 16, 0),
(14, 'Isaac Newton', 'http://localhost:5173/personnages/newton.png', 'http://localhost:5173/without_border/newton.png', 1500, 3000, 1000, 1.5, 1),
(15, 'Robert Oppenheimer', 'http://localhost:5173/personnages/oppenheimer.png', 'http://localhost:5173/without_border/oppenheimer.png', 2100, 5100, 1250, 1, 2),
(16, 'Socrate', 'http://localhost:5173/personnages/socrate.png', 'http://localhost:5173/without_border/socrate.png', 1500, 3000, 1000, 1.5, 1),
(17, 'Spatacus', 'http://localhost:5173/personnages/spartacus.png', 'http://localhost:5173/without_border/spartacus.png', 2100, 5100, 1250, 1, 2),
(18, 'Sun Tzu', 'http://localhost:5173/personnages/sun tzu.png', 'http://localhost:5173/without_border/sun tzu.png', 1500, 3000, 1000, 1.5, 1),
(19, 'Nikola Tesla', 'http://localhost:5173/personnages/tesla.png', 'http://localhost:5173/without_border/tesla.png', 1300, 2000, 750, 16, 0),
(20, 'Vercingetorix', 'http://localhost:5173/personnages/vercingétorix.png', 'http://localhost:5173/without_border/vercingétorix.png', 1500, 3000, 1000, 1.5, 1);

-- --------------------------------------------------------

--
-- Structure de la table `enemies`
--

DROP TABLE IF EXISTS `enemies`;
CREATE TABLE IF NOT EXISTS `enemies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `attack` int NOT NULL,
  `defense` int NOT NULL,
  `speed` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `enemies`
--

INSERT INTO `enemies` (`id`, `name`, `image`, `attack`, `defense`, `speed`) VALUES
(5, 'Ramses II', 'http://localhost:5173/ennemies/Ramses%20II.png', 3000, 6000, 1000),
(4, 'Croque-mitaine', 'http://localhost:5173/ennemies/croque-mitaine.png', 2000, 4000, 800),
(3, 'Fanatiques', 'http://localhost:5173/ennemies/fanatique.png', 1500, 3000, 700),
(2, 'Brigand', 'http://localhost:5173/ennemies/brigand.png', 1200, 2500, 600),
(1, 'Punk', 'http://localhost:5173/ennemies/punk.png', 1000, 2000, 500),
(6, 'Ivar le désossé', 'http://localhost:5173/ennemies/desosse.png', 3500, 7000, 1000),
(7, 'Sphynx', 'http://localhost:5173/ennemies/sphynx.png', 4000, 8000, 1200),
(8, 'Barbe noir', 'http://localhost:5173/ennemies/barbe noire.png', 4500, 9000, 1500),
(9, 'Momies', 'http://localhost:5173/ennemies/momie.png', 1200, 2500, 600),
(10, 'Esclavagiste', 'http://localhost:5173/ennemies/esclavagiste.png', 1500, 3000, 700),
(11, 'Scribes', 'http://localhost:5173/ennemies/scribes.png', 1800, 3500, 800),
(12, 'Scorpion', 'http://localhost:5173/ennemies/scorpion.png', 1600, 3500, 700),
(13, 'Ver des sables', 'http://localhost:5173/ennemies/ver.png', 1800, 4000, 800),
(14, 'Génie', 'http://localhost:5173/ennemies/genie.png', 2000, 4500, 900),
(15, 'Maquaques', 'http://localhost:5173/ennemies/maquaque.png', 1800, 4000, 800),
(16, 'Pirates', 'http://localhost:5173/ennemies/pirate.png', 2000, 4500, 900),
(17, 'Seconds', 'http://localhost:5173/ennemies/second.png', 2200, 5000, 1000),
(18, 'Vikings', 'http://localhost:5173/ennemies/viking.png', 1400, 3000, 600),
(19, 'Femme vikings', 'http://localhost:5173/ennemies/femme%20viking.png', 1600, 3500, 700),
(20, 'Drakkars', 'http://localhost:5173/ennemies/drakkar.png', 1800, 4000, 800);

-- --------------------------------------------------------

--
-- Structure de la table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
CREATE TABLE IF NOT EXISTS `equipment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `attack` int DEFAULT NULL,
  `defense` int DEFAULT NULL,
  `speed` int DEFAULT NULL,
  `rarity` enum('Common','Uncommon','Rare','Epic','Legendary') DEFAULT 'Common',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf32;

--
-- Déchargement des données de la table `equipment`
--

INSERT INTO `equipment` (`id`, `name`, `image`, `attack`, `defense`, `speed`, `rarity`) VALUES
(1, 'Épée de Valeur', 'http://localhost:5173/equipments/1.png', 45, 20, 10, 'Rare'),
(2, 'Robe du Mage', 'http://localhost:5173/equipments/2.png', 15, 30, 5, 'Common'),
(3, 'Marteau du Tonnerre', 'http://localhost:5173/equipments/3.png', 60, 15, 8, 'Epic'),
(4, 'Bouclier d\'Acier', 'http://localhost:5173/equipments/4.png', 10, 50, 3, 'Uncommon'),
(5, 'Arc de la Lune', 'http://localhost:5173/equipments/5.png', 35, 10, 12, 'Rare'),
(6, 'Gants d\'Ombre', 'http://localhost:5173/equipments/6.png', 20, 25, 15, 'Common'),
(7, 'Hache du Chaos', 'http://localhost:5173/equipments/7.png', 55, 18, 7, 'Epic'),
(8, 'Cape de Mystère', 'http://localhost:5173/equipments/8.png', 12, 40, 6, 'Uncommon'),
(9, 'Fiole d\'Éclat', 'http://localhost:5173/equipments/9.png', 30, 8, 20, 'Common'),
(10, 'Dague du Serpent', 'http://localhost:5173/equipments/10.png', 25, 12, 18, 'Rare'),
(11, 'Armure Lourde', 'http://localhost:5173/equipments/11.png', 8, 60, 4, 'Uncommon'),
(12, 'Foudre Rapide', 'http://localhost:5173/equipments/12.png', 40, 14, 14, 'Common'),
(13, 'Éventail de Glace', 'http://localhost:5173/equipments/13.png', 22, 22, 16, 'Epic'),
(14, 'Sceptre de Sagesse', 'http://localhost:5173/equipments/14.png', 50, 16, 9, 'Rare'),
(15, 'Bottes Agile', 'http://localhost:5173/equipments/15.png', 18, 28, 11, 'Common'),
(16, 'Lance du Soleil', 'http://localhost:5173/equipments/16.png', 48, 13, 8, 'Epic'),
(17, 'Pendentif Enchanté', 'http://localhost:5173/equipments/17.png', 15, 35, 5, 'Uncommon'),
(18, 'Casque de Brume', 'http://localhost:5173/equipments/18.png', 11, 45, 7, 'Common'),
(19, 'Griffes du Tigre', 'http://localhost:5173/equipments/19.png', 33, 11, 17, 'Rare'),
(20, 'Élixir de Protection', 'http://localhost:5173/equipments/20.png', 28, 10, 19, 'Uncommon');

-- --------------------------------------------------------

--
-- Structure de la table `stages`
--

DROP TABLE IF EXISTS `stages`;
CREATE TABLE IF NOT EXISTS `stages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf32;

--
-- Déchargement des données de la table `stages`
--

INSERT INTO `stages` (`id`, `name`) VALUES
(1, 'Stage 1'),
(2, 'Stage 2'),
(3, 'Stage 3'),
(4, 'Stage 4'),
(5, 'Stage 5');

-- --------------------------------------------------------

--
-- Structure de la table `stage_fights`
--

DROP TABLE IF EXISTS `stage_fights`;
CREATE TABLE IF NOT EXISTS `stage_fights` (
  `id` int NOT NULL AUTO_INCREMENT,
  `stage_id` int NOT NULL,
  `fight_number` int NOT NULL,
  `enemy1_id` int NOT NULL,
  `enemy2_id` int NOT NULL,
  `enemy3_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_stage_id` (`stage_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf32;

--
-- Déchargement des données de la table `stage_fights`
--

INSERT INTO `stage_fights` (`id`, `stage_id`, `fight_number`, `enemy1_id`, `enemy2_id`, `enemy3_id`) VALUES
(1, 1, 1, 1, 2, 3),
(2, 1, 2, 2, 3, 1),
(3, 1, 3, 3, 4, 2),
(4, 2, 1, 9, 10, 11),
(5, 2, 2, 10, 11, 9),
(6, 2, 3, 11, 5, 10),
(7, 3, 1, 18, 19, 20),
(8, 3, 2, 19, 20, 18),
(9, 3, 3, 19, 6, 20),
(10, 4, 1, 12, 13, 14),
(11, 4, 2, 13, 14, 12),
(12, 4, 3, 14, 7, 13),
(13, 5, 1, 15, 16, 17),
(14, 5, 2, 16, 17, 15),
(15, 5, 3, 16, 8, 17);

-- --------------------------------------------------------

--
-- Structure de la table `teams`
--

DROP TABLE IF EXISTS `teams`;
CREATE TABLE IF NOT EXISTS `teams` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `card1_id` int DEFAULT NULL,
  `card2_id` int DEFAULT NULL,
  `card3_id` int DEFAULT NULL,
  `card4_id` int DEFAULT NULL,
  `card5_id` int DEFAULT NULL,
  `stage_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fk_stage_id` (`stage_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `teams`
--

INSERT INTO `teams` (`id`, `user_id`, `card1_id`, `card2_id`, `card3_id`, `card4_id`, `card5_id`, `stage_id`) VALUES
(7, 4, 20, 19, 18, 17, 16, NULL),
(8, 6, 6, 4, 3, 5, 7, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(25) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` int NOT NULL,
  `xp` int NOT NULL DEFAULT '0',
  `level` int NOT NULL DEFAULT '1',
  `summon_stone` int NOT NULL DEFAULT '0',
  `coin` int NOT NULL DEFAULT '0',
  `equipment_stone` int NOT NULL DEFAULT '0',
  `currentStage` int DEFAULT '1',
  `favorite_card` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf32;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `xp`, `level`, `summon_stone`, `coin`, `equipment_stone`, `currentStage`, `favorite_card`) VALUES
(1, 'CompteTest', 'test@test.fr', 1234, 96, 12, 200000, 0, 5, 1, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `user_cards`
--

DROP TABLE IF EXISTS `user_cards`;
CREATE TABLE IF NOT EXISTS `user_cards` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `card_id` int DEFAULT NULL,
  `level` int DEFAULT '1',
  `attack_upgrade` int DEFAULT NULL,
  `defense_upgrade` int DEFAULT NULL,
  `speed_upgrade` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf32;

--
-- Déchargement des données de la table `user_cards`
--

INSERT INTO `user_cards` (`id`, `user_id`, `card_id`, `level`, `attack_upgrade`, `defense_upgrade`, `speed_upgrade`) VALUES
(1, 1, 4, 1, 100, 0, 0),
(2, 1, 3, 1, 100, 0, 0),
(3, 1, 2, 1, 100, 0, 0),
(4, 1, 7, 1, 100, 0, 0),
(5, 1, 5, 1, 100, 0, 0),
(6, 1, 6, 1, 0, 0, 0),
(7, 1, 1, 1, 10, 0, 0),
(8, 1, 9, 1, 0, 0, 0),
(9, 1, 8, 3, 100, 100, 0),
(10, 1, 10, 1, 0, 0, 0),
(11, 1, 12, 1, 0, 0, 0),
(12, 1, 11, 1, 0, 0, 0),
(13, 1, 13, 1, 0, 0, 0),
(14, 1, 14, 1, 0, 0, 0),
(15, 1, 16, 1, 0, 0, 0),
(16, 1, 19, 1, 20, 0, 0),
(17, 1, 20, 1, 0, 0, 0),
(18, 1, 15, 3, 100, 100, 100),
(19, 4, 19, 1, 0, 0, 0),
(20, 4, 14, 1, 0, 0, 0),
(21, 4, 4, 1, 0, 0, 0),
(22, 4, 15, 1, 0, 0, 0),
(23, 4, 7, 1, 0, 0, 0),
(24, 4, 13, 1, 0, 0, 0),
(25, 4, 11, 1, 0, 0, 0),
(26, 4, 2, 1, 0, 0, 0),
(27, 4, 12, 1, 0, 0, 0),
(28, 4, 10, 1, 0, 0, 0),
(29, 4, 5, 3, 100, 100, 0),
(30, 6, 4, 1, 0, 0, 0),
(31, 6, 11, 1, 0, 0, 0),
(32, 6, 13, 1, 0, 0, 0),
(33, 6, 19, 1, 0, 0, 0),
(34, 6, 7, 1, 0, 0, 0),
(35, 6, 9, 3, 100, 100, 0);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `account_cards`
--
ALTER TABLE `account_cards`
  ADD CONSTRAINT `fk_id_card` FOREIGN KEY (`id_card`) REFERENCES `cards` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_id_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `stage_fights`
--
ALTER TABLE `stage_fights`
  ADD CONSTRAINT `fk_stage_id` FOREIGN KEY (`stage_id`) REFERENCES `stages` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
