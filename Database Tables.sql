---Antibuddies Basics Script
---CS 4550 Summer 2019
---This script contains the tables, primary, and foreign keys for the database.

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

------------------------------------
--INSERT STATEMENTS
------------------------------------
---I use this section to insert data to run tests
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