CREATE DATABASE Chuong103;

USE Chuong103;

CREATE TABLE Khoa (
	k_ID				int				PRIMARY KEY		AUTO_INCREMENT,
    k_Ten				NVARCHAR(20)
);

CREATE TABLE Lop (
	l_ID				int				PRIMARY KEY		AUTO_INCREMENT,
    l_Ten				NVARCHAR(20),
    l_Khoa				int				NOT NULL,
    FOREIGN KEY (l_Khoa) REFERENCES Khoa(k_ID)
);

CREATE TABLE SinhVien (
	sv_Maso				int				PRIMARY KEY		AUTO_INCREMENT,
    sv_Hodem			NVARCHAR(30),
    sv_Ten				NVARCHAR(15),
    sv_Ngaysinh			DATETIME,
    sv_Lop				int				NOT NULL,
    sv_DiemTB			double,
    FOREIGN KEY (sv_Lop) REFERENCES Lop(l_ID)
);

-- Liệt kê danh sách các sinh viên
SELECT * FROM SinhVien;

-- Liệt kê danh sách các sinh viên (họ tên viết liền)
SELECT sv_Maso, CONCAT(sv_Hodem, ' ', sv_Ten) AS sv_Hovaten FROM SinhVien;

-- Liệt kê danh sách sinh viên: Mã số, họ đệm, tên, tuổi
SELECT sv_Maso, CONCAT(sv_Hodem, ' ', sv_Ten) AS sv_Hovaten, (YEAR(CURDATE())-YEAR(sv_Ngaysinh)) AS sv_Tuoi FROM SinhVien;

-- Liệt kê danh sách các lớp
SELECT * FROM Lop;

-- Liệt kê danh sách các khoa
SELECT * FROM Khoa;

-- Tìm những sinh viên thuộc khoa CNTT
SELECT sv.* FROM SinhVien AS sv JOIN Lop AS l ON sv.sv_Lop = l.l_ID
JOIN Khoa AS k ON l.l_Khoa = k.k_ID WHERE k.k_Ten = 'CNTT';

-- Số lượng sinh viên loại giỏi, loại khá, loại trung bình (trong cùng 1 query)
-- Số lượng sinh viên loại giỏi, khá, trung bình của từng lớp (trong cùng 1 query)
-- Tên lớp, danh sách các sinh viên của lớp sắp xếp theo điểm trung bình giảm dần
SELECT l.l_Ten, sv.* FROM SinhVien AS sv JOIN Lop AS l ON sv.sv_Lop = l.l_ID
ORDER BY sv_DiemTB DESC;

-- Tên lớp, tổng số sinh viên của lớp
SELECT l.l_Ten, COUNT(sv.sv_Maso) FROM SinhVien AS sv JOIN Lop AS l ON sv.sv_Lop = l.l_ID
GROUP BY sv.sv_Lop;

-- Tên khoa, tổng số sinh viên của khoa
SELECT k.k_Ten, COUNT(sv.sv_Maso) FROM SinhVien AS sv 
JOIN Lop AS l ON sv.sv_Lop = l.l_ID 
JOIN Khoa AS k ON l.l_Khoa = k.k_ID 
GROUP BY sv.sv_Lop, l.l_Khoa;

-- Tên khoa, tên lớp, điểm trung bình của sinh viên (chú ý: liệt kê tất cả các khoa và lớp, kể cả khoa và lớp chưa có sinh viên)
-- Tên khoa, tên lớp, họ tên, ngày sinh, điểm trung bình của sinh viên có điểm trung bình cao nhất lớp
SELECT k.k_Ten, l.l_Ten, CONCAT(sv.sv_Hodem, ' ', sv.sv_Ten) AS sv_Hovaten, sv.sv_Ngaysinh, sv.sv_DiemTB 
FROM SinhVien AS sv 
JOIN Lop AS l ON sv.sv_Lop = l.l_ID 
JOIN Khoa AS k ON l.l_Khoa = k.k_ID 
WHERE sv.sv_DiemTB = (SELECT MAX(sv_DiemTB) FROM SinhVien);

-- Tên khoa, Họ tên, ngày sinh, điểm trung bình của sinh viên có điểm trung bình cao nhất khoa
