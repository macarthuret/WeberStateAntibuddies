--Antibuddies Creation Script
--CS 4550 Summer 2019
--This script contains all of the elements of the database in one script.

USE antibuddies;

------------------------
---Drop all tables
------------------------

/*
DROP TABLE IF EXISTS Courses

DROP TABLE IF EXISTS Users;

DROP TABLE IF EXISTS Classes;

DROP TABLE IF EXISTS CourseItems;

DROP TABLE IF EXISTS Panels;

DROP TABLE IF EXISTS PanelRows;

DROP TABLE IF EXISTS PanelScores;

DROP TABLE IF EXISTS PracticeQuestions;

DROP TABLE IF EXISTS PQAnswers;

DROP TABLE IF EXISTS PQScores;
*/

------------------------
----Create all tables
-----------------------
/*
---This table consists of all courses that will be shown in the app or website, courses can be added or deleted at this table.
CREATE TABLE dbo.Courses
	(
	course_id int IDENTITY(1,1) NOT NULL,
	courseName nvarchar(50) NOT NULL
	);

---This table consists of all users who use the app or website. Admins are just a type of user.
CREATE TABLE dbo.Users
	(
	user_id int IDENTITY(1,1) NOT NULL,
	firstName nvarchar(25) NOT NULL,
	lastName nvarchar(25) NOT NULL,
	username nvarchar(50) NOT NULL,
	password nvarchar(64) NOT NULL,
	isAdmin BIT NOT NULL				--This variable represents whether a user is an adimin (1) or not (0).
	);

---This table is a relationship table between Courses and Users to show users enrolled in each course.
---Currently this table is automatically created by a trigger, which puts all users including admins in all courses.
CREATE TABLE dbo.Classes
	(
	class_id int IDENTITY(1,1) NOT NULL,
	user_id int NOT NULL,
	course_id int NOT NULL
	);

---This table contains all courseItems for all courses. Each course item represents a item in the course.
CREATE TABLE dbo.CourseItems
	(
	citem_id int IDENTITY(1,1) NOT NULL,
	course_id int NOT NULL,
	itemType nvarchar(1) NOT NULL,			--This variable is currently set to only 'Q' or 'P' for question or Panel.
	createdBy nvarchar(50) NOT NULL,		--To show what admin created the item.
	createdDate datetime2 NOT NULL
	);
	
---This table contains panel basic table data.
CREATE TABLE dbo.Panels
	(
	panel_id int IDENTITY(1,1) NOT NULL,
	citem_id int NOT NULL,
	panelName nvarchar(25) NOT NULL,
	pdifficulty int NOT NULL				--Should only accept 1,2, or 3. For beginner, intermediate, and advanced.
	);

---This table contains all of the data for a specific row inside of a panel.
---Variables with l in front are representations for little.
CREATE TABLE dbo.PanelRows
	(
	row_id int IDENTITY(1,1) NOT NULL,
	panel_id int NOT NULL,
	rowNumber int NOT NULL,					--This variable is for ordering rows in a panel to make sure it is the same for all instances the panel is used.
	D nvarchar(1) NOT NULL,
	C nvarchar(1) NOT NULL,
	lc nvarchar(1) NOT NULL,
	E nvarchar(1) NOT NULL,
	le nvarchar(1) NOT NULL,
	f nvarchar(1) NOT NULL,
	V nvarchar(1) NOT NULL,
	Cw nvarchar(1) NOT NULL,
	K nvarchar(1) NOT NULL,
	lk nvarchar(1) NOT NULL,
	Kpa nvarchar(1) NOT NULL,
	Kpb nvarchar(1) NOT NULL,
	Jsa nvarchar(1) NOT NULL,
	Jsb nvarchar(1) NOT NULL,
	Fya nvarchar(1) NOT NULL,
	Fyb nvarchar(1) NOT NULL,
	Jka nvarchar(1) NOT NULL,
	Jkb nvarchar(1) NOT NULL,
	Lea nvarchar(1) NOT NULL,
	Leb nvarchar(1) NOT NULL,
	P1 nvarchar(1) NOT NULL,
	M nvarchar(1) NOT NULL,
	N nvarchar(1) NOT NULL,
	S nvarchar(1) NOT NULL,
	ls nvarchar(1) NOT NULL,
	Lua nvarchar(1) NOT NULL,
	Lub nvarchar(1) NOT NULL,
	Xga nvarchar(1) NOT NULL,
	rIS nvarchar(2) NOT NULL,
	thirtySeven nvarchar(2) NOT NULL,
	AHG nvarchar(2) NOT NULL,
	CC BIT NOT NULL,
	);

---This table shows the score that a user gets after going through the panel.
CREATE TABLE dbo.PanelScores
	(
	panelScore_id int IDENTITY(1,1) NOT NULL,
	panel_id int NOT NULL,
	user_id int NOT NULL,
	errors int DEFAULT 0,		---This is default 0 because they have made no errors	
	tries int DEFAULT 0,		---This is default 0 because they haven't tried yet
	completed BIT DEFAULT 0		---This is default 0 because they haven't completed it yet
	);

---This table contains the information for a practice question.
CREATE TABLE dbo.PracticeQuestions
	(
	question_id int IDENTITY(1,1) NOT NULL,
	citem_id int NOT NULL,
	section nvarchar(100) NOT NULL,
	question nvarchar(500) NOT NULL,
	qdifficulty int NOT NULL,					--Should only accept 1,2, or 3. For beginner, intermediate, and advanced.
	atype int NOT NULL,							--This variable is the number to the correct answer. AKA it should make an anum variable.
	aresponse nvarchar(500) NOT NULL			--This is the explanation of why the question is answered is for example C.
	);

---This table contains all of the possible answers for a question.
CREATE TABLE dbo.PQAnswers
	(
	qanswer_id int IDENTITY(1,1) NOT NULL,
	question_id int NOT NULL,
	qanswer nvarchar(250) NOT NULL,				--This is a string to contain the answer statement.
	anum int NOT NULL							--This is a variable to show what answer this is. For 3 answers it could be 0,1, or 2.
	);

---This table shows if the user got the question correct or not.
CREATE TABLE dbo.PQScores
	(
	qscore_id int IDENTITY(1,1) NOT NULL,
	question_id int NOT NULL,
	user_id int NOT NULL,
	correct BIT DEFAULT 0,		---This is default 0 because they haven't tried it yet.
	completed BIT DEFAULT 0		---This is default 0 because they haven't completed it yet.
	);

--------------------------
--- CREATE Primary Keys
--------------------------

ALTER TABLE Courses
	ADD CONSTRAINT PK_Courses
	PRIMARY KEY CLUSTERED (course_id);

ALTER TABLE Classes
	ADD CONSTRAINT PK_Classes
	PRIMARY KEY CLUSTERED (class_id);

ALTER TABLE Users
	ADD CONSTRAINT PK_Users
	PRIMARY KEY CLUSTERED (user_id);
	
ALTER TABLE CourseItems
	ADD CONSTRAINT PK_CourseItems
	PRIMARY KEY CLUSTERED (citem_id);

ALTER TABLE Panels
	ADD CONSTRAINT PK_Panels
	PRIMARY KEY CLUSTERED (panel_id);
	
ALTER TABLE PanelRows
	ADD CONSTRAINT PK_PanelRows
	PRIMARY KEY CLUSTERED (row_id);
	
ALTER TABLE PanelScores
	ADD CONSTRAINT PK_PanelScores
	PRIMARY KEY CLUSTERED (panelScore_id);

ALTER TABLE PracticeQuestions
	ADD CONSTRAINT PK_PracticeQuestions
	PRIMARY KEY CLUSTERED (question_id);

ALTER TABLE PQAnswers
	ADD CONSTRAINT PK_PQAnswers
	PRIMARY KEY CLUSTERED (qanswer_id);

ALTER TABLE PQScores
	ADD CONSTRAINT PK_PQScores
	PRIMARY KEY CLUSTERED (qscore_id);

---------------------------
---CREATE Foreign Keys
---------------------------

ALTER TABLE Classes
	ADD CONSTRAINT FK_Classes_user_id
	FOREIGN KEY (user_id)
	REFERENCES Users(user_id);

ALTER TABLE Classes
	ADD CONSTRAINT FK_Classes_course_id
	FOREIGN KEY (course_id)
	REFERENCES Courses(course_id);

ALTER TABLE CourseItems
	ADD CONSTRAINT FK_CourseItems_course_id
	FOREIGN KEY (course_id)
	REFERENCES Courses(course_id);

ALTER TABLE Panels
	ADD CONSTRAINT FK_CourseItems_citem_id
	FOREIGN KEY (citem_id)
	REFERENCES CourseItems(citem_id);

ALTER TABLE PanelRows
	ADD CONSTRAINT FK_PanelRows_panel_id
	FOREIGN KEY (panel_id)
	REFERENCES PanelRows(row_id);

ALTER TABLE PanelScores
	ADD CONSTRAINT FK_PanelScores_panel_id
	FOREIGN KEY (panel_id)
	REFERENCES Panels(panel_id);

ALTER TABLE PanelScores
	ADD CONSTRAINT FK_PanelScore_user_id
	FOREIGN KEY (user_id)
	REFERENCES Users(user_id);

ALTER TABLE PracticeQuestions
	ADD CONSTRAINT FK_PracticeQuestions_citem_id
	FOREIGN KEY (citem_id)
	REFERENCES CourseItems(citem_id);

ALTER TABLE PQAnswers
	ADD CONSTRAINT FK_PQAnswers_question_id
	FOREIGN KEY (question_id)
	REFERENCES PracticeQuestions(question_id);

ALTER TABLE PQScores
	ADD CONSTRAINT FK_PQScores_question_id
	FOREIGN KEY (question_id)
	REFERENCES PracticeQuestions(question_id);

ALTER TABLE PQScores
	ADD CONSTRAINT FK_PQScores_user_id
	FOREIGN KEY (user_id)
	REFERENCES Users(user_id);
	
--------------------------
---CREATE Alternate Keys
--------------------------

---This makes sure that all course names are unique
ALTER TABLE Courses
	ADD CONSTRAINT AK_Courses_courseName
	UNIQUE(courseName)

---This makes sure that the all usernames are unique

ALTER TABLE Users
	ADD CONSTRAINT AK_Users_username
	UNIQUE(username)
	
---This makes sure there are not multiple same named Panels.
ALTER TABLE Panels
	ADD CONSTRAINT AK_Panels_panelName
	UNIQUE(panelName)

---This makes sure there are no duplicate practice questions.
ALTER TABLE PracticeQuestions
	ADD CONSTRAINT AK_PracticeQuestions_question
	UNIQUE(question)
	
---This makes sure there is not two same named Panels with the same difficulty
ALTER TABLE Panels
	ADD CONSTRAINT AK_Panels_panelName_difficulty
	UNIQUE(panelName, pdifficulty)

---This makes sure that a Panel doesn't have the same rowNumbers for a panel ex. 2 row 6's 
ALTER TABLE PanelRows
	ADD CONSTRAINT AK_PanelRows_panel_id_rowNumber
	UNIQUE(panel_id, rowNumber)

---This makes sure that there are not duplicate Answers numbers for a question (Ex. two b's for an a,b,c,or d question)
ALTER TABLE PQAnswers
	ADD CONSTRAINT AK_PQAnswers_question_id_anum
	UNIQUE(question_id, anum)
	

--------------------------
---CREATE Data Constraints
--------------------------

---ItemTypes are for the types of course items that can be made. (P = Panels, Q = Questions)

ALTER TABLE CourseItems
	ADD CONSTRAINT CK_CourseItems_itemType
	CHECK (itemType = 'P' OR itemType = 'Q')

---This makes sure that the difficulties in Panels and PracticeQuestions to only allow 1,2,3 (Beginner, Intermediate, Advanced)

ALTER TABLE Panels
	ADD CONSTRAINT CK_Panels_pdifficulty
	CHECK (pdifficulty = 1 OR pdifficulty = 2 OR pdifficulty = 3)
	
ALTER TABLE PracticeQuestions
	ADD CONSTRAINT CK_PracticeQuestions_qdifficulty
	CHECK (qdifficulty = 1 OR qdifficulty = 2 OR qdifficulty = 3)

---Antibody variables are only allowed to have 0, +, or W as characters. DOES NOT INCLUDE RESULT SET (IS, 37, AHG, CC)

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_D
	CHECK (D ='0' OR D = '+' OR D = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_C
	CHECK (C ='0' OR C = '+' OR C = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_lc7
	CHECK (lc ='0' OR lc = '+' OR lc = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_E
	CHECK (E ='0' OR E = '+' OR E = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_le
	CHECK (le ='0' OR le = '+' OR le = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_f
	CHECK (f ='0' OR f = '+' OR f = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_V
	CHECK (V ='0' OR V = '+' OR V = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_Cw
	CHECK (Cw ='0' OR Cw = '+' OR Cw = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_K
	CHECK (K ='0' OR K = '+' OR K = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_lk
	CHECK (lk ='0' OR lk = '+' OR lk = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_Kpa
	CHECK (Kpa ='0' OR Kpa = '+' OR Kpa = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_Kpb
	CHECK (Kpb ='0' OR Kpb = '+' OR Kpb = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_Jsa
	CHECK (Jsa ='0' OR Jsa = '+' OR Jsa = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_Fya
	CHECK (Fya ='0' OR Fya = '+' OR Fya = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_Fyb
	CHECK (Fyb ='0' OR Fyb = '+' OR Fyb = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_Jka
	CHECK (Jka ='0' OR Jka = '+' OR Jka = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_Jkb
	CHECK (Jkb ='0' OR Jkb = '+' OR Jkb = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_Lea
	CHECK (Lea ='0' OR Lea = '+' OR Lea = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_Leb
	CHECK (Leb ='0' OR Leb = '+' OR Leb = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRow_Pl
	CHECK (P1 ='0' OR P1 = '+' OR P1 = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_M
	CHECK (M ='0' OR M = '+' OR M = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_N
	CHECK (N ='0' OR N = '+' OR N = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_S
	CHECK (S ='0' OR S = '+' OR S = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_ls
	CHECK (ls ='0' OR ls = '+' OR ls = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_Lua
	CHECK (Lua ='0' OR Lua = '+' OR Lua = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_Lub
	CHECK (Lub ='0' OR Lub = '+' OR Lub = 'W')

ALTER TABLE PanelRows
	ADD CONSTRAINT CK_PanelRows_Xga
	CHECK (Xga ='0' OR Xga = '+' OR Xga = 'W')

GO

--------------------------------
---CREATE FUNCTIONS
--------------------------------
---These functions are table-valued Functions that are just querys that can be called to remove code from the app and website.


GO
---This function finds all questions from a course based on the course_id and question difficulty (qdifficulty)
CREATE FUNCTION questionsDifficulty (
	@courseid int,
	@difficulty int
)
RETURNS TABLE
AS 
RETURN
	SELECT q.question_id, q.citem_id, q.section, q.question, q.qdifficulty, q.atype, q.aresponse
	FROM
		Courses c
		INNER JOIN CourseItems ci
		ON c.course_id = ci.course_id
		INNER JOIN PracticeQuestions q
		ON q.citem_id = ci.citem_id

	WHERE
		q.qdifficulty = @difficulty AND c.course_id = @courseid
GO

---This function finds all panels from a course based on the course_id and panel difficulty (pdifficulty)
CREATE FUNCTION panelsDifficulty (
	@courseid int,
	@difficulty int
)
RETURNS TABLE
AS 
RETURN
	SELECT p.panel_id, p.citem_id, p.panelName, p.pdifficulty
	FROM
		Courses c
		INNER JOIN CourseItems ci
		ON c.course_id = ci.course_id
		INNER JOIN 	Panels p
		ON p.citem_id = ci.citem_id
	WHERE
		p.pdifficulty = @difficulty AND c.course_id = @courseid
GO

---Function to find panel based on course_id ane panelName.
CREATE FUNCTION panelsName (
	@courseid int,
	@pName nvarchar(25)
)
RETURNS TABLE
AS 
RETURN
	SELECT p.panel_id, p.citem_id, p.panelName, p.pdifficulty
	FROM
		Courses c
		INNER JOIN CourseItems ci
		ON c.course_id = ci.course_id
		INNER JOIN 	Panels p
		ON p.citem_id = ci.citem_id
	WHERE
		p.panelName = @pName AND c.course_id = @courseid

GO


---This function finds all of the panelScores for a User from a specific course.
CREATE FUNCTION userPanelScores (
	@courseid int,
	@userid int
)
RETURNS TABLE
AS
RETURN
	SELECT ps.panelScore_id, ps.panel_id, ps.user_id, ps.errors, ps.tries, ps.completed
	FROM
		Courses c
		INNER JOIN CourseItems ci
		ON c.course_id = ci.course_id
		INNER JOIN 	Panels p
		ON p.citem_id = ci.citem_id
		INNER JOIN PanelScores ps
		ON p.panel_id = ps.panel_id
	WHERE
		ps.user_id = @userid AND c.course_id = @courseid;

GO

---This function finds all of the questionScores for a User from a specific course.
CREATE FUNCTION userQuestionScores (
	@courseid int,
	@userid int
)
RETURNS TABLE
AS
RETURN
	SELECT pqs.qscore_id, pqs.question_id, pqs.user_id, pqs.correct, pqs.completed
	FROM
		Courses c
		INNER JOIN CourseItems ci
		ON c.course_id = ci.course_id
		INNER JOIN PracticeQuestions pq
		ON pq.citem_id = ci.citem_id
		INNER JOIN PQScores pqs
		ON pq.question_id = pqs.qscore_id
	WHERE
		pqs.user_id = @userid AND c.course_id = @courseid;
GO
*/

