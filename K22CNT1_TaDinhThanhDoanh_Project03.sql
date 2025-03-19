-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th3 19, 2025 lúc 05:28 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `mydatabase`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tdtdattendance`
--

CREATE TABLE `tdtdattendance` (
  `TdtdAttendanceId` int(11) NOT NULL,
  `TdtdEmployeeId` int(11) NOT NULL,
  `TdtdDate` date NOT NULL,
  `TdtdClockIn` time DEFAULT NULL,
  `TdtdClockOut` time DEFAULT NULL,
  `TdtdStatus` enum('Đi làm','Vắng mặt','Nghỉ phép') DEFAULT 'Đi làm',
  `TdtdIsDeleted` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tdtdattendance`
--

INSERT INTO `tdtdattendance` (`TdtdAttendanceId`, `TdtdEmployeeId`, `TdtdDate`, `TdtdClockIn`, `TdtdClockOut`, `TdtdStatus`, `TdtdIsDeleted`) VALUES
(1, 1, '2025-03-01', '08:00:00', '17:00:00', 'Vắng mặt', 0),
(2, 5, '2025-03-06', '08:15:00', '17:30:00', 'Nghỉ phép', 0),
(3, 3, '2025-03-01', '17:39:00', '17:39:00', 'Nghỉ phép', 0),
(4, 2, '2025-03-07', '15:35:00', '11:44:00', 'Đi làm', 0),
(5, 1, '2025-03-14', NULL, NULL, 'Vắng mặt', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tdtddepartment`
--

CREATE TABLE `tdtddepartment` (
  `TdtdDepartmentId` int(11) NOT NULL,
  `TdtdDepartmentName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TdtdDescription` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `TdtdIsDeleted` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tdtddepartment`
--

INSERT INTO `tdtddepartment` (`TdtdDepartmentId`, `TdtdDepartmentName`, `TdtdDescription`, `TdtdIsDeleted`) VALUES
(1, 'Phòng Nhân sự', 'Quản lý nhân sự và tuyển dụng phò cho công ty', 0),
(2, 'Phòng Kỹ thuật', 'Phát triển và bảo trì hệ thống', 0),
(3, 'Phòng Kinh doanh', 'Quản lý bán hàng và khách hàng', 1),
(4, 'Phòng Họp Khẩn', 'Vô cùng cấp bách', 0),
(5, 'Phòng Ý Tưởng', 'Đầu to', 0),
(6, 'Ăn hại', 'Ăn hại', 0),
(7, 'Xin chào mấy con vợ', 'hehe', 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tdtdemployee`
--

CREATE TABLE `tdtdemployee` (
  `TdtdEmployeeId` int(11) NOT NULL,
  `TdtdDepartmentId` int(11) DEFAULT NULL,
  `TdtdPositionId` int(11) DEFAULT NULL,
  `TdtdFullName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TdtdDateOfBirth` date NOT NULL,
  `TdtdGender` enum('Nam','Nữ','Khác') DEFAULT NULL,
  `TdtdPhoneNumber` varchar(15) NOT NULL,
  `TdtdEmail` varchar(100) DEFAULT NULL,
  `TdtdHireDate` date NOT NULL,
  `TdtdStatus` enum('Đang làm việc','Đã nghỉ việc','Tạm nghỉ') DEFAULT 'Đang làm việc',
  `TdtdIsDeleted` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tdtdemployee`
--

INSERT INTO `tdtdemployee` (`TdtdEmployeeId`, `TdtdDepartmentId`, `TdtdPositionId`, `TdtdFullName`, `TdtdDateOfBirth`, `TdtdGender`, `TdtdPhoneNumber`, `TdtdEmail`, `TdtdHireDate`, `TdtdStatus`, `TdtdIsDeleted`) VALUES
(1, 4, 3, 'Vua Trò Chơi', '2004-04-21', 'Nam', '0967055032', 'doanhdoe@gmail.com', '2020-01-17', 'Đang làm việc', 0),
(2, 4, 5, 'Trần Thị Bé', '1990-07-22', 'Nữ', '0912345678', 'be.tran@example.com', '2021-05-20', 'Đã nghỉ việc', 0),
(3, 3, 2, 'Lê Văn Cường', '1995-11-30', 'Nam', '0923456789', 'cuong.le@example.com', '2022-03-15', 'Tạm nghỉ', 0),
(4, 1, 1, 'Tạ Đình Thành Doanh', '2025-03-06', 'Khác', '0967055032', 'doanhdoe@gmail.com', '2025-03-14', 'Đang làm việc', 0),
(5, 3, 3, 'Joestar Johnny', '2025-03-06', 'Nam', '0967055032', 'doanhdoe@gmail.com', '2025-03-06', 'Đang làm việc', 0),
(6, 6, 5, 'Hán Thị Anh Thư', '2006-11-22', 'Nữ', '0000000000', 'doanhdoe@gmail.com', '2025-03-13', 'Đã nghỉ việc', 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tdtdgreenproject`
--

CREATE TABLE `tdtdgreenproject` (
  `TdtdProjectId` int(11) NOT NULL,
  `TdtdProjectName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TdtdLocation` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TdtdStartDate` date NOT NULL,
  `TdtdEndDate` date DEFAULT NULL,
  `TdtdStatus` enum('Chuẩn bị','Đang thực hiện','Hoàn thành','Tạm dừng') DEFAULT 'Chuẩn bị',
  `TdtdIsDeleted` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tdtdgreenproject`
--

INSERT INTO `tdtdgreenproject` (`TdtdProjectId`, `TdtdProjectName`, `TdtdLocation`, `TdtdStartDate`, `TdtdEndDate`, `TdtdStatus`, `TdtdIsDeleted`) VALUES
(1, 'Dự án trồng cây đô thị', 'Quận 1, TP.HCM', '2023-01-01', '2023-12-31', 'Hoàn thành', 0),
(2, 'Dự án rừng phòng hộ', 'Bình Thuận', '2022-06-01', '2024-06-01', 'Đang thực hiện', 0),
(3, 'Vườn địa đàng', 'Cần Thơ', '2023-03-01', '2025-03-07', 'Tạm dừng', 0),
(4, 'Tên lựa đạn đạo siêu khủng khiếp', 'Hà Nội', '2025-03-06', '2025-03-15', 'Chuẩn bị', 0),
(5, 'Tên lựa đạn đạo siêu khủng khiếp', 'Hà Nội', '2025-03-06', '2025-03-06', 'Tạm dừng', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tdtdposition`
--

CREATE TABLE `tdtdposition` (
  `TdtdPositionId` int(11) NOT NULL,
  `TdtdPositionName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TdtdSalaryBase` decimal(12,2) NOT NULL,
  `TdtdIsDeleted` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tdtdposition`
--

INSERT INTO `tdtdposition` (`TdtdPositionId`, `TdtdPositionName`, `TdtdSalaryBase`, `TdtdIsDeleted`) VALUES
(1, 'Quản lý', 15000000.00, 0),
(2, 'Nhân viên', 8000000.00, 0),
(3, 'Kỹ thuật viên', 10000000.00, 0),
(4, 'Vua Trò Chơi', 10000000.00, 1),
(5, 'Đào mỏ', 123456789.00, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tdtdprojectassignment`
--

CREATE TABLE `tdtdprojectassignment` (
  `TdtdAssignmentId` int(11) NOT NULL,
  `TdtdProjectId` int(11) NOT NULL,
  `TdtdEmployeeId` int(11) NOT NULL,
  `TdtdRole` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TdtdStartDate` date NOT NULL,
  `TdtdEndDate` date DEFAULT NULL,
  `TdtdIsDeleted` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tdtdprojectassignment`
--

INSERT INTO `tdtdprojectassignment` (`TdtdAssignmentId`, `TdtdProjectId`, `TdtdEmployeeId`, `TdtdRole`, `TdtdStartDate`, `TdtdEndDate`, `TdtdIsDeleted`) VALUES
(1, 1, 1, 'Quản lý dự án', '2023-01-01', '2023-12-31', 0),
(2, 3, 2, 'Kỹ thuật viên', '2023-01-01', '2023-12-31', 0),
(3, 2, 4, 'Nhân viên hỗ trợ', '2022-06-01', '2024-06-01', 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tdtdsalary`
--

CREATE TABLE `tdtdsalary` (
  `TdtdSalaryId` int(11) NOT NULL,
  `TdtdEmployeeId` int(11) NOT NULL,
  `TdtdMonth` tinyint(4) NOT NULL,
  `TdtdYear` smallint(6) NOT NULL,
  `TdtdBasicSalary` decimal(12,2) NOT NULL,
  `TdtdAllowance` decimal(12,2) DEFAULT 0.00,
  `TdtdBonus` decimal(12,2) DEFAULT 0.00,
  `TdtdFinalSalary` decimal(12,2) NOT NULL,
  `TdtdPaymentStatus` enum('Chưa thanh toán','Đã thanh toán') DEFAULT 'Chưa thanh toán',
  `TdtdIsDeleted` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tdtdsalary`
--

INSERT INTO `tdtdsalary` (`TdtdSalaryId`, `TdtdEmployeeId`, `TdtdMonth`, `TdtdYear`, `TdtdBasicSalary`, `TdtdAllowance`, `TdtdBonus`, `TdtdFinalSalary`, `TdtdPaymentStatus`, `TdtdIsDeleted`) VALUES
(1, 1, 2, 2025, 15000000.00, 2000000.00, 1000000.00, 18000000.00, 'Đã thanh toán', 0),
(2, 2, 5, 2025, 10000000.00, 1000000.00, 500000.00, 11500000.00, 'Chưa thanh toán', 0),
(3, 3, 2, 2025, 8000000.00, 500000.00, 0.00, 8500000.00, 'Chưa thanh toán', 0),
(4, 5, 4, 2025, 100000.00, 500000.00, 555555.00, 1155555.00, 'Đã thanh toán', 0),
(5, 4, 12, 2024, 1000000.00, 54736437.00, 321327863.00, 377064300.00, 'Chưa thanh toán', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tdtduser`
--

CREATE TABLE `tdtduser` (
  `TdtdUserId` int(11) NOT NULL,
  `TdtdEmployeeId` int(11) DEFAULT NULL,
  `TdtdUsername` varchar(50) NOT NULL,
  `TdtdPassword` varchar(255) NOT NULL,
  `TdtdRole` enum('Admin','Manager','HR','Employee') NOT NULL,
  `TdtdIsActive` tinyint(1) DEFAULT 1,
  `TdtdIsDeleted` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tdtduser`
--

INSERT INTO `tdtduser` (`TdtdUserId`, `TdtdEmployeeId`, `TdtdUsername`, `TdtdPassword`, `TdtdRole`, `TdtdIsActive`, `TdtdIsDeleted`) VALUES
(1, 1, 'admin', 'admin', 'Admin', 0, 0),
(2, 2, 'betran', 'password456', 'Employee', 1, 0),
(3, 3, 'cuongle', 'password789', 'Manager', 1, 0),
(4, 4, 'test01', 'test01', 'HR', 1, 0),
(5, 5, 'employee', 'employee', 'Employee', 1, 0),
(7, NULL, 'test02', 'test02', 'Employee', 1, 1);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `tdtdattendance`
--
ALTER TABLE `tdtdattendance`
  ADD PRIMARY KEY (`TdtdAttendanceId`),
  ADD UNIQUE KEY `TdtdUniqueEmployeeDate` (`TdtdEmployeeId`,`TdtdDate`);

--
-- Chỉ mục cho bảng `tdtddepartment`
--
ALTER TABLE `tdtddepartment`
  ADD PRIMARY KEY (`TdtdDepartmentId`);

--
-- Chỉ mục cho bảng `tdtdemployee`
--
ALTER TABLE `tdtdemployee`
  ADD PRIMARY KEY (`TdtdEmployeeId`),
  ADD KEY `TdtdDepartmentId` (`TdtdDepartmentId`),
  ADD KEY `TdtdPositionId` (`TdtdPositionId`);

--
-- Chỉ mục cho bảng `tdtdgreenproject`
--
ALTER TABLE `tdtdgreenproject`
  ADD PRIMARY KEY (`TdtdProjectId`);

--
-- Chỉ mục cho bảng `tdtdposition`
--
ALTER TABLE `tdtdposition`
  ADD PRIMARY KEY (`TdtdPositionId`);

--
-- Chỉ mục cho bảng `tdtdprojectassignment`
--
ALTER TABLE `tdtdprojectassignment`
  ADD PRIMARY KEY (`TdtdAssignmentId`),
  ADD KEY `TdtdProjectId` (`TdtdProjectId`),
  ADD KEY `TdtdEmployeeId` (`TdtdEmployeeId`);

--
-- Chỉ mục cho bảng `tdtdsalary`
--
ALTER TABLE `tdtdsalary`
  ADD PRIMARY KEY (`TdtdSalaryId`),
  ADD UNIQUE KEY `TdtdUniqueEmployeeMonthYear` (`TdtdEmployeeId`,`TdtdMonth`,`TdtdYear`);

--
-- Chỉ mục cho bảng `tdtduser`
--
ALTER TABLE `tdtduser`
  ADD PRIMARY KEY (`TdtdUserId`),
  ADD UNIQUE KEY `TdtdUsername` (`TdtdUsername`),
  ADD UNIQUE KEY `TdtdEmployeeId` (`TdtdEmployeeId`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `tdtdattendance`
--
ALTER TABLE `tdtdattendance`
  MODIFY `TdtdAttendanceId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `tdtddepartment`
--
ALTER TABLE `tdtddepartment`
  MODIFY `TdtdDepartmentId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `tdtdemployee`
--
ALTER TABLE `tdtdemployee`
  MODIFY `TdtdEmployeeId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `tdtdgreenproject`
--
ALTER TABLE `tdtdgreenproject`
  MODIFY `TdtdProjectId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `tdtdposition`
--
ALTER TABLE `tdtdposition`
  MODIFY `TdtdPositionId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `tdtdprojectassignment`
--
ALTER TABLE `tdtdprojectassignment`
  MODIFY `TdtdAssignmentId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `tdtdsalary`
--
ALTER TABLE `tdtdsalary`
  MODIFY `TdtdSalaryId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `tdtduser`
--
ALTER TABLE `tdtduser`
  MODIFY `TdtdUserId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `tdtdattendance`
--
ALTER TABLE `tdtdattendance`
  ADD CONSTRAINT `tdtdattendance_ibfk_1` FOREIGN KEY (`TdtdEmployeeId`) REFERENCES `tdtdemployee` (`TdtdEmployeeId`);

--
-- Các ràng buộc cho bảng `tdtdemployee`
--
ALTER TABLE `tdtdemployee`
  ADD CONSTRAINT `tdtdemployee_ibfk_1` FOREIGN KEY (`TdtdDepartmentId`) REFERENCES `tdtddepartment` (`TdtdDepartmentId`),
  ADD CONSTRAINT `tdtdemployee_ibfk_2` FOREIGN KEY (`TdtdPositionId`) REFERENCES `tdtdposition` (`TdtdPositionId`);

--
-- Các ràng buộc cho bảng `tdtdprojectassignment`
--
ALTER TABLE `tdtdprojectassignment`
  ADD CONSTRAINT `tdtdprojectassignment_ibfk_1` FOREIGN KEY (`TdtdProjectId`) REFERENCES `tdtdgreenproject` (`TdtdProjectId`),
  ADD CONSTRAINT `tdtdprojectassignment_ibfk_2` FOREIGN KEY (`TdtdEmployeeId`) REFERENCES `tdtdemployee` (`TdtdEmployeeId`);

--
-- Các ràng buộc cho bảng `tdtdsalary`
--
ALTER TABLE `tdtdsalary`
  ADD CONSTRAINT `tdtdsalary_ibfk_1` FOREIGN KEY (`TdtdEmployeeId`) REFERENCES `tdtdemployee` (`TdtdEmployeeId`);

--
-- Các ràng buộc cho bảng `tdtduser`
--
ALTER TABLE `tdtduser`
  ADD CONSTRAINT `tdtduser_ibfk_1` FOREIGN KEY (`TdtdEmployeeId`) REFERENCES `tdtdemployee` (`TdtdEmployeeId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
