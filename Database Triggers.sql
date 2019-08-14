---Antibuddies Trigger Script
---CS 4550 Summer 2019
---This script is just all of the triggers used in the antibuddies database.


USE antibuddies;

DROP TRIGGER IF EXISTS new_user;
DROP TRIGGER IF EXISTS new_panel;
DROP TRIGGER IF EXISTS new_course;
DROP TRIGGER IF EXISTS new_question;

GO

---This trigger activates if a new user is created. It populates all score tables (PanelScores, PQScores) and links it to all avaiable Courses (Classes).
CREATE TRIGGER new_user ON dbo.Users 
AFTER INSERT
AS
BEGIN
	DECLARE @userid int;
	DECLARE @panelid int;
	DECLARE @courseid int;
	DECLARE @questionid int;

	---For loop variables
	DECLARE @i int;
	DECLARE @size int;

	---Tables for looping
	DECLARE @panel_table TABLE (
		pt_id int PRIMARY KEY IDENTITY(1,1),
		panel_id int
	)

	DECLARE @question_table TABLE (
		qt_id int PRIMARY KEY IDENTITY(1,1),
		question_id int
	)

	DECLARE @course_table TABLE (
		ct_id int PRIMARY KEY IDENTITY(1,1),
		course_id int
	)

	SELECT @userid = i.user_id FROM inserted i;


	---populate @panel_table
	INSERT INTO @panel_table
	SELECT distinct panel_id FROM Panels

	---populate @course_table
	INSERT INTO @course_table
	SELECT distinct course_id FROM Courses

	---populate @question_table
	INSERT INTO @question_table
	SELEct distinct question_id FROM PracticeQuestions

	---go through select query to get each individual panel_id
	SET @i = 1
	SET @size = (SELECT COUNT(*) FROM @panel_table)
	IF @size > 0
		WHILE (@i <= (SELECT MAX(pt_id) FROM @panel_table))
		BEGIN

			---get the next panel primary key

			SELECT @panelid = panel_id
			FROM @panel_table
			WHERE pt_id = @i

			INSERT INTO dbo.PanelScores
			(panel_id, user_id)
			VALUES
			(@panelid, @userid) 

			SET @i = @i + 1
		END

	---go through select query to get each individual course_id
	SET @i = 1
	SET @size = (SELECT COUNT(*) FROM @course_table)
	IF @size > 0
		WHILE (@i <= (SELECT MAX(ct_id) FROM @course_table))
		BEGIN

			---get the next course primary key

			SELECT @courseid = course_id
			FROM @course_table
			WHERE ct_id = @i

			INSERT INTO dbo.Classes
			(user_id, course_id)
			VALUES
			(@userid, @courseid) 

			SET @i = @i + 1
		END

	---go through select query to get each individual question_id
	SET @i = 1
	SET @size = (SELECT COUNT(*) FROM @question_table)
	IF @size > 0
		WHILE (@i <= (SELECT MAX(qt_id) FROM @question_table))
		BEGIN

			---get the next question primary key

			SELECT @questionid = question_id
			FROM @question_table
			WHERE qt_id = @i

			INSERT INTO dbo.PQScores
			(question_id, user_id)
			VALUES
			(@questionid, @userid) 

			SET @i = @i + 1
		END

		PRINT 'new_user trigger was successful'
END

GO

