/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 50729
 Source Host           : localhost:3306
 Source Schema         : albedo-config

 Target Server Type    : MySQL
 Target Server Version : 50729
 File Encoding         : 65001

 Date: 15/06/2020 10:16:04
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for config_info
-- ----------------------------
DROP TABLE IF EXISTS `config_info`;
CREATE TABLE `config_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) DEFAULT NULL,
  `group_id` varchar(255) DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) DEFAULT NULL,
  `gmt_create` datetime NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '修改时间',
  `src_user` mediumtext,
  `src_ip` varchar(20) DEFAULT NULL,
  `app_name` varchar(128) DEFAULT NULL,
  `tenant_id` varchar(128) DEFAULT NULL,
  `c_desc` varchar(256) DEFAULT NULL,
  `c_use` varchar(64) DEFAULT NULL,
  `effect` varchar(64) DEFAULT NULL,
  `type` varchar(64) DEFAULT NULL,
  `c_schema` mediumtext,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_configinfo_datagrouptenant` (`data_id`,`group_id`,`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='config_info';

-- ----------------------------
-- Records of config_info
-- ----------------------------
BEGIN;
INSERT INTO `config_info` VALUES (9, 'albedo-auth-dev.yml', 'DEFAULT_GROUP', '# 数据源\r\nspring:\r\n  datasource:\r\n    type: com.zaxxer.hikari.HikariDataSource\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    username: root\r\n    password: 111111\r\n    url: jdbc:mysql://albedo-mysql:3306/albedo-cloud?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Shanghai\r\n\r\n', '65aca253bd8fe81d134f0a45fba631a5', '2019-12-13 17:53:57', '2020-06-02 09:30:34', NULL, '127.0.0.1', '', '', 'null', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (10, 'albedo-gateway-dev.yml', 'DEFAULT_GROUP', 'spring:\r\n  cloud:\r\n    gateway:\r\n      locator:\r\n        enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: albedo-auth\r\n          uri: lb://albedo-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            # 验证码处理\r\n            - ValidateCodeGatewayFilter\r\n            # 前端密码解密\r\n            - PasswordDecoderFilter\r\n        #系统管理 模块\r\n        - id: albedo-sys\r\n          uri: lb://albedo-sys\r\n          predicates:\r\n            - Path=/sys/**\r\n          filters:\r\n            # 限流配置\r\n            - name: RequestRateLimiter\r\n              args:\r\n                key-resolver: \'#{@remoteAddrKeyResolver}\'\r\n                redis-rate-limiter.replenishRate: 10\r\n                redis-rate-limiter.burstCapacity: 20\r\n              # 降级配置\r\n        #            - name: Hystrix\r\n        #              args:\r\n        #                name: default\r\n        #                fallbackUri: \'forward:/fallback\'\r\n        # 代码生成模块\r\n        - id: albedo-gen\r\n          uri: lb://albedo-gen\r\n          predicates:\r\n            - Path=/gen/**\r\n        # 任务调度模块\r\n        - id: albedo-quartz\r\n          uri: lb://albedo-quartz\r\n          predicates:\r\n            - Path=/quartz/**\r\n\r\n    sentinel:\r\n      # datasource.ds2.file:\r\n      #   file: \"classpath: gateway.json\"\r\n      #   ruleType: gw-flow\r\n      # datasource.ds1.file:\r\n      #   file: \"classpath: api.json\"\r\n      #   ruleType: gw-api-group\r\n      transport:\r\n        dashboard: 127.0.0.1:8858\r\n      filter:\r\n        enabled: true\r\n      scg.fallback:\r\n          mode: response\r\n          response-status: 444\r\n          response-body: 1234\r\n      scg:\r\n        order: -100\r\nsecurity:\r\n  encode:\r\n    # 前端密码密钥，必须16位\r\n    key: \'somewhere-albedo\'\r\n\r\n# 不校验验证码终端\r\nignore:\r\n  clients:\r\n    - swagger\r\n', '31ba0fa6c588872cf0fa56956df0008d', '2019-12-13 17:54:26', '2019-12-13 17:54:26', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, 'yaml', NULL);
INSERT INTO `config_info` VALUES (11, 'albedo-gen-dev.yml', 'DEFAULT_GROUP', '## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: ENC(FGKBtFgGcI+XAg5c+7EAJg==)\r\n      client-secret: ENC(PE5+ODGIk7rfbiaZXHVhow==)\r\n      scope: server\r\n\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.zaxxer.hikari.HikariDataSource\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    username: root\r\n    password: 111111\r\n    url: jdbc:mysql://albedo-mysql:3306/albedo-cloud?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Shanghai\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/\r\n\r\n# 直接放行URL\r\nignore:\r\n  urls:\r\n    - /v2/**\r\n    - /actuator/**\r\n', '4f8316a85099f352cf83565175fa20ac', '2019-12-13 17:54:43', '2019-12-13 17:54:43', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, 'yaml', NULL);
INSERT INTO `config_info` VALUES (12, 'albedo-monitor-dev.yml', 'DEFAULT_GROUP', 'spring:\r\n  # 安全配置\r\n  security:\r\n    user:\r\n      name: ENC(ToJTk3p6JF+h0gsHeHVRoQ==)     # albedo\r\n      password: ENC(sGfB6KY7Zq0BTfwbWYxnWw==) # albedo\r\n', 'c9e2b0633b44d33b37beb14a7f3dc501', '2019-12-13 17:54:58', '2019-12-13 17:54:58', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, 'yaml', NULL);
INSERT INTO `config_info` VALUES (13, 'albedo-quartz-dev.yml', 'DEFAULT_GROUP', '## spring security 配置\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: ENC(FGKBtFgGcI+XAg5c+7EAJg==)\r\n      client-secret: ENC(PE5+ODGIk7rfbiaZXHVhow==)\r\n      scope: server\r\n\r\n# 数据源配置\r\nspring:\r\n  datasource:\r\n    type: com.zaxxer.hikari.HikariDataSource\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    username: root\r\n    password: 111111\r\n    url: jdbc:mysql://albedo-mysql:3306/albedo-cloud?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Shanghai\r\n  resources:\r\n    static-locations: classpath:/static/,classpath:/views/\r\n\r\n# 直接放行URL\r\nignore:\r\n  urls:\r\n    - /v2/**\r\n    - /actuator/**\r\n', '4f8316a85099f352cf83565175fa20ac', '2019-12-13 17:55:19', '2019-12-13 17:55:19', NULL, '0:0:0:0:0:0:0:1', '', '', NULL, NULL, NULL, 'yaml', NULL);
INSERT INTO `config_info` VALUES (14, 'albedo-sys-dev.yml', 'DEFAULT_GROUP', 'dubbo:\r\n  cloud:\r\n    # The subscribed services in consumer side\r\n    subscribed-services: albedo-auth\r\n# 直接放行URL\r\nignore:\r\n  urls:\r\n    - /v2/**\r\n    - /actuator/**\r\n    - /user/info/*\r\n    - /menu/gen\r\n    - /dict/all\r\n    - /log-operate/**\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: ENC(WJRDLZlPlWkmLu/d+gkeAw==)\r\n      client-secret: ENC(gyOtaeY+fxP8/Rkd3PKm8Q==)\r\n      scope: server\r\n\r\n# 数据源\r\nspring:\r\n  datasource:\r\n    type: com.zaxxer.hikari.HikariDataSource\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    username: root\r\n    password: 111111\r\n    url: jdbc:mysql://albedo-mysql:3306/albedo-cloud?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&allowMultiQueries=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Shanghai&allowPublicKeyRetrieval=true\r\n\r\n\r\n\r\n', '5163a8104fe0326a3b11f5c24200064e', '2019-12-13 17:56:02', '2020-06-02 09:31:32', NULL, '127.0.0.1', '', '', 'null', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (15, 'albedo-sys-prod.yml', 'DEFAULT_GROUP', 'dubbo:\r\n  cloud:\r\n    # The subscribed services in consumer side\r\n    subscribed-services: albedo-auth\r\n# 直接放行URL\r\nignore:\r\n  urls:\r\n    - /v2/**\r\n    - /actuator/**\r\n    - /user/info/*\r\n    - /menu/gen\r\n    - /dict/all\r\n    - /log-operate/**\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: ENC(WJRDLZlPlWkmLu/d+gkeAw==)\r\n      client-secret: ENC(gyOtaeY+fxP8/Rkd3PKm8Q==)\r\n      scope: server\r\n\r\n# 数据源\r\nspring:\r\n  datasource:\r\n    type: com.zaxxer.hikari.HikariDataSource\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    username: root\r\n    password: 111111\r\n    url: jdbc:mysql://albedo-mysql:3306/albedo-cloud?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&allowMultiQueries=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Shanghai\r\n\r\n\r\n\r\n', '85624bf00c4775d3ea3e89ba8f7712fa', '2019-12-13 17:56:30', '2020-06-02 09:31:43', NULL, '127.0.0.1', '', '', 'null', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (16, 'application-dev.yml', 'DEFAULT_GROUP', '# 加解密根密码\njasypt:\n  encryptor:\n    password: albedo #根密码\n\n\ndubbo:\n  scan:\n    base-packages: com.albedo.java.*\n  protocols:\n    dubbo:\n      name: dubbo\n      port: -1\n  registry:\n    #   The Spring Cloud Dubbo\'s registry extension\n    ##  the default value of dubbo-provider-services is \"*\", that means to subscribe all providers,\n    ##  thus it\'s optimized if subscriber specifies the required providers.\n    address: spring-cloud://localhost\n  cloud:\n    # The subscribed services in consumer side\n    subscribed-services: albedo-sys\n\n# Spring 相关\nspring:\n  redis:\n    password:\n    host: albedo-redis\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n\n# feign 配置\nfeign:\n  hystrix:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n\n# hystrix 配置\nhystrix:\n  command:\n    default:\n      execution:\n        isolation:\n          strategy: SEMAPHORE\n          thread:\n            timeoutInMilliseconds: 60000\n  shareSecurityContext: true\n\n#请求处理的超时时间\nribbon:\n  ReadTimeout: 10000\n  ConnectTimeout: 10000\n\n# mybaits-plus配置\nmybatis-plus:\n  mapper-locations: classpath:/mapper/*/*Mapper.xml\n  global-config:\n    banner: false\n    db-config:\n      id-type: UUID\n      field-strategy: NOT_NULL\n      table-underline: true\n      logic-delete-value: 1\n      logic-not-delete-value: 0\n  configuration:\n    map-underscore-to-camel-case: true\n\n# spring security 配置\nsecurity:\n  oauth2:\n    resource:\n      loadBalanced: true\n      token-info-uri: http://albedo-auth:4000/oauth/check_token\n\n# ===================================================================\n# Albedo specific properties\n# ===================================================================\n\napplication:\n  developMode: true\n  address-enabled: true\n  logPath: target/logs\n  static-file-directory: \n    mac: ~/albedo-file\n    linux: /home/albedo/file/\n    win: C:\\albedo\\file\\\n  cors: #By default CORS are not enabled. Uncomment to enable.\n    allowed-origins: \"*\"\n    allowed-methods: \"*\"\n    allowed-headers: \"*\"\n    exposed-headers: \"Authorization,Link,X-Total-Count\"\n    allow-credentials: true\n    max-age: 1800\n  swagger:\n    default-include-pattern: /.*\n    title: ${spring.application.name} API\n    description: ${spring.application.name} API documentation\n    version: 0.0.1\n    termsOfServiceUrl:\n    contactName:\n    contactUrl:\n    contactEmail:\n    license:\n    licenseUrl:\n    oauthServer: /auth/oauth/token', 'f71ef9293e49992d0288160b4fb6b90c', '2019-12-14 10:14:03', '2020-06-15 10:15:43', NULL, '127.0.0.1', '', '', 'null', 'null', 'null', 'yaml', 'null');
COMMIT;

-- ----------------------------
-- Table structure for config_info_aggr
-- ----------------------------
DROP TABLE IF EXISTS `config_info_aggr`;
CREATE TABLE `config_info_aggr` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) DEFAULT NULL,
  `group_id` varchar(128) DEFAULT NULL,
  `datum_id` varchar(255) DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) DEFAULT NULL,
  `tenant_id` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_configinfoaggr_datagrouptenantdatum` (`data_id`,`group_id`,`tenant_id`,`datum_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='增加租户字段';

-- ----------------------------
-- Records of config_info_aggr
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for config_info_beta
-- ----------------------------
DROP TABLE IF EXISTS `config_info_beta`;
CREATE TABLE `config_info_beta` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) DEFAULT NULL,
  `group_id` varchar(128) DEFAULT NULL,
  `app_name` varchar(128) DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) DEFAULT NULL,
  `md5` varchar(32) DEFAULT NULL,
  `gmt_create` datetime NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '修改时间',
  `src_user` mediumtext,
  `src_ip` varchar(20) DEFAULT NULL,
  `tenant_id` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_configinfobeta_datagrouptenant` (`data_id`,`group_id`,`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='config_info_beta';

-- ----------------------------
-- Records of config_info_beta
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for config_info_tag
-- ----------------------------
DROP TABLE IF EXISTS `config_info_tag`;
CREATE TABLE `config_info_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) DEFAULT NULL,
  `group_id` varchar(128) DEFAULT NULL,
  `tenant_id` varchar(128) DEFAULT NULL,
  `tag_id` varchar(128) DEFAULT NULL,
  `app_name` varchar(128) DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) DEFAULT NULL,
  `gmt_create` datetime NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '修改时间',
  `src_user` mediumtext,
  `src_ip` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_configinfotag_datagrouptenanttag` (`data_id`,`group_id`,`tenant_id`,`tag_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='config_info_tag';

-- ----------------------------
-- Records of config_info_tag
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for config_tags_relation
-- ----------------------------
DROP TABLE IF EXISTS `config_tags_relation`;
CREATE TABLE `config_tags_relation` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `tag_name` varchar(128) DEFAULT NULL,
  `tag_type` varchar(64) DEFAULT NULL,
  `data_id` varchar(255) DEFAULT NULL,
  `group_id` varchar(128) DEFAULT NULL,
  `tenant_id` varchar(128) DEFAULT NULL,
  `nid` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`) USING BTREE,
  UNIQUE KEY `uk_configtagrelation_configidtag` (`id`,`tag_name`,`tag_type`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='config_tag_relation';

-- ----------------------------
-- Records of config_tags_relation
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for group_capacity
-- ----------------------------
DROP TABLE IF EXISTS `group_capacity`;
CREATE TABLE `group_capacity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) DEFAULT NULL,
  `quota` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='集群、各Group容量信息表';

