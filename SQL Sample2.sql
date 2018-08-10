SELECT CourseInventory.CourseNumber, ScheduleOfClasses.ClassCode, CourseInventory.CourseTitle, ScheduleOfClasses.SemesterCode, Student.LastName, Student.FirstName
FROM Student JOIN StudentSchedule ON Student.StudentID = StudentSchedule.StudentID
JOIN ScheduleOfClasses ON (StudentSchedule.SemesterCode = ScheduleOfClasses.SemesterCode AND StudentSchedule.ClassCode = ScheduleOfClasses.ClassCode)
RIGHT JOIN CourseInventory ON (ScheduleOfClasses.DepartmentName = CourseInventory.DepartmentName AND ScheduleOfClasses.CourseNumber = CourseInventory.CourseNumber)
ORDER BY CourseNumber, ClassCode, LastName, FirstName;

SELECT i.InstructorID, i.LastName, i.FirstName, i.Rank, ci.DepartmentName, ci.CourseNumber, ci.CourseTitle, soc.SemesterCode, soc.ClassCode, soc.ClassSection, soc.Days, soc.Times, soc.Location, soc.CurrentEnrollment, ci.CreditHours, soc.MaximumEnrollment,
(Select Count(*) FROM ScheduleOfClasses a WHERE a.InstructorID = i.InstructorID) as "Total Courses"
FROM Instructor i JOIN ScheduleOfClasses soc ON i.InstructorID = soc.InstructorID
JOIN CourseInventory ci ON (soc.DepartmentName = ci.DepartmentName AND soc.CourseNumber = ci.CourseNumber)
ORDER BY i.InstructorID;

SELECT s.StudentID, s.LastName, s.FirstName, soc.SemesterCode, soc.ClassCode, ci.DepartmentName, ci.CourseNumber, ci.CourseTitle, soc.Days, soc.Times, soc.Location, i.LastName, i.FirstName, ci.CreditHours,
(Select SUM(CreditHours) FROM CourseInventory a JOIN ScheduleOfClasses b ON (a.DepartmentName = b.DepartmentName AND a.CourseNumber = b.CourseNumber)
JOIN StudentSchedule c ON (b.SemesterCode = c.SemesterCode AND b.ClassCode = c.ClassCode)
WHERE c.StudentID = s.StudentID) as "Total Credits"
FROM Student s JOIN StudentSchedule ss ON s.StudentID = ss.StudentID
JOIN ScheduleOfClasses soc ON (ss.SemesterCode = soc.SemesterCode AND ss.ClassCode = soc.ClassCode)
JOIN Instructor i ON soc.InstructorID = i.InstructorID
JOIN CourseInventory ci ON (soc.DepartmentName = ci.DepartmentName AND soc.CourseNumber = ci.CourseNumber)
ORDER BY s.STUDENTID, ci.COURSENUMBER, soc.CLASSCODE;

SELECT 'Instructor' as "Type", FirstName, LastName, Email FROM Instructor WHERE (Email NOT LIKE '%@%') or (Email is NULL) 
UNION SELECT 'Student', FirstName, LastName, Email FROM Student WHERE (Email NOT LIKE '%@%') or (Email is NULL) ORDER BY LASTNAME, FIRSTNAME;

SELECT DISTINCT i.InstructorID, i.LastName, i.FirstName,
NVL((Select SUM(CreditHours) FROM CourseInventory a JOIN ScheduleOfClasses b ON (a.DepartmentName = b.DepartmentName AND a.CourseNumber = b.CourseNumber)
WHERE b.InstructorID = i.InstructorID), 0) as Workload
FROM ScheduleOfClasses soc JOIN CourseInventory ci ON (soc.DepartmentName = ci.DepartmentName AND soc.CourseNumber = ci.CourseNumber)
RIGHT JOIN Instructor i ON soc.InstructorID = i.InstructorID
ORDER BY i.InstructorID;

SELECT ci.DepartmentName, ci.CourseNumber, ci.CourseTitle,
(Select COUNT(*) FROM ScheduleOfClasses a WHERE (a.DepartmentName = ci.DepartmentName AND a.CourseNumber = ci.CourseNumber)) as "Courses Offered"
FROM CourseInventory ci;