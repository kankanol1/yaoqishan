/*
Navicat MySQL Data Transfer

Source Server         : 106.52.105.214
Source Server Version : 50732
Source Host           : 106.52.105.214:3306
Source Database       : sq_173cms

Target Server Type    : MYSQL
Target Server Version : 50732
File Encoding         : 65001

Date: 2020-12-31 17:27:16
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for activate_info
-- ----------------------------
DROP TABLE IF EXISTS `activate_info`;
CREATE TABLE `activate_info` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `code` varchar(50) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of activate_info
-- ----------------------------

-- ----------------------------
-- Table structure for api_info
-- ----------------------------
DROP TABLE IF EXISTS `api_info`;
CREATE TABLE `api_info` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `sort` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `leixing` varchar(50) DEFAULT NULL,
  `diqu` varchar(50) DEFAULT NULL,
  `nianfen` varchar(50) DEFAULT NULL,
  `zhuangtai` varchar(50) DEFAULT NULL,
  `zifei` varchar(50) DEFAULT NULL,
  `xingqi` varchar(50) DEFAULT NULL,
  `type_id` varchar(50) DEFAULT NULL,
  `field` varchar(50) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `tag` varchar(50) DEFAULT NULL,
  `select_video` int(11) DEFAULT NULL,
  `kandian` varchar(100) DEFAULT NULL,
  `zongjishu` varchar(100) DEFAULT NULL,
  `shangyingnianfen` varchar(100) DEFAULT NULL,
  `fengge` varchar(100) DEFAULT NULL,
  `shengyou` varchar(100) DEFAULT NULL,
  `rank_type` varchar(50) DEFAULT NULL,
  `cache_time` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of api_info
-- ----------------------------

-- ----------------------------
-- Table structure for audio_info
-- ----------------------------
DROP TABLE IF EXISTS `audio_info`;
CREATE TABLE `audio_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `sort` int(11) NOT NULL,
  `template` varchar(50) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `description` text,
  `url` varchar(255) NOT NULL,
  `result` varchar(255) DEFAULT NULL,
  `images` varchar(10000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of audio_info
-- ----------------------------
INSERT INTO `audio_info` VALUES ('1', 'test.mp4', '2', 'edit', 'test.mp4', 'test.mp4', 'test.mp4视频描述', 'http://eways.gl-data.com:10009/test.mp4', 'http://eways.gl-data.com:10009/test.mp4', 'http://eways.gl-data.com:10009/1.png,http://eways.gl-data.com:10009/2.png,http://eways.gl-data.com:10009/3.png');

-- ----------------------------
-- Table structure for channel_info
-- ----------------------------
DROP TABLE IF EXISTS `channel_info`;
CREATE TABLE `channel_info` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `sort` int(11) NOT NULL,
  `template` varchar(50) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of channel_info
-- ----------------------------

-- ----------------------------
-- Table structure for collection_info
-- ----------------------------
DROP TABLE IF EXISTS `collection_info`;
CREATE TABLE `collection_info` (
  `id` int(11) NOT NULL,
  `media_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of collection_info
-- ----------------------------

-- ----------------------------
-- Table structure for comment_info
-- ----------------------------
DROP TABLE IF EXISTS `comment_info`;
CREATE TABLE `comment_info` (
  `id` int(11) NOT NULL,
  `video_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `update_time` datetime NOT NULL,
  `login_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of comment_info
-- ----------------------------

-- ----------------------------
-- Table structure for email_info
-- ----------------------------
DROP TABLE IF EXISTS `email_info`;
CREATE TABLE `email_info` (
  `id` int(11) NOT NULL,
  `smtp` varchar(50) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of email_info
-- ----------------------------

-- ----------------------------
-- Table structure for field_info
-- ----------------------------
DROP TABLE IF EXISTS `field_info`;
CREATE TABLE `field_info` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `sort` int(11) NOT NULL,
  `input_type` varchar(50) NOT NULL,
  `var_name` varchar(50) NOT NULL,
  `content` longtext,
  `type` varchar(50) DEFAULT NULL,
  `is_allow_edit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of field_info
-- ----------------------------
INSERT INTO `field_info` VALUES ('7', '海报', '1', 'image', 'haibao', '', 'system', null);
INSERT INTO `field_info` VALUES ('8', '小封面', '1', 'image', 'fengmian', '', 'system', null);
INSERT INTO `field_info` VALUES ('12', '简介', '1', 'textarea', 'jianjie', '', 'system', null);
INSERT INTO `field_info` VALUES ('13', '标题', '1', 'text', 'biaoti', '', 'system', null);
INSERT INTO `field_info` VALUES ('17', '看点', '1', 'text', 'kandian', '	<div class=\'unit\'>		<div class=\'left\'>			<p class=\'subtitle\'>看点</p>		</div>		<div class=\'right\'>		<input type=\'text\' class=\'text\' name=\'kandian\' value=\'\' />		</div>		<span class=\'clearfix\'></span>	</div>', 'user', null);
INSERT INTO `field_info` VALUES ('20', '总集数', '2', 'number', 'zongjishu', '	<div class=\'unit\'>		<div class=\'left\'>			<p class=\'subtitle\'>总集数</p>		</div>		<div class=\'right\'>		<input type=\'text\' class=\'text\' name=\'zongjishu\' data-type=\"空|正整数\" error-msg=\"正整数格式错误\" value=\'\' />		</div>		<span class=\'clearfix\'></span>	</div>', 'user', null);
INSERT INTO `field_info` VALUES ('21', '别名', '1', 'text', 'bieming', '', 'system', null);
INSERT INTO `field_info` VALUES ('23', '媒体主键', '1', 'text', 'media_id', null, 'system', null);
INSERT INTO `field_info` VALUES ('24', '分类id', '1', 'text', 'type_id', null, 'system', null);
INSERT INTO `field_info` VALUES ('25', '媒体状态', '1', 'text', 'status', null, 'system', null);
INSERT INTO `field_info` VALUES ('26', '更新时间', '1', 'text', 'update_time', null, 'system', null);
INSERT INTO `field_info` VALUES ('27', '标签', '1', 'text', 'tag', null, 'system', null);
INSERT INTO `field_info` VALUES ('28', '主键', '1', 'text', 'id', null, 'system', null);
INSERT INTO `field_info` VALUES ('32', '接口字段', '1', 'text', 'field', null, 'system', null);
INSERT INTO `field_info` VALUES ('33', '接口名称', '1', 'text', 'name', null, 'system', null);
INSERT INTO `field_info` VALUES ('34', '接口排序', '1', 'text', 'sort', null, 'system', null);
INSERT INTO `field_info` VALUES ('35', '接口类型', '1', 'text', 'type', null, 'system', null);
INSERT INTO `field_info` VALUES ('45', '大封面', '1', 'image', 'dafengmian', null, 'system', null);

-- ----------------------------
-- Table structure for field_profile_info
-- ----------------------------
DROP TABLE IF EXISTS `field_profile_info`;
CREATE TABLE `field_profile_info` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `sort` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of field_profile_info
-- ----------------------------

-- ----------------------------
-- Table structure for group_info
-- ----------------------------
DROP TABLE IF EXISTS `group_info`;
CREATE TABLE `group_info` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `power` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of group_info
-- ----------------------------
INSERT INTO `group_info` VALUES ('1', '管理员', '255', 'system', '1');
INSERT INTO `group_info` VALUES ('2', '注册用户', '1', 'system', '3');

-- ----------------------------
-- Table structure for history_info
-- ----------------------------
DROP TABLE IF EXISTS `history_info`;
CREATE TABLE `history_info` (
  `id` int(11) NOT NULL,
  `video_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of history_info
-- ----------------------------

-- ----------------------------
-- Table structure for media_info
-- ----------------------------
DROP TABLE IF EXISTS `media_info`;
CREATE TABLE `media_info` (
  `media_id` int(11) NOT NULL,
  `update_time` datetime NOT NULL,
  `status` int(11) NOT NULL,
  `haibao` varchar(200) DEFAULT NULL,
  `fengmian` varchar(200) DEFAULT NULL,
  `biaoti` varchar(100) DEFAULT NULL,
  `kandian` varchar(50) DEFAULT NULL,
  `jianjie` text,
  `tag` varchar(100) DEFAULT NULL,
  `zongjishu` varchar(50) DEFAULT NULL,
  `bieming` varchar(200) DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  `dafengmian` varchar(200) DEFAULT NULL,
  `has_video` int(11) DEFAULT NULL,
  PRIMARY KEY (`media_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of media_info
-- ----------------------------

-- ----------------------------
-- Table structure for nav_info
-- ----------------------------
DROP TABLE IF EXISTS `nav_info`;
CREATE TABLE `nav_info` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `link` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `sort` int(11) NOT NULL,
  `is_index` int(11) NOT NULL,
  `is_use` int(11) NOT NULL,
  `channel_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of nav_info
-- ----------------------------
INSERT INTO `nav_info` VALUES ('1', '首页', 'portal/index.action', 'system', '0', '1', '1', null);

-- ----------------------------
-- Table structure for player_info
-- ----------------------------
DROP TABLE IF EXISTS `player_info`;
CREATE TABLE `player_info` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `content` text,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of player_info
-- ----------------------------

-- ----------------------------
-- Table structure for qiniu_info
-- ----------------------------
DROP TABLE IF EXISTS `qiniu_info`;
CREATE TABLE `qiniu_info` (
  `id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `ak` varchar(100) DEFAULT NULL,
  `sk` varchar(100) DEFAULT NULL,
  `bucket` varchar(50) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `compress` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `domain` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of qiniu_info
-- ----------------------------
INSERT INTO `qiniu_info` VALUES ('1', 'haibao', '', '', '', '400', '600', '0', '海报', '');
INSERT INTO `qiniu_info` VALUES ('2', 'fengmian', '', '', '', '320', '180', '0', '小封面', '');
INSERT INTO `qiniu_info` VALUES ('7', 'content', '', '', '', '0', '0', '0', '照片', '');
INSERT INTO `qiniu_info` VALUES ('10', 'touxiang', '', '', '', '200', '200', '0', '头像', '');
INSERT INTO `qiniu_info` VALUES ('11', 'dafengmian', '', '', '', '492', '319', '0', '大封面', '');

-- ----------------------------
-- Table structure for reply_info
-- ----------------------------
DROP TABLE IF EXISTS `reply_info`;
CREATE TABLE `reply_info` (
  `id` int(11) NOT NULL,
  `comment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `login_name` varchar(50) NOT NULL,
  `to_user_id` int(11) NOT NULL,
  `to_login_name` varchar(50) NOT NULL,
  `update_time` datetime NOT NULL,
  `content` text NOT NULL,
  `video_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of reply_info
-- ----------------------------

-- ----------------------------
-- Table structure for seo_info
-- ----------------------------
DROP TABLE IF EXISTS `seo_info`;
CREATE TABLE `seo_info` (
  `id` int(11) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `keywords` varchar(200) DEFAULT NULL,
  `description` text,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of seo_info
-- ----------------------------
INSERT INTO `seo_info` VALUES ('1', '', '', '', 'index');
INSERT INTO `seo_info` VALUES ('2', '', '', '', 'list');
INSERT INTO `seo_info` VALUES ('3', '', '', null, 'play');
INSERT INTO `seo_info` VALUES ('4', '', '', null, 'profile');

-- ----------------------------
-- Table structure for slide_info
-- ----------------------------
DROP TABLE IF EXISTS `slide_info`;
CREATE TABLE `slide_info` (
  `id` int(11) NOT NULL,
  `api_id` int(11) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `summary` varchar(100) DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `sort` int(11) NOT NULL,
  `thumbnail` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of slide_info
-- ----------------------------

-- ----------------------------
-- Table structure for star_info
-- ----------------------------
DROP TABLE IF EXISTS `star_info`;
CREATE TABLE `star_info` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `alias` varchar(50) DEFAULT NULL,
  `sex` varchar(50) NOT NULL,
  `region` varchar(50) DEFAULT NULL,
  `blood` varchar(50) DEFAULT NULL,
  `birthday` varchar(50) DEFAULT NULL,
  `constellation` varchar(50) DEFAULT NULL,
  `occupation` varchar(50) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `introduction` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of star_info
-- ----------------------------

-- ----------------------------
-- Table structure for tag_info
-- ----------------------------
DROP TABLE IF EXISTS `tag_info`;
CREATE TABLE `tag_info` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tag_info
-- ----------------------------

-- ----------------------------
-- Table structure for template_info
-- ----------------------------
DROP TABLE IF EXISTS `template_info`;
CREATE TABLE `template_info` (
  `id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of template_info
-- ----------------------------
INSERT INTO `template_info` VALUES ('1', 'pc', 'default');
INSERT INTO `template_info` VALUES ('2', 'm', 'default');

-- ----------------------------
-- Table structure for type_field
-- ----------------------------
DROP TABLE IF EXISTS `type_field`;
CREATE TABLE `type_field` (
  `id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `is_screen` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  `is_required` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of type_field
-- ----------------------------

-- ----------------------------
-- Table structure for type_info
-- ----------------------------
DROP TABLE IF EXISTS `type_info`;
CREATE TABLE `type_info` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `sort` int(11) NOT NULL,
  `profile_template` varchar(50) DEFAULT NULL,
  `play_template` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of type_info
-- ----------------------------

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `login_name` varchar(50) NOT NULL,
  `pass_word` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `register_time` datetime NOT NULL,
  `register_ip` varchar(50) DEFAULT NULL,
  `last_login_time` datetime NOT NULL,
  `last_login_ip` varchar(50) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `sign_personal` varchar(255) DEFAULT NULL,
  `point` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `group_name` varchar(255) DEFAULT NULL,
  `power` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES ('1', 'admin', '96e79218965eb72c92a549dd5a330112', '123456@qq.com', '2018-03-07 16:16:00', 'hidden', '2018-03-07 16:16:00', 'hidden', '1', null, null, null, null, null, null);
INSERT INTO `user_info` VALUES ('22', 'usertest', '806b2af4633e64af88d33fbe4165a06a', 'usertest@qq.com', '2020-12-30 14:28:07', '127.0.0.1', '2020-12-30 14:28:07', '127.0.0.1', '1', null, null, null, null, null, null);

-- ----------------------------
-- Table structure for user_profile_info
-- ----------------------------
DROP TABLE IF EXISTS `user_profile_info`;
CREATE TABLE `user_profile_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `sign_personal` varchar(255) DEFAULT NULL,
  `point` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_profile_info
-- ----------------------------
INSERT INTO `user_profile_info` VALUES ('1', '1', '1', '', '', '0');
INSERT INTO `user_profile_info` VALUES ('3', '22', '2', null, null, null);

-- ----------------------------
-- Table structure for video_info
-- ----------------------------
DROP TABLE IF EXISTS `video_info`;
CREATE TABLE `video_info` (
  `video_id` int(11) NOT NULL,
  `media_id` int(11) NOT NULL,
  `num` varchar(50) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `view_count` int(11) NOT NULL,
  `player_id` int(11) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `remark` text,
  `power` int(11) DEFAULT NULL,
  `point` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `view_count_day` int(11) DEFAULT NULL,
  `view_count_week` int(11) DEFAULT NULL,
  `view_count_month` int(11) DEFAULT NULL,
  `view_count_year` int(11) DEFAULT NULL,
  PRIMARY KEY (`video_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of video_info
-- ----------------------------

-- ----------------------------
-- Table structure for web_info
-- ----------------------------
DROP TABLE IF EXISTS `web_info`;
CREATE TABLE `web_info` (
  `name` varchar(255) DEFAULT NULL,
  `domain` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `record_number` varchar(50) DEFAULT NULL,
  `statistical_code` text,
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of web_info
-- ----------------------------
INSERT INTO `web_info` VALUES (null, null, null, null, null, '1');
