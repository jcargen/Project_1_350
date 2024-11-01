-- Creating the Senators table
CREATE TABLE Senators (
    Senator_ID SERIAL PRIMARY KEY,
    First_Name VARCHAR(100) NOT NULL,
    Last_Name VARCHAR(100) NOT NULL,
    Party VARCHAR(50) NOT NULL,
    State VARCHAR(2) NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE,
    Email VARCHAR(150),
    Phone_Number VARCHAR(15)
);

-- Creating the Committees table
CREATE TABLE Committees (
    Committee_ID SERIAL PRIMARY KEY,
    Name VARCHAR(150) NOT NULL,
    Chairperson_ID INT REFERENCES Senators(Senator_ID)
);

-- Creating the Committee_Memberships table
CREATE TABLE Committee_Memberships (
    Membership_ID SERIAL PRIMARY KEY,
    Committee_ID INT REFERENCES Committees(Committee_ID),
    Senator_ID INT REFERENCES Senators(Senator_ID)
);

-- Creating the Legislative_Bills table
CREATE TABLE Legislative_Bills (
    Bill_ID SERIAL PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Summary TEXT,
    Sponsor_ID INT REFERENCES Senators(Senator_ID),
    Date_Introduced DATE NOT NULL,
    Status VARCHAR(50)
);

-- Creating the Votes table
CREATE TABLE Votes (
    Vote_ID SERIAL PRIMARY KEY,
    Bill_ID INT REFERENCES Legislative_Bills(Bill_ID),
    Senator_ID INT REFERENCES Senators(Senator_ID),
    Vote VARCHAR(10) CHECK (Vote IN ('Yea', 'Nay', 'Abstain'))
);

-- Creating an index on the Senator's state to speed up queries involving filtering by state
CREATE INDEX idx_senators_state ON Senators(State);





-- Creating the House_Representatives table
CREATE TABLE House_Representatives (
    Representative_ID SERIAL PRIMARY KEY,
    First_Name VARCHAR(100) NOT NULL,
    Last_Name VARCHAR(100) NOT NULL,
    Party VARCHAR(50) NOT NULL,
    State VARCHAR(2) NOT NULL,
    District INT NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE,
    Email VARCHAR(150),
    Phone_Number VARCHAR(15)
);

-- Creating a Committee_Memberships_House table to relate House Representatives to Committees
CREATE TABLE Committee_Memberships_House (
    Membership_ID SERIAL PRIMARY KEY,
    Committee_ID INT REFERENCES Committees(Committee_ID),
    Representative_ID INT REFERENCES House_Representatives(Representative_ID)
);

-- Creating a Legislative_Bills_House table for bills introduced by House Representatives
CREATE TABLE Legislative_Bills_House (
    Bill_ID SERIAL PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Summary TEXT,
    Sponsor_ID INT REFERENCES House_Representatives(Representative_ID),
    Date_Introduced DATE NOT NULL,
    Status VARCHAR(50)
);

-- Creating the Votes_House table to record votes from Representatives on House bills
CREATE TABLE Votes_House (
    Vote_ID SERIAL PRIMARY KEY,
    Bill_ID INT REFERENCES Legislative_Bills_House(Bill_ID),
    Representative_ID INT REFERENCES House_Representatives(Representative_ID),
    Vote VARCHAR(10) CHECK (Vote IN ('Yea', 'Nay', 'Abstain'))
);

-- Index for faster lookup on House_Representatives by state
CREATE INDEX idx_house_reps_state ON House_Representatives(State);


