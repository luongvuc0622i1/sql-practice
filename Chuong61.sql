CREATE DATABASE chuong61;

USE chuong61;

CREATE TABLE Class (
    ClassID			int				PRIMARY KEY		AUTO_INCREMENT,
    ClassName		nvarchar(255)	NOT NULL,
    StartDate 		Datetime		NOT NULL,
    Status 			Bit
);

CREATE TABLE Student (
	StudentID		int				PRIMARY KEY,
    StudentName		nvarchar(30)	NOT NULL,
    Address			nvarchar(50),
    Phone			Varchar(20),
    Status			Bit,
    ClassID 		int				NOT NULL
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

INSERT INTO Class (ClassName, Status) VALUES ("A1", 1),
											 ("A2", 1),
                                             ("B3", 0);
                                             
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