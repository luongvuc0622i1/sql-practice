CREATE DATABASE chuong4;

USE chuong4;

CREATE TABLE Classes (
    ClassID			int				PRIMARY KEY		AUTO_INCREMENT,
    ClassName		nvarchar(50)	NOT NULL
);

CREATE TABLE Students (
	StudentID		int				PRIMARY KEY		AUTO_INCREMENT,
    StudentName		nvarchar(50)	NOT NULL,
    Age				int,
    Email			Varchar(100)
);

CREATE TABLE ClassStudent (
	ClassID			int				NOT NULL,
    StudentID		int				NOT NULL,
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    UNIQUE (ClassID, StudentID)
);

CREATE TABLE Subjects (
	SubID			int				PRIMARY KEY		AUTO_INCREMENT,
    SubName			nvarchar(50)	NOT NULL		UNIQUE
);

CREATE TABLE Marks (
	MarkID			int				PRIMARY KEY		AUTO_INCREMENT,
    SubID			int				NOT NULL,
    StudentID		int				NOT NULL,
    Mark			float			DEFAULT 0		CHECK (Mark BETWEEN 0 AND 100),
    FOREIGN KEY (SubID) REFERENCES Subjects(SubID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

INSERT INTO Classes (ClassName) VALUES ("C0706L"),
									 ("C0708G");
                                             
INSERT INTO Students (StudentName, Age, Email) VALUES ("Nguyen Quang An", 18, "an@yahoo.com"),
													 ("Nguyen Cong Vinh", 20, "vinh@gmail.com"),
													 ("Nguyen Van Quyen", 19, "quyen"),
													 ("Pham Thanh Binh", 25, "binh@com"),
													 ("Nguyen Van Tai Em", 30, "taiem@sport.vn");

INSERT INTO ClassStudent (StudentID, ClassID) VALUES (1, 1),
													 (2, 1),
													 (3, 2),
													 (4, 2),
													 (5, 2);

INSERT INTO Subjects (SubName) VALUES ("SQL"),
									 ("Java"),
									 ("C"),
									 ("Visual Basic");
                                             
INSERT INTO Marks (StudentID, SubID, Mark) VALUES (1, 1, 8),
												 (1, 2, 4),
												 (1, 1, 9),
												 (3, 1, 7),
												 (4, 1, 3),
												 (5, 2, 5),
												 (3, 3, 8),
												 (5, 3, 1),
												 (4, 2, 3);
                                                 
SELECT * FROM Students;

SELECT * FROM Subjects;

SELECT AVG(Mark) FROM Marks;

SELECT * FROM Subjects WHERE SubID = (SELECT SubID FROM Marks WHERE Mark = (SELECT MAX(Mark) FROM Marks));

SELECT * FROM Marks ORDER BY Mark DESC;

SELECT CONCAT("Day la mon hoc ", SubName) FROM Subjects;

ALTER TABLE ClassStudent DROP CONSTRAINT classstudent_ibfk_1;
ALTER TABLE ClassStudent DROP CONSTRAINT classstudent_ibfk_2;
ALTER TABLE Marks DROP CONSTRAINT marks_ibfk_1;
ALTER TABLE Marks DROP CONSTRAINT marks_ibfk_2;

DELETE FROM Students WHERE StudentID = 1;