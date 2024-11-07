CREATE OR REPLACE FUNCTION GetCommitteeMembers(committee_id INT)
RETURNS TABLE (
    member_id INT,
    name VARCHAR(200),
    role VARCHAR(50)
)
AS $$
BEGIN
    RETURN QUERY
    -- Get senators in the committee
    SELECT Senators.Senator_ID AS member_id, CONCAT(Senators.First_Name, ' ', Senators.Last_Name)::VARCHAR(200) AS name, 'Senator'::VARCHAR(50) AS role
    FROM Committee_Memberships
    JOIN Senators ON Committee_Memberships.Senator_ID = Senators.Senator_ID
    WHERE Committee_Memberships.Committee_ID = GetCommitteeMembers.committee_id

    UNION

    -- Get house representatives in the committee
    SELECT House_Representatives.Representative_ID AS member_id, CONCAT(House_Representatives.First_Name, ' ', House_Representatives.Last_Name)::VARCHAR(200) AS name, 'Representative'::VARCHAR(50) AS role
    FROM Committee_Memberships_House
    JOIN House_Representatives ON Committee_Memberships_House.Representative_ID = House_Representatives.Representative_ID
    WHERE Committee_Memberships_House.Committee_ID = GetCommitteeMembers.committee_id;
END;
$$ LANGUAGE plpgsql;
