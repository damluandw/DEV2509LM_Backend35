-- Tạo cơ sở dữ liệu
--CREATE DATABASE DEV2509LM_Backend_Lesson02
--GO
CREATE DATABASE DEV2509LM_Backend_Lesson02
ON PRIMARY
(
    NAME = DEV2509LM_Backend_Lesson02_Data,
    FILENAME = 'D:\00.DATABASE\DEV2509LM_Backend_Lesson02.mdf',
    SIZE = 10MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 10%
)
LOG ON
(
    NAME = DEV2509LM_Backend_Lesson02_Log,
    FILENAME = 'D:\00.DATABASE\DEV2509LM_Backend_Lesson02_Log.ldf',
    SIZE = 5MB,
    MAXSIZE = 20MB,
    FILEGROWTH = 1MB
);
GO
-- XÓA BẢNG
-- systax: DROP DATABASE TÊN_DATABASE
DROP DATABASE DEV2509LM_Backend_Lesson02
GO
-- Sử dụng CSDL
-- systax: USE TÊN_DATABASE
USE DEV2509LM_Backend_Lesson02
GO
-- Tạo bảng
/* systax: 
	CREATE TABLE TÊN_BẢNG(
		TÊN_CỘT KIỂU_DỮ_LIỆU BỔ_TỪ,
		TÊN_CỘT KIỂU_DỮ_LIỆU BỔ_TỪ,
		...
		TÊN_CỘT KIỂU_DỮ_LIỆU BỔ_TỪ
	)		
*/
CREATE TABLE KHOA(
	MaKH char(2),
	TenKH nvarchar(50)
)
GO
CREATE TABLE MONHOC(
	MAKH CHAR(2) PRIMARY KEY,
	TENMH NVARCHAR(50),
	SOTIET INT
)
GO
-- SỬA BẢNG
-- THÊM CỘT
/* systax: 
	ALTER TABLE TÊN_BẢNG
	ADD TÊN_CỘT KIÊU_DỮ_LIỆU BỔ TỪ		
*/
ALTER TABLE MONHOC
ADD TEST nvarchar(50)
GO
-- SỬA CỘT
/* systax: 
	ALTER TABLE TÊN_BẢNG
	ALTER COLUMN TÊN_CỘT KIÊU_DỮ_LIỆU BỔ TỪ		
*/
ALTER TABLE MONHOC
ALTER COLUMN TEST nvarchar(25) NOT NULL
GO
-- XÓA CỘT
/* systax: 
	ALTER TABLE TÊN_BẢNG
	DROP COLUMN TÊN_CỘT KIÊU_DỮ_LIỆU BỔ TỪ		
*/
ALTER TABLE MONHOC
DROP COLUMN TEST
GO
-- DỮ LIỆU
-- THÊM DỮ LIỆU
/* systax: 
	INSERT TÊN_BẢNG (TÊN_CỘT,....)
	VALUES (GIÁ_TRỊ_CỘT,....)		
*/
INSERT KHOA (MaKH, TenKH)
VALUES ('IT',N'Công nghệ thông tin'),
 ('AH',N'Anh học'),
 ('TH',N'Trung Quốc học')
 GO
 SELECT * FROM KHOA
-- SỬA DỮ LIỆU
/* systax: 
	UPDATE TÊN_BẢNG SET TÊN_CỘT = GIÁ_TRỊ	
	WHERE ....	
*/
UPDATE KHOA SET MaKH = N'OT' WHERE MaKH = 'IT'
-- XÓA DỮ LIỆU

/* systax: 
	DELETE TÊN_BẢNG WHERE ....	

	TRUNCATE TABLE TÊN_BẢNG
*/

DELETE KHOA WHERE MaKH = 'IT'

TRUNCATE TABLE KHOA

-- XÓA BẢNG
-- DROP TABLE TÊN_BẢNG
DROP TABLE KHOA

-- BÔ TỪ - RÀNG BUỘC KHI TẠO BẢNG VÀ SƯA BẢNG
/*
	1. PRIMARY KEY - khóa chính - trong bảo chỉ nhận 1 giá trị duy nhất và không nhận giá trị null
	SYSTAX: 
		Cách 1:
		TÊN CỘT KIỂU_DỮ_LIỆU PRIMARY KEY
		Cách 2:
		PRIMARY KEY(TÊN_CỘT)

	2. FOREIGN KEY - khóa ngoại
		TÊN CỘT KIỂU_DỮ_LIỆU FOREIGN KEY REFERENCES TÊN_BẢNG(TÊN_CỘT)
	3. UNIQUE - trong bảo chỉ nhận 1 giá trị duy nhất nhưng có nhận giá trị null
	4. CHECK - kiểm tra giá trị đầu vào của trường
	5. NOT NULL/NULL - kiểm tra giá trị đầu vào cho phép null hoặc k cho phép null

*/

