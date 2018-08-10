UPDATE ScheduleOfClasses soc
Set CurrentEnrollment = 
(Select Count(*) 
FROM StudentSchedule a
WHERE (a.SemesterCode = soc.SemesterCode AND a.ClassCode = soc.ClassCode));

UPDATE Student
SET Email = SUBSTR(FIRSTNAME, 1, 3) || SUBSTR(LASTNAME, 1, 8) || SUBSTR(StudentID, -2, 2) || '@kent.edu'
WHERE Email IS NULL;