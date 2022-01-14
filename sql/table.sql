-- seata_account,seata_repo,seata_order 三个数据库，每个数据库都要创建一个undo_log表
--  seata_repo.tbl_repo分布式建锁
CREATE TABLE `tbl_repo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `tbl_repo` (`id`, `product_code`, `name`, `count`) VALUES ('1', 'GP20220112', '华为手机', '5000');
INSERT INTO `tbl_repo` (`id`, `product_code`, `name`, `count`) VALUES ('2', 'GP20220113', '小米手机', '2000');
INSERT INTO `tbl_repo` (`id`, `product_code`, `name`, `count`) VALUES ('3', 'GP20200202002', '键盘', '400');
--  seata_account.tbl_account分布式建锁
CREATE TABLE `tbl_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) DEFAULT NULL,
  `balance` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `tbl_account` (`id`, `user_id`, `balance`) VALUES ('1', '2', '20000');
--  seata_order.tbl_order分布式建锁
CREATE TABLE `tbl_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `product_code` varchar(255) DEFAULT NULL,
  `count` int(11) DEFAULT '0',
  `amount` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- SEATA AT 模式需要 UNDO_LOG 表
CREATE TABLE `undo_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) NOT NULL,
  `xid` varchar(100) NOT NULL,
  `context` varchar(128) NOT NULL,
  `rollback_info` longblob NOT NULL,
  `log_status` int(11) NOT NULL,
  `log_created` datetime NOT NULL,
  `log_modified` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;