----------------- SELECT -----------------
--SELECT TỪ_KHÓA_SỐ_LƯỢNG TÊN_CỘT,...
--FROM TÊN_BẢNG_1 ĐẶT_TÊN_BẢNG_1
--INNER/LEFT/RIGHT/FULL JOIN  TÊN_BẢNG_2 ĐẶT_TÊN_BẢNG_2
--ON ĐẶT_TÊN_BẢNG_1.TÊN_CỘT = ĐẶT_TÊN_BẢNG_2.TÊN_CỘT
--...
--WHERE MỆNH_ĐỀ_ĐIỀU_KIỆN (AND, OR,...)
--GROUP BY TÊN_CỘT,...
--HAVING MỆNH_ĐỀ_ĐIỀU_KIỆN
--ORDER BY TÊN_CỘT,... ASC/DESC

--Bài 1
-- 1.1. Cho biết dánh sách môn học, gồm các thông tin sau: 
-- Mã môn, tên môn, số tiết
SELECT * FROM [dbo].[MonHoc]
GO
SELECT MaMH, TenMH, Sotiet FROM [dbo].[MonHoc]
GO
--1.2. Liệt kê danh sách sinh viên, gồm các thông tin sau: 
--	Mã sinh viên, Họ sinh viên,  Tên sinh viên, Học bổng. 
--	Danh sách sẽ được sắp xếp theo thứ tự Mã sinh viên  tăng dần. 
SELECT MaSV as N'Mã sinh viên', HoSV N'Họ sinh viên', 
	   TenSV N'Tên sinh viên',  HocBong N'Học bổng'
		FROM [dbo].[SinhVien] 
		ORDER BY MaSV ASC
GO
-- 1.5. Danh sách các môn học có tên bắt đầu bằng chữ T,
-- gồm các thông tin: Mã môn,  Tên môn, Số tiết. 
SELECT MaMH, TenMH, Sotiet 
		FROM  [dbo].[MonHoc] 
		WHERE TenMH LIKE N'T%'
-- 1.7. Danh sách những khoa có ký tự thứ hai của tên khoa có 
-- chứa chữ N, gồm các  thông tin: Mã khoa, Tên khoa.  
SELECT MaKH, TenKH FROM [dbo].[Khoa]
		WHERE TenKH like N'_N%'

-- Bài 2: Sử dụng hàm trong truy vấn dữ liệu 

-- MỘT SỐ HÀM TRONG SQL: CASE WHEN THEN END; IIF
-- HÀM CASE WHEN THEN END: 
--		CASE WHEN TÊN_CỘT PHÉP_LOGIC GIÁ_TRỊ_SO_SÁNH THEN GIÁ_TRỊ_ĐƯA_RA 
--			 WHEN TÊN_CỘT PHÉP_LOGIC GIÁ_TRỊ_SO_SÁNH THEN GIÁ_TRỊ_ĐƯA_RA
--           ...
--			 ELSE GIÁ_TRỊ_ĐƯA_RA
--			 END
-- HÀM IIF: 
--       IIF(MỆNH_ĐỀ_SO_SÁNH, GIÁ_TRỊ_NẾU_ĐÚNG, GIÁ_TRỊ_NẾU_SAI)
-- HÀM DATEDIFF/DATEDADD
--		DATEDADD/DATEDIFF(ĐỊNH_DẠNG_KIỂU_THỜI_GIAN,THỜI_GIAN,THỜI_GIAN_TĂNG/GIẢM)


-- 2.1.1. Liệt kê danh sách sinh viên gồm các thông tin sau: 
--Họ và tên sinh viên, Giới tính,  Tuổi, Mã khoa. 
--Trong đó Giới tính hiển thị ở dạng Nam/Nữ tuỳ theo giá trị của  field 
--Phai là True hay False, Tuổi sẽ được tính bằng cách lấy năm hiện hành 
--trừ  cho năm sinh. Danh sách sẽ được sắp xếp theo thứ tự Tuổi giảm dần  

SELECT HoSV + N' ' + TenSV AS N'Họ và tên', 
		CASE WHEN Phai = 0 THEN N'Nam' ELSE N'Nữ' END AS N'Giới tính', 
		IIF(Phai = 0,N'Nam', N'Nữ') AS N'Giới tính 2',
		DATEDIFF(YEAR,NgaySinh,GETDATE()) AS N'Tuổi',  MaKH
	FROM [dbo].[SinhVien]

