CREATE SCHEMA IF NOT EXISTS `employee_schema`;

USE `employee_schema`;

CREATE TABLE `employees` (
  `employeeId` VARCHAR(10) NOT NULL,
  `workEmail` VARCHAR(255) NOT NULL UNIQUE,
  `firstName` VARCHAR(100) NOT NULL,
  `lastName` VARCHAR(100) NOT NULL,
  `jobRole` VARCHAR(100) NOT NULL,
  `employeeThumbnail` VARCHAR(255) NULL,
  `created_on` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `created_by` varchar(100) NOT NULL DEFAULT 'system',
  `updated_on` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `updated_by` varchar(100) NOT NULL DEFAULT 'system',
  PRIMARY KEY (`employeeId`)
);

-- Insert sample data
LOCK TABLES `employees` WRITE;
INSERT INTO `employees` VALUES 
('LK01', 'john@wso2.com', 'John', 'Smith', 'Software Engineer', 'https://xsgames.co/randomusers/assets/avatars/male/42.jpg', NOW(6), 'system', NOW(6), 'system'),
('LK02', 'jane@wso2.com', 'Jane', 'Doe', 'Senior Software Engineer', 'https://xsgames.co/randomusers/assets/avatars/female/19.jpg', NOW(6), 'system', NOW(6), 'system'),
('LK03', 'bob@wso2.com', 'Bob', 'Johnson', 'Tech Lead', 'https://xsgames.co/randomusers/assets/avatars/male/62.jpg', NOW(6), 'system', NOW(6), 'system'),
('LK04', 'alice@wso2.com', 'Alice', 'Brown', 'QA Engineer', 'https://xsgames.co/randomusers/assets/avatars/female/64.jpg', NOW(6), 'system', NOW(6), 'system'),
('LK05', 'sam@wso2.com', 'Sam', 'Wilson', 'DevOps Engineer', 'https://xsgames.co/randomusers/assets/avatars/male/66.jpg', NOW(6), 'system', NOW(6), 'system');
UNLOCK TABLES;