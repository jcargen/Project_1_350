-- Data Entry for the Senate and House Database

-- Inserting Data into Senators Table
INSERT INTO Senators (First_Name, Last_Name, Party, State, Start_Date, End_Date, Email, Phone_Number)
VALUES ('John', 'Doe', 'Democratic', 'NY', '2018-01-03', NULL, 'john.doe@senate.gov', '123-456-7890');

INSERT INTO Senators (First_Name, Last_Name, Party, State, Start_Date, End_Date, Email, Phone_Number)
VALUES ('Jane', 'Smith', 'Republican', 'CA', '2020-01-03', NULL, 'jane.smith@senate.gov', '234-567-8901');

INSERT INTO Senators (First_Name, Last_Name, Party, State, Start_Date, End_Date, Email, Phone_Number)
VALUES ('Michael', 'Johnson', 'Independent', 'TX', '2016-01-03', '2022-12-31', 'michael.johnson@senate.gov', '345-678-9012');

-- Inserting Data into House_Representatives Table
INSERT INTO House_Representatives (First_Name, Last_Name, Party, State, District, Start_Date, End_Date, Email, Phone_Number)
VALUES ('Emily', 'Davis', 'Democratic', 'FL', 12, '2019-01-03', NULL, 'emily.davis@house.gov', '456-789-0123');

INSERT INTO House_Representatives (First_Name, Last_Name, Party, State, District, Start_Date, End_Date, Email, Phone_Number)
VALUES ('Robert', 'Brown', 'Republican', 'OH', 3, '2021-01-03', NULL, 'robert.brown@house.gov', '567-890-1234');

-- Inserting Data into Committees Table
INSERT INTO Committees (Name, Chairperson_ID)
VALUES ('Finance Committee', 1);

INSERT INTO Committees (Name, Chairperson_ID)
VALUES ('Health Committee', 2);

-- Inserting Data into Committee_Memberships Table
INSERT INTO Committee_Memberships (Committee_ID, Senator_ID)
VALUES (1, 1);

INSERT INTO Committee_Memberships (Committee_ID, Senator_ID)
VALUES (2, 2);

-- Inserting Data into Committee_Memberships_House Table
INSERT INTO Committee_Memberships_House (Committee_ID, Representative_ID)
VALUES (1, 1);

-- Inserting Data into Legislative_Bills Table
INSERT INTO Legislative_Bills (Title, Summary, Sponsor_ID, Status, Date_Introduced)
VALUES ('Healthcare Reform Act', 'A bill to improve healthcare services', 2, 'In Progress', '2021-02-15');

INSERT INTO Legislative_Bills (Title, Summary, Sponsor_ID, Status, Date_Introduced)
VALUES ('Tax Reduction Act', 'A bill to reduce taxes for middle-class families', 1, 'In Progress', '2022-03-10');

-- Inserting Data into Votes Table
INSERT INTO Votes (Bill_ID, Senator_ID, Vote, Date_Voted)
VALUES (1, 1, 'Yes', '2021-02-20');

INSERT INTO Votes (Bill_ID, Senator_ID, Vote, Date_Voted)
VALUES (1, 2, 'No', '2021-02-20');

-- Inserting Data into Legislative_Bills_House Table
INSERT INTO Legislative_Bills_House (Title, Summary, Sponsor_ID, Status, Date_Introduced)
VALUES ('Education Funding Act', 'A bill to increase funding for public schools', 1, 'In Progress', '2022-05-05');

-- Inserting Data into House_Votes Table
INSERT INTO House_Votes (Bill_ID, Representative_ID, Vote, Date_Voted)
VALUES (1, 1, 'Yes', '2022-06-01');

INSERT INTO House_Votes (Bill_ID, Representative_ID, Vote, Date_Voted)
VALUES (1, 2, 'Yes', '2022-06-01');