-- PRIMARY KEY
--CREATE TABLE DIEM(
--	MADIEM CHAR(5) PRIMARY KEY,
--	DIEM FLOAT 
--)
--GO
--CREATE TABLE DIEM(
--	MADIEM CHAR(5), 
--	DIEM FLOAT, 
--	PRIMARY KEY(MADIEM)
--)
--GO

-- FOREIGN KEY 

CREATE TABLE DIEM(
	MADIEM CHAR(5) PRIMARY KEY,
	MAMH CHAR(2)  FOREIGN KEY REFERENCES MONHOC(MAKH),
	DIEM FLOAT 
)
GO

-- CHECK/ NULL/NOT NULL
CREATE TABLE SINHVIEN(
	MASV CHAR(5) PRIMARY KEY ,
	NAME NVARCHAR(50) NOT NULL,
	AGE INT CHECK(AGE > 18 AND AGE < 100)
)
GO
INSERT SINHVIEN (MASV, NAME, AGE)
VALUES ('SV003', N'Devmaster 4 ',  20)
GO

----------------------------------------------------------------------------------------------
-------------------------------------------TRUY VẤN-------------------------------------------
----------------------------------------------------------------------------------------------
--SELECT TÊN_CỘT,..
--FROM TÊN_BẢNG
--WHERE MÊNH_ĐỀ_ĐIỀU_KIỆN
--GROUP BY TÊN_CỘT,...
--HAVING MÊNH_ĐỀ_ĐIỀU_KIỆN
--ORDER BY TÊN_CỘT,...

SELECT 'Devmaster' AS 'Tên_cột_1', N'25 Vũ Ngọc Phan' AS 'Tên_cột_2'
GO
-- Hiện thị tất cả các cột *
SELECT * FROM [dbo].[KHOA]
GO
-- Hiện thị tất cả các cột được chọn
SELECT MASV, NAME, AGE FROM [dbo].[SINHVIEN]
GO



-- JOIN/ INNER JOIN: Lấy phần chung của 2 bảng
-- LEFT JOIN : Lấy nửa bên trái và phần chung của 2 bảng
-- RIGHT JOIN : Lấy nửa bên phải và phần chung của 2 bảng
-- FULL JOIN: Lấy tất cả dữ liệu của 2 bảng
INSERT [dbo].[MONHOC](MAKH, TENMH, SOTIET)
VALUES('A1', N'Anh Văn 1' , 20),
('A2', N'Anh Văn 2' , 30),
('A3', N'Anh Văn 3' , 20),
('A4', N'Anh Văn 4' , 50),
('A5', N'Anh Văn 5' , 60)
GO

INSERT [dbo].[DIEM](MADIEM, MAMH, DIEM)
VALUES('D1', 'A1' , 9),
('D2', 'A1' , 5),
('D3', 'A3' , 7),
('D4', 'A4' , 5),
('D5', 'A5' , 6)
GO

SELECT * FROM
[dbo].[MONHOC] AS MH
INNER JOIN [dbo].[DIEM] AS D ON MH.[MaKH] = D.[MAMH]

SELECT * FROM
[dbo].[MONHOC] AS MH
LEFT JOIN [dbo].[DIEM] AS D ON MH.[MaKH] = D.[MAMH]

SELECT * FROM
[dbo].[MONHOC] AS MH
RIGHT JOIN [dbo].[DIEM] AS D ON MH.[MaKH] = D.[MAMH]

SELECT * FROM
[dbo].[MONHOC] AS MH
FULL JOIN [dbo].[DIEM] AS D ON MH.[MaKH] = D.[MAMH]


--- SELECT VỚI ĐIỀU KIỆN VÀ SẮP XẾP
SELECT * FROM [dbo].[DIEM]
-- <;>;=;...
SELECT * FROM [dbo].[DIEM] WHERE DIEM  > 6 ORDER BY DIEM ASC
 -- BETWEEN
SELECT * FROM [dbo].[DIEM] WHERE DIEM BETWEEN  6 AND 9 ORDER BY DIEM DESC
-- in 
SELECT * FROM [dbo].[DIEM] WHERE DIEM IN (5,9)
-- like 
SELECT * FROM [dbo].[KHOA]  WHERE TenKH like 'C%'
SELECT * FROM [dbo].[KHOA]  WHERE TenKH like '_n%'
SELECT * FROM [dbo].[KHOA]  WHERE TenKH like '[a-d]n%'
SELECT * FROM [dbo].[KHOA]  WHERE TenKH like '[^c-f]n%'

-- DISTINCT
SELECT DISTINCT SOTIET FROM [dbo].[MONHOC] 


-- TOP, PREVENT