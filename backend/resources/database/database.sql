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
('LK01', 'john@wso2.com', 'John', 'Smith', 'Software Engineer', 'https://abcd.com/john.jpg', NOW(6), 'system', NOW(6), 'system'),
('LK02', 'jane@wso2.com', 'Jane', 'Doe', 'Senior Software Engineer', 'https://abcd.com/jane.jpg', NOW(6), 'system', NOW(6), 'system'),
('LK03', 'bob@wso2.com', 'Bob', 'Johnson', 'Tech Lead', 'https://abcd.com/bob.jpg', NOW(6), 'system', NOW(6), 'system'),
('LK04', 'alice@wso2.com', 'Alice', 'Brown', 'QA Engineer', 'https://abcd.com/alice.jpg', NOW(6), 'system', NOW(6), 'system'),
('LK05', 'sam@wso2.com', 'Sam', 'Wilson', 'DevOps Engineer', 'https://abcd.com/sam.jpg', NOW(6), 'system', NOW(6), 'system');
UNLOCK TABLES;