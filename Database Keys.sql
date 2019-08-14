---Antibuddies Keys Script
---CS 4550 Summer 2019
---This script contains all of the DATA/CHECK keys  and ALTERNATIVE keys

USE antibuddies;
	
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
	ADD CONSTRAINT CK_PanelRows_lc
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