-- Bài 3: Tính toán thống kê dữ liệu 
-- SUM, AVG, COUNT,...
-- 3.1. Cho biết trung bình điểm thi theo từng môn,
--  gồm các thông tin: Mã môn, Tên  môn, Trung bình điểm thi 
-- BỔ SUNG
-- Tên môn bắt đầu đầu bằng chữ T
-- điều kiện điểm TB lớn hơn 5
SELECT KQ.MaMH, MH.TenMH , AVG(KQ.Diem) N'Trung bình điểm thi'
	FROM [dbo].[Ketqua] KQ
	JOIN [dbo].[MonHoc] MH ON MH.MaMH = KQ.MaMH
	--WHERE TenMH like 'T%'
	GROUP BY KQ.MaMH, MH.TenMH 
	--HAVING AVG(KQ.Diem) >5
	ORDER BY KQ.MaMH


-- Bài 4: Sử dụng tham số trong truy vấn  
-- KHAI BÁO BIẾN
-- DECLARE @tên_biến KIỂU_DỮ_LIỆU

-- 4.1. 1. Cho biết danh sách những sinh viên của một khoa, 
-- gồm: Mã sinh viên, Họ tên  sinh viên, Giới tính, Tên khoa. 
-- Trong đó, giá trị mã khoa cần xem danh sách sinh  viên sẽ 
-- được người dùng nhập khi thực thi câu truy vấn
DECLARE @TenKH NVARCHAR(50)
SET @TenKH =N'anh%' 
SELECT MaSV, HoSV +N' '+ TenSV 'Họ và tên', IIF(Phai=0,'Nam',N'Nữ')
	,TenKH
	 FROM [dbo].[SinhVien] SV
	 JOIN [dbo].[Khoa] KH ON SV.MaKH = KH.MaKH
	 WHERE TenKH like @TenKH
GO

-- Bài 5: Truy vấn con (Subquery)
--5.1. Danh sách sinh viên chưa thi môn nào, thông tin gồm:
-- Mã sinh viên, Mã khoa,  Phái 
-- tất cả sinh viên đã thi và chưa thi
SELECT [MaSV],[MaKH],[Phai] FROM [dbo].[SinhVien]
-- lấy danh sách sinh viên đã thi 
SELECT MaSV, MaMH, Diem FROM [dbo].[Ketqua]
-- lấy  danh sách mã sinh viên đã thi 
SELECT DISTINCT MaSV FROM [dbo].[Ketqua]
--SELECT  MaSV FROM [dbo].[Ketqua] GROUP BY MaSV

SELECT [MaSV],[MaKH],[Phai] FROM [dbo].[SinhVien]
	WHERE [MaSV] NOT IN (SELECT DISTINCT MaSV FROM [dbo].[Ketqua])

--5.2. Danh sách những sinh viên chưa thi môn Cơ sở dữ liệu,
-- gồm các thông tin: Mã  sinh viên, Họ tên sinh viên, Mã khoa 

--5.9. Cho biết những sinh viên có học bổng lớn hơn tổng học bổng 
-- của những sinh  viên thuộc khoa Triết

-- ds tất cả sinh viên
SELECT MaSV, HoSV, TenSV,  NgaySinh, HocBong, MaKh
	FROM [dbo].[SinhVien]
-- Mã Khoa triết
-- Cách 1: Khai báo tham số
DECLARE @MaKH nvarchar(2)
SELECT @MaKH = MaKH FROM [dbo].[Khoa] WHERE TenKH= N'Triết'
-- tổng học bổng của những sinh viên khoa triết
SELECT SUM(HocBong)
	FROM [dbo].[SinhVien] WHERE MaKH = @MaKH

-- Cách 2: Subquery
SELECT  MaKH FROM [dbo].[Khoa] WHERE TenKH= N'Anh Văn'
-- tổng học bổng của những sinh viên khoa triết
SELECT SUM(ISNULL(HocBong,0))
	FROM [dbo].[SinhVien] 
	WHERE MaKH IN (SELECT MaKH FROM [dbo].[Khoa] 
								WHERE TenKH= N'Anh Văn')

SELECT MaSV, HoSV, TenSV,  NgaySinh, HocBong, MaKh
	FROM [dbo].[SinhVien]
	WHERE HocBong >(SELECT SUM(ISNULL(HocBong,0))
						FROM [dbo].[SinhVien] 
						WHERE MaKH IN (SELECT MaKH FROM [dbo].[Khoa] 
													WHERE TenKH= N'Triết'))