DROP TABLE CourseInventory CASCADE CONSTRAINTS PURGE;
DROP TABLE Instructor CASCADE CONSTRAINTS PURGE;
DROP TABLE Student CASCADE CONSTRAINTS PURGE;
DROP TABLE ScheduleOfClasses CASCADE CONSTRAINTS PURGE;
DROP TABLE StudentSchedule CASCADE CONSTRAINTS PURGE;

CREATE TABLE CourseInventory ( 
DepartmentName varchar2(4) NOT NULL,
CourseNumber char(5) NOT NULL,
CourseTitle varchar2(50) UNIQUE NOT NULL,
CourseDescription varchar2(55),
CreditHours int,
CONSTRAINT PK_CourseInventory PRIMARY KEY (DepartmentName, CourseNumber)
);

CREATE TABLE Instructor ( 
InstructorID varchar2(15) NOT NULL,
Rank varchar2(20),
FirstName varchar2(15) NOT NULL,
LastName varchar2(15) NOT NULL,
Extension varchar2(5),
Office varchar2(20),
Email varchar2(20) UNIQUE,
CONSTRAINT PK_Instructor PRIMARY KEY (InstructorID)
);

CREATE TABLE Student ( 
StudentID varchar2(9) NOT NULL,
FirstName varchar2(15) NOT NULL,
LastName varchar2(15) NOT NULL,
Address varchar2(20) NOT NULL,
City varchar2(15) NOT NULL,
State char(2) NOT NULL,
ZipCode char(5) NOT NULL,
Email varchar2(30) UNIQUE ,
DateAdmitted date,
Major varchar2(20) DEFAULT 'Undecided',
CONSTRAINT PK_Student PRIMARY KEY (StudentID)
);

CREATE TABLE ScheduleOfClasses ( 
SemesterCode char(5) NOT NULL,
ClassCode char(5) NOT NULL,
DepartmentName varchar2(4) NOT NULL,
CourseNumber char(5) NOT NULL,
ClassSection char(3) NOT NULL,
Days varchar(5) NOT NULL,
Times varchar(20) NOT NULL,
Location varchar(10),
CurrentEnrollment int,
MaximumEnrollment int,
InstructorID varchar2(15),
CONSTRAINT PK_ScheduleOfClasses PRIMARY KEY (SemesterCode, ClassCode),
CONSTRAINT FK_DepartmentName_CourseName FOREIGN KEY (DepartmentName, CourseNumber) REFERENCES CourseInventory(DepartmentName, CourseNumber),
CONSTRAINT FK_InstructorID FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID),
CONSTRAINT CHK_Enrollment CHECK (CurrentEnrollment <= MaximumEnrollment)
);

CREATE TABLE StudentSchedule ( 
SemesterCode char(5) NOT NULL,
StudentID varchar2(9) NOT NULL,
ClassCode char(5) NOT NULL,
Grade char(1),
CONSTRAINT PK_StudentSchedule PRIMARY KEY (SemesterCode, StudentID, ClassCode),
CONSTRAINT FK_SemesterCode_ClassCode FOREIGN KEY (SemesterCode, ClassCode) REFERENCES ScheduleOfClasses(SemesterCode, ClassCode),
CONSTRAINT FK_StudentID FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);

set define off;

INSERT INTO CourseInventory
values('COMT', '11000', 'Introduction to Computer Systems', 'Introduction course for computer systems', 3);

INSERT INTO CourseInventory
values('COMT', '11002', 'Visual Basic Programming', 'Programming in visual basic', 3);

INSERT INTO CourseInventory
values('COMT', '11005', 'Intro to OS & Networking', 'Introductory class to operating systems and networking', 3);

INSERT INTO CourseInventory
values('COMT', '11006', 'Intro to Web Site Technology', 'Introduction course for web technology', 3);

INSERT INTO CourseInventory
values('COMT', '11009', 'Computer Assembly & Configuration', 'Studies of computer hardware and software', 4);

INSERT INTO CourseInventory
values('ENG', '11011', 'College Writing I', 'Basic english college writing course', 3);

INSERT INTO CourseInventory
values('ENG', '21011', 'College Writing II', 'Advanced english college writing course', 3);

