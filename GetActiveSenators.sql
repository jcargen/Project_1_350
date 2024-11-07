CREATE OR REPLACE FUNCTION GetActiveSenators()
RETURNS TABLE (
    senator_id INT,
    name VARCHAR(200),
    status VARCHAR(50)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT Senators.senator_id, CONCAT(Senators.First_Name, ' ', Senators.Last_Name)::VARCHAR(200) AS name, 'active'::VARCHAR(50) AS status
    FROM Senators
    WHERE End_Date IS NULL OR End_Date > CURRENT_DATE;
END;
$$ LANGUAGE plpgsql;
