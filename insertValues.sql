USE `clash_of_clans`;

insert into AdminAccount() values(1, "Illia");
insert into AdminAccount() values(2, "someone else");

call InsertIntoUnitType(1, "ground", 1);
call InsertIntoUnitType(2, "fly", 2);
call InsertIntoBuildingType(1, "defence",1);
call InsertIntoBuildingType(2, "resourses",1);
call InsertIntoBuildingType(3, "any",2);

INSERT INTO UserAccount (
    user_id, clan_id, nickname, level, expirience, clan_position, current_trophies, max_trophies, builder_village_trophies, max_builder_village_trophies, battle_stars_won, builder_town_hall_level, last_change
) VALUES (
    1, 
    null, 
    'Warrior123', 
    10, 
    1500, 
    'Leader', 
    2000, 
    2500, 
    300, 
    350, 
    500, 
    5, 
    NOW()
);

CALL InsertIntoVillageUnit( 1, 1, 3, 1, 1, 1000, 50, 5, 'Physical', 10, 'Warrior', 60, 'None');

CALL InsertIntoVillageUnit(2, 1, 1, 2, 2, 1500, 75, 10, 'Magic', 8, 'Mage', 120, 'Fireball');

CALL InsertIntoVillageUnit(3, 1, 2, 1, 3, 2000, 100,15, 'Ranged', 12, 'Archer', 90, 'Piercing Arrow');

INSERT INTO UserArmyUnit (user_unit_id, unit_id, user_id, amount)
VALUES 
    (1, 1, 1, 10),
    (2, 2,1, 20),
    (3, 3, 1, 30);

INSERT INTO UserArmyUnit (user_unit_id, unit_id, user_id, amount)
VALUES 
    (4, 1, 1, 15),
    (5, 2, 1, 25),
    (6, 3, 1, 35);

