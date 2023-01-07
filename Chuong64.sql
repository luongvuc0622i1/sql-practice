CREATE DATABASE chuong64;

USE chuong64;

CREATE TABLE Customers (
	MaKhach			int			PRIMARY KEY		AUTO_INCREMENT,
    Ten				nvarchar(50),
    SoDienThoai		varchar(10)
);

CREATE TABLE Items (
	MaHang			int			PRIMARY KEY		AUTO_INCREMENT,
    Ten				nvarchar(100),
    SoLuong			int,
    DonGia			int
);

CREATE TABLE CustomerItem (
	MaKhach			int			NOT NULL,
    MaHang			int			NOT NULL,
    SoLuong			int
);

INSERT INTO Items (Ten, SoLuong, DonGia) VALUES ("Tu lanh", 5, 3500),
												("Ti vi", 2, 3000),
												("Dieu hoa", 1, 8000),
												("Quat da", 5, 1700),
												("May giat", 3, 5000);
                         
INSERT INTO Customers (Ten, SoDienThoai) VALUES ("Dinh Truong Son", 1234567),
											   ("Mai Thanh Minh", 1357999),
											   ("Nguyen Hong Ha", 2468888);

INSERT INTO CustomerItem (MaKhach, MaHang, SoLuong) VALUES (1, 1, 4),
														   (1, 5, 1),
														   (2, 2, 1),
														   (3, 3, 1),
														   (3, 1, 1);
                                                           
ALTER TABLE CustomerItem
ADD FOREIGN KEY (MaKhach) REFERENCES Customers(MaKhach),
ADD FOREIGN KEY (MaHang) REFERENCES Items(MaHang);

DELETE FROM Customers WHERE MaKhach = 1;

