CREATE DATABASE Chuong102;

USE Chuong102;

CREATE TABLE Khachhang (
	makh				int				PRIMARY KEY		AUTO_INCREMENT,
    tenkh				nvarchar(50),
    ngaysinh			DATETIME,
    diachi				nvarchar(100),
    dienthoai			int,
    ghichu				nvarchar(255)
);

CREATE TABLE Dongia (
	maloai				int				PRIMARY KEY		AUTO_INCREMENT,
    loaiho				nvarchar(100),
    gia					int
);

CREATE TABLE Chiso (
	makh				int				NOT NULL,
    maloai				int				NOT NULL,
    UNIQUE (makh, maloai),
    chisodau			int,
    chisocuoi			int
);

-- Đưa ra danh sách khách hàng sinh năm 1980.
SELECT * FROM Khachhang WHERE YEAR(ngaysinh) < 1980;

-- Đưa ra danh sách khách hàng, chỉ số tiêu thụ.
SELECT kh.*, (cs.chisocuoi-cs.chisodau) AS chisotieuthu FROM Khachhang AS kh JOIN Chiso AS cs ON kh.makh = cs.makh;

-- Đưa ra đầy đủ thông tin về khách hàng, đơn giá, chỉ số, số điện tiêu thụ
SELECT kh.*, dg.gia, (cs.chisocuoi-cs.chisodau) AS chisotieuthu FROM Khachhang AS kh JOIN Chiso AS cs ON kh.makh = cs.makh
JOIN Dongia AS dg ON dg.maloai = cs.maloai;

-- Đưa ra danh sách khách hàng phải trả tiền điện.
SELECT kh.*, (cs.chisocuoi-cs.chisodau) AS chisotieuthu FROM Khachhang AS kh JOIN Chiso AS cs ON kh.makh = cs.makh WHERE (cs.chisocuoi-cs.chisodau) > 0;

-- Tính tiền điện cho từng khách hàng và đưa ra thông tin bao gồm: tenkh,loaiho, chi_so_tieu_thu, so_tien_phai_tra
SELECT kh.tenkh, dg.loaiho, (cs.chisocuoi-cs.chisodau) AS chisotieuthu, (cs.chisocuoi-cs.chisodau)*dg.gia AS sotienphaitra FROM Khachhang AS kh JOIN Chiso AS cs ON kh.makh = cs.makh
JOIN Dongia AS dg ON dg.maloai = cs.maloai;

-- Cho danh sách khách hàng thuộc loaiho =”Gia đình”
SELECT kh.* FROM Khachhang AS kh JOIN Chiso AS cs ON kh.makh = cs.makh
JOIN Dongia AS dg ON dg.maloai = cs.maloai 
WHERE dg.loaiho = 'Gia đình';

-- Cho danh sách những khách hàng không phải trả tiền điện.
SELECT * FROM Khachhang WHERE makh NOT IN (SELECT kh.makh FROM Khachhang AS kh JOIN Chiso AS cs ON kh.makh = cs.makh WHERE (cs.chisocuoi-cs.chisodau) > 0);