-- Test Queries for Validation

-- Test Case 1: Retrieve Active Senators
-- Expected Output: John Doe and Jane Smith
SELECT First_Name, Last_Name FROM Senators WHERE End_Date IS NULL OR End_Date > CURRENT_DATE;

-- Test Case 2: Count Bills Sponsored by Senator ID 1
-- Expected Output: 1
SELECT COUNT(*) AS BillCount FROM Legislative_Bills WHERE Sponsor_ID = 1;

-- Test Case 3: Get All Members of the Finance Committee
-- Expected Output: John Doe and Emily Davis
SELECT Senators.First_Name, Senators.Last_Name 
FROM Committee_Memberships
JOIN Senators ON Committee_Memberships.Senator_ID = Senators.Senator_ID
WHERE Committee_Memberships.Committee_ID = 1
UNION
SELECT House_Representatives.First_Name, House_Representatives.Last_Name
FROM Committee_Memberships_House
JOIN House_Representatives ON Committee_Memberships_House.Representative_ID = House_Representatives.Representative_ID
WHERE Committee_Memberships_House.Committee_ID = 1;

-- Test Case 4: Retrieve All Votes on Bill ID 1
-- Expected Output: John Doe - Yes, Jane Smith - No
SELECT Senators.First_Name, Senators.Last_Name, Votes.Vote
FROM Votes
JOIN Senators ON Votes.Senator_ID = Senators.Senator_ID
WHERE Votes.Bill_ID = 1;

-- Test Case 5: Retrieve All House Votes on Bill ID 1
-- Expected Output: Emily Davis - Yes, Robert Brown - Yes
SELECT House_Representatives.First_Name, House_Representatives.Last_Name, House_Votes.Vote
FROM House_Votes
JOIN House_Representatives ON House_Votes.Representative_ID = House_Representatives.Representative_ID
WHERE House_Votes.Bill_ID = 1;

-- Test Case 6: Get Committees Chaired by Senator ID 1
-- Expected Output: Finance Committee
SELECT Name FROM Committees WHERE Chairperson_ID = 1;

-- Test Cases for Functions

-- Test Case 1: Test CountBillsSponsored Function with Senator ID 1
-- Expected Output: 1
SELECT CountBillsSponsored(1) AS SponsoredBillsCount;

-- Test Case 2: Test GetActiveSenators Function
-- Expected Output: Active senators with ID, name, and status
SELECT * FROM GetActiveSenators();

-- Test Case 3: Test GetCommitteeMembers Function with Committee ID 1
-- Expected Output: Members of Committee ID 1 with their roles
SELECT * FROM GetCommitteeMembers(1);




-- Test Cases for Senators Trigger (EndMembershipOnTermEnd_Senators)

-- Test Case 1: Ensure senator is still in committee membership if End_Date is in the future
UPDATE Senators SET End_Date = '2050-12-31' WHERE Senator_ID = 1;
-- Expected Outcome: The senator with Senator_ID = 1 remains in Committee_Memberships, as the End_Date is in the future.
SELECT * FROM Committee_Memberships WHERE Senator_ID = 1;

-- Test Case 2: Remove senator from committee membership if End_Date is in the past
UPDATE Senators SET End_Date = '2022-01-01' WHERE Senator_ID = 1;
-- Expected Outcome: The senator with Senator_ID = 1 should be removed from Committee_Memberships, as the End_Date is in the past.
SELECT * FROM Committee_Memberships WHERE Senator_ID = 1;

-- Test Case 3: Verify if a senator with End_Date updated to NULL remains in committee membership
UPDATE Senators SET End_Date = NULL WHERE Senator_ID = 2;
-- Expected Outcome: The senator with Senator_ID = 2 remains in Committee_Memberships, as End_Date is NULL, meaning the term is ongoing.
SELECT * FROM Committee_Memberships WHERE Senator_ID = 2;


-- Test Cases for House Representatives Trigger (EndMembershipOnTermEnd_HouseReps)

-- Test Case 4: Ensure representative remains in committee if End_Date is in the future
UPDATE House_Representatives SET End_Date = '2050-12-31' WHERE Representative_ID = 3;
-- Expected Outcome: The representative with Representative_ID = 3 remains in Committee_Memberships_House, as the End_Date is in the future.
SELECT * FROM Committee_Memberships_House WHERE Representative_ID = 3;

-- Test Case 5: Remove representative from committee membership if End_Date is in the past
UPDATE House_Representatives SET End_Date = '2022-01-01' WHERE Representative_ID = 3;
-- Expected Outcome: The representative with Representative_ID = 3 should be removed from Committee_Memberships_House, as the End_Date is in the past.
SELECT * FROM Committee_Memberships_House WHERE Representative_ID = 3;

-- Test Case 6: Verify if representative with End_Date updated to NULL remains in committee membership
UPDATE House_Representatives SET End_Date = NULL WHERE Representative_ID = 4;
-- Expected Outcome: The representative with Representative_ID = 4 remains in Committee_Memberships_House, as End_Date is NULL, meaning the term is ongoing.
SELECT * FROM Committee_Memberships_House WHERE Representative_ID = 4;
