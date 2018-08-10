--Queries if Student has duplicates of the same class--
SELECT StudentID, LastName, FirstName, DepartmentName, CourseNumber, CourseTitle
FROM Student NATURAL JOIN StudentSchedule NATURAL JOIN ScheduleOfClasses NATURAL JOIN CourseInventory
GROUP BY(StudentID, LastName, FirstName, DepartmentName, CourseNumber, CourseTitle)
HAVING COUNT(DepartmentName || CourseNumber) > 1;

--Creates a user--
alter session set "_ORACLE_SCRIPT"=true;

DROP USER tinstructor;

CREATE USER tinstructor
IDENTIFIED BY instructor1
PASSWORD EXPIRE;

DROP ROLE Professor;

CREATE ROLE Professor;

GRANT CREATE SESSION to Professor;

GRANT SELECT ON ScheduleOfClasses to Professor;

--Select or Insert via Substitution Variables--
SELECT * FROM Student
WHERE STUDENTID = '&StudentID';

SELECT * FROM Student
WHERE LastName = '&LastName' AND FirstName = '&FirstName';

INSERT INTO Student
values('&StudentID', '&FirstName', '&LastName', '&Address', '&City', '&State', '&ZipCode', NULL, SYSDATE, '&Major');

--Creates a view that calculates student tuition--
CREATE OR REPLACE VIEW StudentTuition as
SELECT StudentID, LastName, FirstName, TO_CHAR(SUM(CreditHours) * 258, '$99999.99') as Tuition
FROM Student NATURAL JOIN StudentSchedule NATURAL JOIN ScheduleOfClasses NATURAL JOIN CourseInventory
GROUP BY(StudentID, LastName, FirstName);

SELECT * FROM StudentTuition;

--Indexes--

CREATE INDEX Course_Title_idx
ON CourseInventory(CourseTitle);

CREATE BITMAP INDEX Student_City_idx
ON Student(City);