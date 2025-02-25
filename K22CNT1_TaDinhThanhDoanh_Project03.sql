-- Tạo bảng Phòng ban
CREATE TABLE TdtdDepartment (
    TdtdDepartmentId INT PRIMARY KEY AUTO_INCREMENT,
    TdtdDepartmentName NVARCHAR(100) NOT NULL,
    TdtdDescription NVARCHAR(255)
);

-- Tạo bảng Chức vụ
CREATE TABLE TdtdPosition (
    TdtdPositionId INT PRIMARY KEY AUTO_INCREMENT,
    TdtdPositionName NVARCHAR(100) NOT NULL,
    TdtdSalaryBase DECIMAL(12, 2) NOT NULL
);

-- Tạo bảng Nhân viên
CREATE TABLE TdtdEmployee (
    TdtdEmployeeId INT PRIMARY KEY AUTO_INCREMENT,
    TdtdDepartmentId INT,
    TdtdPositionId INT,
    TdtdFullName NVARCHAR(100) NOT NULL,
    TdtdDateOfBirth DATE NOT NULL,
    TdtdGender ENUM('Nam', 'Nữ', 'Khác'),
    TdtdPhoneNumber VARCHAR(15) NOT NULL,
    TdtdEmail VARCHAR(100),
    TdtdHireDate DATE NOT NULL,
    TdtdStatus ENUM('Đang làm việc', 'Đã nghỉ việc', 'Tạm nghỉ') DEFAULT 'Đang làm việc',
    FOREIGN KEY (TdtdDepartmentId) REFERENCES TdtdDepartment(TdtdDepartmentId),
    FOREIGN KEY (TdtdPositionId) REFERENCES TdtdPosition(TdtdPositionId)
);

-- Tạo bảng Dự án cây xanh
CREATE TABLE TdtdGreenProject (
    TdtdProjectId INT PRIMARY KEY AUTO_INCREMENT,
    TdtdProjectName NVARCHAR(200) NOT NULL,
    TdtdLocation NVARCHAR(255) NOT NULL,
    TdtdStartDate DATE NOT NULL,
    TdtdEndDate DATE,
    TdtdStatus ENUM('Chuẩn bị', 'Đang thực hiện', 'Hoàn thành', 'Tạm dừng') DEFAULT 'Chuẩn bị'
);

-- Tạo bảng Phân công dự án
CREATE TABLE TdtdProjectAssignment (
    TdtdAssignmentId INT PRIMARY KEY AUTO_INCREMENT,
    TdtdProjectId INT NOT NULL,
    TdtdEmployeeId INT NOT NULL,
    TdtdRole NVARCHAR(100) NOT NULL,
    TdtdStartDate DATE NOT NULL,
    TdtdEndDate DATE,
    FOREIGN KEY (TdtdProjectId) REFERENCES TdtdGreenProject(TdtdProjectId),
    FOREIGN KEY (TdtdEmployeeId) REFERENCES TdtdEmployee(TdtdEmployeeId)
);

-- Tạo bảng Chấm công
CREATE TABLE TdtdAttendance (
    TdtdAttendanceId INT PRIMARY KEY AUTO_INCREMENT,
    TdtdEmployeeId INT NOT NULL,
    TdtdDate DATE NOT NULL,
    TdtdClockIn TIME,
    TdtdClockOut TIME,
    TdtdStatus ENUM('Đi làm', 'Vắng mặt', 'Nghỉ phép') DEFAULT 'Đi làm',
    FOREIGN KEY (TdtdEmployeeId) REFERENCES TdtdEmployee(TdtdEmployeeId),
    UNIQUE KEY TdtdUniqueEmployeeDate (TdtdEmployeeId, TdtdDate)
);

-- Tạo bảng Lương
CREATE TABLE TdtdSalary (
    TdtdSalaryId INT PRIMARY KEY AUTO_INCREMENT,
    TdtdEmployeeId INT NOT NULL,
    TdtdMonth TINYINT NOT NULL,
    TdtdYear SMALLINT NOT NULL,
    TdtdBasicSalary DECIMAL(12, 2) NOT NULL,
    TdtdAllowance DECIMAL(12, 2) DEFAULT 0,
    TdtdBonus DECIMAL(12, 2) DEFAULT 0,
    TdtdFinalSalary DECIMAL(12, 2) NOT NULL,
    TdtdPaymentStatus ENUM('Chưa thanh toán', 'Đã thanh toán') DEFAULT 'Chưa thanh toán',
    FOREIGN KEY (TdtdEmployeeId) REFERENCES TdtdEmployee(TdtdEmployeeId),
    UNIQUE KEY TdtdUniqueEmployeeMonthYear (TdtdEmployeeId, TdtdMonth, TdtdYear)
);

-- Tạo bảng Tài khoản người dùng
CREATE TABLE TdtdUser (
    TdtdUserId INT PRIMARY KEY AUTO_INCREMENT,
    TdtdEmployeeId INT UNIQUE,
    TdtdUsername VARCHAR(50) NOT NULL UNIQUE,
    TdtdPassword VARCHAR(255) NOT NULL,
    TdtdRole ENUM('Admin', 'Manager', 'HR', 'Employee') NOT NULL,
    TdtdIsActive BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (TdtdEmployeeId) REFERENCES TdtdEmployee(TdtdEmployeeId)
);
