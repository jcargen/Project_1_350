-- Senate Database Schema with Proper Relationships and Cardinalities

-- Creating the Senators table
CREATE TABLE Senators (
    Senator_ID SERIAL PRIMARY KEY,
    First_Name VARCHAR(100) NOT NULL,
    Last_Name VARCHAR(100) NOT NULL,
    Party VARCHAR(50) NOT NULL,
    State VARCHAR(2) NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE,
    Email VARCHAR(100),
    Phone_Number VARCHAR(15)
);

-- Adding index on Last_Name to improve search performance
CREATE INDEX idx_senators_last_name ON Senators(Last_Name);

-- Creating the Committees table
CREATE TABLE Committees (
    Committee_ID SERIAL PRIMARY KEY,
    Name VARCHAR(150) NOT NULL,
    Chairperson_ID INTEGER,
    FOREIGN KEY (Chairperson_ID) REFERENCES Senators(Senator_ID) ON DELETE SET NULL
);

-- Creating the Committee Memberships table (associative table linking Senators and Committees)
CREATE TABLE Committee_Memberships (
    Membership_ID SERIAL PRIMARY KEY,
    Committee_ID INTEGER NOT NULL,
    Senator_ID INTEGER NOT NULL,
    FOREIGN KEY (Committee_ID) REFERENCES Committees(Committee_ID) ON DELETE CASCADE,
    FOREIGN KEY (Senator_ID) REFERENCES Senators(Senator_ID) ON DELETE CASCADE
);

-- Procedure to manage committee memberships when a senator's term ends
CREATE OR REPLACE PROCEDURE ManageCommitteeMemberships(senator_id INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Committee_Memberships
    WHERE Senator_ID = senator_id;
    
    -- Log the membership changes
    INSERT INTO Committee_Membership_Changes (Senator_ID, Committee_ID, Change_Date, Action_Type)
    SELECT Senator_ID, Committee_ID, NOW(), 'Removed'
    FROM Committee_Memberships
    WHERE Senator_ID = senator_id;
END;
$$;

-- Creating the Legislative Bills table
CREATE TABLE Legislative_Bills (
    Bill_ID SERIAL PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Summary TEXT,
    Sponsor_ID INTEGER,
    Status VARCHAR(50) NOT NULL,
    Date_Introduced DATE NOT NULL,
    FOREIGN KEY (Sponsor_ID) REFERENCES Senators(Senator_ID) ON DELETE SET NULL
);

-- Procedure to automatically update bill status based on voting conditions
CREATE OR REPLACE PROCEDURE UpdateBillStatus(bill_id INTEGER)
LANGUAGE plpgsql
AS $$
DECLARE
    total_votes INTEGER;
    yes_votes INTEGER;
BEGIN
    -- Count total votes for the given bill
    SELECT COUNT(*) INTO total_votes FROM Votes WHERE Bill_ID = bill_id;
    
    -- Count yes votes for the given bill
    SELECT COUNT(*) INTO yes_votes FROM Votes WHERE Bill_ID = bill_id AND Vote = 'Yes';
    
    -- Update the status based on the number of yes votes and total votes
    IF total_votes > 0 THEN
        IF yes_votes > total_votes / 2 THEN
            UPDATE Legislative_Bills SET Status = 'Passed' WHERE Bill_ID = bill_id;
        ELSE
            UPDATE Legislative_Bills SET Status = 'Failed' WHERE Bill_ID = bill_id;
        END IF;
    END IF;
END;
$$;

-- Creating the Votes table (linking Senators to Bills)
CREATE TABLE Votes (
    Vote_ID SERIAL PRIMARY KEY,
    Bill_ID INTEGER NOT NULL,
    Senator_ID INTEGER NOT NULL,
    Vote VARCHAR(10) NOT NULL,
    Date_Voted DATE NOT NULL,
    FOREIGN KEY (Bill_ID) REFERENCES Legislative_Bills(Bill_ID) ON DELETE CASCADE,
    FOREIGN KEY (Senator_ID) REFERENCES Senators(Senator_ID) ON DELETE SET NULL
);

-- Adding index on Date_Voted to improve performance for date range queries
CREATE INDEX idx_votes_date_voted ON Votes(Date_Voted);

-- Creating the House of Representatives table
CREATE TABLE House_Representatives (
    Representative_ID SERIAL PRIMARY KEY,
    First_Name VARCHAR(100) NOT NULL,
    Last_Name VARCHAR(100) NOT NULL,
    Party VARCHAR(50) NOT NULL,
    State VARCHAR(2) NOT NULL,
    District INTEGER NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE,
    Email VARCHAR(100),
    Phone_Number VARCHAR(15)
);

-- Adding index on District and State to facilitate faster lookups
CREATE INDEX idx_house_representatives_district_state ON House_Representatives(District, State);

-- Creating the Committee Memberships for House Representatives
CREATE TABLE Committee_Memberships_House (
    Membership_ID SERIAL PRIMARY KEY,
    Committee_ID INTEGER NOT NULL,
    Representative_ID INTEGER NOT NULL,
    FOREIGN KEY (Committee_ID) REFERENCES Committees(Committee_ID) ON DELETE CASCADE,
    FOREIGN KEY (Representative_ID) REFERENCES House_Representatives(Representative_ID) ON DELETE CASCADE
);

-- Creating the Joint Committee Memberships table (for both Senators and House Representatives)
CREATE TABLE Joint_Committee_Memberships (
    Membership_ID SERIAL PRIMARY KEY,
    Committee_ID INTEGER NOT NULL,
    Senator_ID INTEGER,
    Representative_ID INTEGER,
    FOREIGN KEY (Committee_ID) REFERENCES Committees(Committee_ID) ON DELETE CASCADE,
    FOREIGN KEY (Senator_ID) REFERENCES Senators(Senator_ID) ON DELETE SET NULL,
    FOREIGN KEY (Representative_ID) REFERENCES House_Representatives(Representative_ID) ON DELETE SET NULL
);

-- Creating the Bills in House table
CREATE TABLE Legislative_Bills_House (
    Bill_ID SERIAL PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Summary TEXT,
    Sponsor_ID INTEGER,
    Status VARCHAR(50) NOT NULL,
    Date_Introduced DATE NOT NULL,
    FOREIGN KEY (Sponsor_ID) REFERENCES House_Representatives(Representative_ID) ON DELETE SET NULL
);

-- Creating the House Votes table
CREATE TABLE House_Votes (
    Vote_ID SERIAL PRIMARY KEY,
    Bill_ID INTEGER NOT NULL,
    Representative_ID INTEGER NOT NULL,
    Vote VARCHAR(10) NOT NULL,
    Date_Voted DATE NOT NULL,
    FOREIGN KEY (Bill_ID) REFERENCES Legislative_Bills_House(Bill_ID) ON DELETE CASCADE,
    FOREIGN KEY (Representative_ID) REFERENCES House_Representatives(Representative_ID) ON DELETE SET NULL
);

-- Adding index on Date_Voted to improve performance for date range queries
CREATE INDEX idx_house_votes_date_voted ON House_Votes(Date_Voted);
