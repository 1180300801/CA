DROP TABLE IF EXISTS `certificate`;
CREATE TABLE `certificate` (
                        `Id` int(11) NOT NULL AUTO_INCREMENT,
                        `username` varchar(255) DEFAULT NULL,
                        `version` varchar(255) DEFAULT 'CTF_1.0',
                        `issuer` varchar(255) DEFAULT 'CA of CTF',
                        `serial_Number` varchar(255) DEFAULT NULL,
                        `sign_Algorithm` varchar(255) DEFAULT 'sha1RSA',
                        `digest_Algorithm` varchar(255) DEFAULT 'SHA-256',
                        `organization` varchar(255) DEFAULT NULL,
                        `start_time` varchar(255) DEFAULT NULL,
                        `end_time` varchar(255) DEFAULT NULL,
                        `public_key` varchar(1024) DEFAULT NULL,
                        `sign` varchar(2048) DEFAULT NULL,
                        `file_path` varchar(255) DEFAULT NULL,
                        PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

#
# Data for table "user"
#

INSERT INTO `certificate` (username,serial_Number,organization, start_time, end_time, public_key, sign,file_path) VALUES ('ctf','123456789','448','2020/12/19','2021/12/19','go','first','null');
