USE `clash_of_clans`;
/*
select * from UnitType;
select * from BuildingType;
select * from VillageUnit;
select * from UserArmyUnit;
select * from UserAccount;
CALL SoftDeleteUserArmyUnit(2);
select * from UserArmyUnit;
CALL RestoreUserArmyUnit(2);
select * from UserArmyUnit;
call GetUserUnitsSummary(); 
CALL CreatePlayerUnitView(1);
SELECT * FROM PlayerUnitView;
select GetTotalAmount(1, "fly");
CALL UpdateUnitType(1, "NEW_U_TYPE",1);
CALL UpdateBuildingType(2, "NEW_B_TYPE",1);
select * from UnitType;
select * from BuildingType;
*/
SET profiling = 1;
CALL UpdateUnitType(1, 'NEW_U_TYPE', 1);
CALL SoftDeleteUserArmyUnit(1);
CALL RestoreUserArmyUnit(1);
CALL GetUserUnitsSummary();
select GetTotalAmount(1, "fly");
SHOW PROFILES;
