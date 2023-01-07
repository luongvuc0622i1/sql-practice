CREATE DATABASE Chuong8;

USE Chuong8;

CREATE TABLE Class (
	ClassID			int				PRIMARY KEY		AUTO_INCREMENT,
    ClassName		nvarchar(255)	NOT NULL,
    StartDate		datetime		NOT NULL,
    Status			bit
);

CREATE TABLE Student (
	StudentID		int				PRIMARY KEY		AUTO_INCREMENT,
    StudentName		nvarchar(30)	NOT NULL,
    Address			nvarchar(50),
    Phone			varchar(20),
    Status			bit,
    ClassID			int				NOT NULL
);

CREATE TABLE Subject (
	SubID			int				PRIMARY KEY		AUTO_INCREMENT,
    SubName			nvarchar(30)	NOT NULL,
    Credit			TINYINT			NOT NULL		DEFAULT 1		CHECK (Credit >= 1),
    Status			Bit				DEFAULT 1
);

CREATE TABLE Mark (
	MarkID			int				PRIMARY KEY		AUTO_INCREMENT,
    SubID			int				NOT NULL,
    StudentID		int				NOT NULL,
    Mark			float			DEFAULT 0		CHECK (Mark BETWEEN 0 AND 100),
    ExamTimes		TINYINT			DEFAULT 1,
    UNIQUE (SubID, StudentID)
);

ALTER TABLE Student
ADD FOREIGN KEY (ClassID) REFERENCES Class(ClassID);

ALTER TABLE Class
MODIFY COLUMN StartDate DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE Student
ALTER Status SET DEFAULT 1;

ALTER TABLE Mark
ADD FOREIGN KEY (SubID) REFERENCES Subject(SubID),
ADD FOREIGN KEY (StudentID) REFERENCES Student(StudentID);

INSERT INTO Class (ClassName, Status, StartDate) VALUES ("A1", 1, "2008-12-20"),
														("A2", 1, "2008-12-22");
INSERT INTO Class (ClassName, Status) VALUES ("B3", 0);
                                             
INSERT INTO Student (StudentID, StudentName, Address, Phone, ClassID) VALUES (1, "Hung", "Ha noi", "0912113113", 1);
INSERT INTO Student (StudentID, StudentName, Address, ClassID) VALUES (2, "Hoa", "Hai phong", 1);
INSERT INTO Student (StudentID, StudentName, Address, Phone, Status, ClassID) VALUES (3, "Manh", "HCM", "0123123123", 0, 2);

INSERT INTO Subject (SubName, Credit) VALUES ("CF", 5),
											 ("C", 6),
											 ("HDJ", 5),
											 ("RDBMS", 10);
                                             
INSERT INTO Mark (SubID, StudentID, Mark) VALUES (1, 1, 8);
INSERT INTO Mark (SubID, StudentID, Mark, ExamTimes) VALUES (1, 2, 10, 2);
INSERT INTO Mark (SubID, StudentID, Mark) VALUES (2, 1, 12);

UPDATE Student SET ClassID = 2 WHERE StudentName = "Hung";
UPDATE Student SET Phone = "No phone" WHERE Phone IS NULL;

-- 
-- 
UPDATE Class SET Status = 0 WHERE ClassID NOT IN (SELECT DISTINCT ClassID FROM Student);
UPDATE Subject SET Status = 0 WHERE SubID NOT IN (SELECT DISTINCT SubID FROM Mark);

SELECT * FROM Student WHERE StudentName LIKE 'h%';
SELECT * FROM Class WHERE Month(StartDate) = 12;
SELECT MAX(Credit) FROM Subject;
SELECT * FROM Subject WHERE Credit = (SELECT MAX(Credit) FROM Subject);
SELECT * FROM Subject WHERE Credit BETWEEN 3 AND 5;
SELECT c.ClassID, c.ClassName, s.StudentName, s.Address FROM Class AS c JOIN Student AS s ON c.ClassID = s.ClassID;
SELECT * FROM Subject WHERE SubID NOT IN (SELECT DISTINCT SubID FROM Mark);
SELECT * FROM Subject WHERE SubID = (SELECT SubID FROM Mark WHERE Mark = (SELECT MAX(Mark) FROM Mark));
SELECT s.StudentName, AVG(m.Mark) FROM Student AS s JOIN MARK AS m ON s.StudentID = m.StudentID GROUP BY StudentName;

DELETE FROM Class WHERE Status = 0;
DELETE FROM Subject WHERE Status = 0;
-- Chuyển cơ sở dữ liệu hiện hành sang cơ sở dữ liệu Master.
-- Xóa bỏ cơ sở dữ liệu vừa tạo.

ALTER TABLE Mark DROP ExamTimes;
ALTER TABLE Class
RENAME COLUMN Status TO ClassStatus;
ALTER TABLE Mark RENAME TO SubjectTest;

DROP DATABASE Chuong8;