---This trigger activates if a new Panel is created making a new PanelScore object for each user for the new Panel.
CREATE TRIGGER new_panel ON dbo.Panels
AFTER INSERT
AS
BEGIN
	DECLARE @userid int;
	DECLARE @panelid int;

	---For loop variables
	DECLARE @i int;
	DECLARE @size int;

	---Tables for looping
	DECLARE @user_table TABLE (
		u_id int PRIMARY KEY IDENTITY(1,1),
		user_id int
	)

	SELECT @panelid = i.panel_id FROM inserted i

	---populate @user_table
	INSERT INTO @user_table
	SELECT distinct user_id FROM Users

	---go through select query to get each individual user_id
	SET @i = 1
	SET @size = (SELECT COUNT(*) FROM @user_table)
	IF @size > 0
		WHILE (@i <= (SELECT MAX(u_id) FROM @user_table))
		BEGIN

			---get the next user primary key

			SELECT @userid = user_id
			FROM @user_table
			WHERE u_id = @i

			INSERT INTO dbo.PanelScores
			(panel_id, user_id)
			VALUES
			(@panelid, @userid) 

			SET @i = @i + 1
		END

		PRINT 'new_panel trigger was successful'
END

GO

---This trigger activates if a new Question is created making a new PQScore object for each user for the new Question.
CREATE TRIGGER new_question ON dbo.PracticeQuestions
AFTER INSERT
AS
BEGIN
	DECLARE @userid int;
	DECLARE @questionid int;

	---For loop variables
	DECLARE @i int;
	DECLARE @size int;

	---Tables for looping
	DECLARE @user_table TABLE (
		u_id int PRIMARY KEY IDENTITY(1,1),
		user_id int
	)

	SELECT @questionid = i.question_id FROM inserted i

	---populate @user_table
	INSERT INTO @user_table
	SELECT distinct user_id FROM Users

	---go through select query to get each individual user_id
	SET @i = 1
	SET @size = (SELECT COUNT(*) FROM @user_table)
	IF @size > 0
		WHILE (@i <= (SELECT MAX(u_id) FROM @user_table))
		BEGIN

			---get the next user primary key

			SELECT @userid = user_id
			FROM @user_table
			WHERE u_id = @i

			INSERT INTO dbo.PQScores
			(question_id, user_id)
			VALUES
			(@questionid, @userid) 

			SET @i = @i + 1
		END

		PRINT 'new_question trigger was successful'
END

GO

---This trigger activates if a new course is created linking each user to it by creating a new Class object for each user.
CREATE TRIGGER new_course ON dbo.Courses
AFTER INSERT
AS
BEGIN
	DECLARE @courseid int;
	DECLARE @userid int;

	---For loop variables
	DECLARE @i int;
	DECLARE @size int;

	---Tables for looping
	DECLARE @user_table TABLE (
		u_id int PRIMARY KEY IDENTITY(1,1),
		user_id int
	)

	SELECT @courseid = i.course_id FROM inserted i

	---populate @user_table
	INSERT INTO @user_table
	SELECT distinct user_id FROM Users

	---go through select query to get each individual user_id
	SET @i = 1
	SET @size = (SELECT COUNT(*) FROM @user_table)
	IF @size > 0
		WHILE (@i <= (SELECT MAX(u_id) FROM @user_table))
		BEGIN

			---get the next user primary key

			SELECT @userid = user_id
			FROM @user_table
			WHERE u_id = @i

			INSERT INTO dbo.Classes
			(user_id, course_id)
			VALUES
			(@userid, @courseid) 

			SET @i = @i + 1
		END

		PRINT 'new_course trigger was successful'
END

GO


---INSERT statements to test triggers

/*
INSERT INTO Users
(firstName, lastName, username, password, isAdmin)
VALUES
('Joe', 'Johnson', 'jj', 'qwerty', 0)

INSERT INTO dbo.CourseItems
(course_id, itemType, createdBy, createdDate)
VALUES
(1, 'P', 'Ethan MacArthur', GETDATE())

INSERT INTO dbo.Panels
(citem_id, panelName, pdifficulty)
VALUES
(2, 'Panel 2', 'Easy')
*/

SELECT * FROM Courses
SELECT * FROM Classes
SELECT * FROM Users
SELECT * FROM CourseItems
SELECT * FROM Panels
SELECT * FROM PanelRows
SELECT * FROM PanelScores
SELECT * FROM PracticeQuestions
SELECT * FROM PQAnswers
SELECT * FROM PQScores