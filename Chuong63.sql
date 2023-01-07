create database chuong63;
use chuong63;

CREATE TABLE Student(
	RN			int,
	Name		nvarchar(255),
	Age			int,
	Gender		bit
);

CREATE TABLE Subject(
	sID			int,
    sName		nvarchar(255)
);

CREATE TABLE StudentSubject(
	RN			int,
    SID			int,
    Mark		int
);

ALTER TABLE Student
ADD CONSTRAINT PK1 PRIMARY KEY(RN);

ALTER TABLE Subject
ADD CONSTRAINT PK2 PRIMARY KEY(sID);

ALTER TABLE StudentSubject
MODIFY Mark int CHECK (Mark BETWEEN 0 AND 10);

ALTER TABLE StudentSubject
ADD FOREIGN KEY (RN) REFERENCES student(RN),
ADD FOREIGN KEY (sID) REFERENCES Subject(sID);

ALTER TABLE StudentSubject
ADD COLUMN Date Datetime;

INSERT INTO Student (RN, Name) VALUES (1, "Mỹ Linh"),
									  (2, "Đàm Vĩnh Hưng"),
                                      (3, "Kim Tử Long"),
                                      (4, "Tài Linh"),
                                      (5, "Mỹ Lệ"),
                                      (6, "Ngọc Oanh");
INSERT INTO Subject VALUES (1, "SQL"),
						   (2, "GLC"),
                           (3, "HTML"),
                           (4, "CF");
INSERT INTO StudentSubject VALUES (1, 1, 8, "2005-7-28"),
								  (2, 2, 3, "2005-7-29"),
                                  (3, 3, 9, "2005-7-31"),
                                  (4, 1, 5, "2005-7-30"),
                                  (5, 4, 10, "2005-7-19"),
                                  (6, 1, 9, "2005-7-25");

UPDATE Student SET Gender = 0 WHERE RN = 1 OR RN = 4 OR RN = 5;
UPDATE Student SET Gender = 1 WHERE RN = 2 OR RN = 3;

-- Mỹ Linh, Kim Tử Long la 19
-- Tài Linh, Đàm Vĩnh Hưng là 20
-- Mỹ Lệ, Ngọc Oanh là 21

INSERT INTO Subject VALUES (5, "Core Java"),
						   (6, "VB.Net");
                           
UPDATE Student SET Age = 19 WHERE RN = 1 OR RN = 3;
UPDATE Student SET Age = 20 WHERE RN = 2 OR RN = 4;
UPDATE Student SET Age = 21 WHERE RN = 5 OR RN = 6;

SELECT * FROM Student;

SELECT COUNT(RN) FROM Student;

SELECT * FROM Subject;

SELECT MAX(Mark) FROM StudentSubject;

SELECT COUNT(RN) FROM StudentSubject WHERE Mark > 5;

SELECT AVG(Mark) FROM StudentSubject;

SELECT * FROM Student WHERE Age >= 20;

SELECT RN AS "So hieu sinh vien", sID AS "Mã môn học" FROM StudentSubject WHERE Mark = (SELECT MAX(Mark) FROM StudentSubject);

SELECT * FROM StudentSubject ORDER BY Mark DESC LIMIT 2;

SELECT Date FROM StudentSubject WHERE Mark = (SELECT MAX(Mark) FROM StudentSubject);







