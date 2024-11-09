-- TRIGGERS - Jacob --

-- Senators trigger, checks when there is a change
CREATE TRIGGER EndMembershipOnTermEnd_Senators
AFTER UPDATE ON Senators
FOR EACH ROW
BEGIN
    -- Ceheck here if they need to be removed
    IF NEW.End_Date IS NOT NULL AND NEW.End_Date <= CURRENT_DATE THEN
        DELETE FROM Committee_Memberships
        WHERE Senator_ID = NEW.Senator_ID;
    END IF;
END;

-- House Representatives trigger, checks when there is a change
CREATE TRIGGER EndMembershipOnTermEnd_HouseReps
AFTER UPDATE ON House_Representatives
FOR EACH ROW
BEGIN
    -- Check if should be removed
    IF NEW.End_Date IS NOT NULL AND NEW.End_Date <= CURRENT_DATE THEN
        DELETE FROM Committee_Memberships_House
        WHERE Representative_ID = NEW.Representative_ID;
    END IF;
END;