-- ----------------------------
-- Records of group_capacity
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for his_config_info
-- ----------------------------
DROP TABLE IF EXISTS `his_config_info`;
CREATE TABLE `his_config_info` (
  `id` bigint(64) unsigned NOT NULL,
  `nid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) DEFAULT NULL,
  `group_id` varchar(128) DEFAULT NULL,
  `app_name` varchar(128) DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `md5` varchar(32) DEFAULT NULL,
  `gmt_create` datetime NOT NULL DEFAULT '2010-05-05 00:00:00',
  `gmt_modified` datetime NOT NULL DEFAULT '2010-05-05 00:00:00',
  `src_user` mediumtext,
  `src_ip` varchar(20) DEFAULT NULL,
  `op_type` char(10) DEFAULT NULL,
  `tenant_id` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`nid`) USING BTREE,
  KEY `idx_gmt_create` (`gmt_create`) USING BTREE,
  KEY `idx_gmt_modified` (`gmt_modified`) USING BTREE,
  KEY `idx_did` (`data_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='多租户改造';

-- ----------------------------
-- Records of his_config_info
-- ----------------------------
BEGIN;
INSERT INTO `his_config_info` VALUES (16, 1, 'application-dev.yml', 'DEFAULT_GROUP', '', '# 加解密根密码\njasypt:\n  encryptor:\n    password: albedo #根密码\n\n\ndubbo:\n  scan:\n    base-packages: com.albedo.java.*\n  protocols:\n    dubbo:\n      name: dubbo\n      port: -1\n  registry:\n    #   The Spring Cloud Dubbo\'s registry extension\n    ##  the default value of dubbo-provider-services is \"*\", that means to subscribe all providers,\n    ##  thus it\'s optimized if subscriber specifies the required providers.\n    address: spring-cloud://localhost\n  cloud:\n    # The subscribed services in consumer side\n    subscribed-services: albedo-sys,albedo-auth\n\n# Spring 相关\nspring:\n  redis:\n    password:\n    host: albedo-redis\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n\n# feign 配置\nfeign:\n  hystrix:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n\n# hystrix 配置\nhystrix:\n  command:\n    default:\n      execution:\n        isolation:\n          strategy: SEMAPHORE\n          thread:\n            timeoutInMilliseconds: 60000\n  shareSecurityContext: true\n\n#请求处理的超时时间\nribbon:\n  ReadTimeout: 10000\n  ConnectTimeout: 10000\n\n# mybaits-plus配置\nmybatis-plus:\n  mapper-locations: classpath:/mapper/*/*Mapper.xml\n  global-config:\n    banner: false\n    db-config:\n      id-type: UUID\n      field-strategy: NOT_NULL\n      table-underline: true\n      logic-delete-value: 1\n      logic-not-delete-value: 0\n  configuration:\n    map-underscore-to-camel-case: true\n\n# spring security 配置\nsecurity:\n  oauth2:\n    resource:\n      loadBalanced: true\n      token-info-uri: http://albedo-auth:4000/oauth/check_token\n\n# ===================================================================\n# Albedo specific properties\n# ===================================================================\n\napplication:\n  developMode: true\n  address-enabled: true\n  logPath: target/logs\n  static-file-directory: D:/albedo-cloud-file\n  cors: #By default CORS are not enabled. Uncomment to enable.\n    allowed-origins: \"*\"\n    allowed-methods: \"*\"\n    allowed-headers: \"*\"\n    exposed-headers: \"Authorization,Link,X-Total-Count\"\n    allow-credentials: true\n    max-age: 1800\n  swagger:\n    default-include-pattern: /.*\n    title: ${spring.application.name} API\n    description: ${spring.application.name} API documentation\n    version: 0.0.1\n    termsOfServiceUrl:\n    contactName:\n    contactUrl:\n    contactEmail:\n    license:\n    licenseUrl:\n    oauthServer: /auth/oauth/token', 'a4aab798bdebdad032b21176ad7dddd0', '2010-05-05 00:00:00', '2020-06-02 09:26:56', NULL, '127.0.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (9, 2, 'albedo-auth-dev.yml', 'DEFAULT_GROUP', '', '# 数据源\r\nspring:\r\n  datasource:\r\n    type: com.zaxxer.hikari.HikariDataSource\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    username: root\r\n    password: 111111\r\n    url: jdbc:mysql://albedo-mysql:3306/albedo-cloud?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Shanghai\r\n\r\n', '65aca253bd8fe81d134f0a45fba631a5', '2010-05-05 00:00:00', '2020-06-02 09:28:11', NULL, '127.0.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (9, 3, 'albedo-auth-dev.yml', 'DEFAULT_GROUP', '', 'dubbo:\r\n  cloud:\r\n    # The subscribed services in consumer side\r\n    subscribed-services: albedo-sys\r\n# 数据源\r\nspring:\r\n  datasource:\r\n    type: com.zaxxer.hikari.HikariDataSource\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    username: root\r\n    password: 111111\r\n    url: jdbc:mysql://albedo-mysql:3306/albedo-cloud?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Shanghai\r\n\r\n', 'c719a56fb6956007d671ba263e968362', '2010-05-05 00:00:00', '2020-06-02 09:30:34', NULL, '127.0.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (16, 4, 'application-dev.yml', 'DEFAULT_GROUP', '', '# 加解密根密码\njasypt:\n  encryptor:\n    password: albedo #根密码\n\n\ndubbo:\n  scan:\n    base-packages: com.albedo.java.*\n  protocols:\n    dubbo:\n      name: dubbo\n      port: -1\n  registry:\n    #   The Spring Cloud Dubbo\'s registry extension\n    ##  the default value of dubbo-provider-services is \"*\", that means to subscribe all providers,\n    ##  thus it\'s optimized if subscriber specifies the required providers.\n    address: spring-cloud://localhost\n\n# Spring 相关\nspring:\n  redis:\n    password:\n    host: albedo-redis\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n\n# feign 配置\nfeign:\n  hystrix:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n\n# hystrix 配置\nhystrix:\n  command:\n    default:\n      execution:\n        isolation:\n          strategy: SEMAPHORE\n          thread:\n            timeoutInMilliseconds: 60000\n  shareSecurityContext: true\n\n#请求处理的超时时间\nribbon:\n  ReadTimeout: 10000\n  ConnectTimeout: 10000\n\n# mybaits-plus配置\nmybatis-plus:\n  mapper-locations: classpath:/mapper/*/*Mapper.xml\n  global-config:\n    banner: false\n    db-config:\n      id-type: UUID\n      field-strategy: NOT_NULL\n      table-underline: true\n      logic-delete-value: 1\n      logic-not-delete-value: 0\n  configuration:\n    map-underscore-to-camel-case: true\n\n# spring security 配置\nsecurity:\n  oauth2:\n    resource:\n      loadBalanced: true\n      token-info-uri: http://albedo-auth:4000/oauth/check_token\n\n# ===================================================================\n# Albedo specific properties\n# ===================================================================\n\napplication:\n  developMode: true\n  address-enabled: true\n  logPath: target/logs\n  static-file-directory: D:/albedo-cloud-file\n  cors: #By default CORS are not enabled. Uncomment to enable.\n    allowed-origins: \"*\"\n    allowed-methods: \"*\"\n    allowed-headers: \"*\"\n    exposed-headers: \"Authorization,Link,X-Total-Count\"\n    allow-credentials: true\n    max-age: 1800\n  swagger:\n    default-include-pattern: /.*\n    title: ${spring.application.name} API\n    description: ${spring.application.name} API documentation\n    version: 0.0.1\n    termsOfServiceUrl:\n    contactName:\n    contactUrl:\n    contactEmail:\n    license:\n    licenseUrl:\n    oauthServer: /auth/oauth/token', 'b0b00a397185c516cdc2c7c58067e52c', '2010-05-05 00:00:00', '2020-06-02 09:31:03', NULL, '127.0.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (14, 5, 'albedo-sys-dev.yml', 'DEFAULT_GROUP', '', '# 直接放行URL\r\nignore:\r\n  urls:\r\n    - /v2/**\r\n    - /actuator/**\r\n    - /user/info/*\r\n    - /menu/gen\r\n    - /dict/all\r\n    - /log-operate/**\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: ENC(WJRDLZlPlWkmLu/d+gkeAw==)\r\n      client-secret: ENC(gyOtaeY+fxP8/Rkd3PKm8Q==)\r\n      scope: server\r\n\r\n# 数据源\r\nspring:\r\n  datasource:\r\n    type: com.zaxxer.hikari.HikariDataSource\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    username: root\r\n    password: 111111\r\n    url: jdbc:mysql://albedo-mysql:3306/albedo-cloud?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&allowMultiQueries=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Shanghai&allowPublicKeyRetrieval=true\r\n\r\n\r\n\r\n', '86d0bbcd276a8e60f5d20b6f9d37077b', '2010-05-05 00:00:00', '2020-06-02 09:31:32', NULL, '127.0.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (15, 6, 'albedo-sys-prod.yml', 'DEFAULT_GROUP', '', '# 直接放行URL\r\nignore:\r\n  urls:\r\n    - /v2/**\r\n    - /actuator/**\r\n    - /user/info/*\r\n    - /menu/gen\r\n    - /dict/all\r\n    - /log-operate/**\r\nsecurity:\r\n  oauth2:\r\n    client:\r\n      client-id: ENC(WJRDLZlPlWkmLu/d+gkeAw==)\r\n      client-secret: ENC(gyOtaeY+fxP8/Rkd3PKm8Q==)\r\n      scope: server\r\n\r\n# 数据源\r\nspring:\r\n  datasource:\r\n    type: com.zaxxer.hikari.HikariDataSource\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    username: root\r\n    password: 111111\r\n    url: jdbc:mysql://albedo-mysql:3306/albedo-cloud?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&allowMultiQueries=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Shanghai\r\n\r\n\r\n\r\n', 'cd670110833dc2c826b757cbb208b2d1', '2010-05-05 00:00:00', '2020-06-02 09:31:43', NULL, '127.0.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (16, 7, 'application-dev.yml', 'DEFAULT_GROUP', '', '# 加解密根密码\njasypt:\n  encryptor:\n    password: albedo #根密码\n\n\ndubbo:\n  scan:\n    base-packages: com.albedo.java.*\n  protocols:\n    dubbo:\n      name: dubbo\n      port: -1\n  registry:\n    #   The Spring Cloud Dubbo\'s registry extension\n    ##  the default value of dubbo-provider-services is \"*\", that means to subscribe all providers,\n    ##  thus it\'s optimized if subscriber specifies the required providers.\n    address: spring-cloud://localhost\n  cloud:\n    # The subscribed services in consumer side\n    subscribed-services: albedo-sys\n\n# Spring 相关\nspring:\n  redis:\n    password:\n    host: albedo-redis\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n\n# feign 配置\nfeign:\n  hystrix:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n\n# hystrix 配置\nhystrix:\n  command:\n    default:\n      execution:\n        isolation:\n          strategy: SEMAPHORE\n          thread:\n            timeoutInMilliseconds: 60000\n  shareSecurityContext: true\n\n#请求处理的超时时间\nribbon:\n  ReadTimeout: 10000\n  ConnectTimeout: 10000\n\n# mybaits-plus配置\nmybatis-plus:\n  mapper-locations: classpath:/mapper/*/*Mapper.xml\n  global-config:\n    banner: false\n    db-config:\n      id-type: UUID\n      field-strategy: NOT_NULL\n      table-underline: true\n      logic-delete-value: 1\n      logic-not-delete-value: 0\n  configuration:\n    map-underscore-to-camel-case: true\n\n# spring security 配置\nsecurity:\n  oauth2:\n    resource:\n      loadBalanced: true\n      token-info-uri: http://albedo-auth:4000/oauth/check_token\n\n# ===================================================================\n# Albedo specific properties\n# ===================================================================\n\napplication:\n  developMode: true\n  address-enabled: true\n  logPath: target/logs\n  static-file-directory: D:/albedo-cloud-file\n  cors: #By default CORS are not enabled. Uncomment to enable.\n    allowed-origins: \"*\"\n    allowed-methods: \"*\"\n    allowed-headers: \"*\"\n    exposed-headers: \"Authorization,Link,X-Total-Count\"\n    allow-credentials: true\n    max-age: 1800\n  swagger:\n    default-include-pattern: /.*\n    title: ${spring.application.name} API\n    description: ${spring.application.name} API documentation\n    version: 0.0.1\n    termsOfServiceUrl:\n    contactName:\n    contactUrl:\n    contactEmail:\n    license:\n    licenseUrl:\n    oauthServer: /auth/oauth/token', '7a145cae10cc402c223f2d24f2c493d3', '2010-05-05 00:00:00', '2020-06-15 10:15:43', NULL, '127.0.0.1', 'U', '');
COMMIT;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `username` varchar(50) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of roles
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for tenant_capacity
-- ----------------------------
DROP TABLE IF EXISTS `tenant_capacity`;
CREATE TABLE `tenant_capacity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) DEFAULT NULL,
  `quota` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数',
  `max_aggr_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='租户容量信息表';

-- ----------------------------
-- Records of tenant_capacity
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for tenant_info
-- ----------------------------
DROP TABLE IF EXISTS `tenant_info`;
CREATE TABLE `tenant_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) DEFAULT NULL,
  `tenant_id` varchar(128) DEFAULT NULL,
  `tenant_name` varchar(128) DEFAULT NULL,
  `tenant_desc` varchar(256) DEFAULT NULL,
  `create_source` varchar(32) DEFAULT NULL,
  `gmt_create` bigint(20) NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint(20) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_tenant_info_kptenantid` (`kp`,`tenant_id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='tenant_info';

-- ----------------------------
-- Records of tenant_info
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `password` varchar(500) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES ('nacos', '$2a$10$1fXDf9q5CKAA.Fe4rjTzzONGDI4cXFvMfPx9Yribr9OQC2.JDe/wK', 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
