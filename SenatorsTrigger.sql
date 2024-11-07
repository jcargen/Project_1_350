-- Senators trigger
CREATE TRIGGER EndMembershipOnTermEnd_Senators
AFTER UPDATE ON Senators
FOR EACH ROW
EXECUTE FUNCTION EndMembershipOnTermEnd_Senators_Func();

-- House Representatives trigger
CREATE TRIGGER EndMembershipOnTermEnd_HouseReps
AFTER UPDATE ON House_Representatives
FOR EACH ROW
EXECUTE FUNCTION EndMembershipOnTermEnd_HouseReps_Func();
