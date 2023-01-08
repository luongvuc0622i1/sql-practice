CREATE DATABASE Chuong101;

USE Chuong101;

CREATE TABLE Classes (
	ClassID				int				PRIMARY KEY		AUTO_INCREMENT,
    CLassName			VARCHAR(50)		NOT NULL
);

CREATE TABLE Students (
	StudentID			int				PRIMARY KEY		AUTO_INCREMENT,
    StudentName			VARCHAR(50)		NOT NULL,
    Age					int,
    Email				VARCHAR(100)
);

CREATE TABLE ClassStudent (
	StudentID			int				NOT NULL		UNIQUE,
    ClassID				int				NOT NULL,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);

CREATE TABLE Subjects (
	SubID				int				PRIMARY KEY		AUTO_INCREMENT,
    SubName				VARCHAR(50)		NOT NULL
);

CREATE TABLE Marks (
	StudentID			int				NOT NULL,
	SubID				int				NOT NULL,
	Mark				int,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (SubID) REFERENCES Subjects(SubID)
);

INSERT INTO Students(StudentName, Age, Email) VALUES ("Nguyen Quang An", 18, "an@yahoo.com"),
													 ("Nguyen Cong Vinh", 20, "vinh@gmail.com"),
													 ("Nguyen Van Quyen", 19, "Quyen"),
													 ("Pham Thanh Binh", 25, "binh@com"),
                                                     ("Nguyen Van Tai Em", 30, "taiem@sport.vn");
                                                     
INSERT INTO Classes (ClassName) VALUES ("C0706L"),
									   ("C0708G");
                                       
INSERT INTO ClassStudent VALUES (1, 1),
								(2, 1),
								(3, 2),
								(4, 2),
								(5, 2);
                                
INSERT INTO Subjects (SubName) VALUES ("SQL"),
									  ("Java"),
									  ("C"),
                                      ("Visual Basic");
                                      
INSERT INTO Marks VALUES (1, 1, 8),
						 (1, 2, 4),
						 (1, 1, 9),
						 (3, 1, 7),
						 (3, 3, 8),
						 (4, 1, 3),
						 (4, 2, 3),
						 (5, 2, 5),
                         (5, 3, 1);
                         
SELECT * FROM Students WHERE StudentName LIKE 'Nguyen%';

SELECT s.*, c.ClassName FROM Students AS s JOIN ClassStudent AS cs ON s.StudentID = cs.StudentID
JOIN Classes AS c ON c.ClassID = cs.ClassID
WHERE ClassName = 'C0706L';

SELECT s.StudentName, sj.SubName, m.Mark 
FROM Marks AS m JOIN Students AS s ON m.StudentID = s.StudentID
JOIN Subjects AS sj ON m.SubID = sj.SubID;

SELECT * FROM Students WHERE StudentID NOT IN (SELECT StudentID FROM Marks);

SELECT * FROM Subjects WHERE SubID NOT IN (SELECT SubID FROM Marks);

SELECT AVG(Mark) FROM Marks;

SELECT sj.*, COUNT(m.Mark) FROM Marks AS m 
JOIN Subjects AS sj ON m.SubID = sj.SubID 
GROUP BY m.SubID;

SELECT * FROM Subjects WHERE SubID = (SELECT SubID FROM Marks WHERE Mark = (SELECT MAX(Mark) FROM Marks));

SELECT * FROM Marks WHERE Mark < 5;
SELECT sj.*, COUNT(m.Mark) FROM (SELECT * FROM Marks WHERE Mark < 5) AS m 
JOIN Subjects AS sj ON m.SubID = sj.SubID 
GROUP BY m.SubID;

ALTER TABLE Students
MODIFY Age int CHECK (Age BETWEEN 15 AND 50);