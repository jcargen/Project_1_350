CREATE OR REPLACE FUNCTION CountBillsSponsored(senator_id INT)
RETURNS INT
AS $$
DECLARE
    total_bills INT;
BEGIN
    SELECT COUNT(*)
    INTO total_bills
    FROM Legislative_Bills
    WHERE sponsor_id = senator_id;

    RETURN total_bills;
END;
$$ LANGUAGE plpgsql;