-------------------------------
---CREATE TRIGGERS
-------------------------------
GO

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

------------------------------------
--INSERT STATEMENTS
------------------------------------
---I use this section to insert data to run tests for new triggers or procedures.
/*

INSERT INTO dbo.Courses
(courseName)
VALUES
('Blood Work')

INSERT INTO dbo.CourseItems
(course_id, itemType, createdBy, createdDate)
VALUES
(1, 'P', 'Ethan MacArthur', GETDATE()),
(1, 'P', 'Ethan MacArthur', GETDATE()),
(1, 'Q', 'Ethan MacArthur', GETDATE()),
(1, 'Q', 'Ethan MacArthur', GETDATE())

INSERT INTO dbo.Panels
(citem_id, panelName, pdifficulty)
VALUES
(1, 'Panel 1', 1)
INSERT INTO dbo.Panels
(citem_id, panelName, pdifficulty)
VALUES
(2, 'Panel 2', 1)

INSERT INTO dbo.PanelRows
(panel_id, rowNumber,D,C,lc,E,le,f,V,Cw,K,lk,Kpa,Kpb,Jsa,Jsb,Fya,Fyb,Jka,Jkb,Lea,Leb,P1,M,N,S,ls,Lua,Lub,Xga,rIS,thirtyseven,AHG,CC)
VALUES
(1,0,'+','0','0','+','+','+','0','0','0','+','0','+','+','0','+','+','0','0','+','0','0','+','+','+','0','+','0','+','0','3+','4+',0),
(1,1,'0','0','0','+','+','+','0','+','0','+','0','+','+','0','0','+','0','0','+','0','0','+','+','+','0','+','0','+','0','3+','4+',0),
(1,2,'+','0','+','+','0','+','0','0','0','+','0','+','0','0','+','+','0','+','+','+','0','+','+','0','0','+','0','+','0','3+','4+',0),
(1,3,'+','+','0','+','+','0','0','0','+','0','0','+','0','+','+','0','+','0','+','0','0','+','+','+','0','+','0','+','0','3+','4+',0)

INSERT INTO dbo.Users
(firstName, lastName, username, password, isAdmin)
VALUES
('Ethan', 'MacArthur', 'mac', '123456', 0)
INSERT INTO dbo.Users
(firstName, lastName, username, password, isAdmin)
VALUES
('Test', 'Student', 'test1', '0123456789', 0)
INSERT INTO dbo.Users
(firstName, lastName, username, password, isAdmin)
VALUES
('Ben', 'Oliverson', 'boliverson', '9eb5512db71ca6d5f701dd5ecc70355a0858924afeccc6e8fc2de2280cfa7b67', 0)

INSERT INTO dbo.PracticeQuestions
(citem_id, section, question, qdifficulty, atype, aresponse)
VALUES
(3, 'Blood Group Systems', 'Which of the following antibodies can be neutralized by pooled human plasma?', 1, 2, 'Correct response is B. Anti-Ch and anti-Rg can be neutralized by pooled human plasma because the Ch and Rg antigens reside on complement protein C4. Neutralization studies with pooled plasma can help confirm the antibody reactivity in a patient’s sample. (Source Harmening, 7th Edition, Chapter...)')

INSERT INTO dbo.PracticeQuestions
(citem_id, section, question, qdifficulty, atype, aresponse)
VALUES
(4, 'Serology', 'The following test results are noted for a unit of blood labeled group A, Rh-negative: Cells tested with: anti-A anti-B anti-D 4+ 0 3+ What should be done next?', 1, 2, 'Correct response is C. A serological test to confirm the ABO on all RBC units and Rh on units labeled as Rh-negative must be performed prior to transfusion. Any errors in labeling must be reported to the collecting facility. (Source AABB Standards, Section...)')

INSERT INTO dbo.PQAnswers
(question_id, qanswer, anum)
VALUES
(1, 'anti-Kna', 0),
(1, 'anti-Ch', 1),
(1, 'anti-Yka', 2),
(1, 'anti-Csa', 3),
(2, 'transfuse as a group A, Rh-negative', 0),
(2, 'transfuse as a group A, Rh-positive', 1),
(2, 'notify the collecting facility', 2),
(2, 'discard the unit', 3)

*/

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

GO

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


----Test Functions Statements
SELECT *
FROM questionsDifficulty(1,1);

SELECT *
FROM panelsName(1,'Panel 1');

SELECT *
FROM panelsDifficulty(2,2);

SELECT *
FROM questionQuestionScores(1,3);

SELECT *
FROM panelPanelScores(1,1);

SELECT *
FROM userPanelScores(1,1);

SELECT *
FROM userQuestionScores(1,1);