-- Function for Senators trigger
CREATE OR REPLACE FUNCTION EndMembershipOnTermEnd_Senators_Func()
RETURNS TRIGGER AS $$
BEGIN
    -- Check if they need to be removed
    IF NEW.End_Date IS NOT NULL AND NEW.End_Date <= CURRENT_DATE THEN
        DELETE FROM Committee_Memberships
        WHERE Senator_ID = NEW.Senator_ID;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Function for House Representatives trigger
CREATE OR REPLACE FUNCTION EndMembershipOnTermEnd_HouseReps_Func()
RETURNS TRIGGER AS $$
BEGIN
    -- Check if they need to be removed
    IF NEW.End_Date IS NOT NULL AND NEW.End_Date <= CURRENT_DATE THEN
        DELETE FROM Committee_Memberships_House
        WHERE Representative_ID = NEW.Representative_ID;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