INSERT INTO CourseInventory
values('MATH', '10021', 'Basic Algebra I', 'Basic college algebra course', 2);

INSERT INTO CourseInventory
values('MATH', '10022', 'Basic Algebra II', 'Intermediate college algebra course', 2);

INSERT INTO CourseInventory
values('MATH', '10023', 'Basic Algebra III', 'Advanced college algebra course', 3);

INSERT INTO CourseInventory
values('MATH', '11009', 'Modeling Algebra', 'Expert college algebra course', 4);

INSERT INTO CourseInventory
values('BSCI', '10001', 'Basic Science', 'Basic college science course', 3);

INSERT INTO Instructor
values('bbunny', 'Instructor', 'Bugs', 'Bunny', '44111', 'ASH RAM A111', 'bbunny@kent.edu');

INSERT INTO Instructor
values('ccarvalh', 'Instructor', 'Carolyn', 'Carvalho', '44222', 'ASH RAM A203', 'ccarvalh@kent.edu');

INSERT INTO Instructor
values('cnaylor', 'Instructor', 'Christine', 'Naylor', '44262', 'ASH RAM A208', 'cnaylor@kent.edu');

INSERT INTO Instructor
values('iedge', 'Professor', 'Irene', 'Edge', '44332', 'ASH RAM A224', 'iedge@kent.edu');

INSERT INTO Instructor
values('kfrog', 'Professor', 'Kermit', 'Frog', '44555', 'ASH RAM A555', 'kfrog_kent.edu');

INSERT INTO Student
values('444554444', 'Shanda', 'Leer', '444 Crystal Dr', 'Ashtabula', 'OH', '44004', NULL, '01-Aug-2012', 'COMT');

INSERT INTO Student
values('555665555', 'Rose', 'Budd', '35 Flower Ln', 'Ashtabula', 'OH', '44004', NULL, '01-Aug-2012', 'Undecided');

INSERT INTO Student
values('666776666', 'Ima', 'Bott', '123 Tech Dr', 'Ashtabula', 'OH', '44004', NULL, '01-Aug-2012', 'COMT');

INSERT INTO Student
values('777887777', 'Twila', 'Zone', '777 Space Pl', 'Ashtabula', 'OH', '44004', NULL, '01-Jan-2013', 'Science');

INSERT INTO Student
values('888998888', 'Ian', 'Turnels', '88 Organ Ln', 'Geneva', 'OH', '44041', NULL, '01-Jan-2013', 'Science');

INSERT INTO ScheduleofClasses
values('2013S', '12345', 'COMT', '11000', '200', 'MW', '9:30-10:45am', 'Ashtabula', 0, 24, 'iedge');

INSERT INTO ScheduleofClasses
values('2013S', '23456', 'COMT', '11000', '210', 'TR', '11:00am-12:15pm', 'Ashtabula', 0, 24, 'ccarvalh');

INSERT INTO ScheduleofClasses
values('2013S', '34567', 'BSCI', '10001', '200', 'MW', '1:00-2:15pm', 'Geneva', 0, 24, 'bbunny');

INSERT INTO ScheduleofClasses
values('2013S', '45678', 'ENG', '11011', '200', 'TR', '1:00-2:15pm', 'Ashtabula', 0, 24, 'kfrog');

INSERT INTO ScheduleofClasses
values('2013S', '56789', 'COMT', '11009', '200', 'T', '12:30-3:50pm', 'Ashtabula', 0, 24, 'iedge');

INSERT INTO StudentSchedule
values('2013S', '444554444', '12345', 'A');

INSERT INTO StudentSchedule
values('2013S', '777887777', '12345', 'B');

INSERT INTO StudentSchedule
values('2013S', '555665555', '23456', 'C');

INSERT INTO StudentSchedule
values('2013S', '666776666', '23456', 'A');

INSERT INTO StudentSchedule
values('2013S', '888998888', '34567', 'B');

INSERT INTO StudentSchedule
values('2013S', '555665555', '56789', 'C');

INSERT INTO StudentSchedule
values('2013S', '444554444', '45678', 'A');

INSERT INTO StudentSchedule
values('2013S', '555665555', '12345', 'B');

set define on;