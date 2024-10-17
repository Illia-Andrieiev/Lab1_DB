DROP SCHEMA if exists `clash_of_clans`; 
CREATE SCHEMA IF NOT EXISTS `clash_of_clans` DEFAULT CHARACTER SET utf8;
USE `clash_of_clans`;

CREATE TABLE AdminAccount (
    admin_id INTEGER PRIMARY KEY,
    admin_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS BuildingType (
    building_type_id INTEGER PRIMARY KEY,
    b_type VARCHAR(255),
    modified_by INTEGER REFERENCES AdminAccount(admin_id) 
);

CREATE TABLE UnitType (
    unit_type_id INTEGER PRIMARY KEY,
    u_type VARCHAR(255),
	modified_by INTEGER REFERENCES AdminAccount(admin_id) 
);

CREATE TABLE ClanCapitalUnit (
    unit_id INTEGER PRIMARY KEY,
    clan_capital_id INTEGER REFERENCES ClanCapital(clan_id),
    building_target_type INTEGER REFERENCES BuildingType(building_type_id),
    unit_type_id INTEGER REFERENCES UnitType(unit_type_id),
    level INTEGER,
    hp INTEGER,
    damage_per_second INTEGER,
    takes_space INTEGER,
    damage_type VARCHAR(255),
    speed INTEGER,
    unit_name VARCHAR(255),
    last_change DATETIME
);

CREATE TABLE ClanCapitalSpell (
    spell_id INTEGER PRIMARY KEY,
    clan_capital_id INTEGER REFERENCES ClanCapital(clan_id),
    unit_target_type_id INTEGER REFERENCES UnitType(unit_type_id),
    building_targey_type_id INTEGER REFERENCES BuildingType(building_type_id),
    spell_name VARCHAR(255),
    takes_space INTEGER,
    level INTEGER,
    effect TEXT,
    duration INTEGER,
    last_change DATETIME
);

CREATE TABLE ClanBuiding (
    clan_building_id INTEGER PRIMARY KEY,
    building_type_id INTEGER REFERENCES BuildingType(building_type_id),
    building_name VARCHAR(255),
    level INTEGER,
    hp INTEGER,
    attack_radius INTEGER,
    damage INTEGER,
    damage_type VARCHAR(255),
    specific_effect TEXT,
    last_change DATETIME
);

CREATE TABLE ClanBuidingClanVillage (
    clan_building_clan_village_id INTEGER PRIMARY KEY,
    capital_village_id INTEGER REFERENCES CapitalVillage(capital_village_id),
    clan_building_id INTEGER REFERENCES ClanBuiding(clan_building_id),
    amount INTEGER
);

CREATE TABLE CapitalVillage (
    capital_village_id INTEGER PRIMARY KEY,
    clan_capital_id INTEGER REFERENCES ClanCapital(clan_id),
    village_name VARCHAR(255),
    district_town_hall_level INTEGER,
    last_change DATETIME
);

CREATE TABLE ClanCapital (
    clan_id INTEGER REFERENCES Clan(clan_id),
    trophies INTEGER,
    capital_town_hall_level INTEGER,
    unit_army_size INTEGER,
    spell_army_size INTEGER
);

CREATE TABLE Clan (
    clan_id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    members_amount INTEGER,
    league VARCHAR(255),
    clan_location VARCHAR(255),
    clan_score INTEGER,
    trophies_for_entry INTEGER,
    town_hall_level_for_entry INTEGER,
    entry_type VARCHAR(255)
);

CREATE TABLE ClanCapitalArmyUnit (
    id INTEGER PRIMARY KEY,
    user_id INTEGER REFERENCES UserAccount(user_id),
    clan_capital_id INTEGER REFERENCES ClanCapital(clan_id),
    unit_id INTEGER REFERENCES ClanCapitalUnit(unit_id),
    amount INTEGER,
    last_change DATETIME,
    deleted_at DATETIME DEFAULT NULL
);

CREATE TABLE ClanCapitalArmySpell (
    id INTEGER PRIMARY KEY,
    user_id INTEGER REFERENCES UserAccount(user_id),
    clan_capital_id INTEGER REFERENCES ClanCapital(clan_id),
    spell_id INTEGER REFERENCES ClanCapitalSpell(spell_id),
    amount INTEGER,
    last_change DATETIME,
    deleted_at DATETIME DEFAULT NULL
);

CREATE TABLE Achievement (
    achievement_id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    reward_expirience INTEGER,
    reward_gems INTEGER,
    level INTEGER,
    receiving_conditions TEXT
);

CREATE TABLE UserAccountAchievement (
    id INTEGER PRIMARY KEY,
    user_id INTEGER REFERENCES UserAccount(user_id),
    achievement_id INTEGER REFERENCES Achievement(achievement_id),
    last_change DATETIME
);

CREATE TABLE UserAccount (
    user_id INTEGER PRIMARY KEY,
    clan_id INTEGER REFERENCES Clan(clan_id),
    nickname VARCHAR(255),
    level INTEGER,
    expirience INTEGER,
    clan_position VARCHAR(255),
    current_trophies INTEGER,
    max_trophies INTEGER,
    builder_village_trophies INTEGER,
    max_builder_village_trophies INTEGER,
    battle_stars_won INTEGER,
    builder_town_hall_level INTEGER,
    last_change DATETIME
);

CREATE TABLE MainVillage (
    user_id INTEGER REFERENCES UserAccount(user_id),
    town_hall_level INTEGER,
    unit_army_size INTEGER,
    spell_army_size INTEGER
);

CREATE TABLE VillageUnit (
    unit_id INTEGER PRIMARY KEY,
    user_id INTEGER REFERENCES UserAccount(user_id),
    building_target_type INTEGER REFERENCES BuildingType(building_type_id),
    unit_type_id INTEGER REFERENCES UnitType(unit_type_id),
    level INTEGER,
    hp INTEGER,
    damage_per_second INTEGER,
    takes_space INTEGER,
    damage_type VARCHAR(255),
    speed INTEGER,
    unit_name VARCHAR(255),
    training_time INTEGER,
    special_skills TEXT,
    last_change DATETIME
);

CREATE TABLE VillageSpell (
    spell_id INTEGER PRIMARY KEY,
    user_id INTEGER REFERENCES UserAccount(user_id),
    unit_target_type_id INTEGER REFERENCES UnitType(unit_type_id),
    building_targey_type_id INTEGER REFERENCES BuildingType(building_type_id),
    spell_name VARCHAR(255),
    takes_space INTEGER,
    level INTEGER,
    effect TEXT,
    duration INTEGER,
    training_time INTEGER,
    last_change DATETIME
);

CREATE TABLE VillageBuiding (
    building_id INTEGER PRIMARY KEY,
    building_type_id INTEGER REFERENCES BuildingType(building_type_id),
    building_name VARCHAR(255),
    level INTEGER,
    hp INTEGER,
    attack_radius INTEGER,
    damage INTEGER,
    damage_type VARCHAR(255),
    specific_effect TEXT,
    last_change DATETIME
);

CREATE TABLE UserBuilding (
    user_building_id INTEGER PRIMARY KEY,
    building_id INTEGER REFERENCES VillageBuiding(building_id),
    user_id INTEGER REFERENCES UserAccount(user_id),
    amount INTEGER
);

CREATE TABLE UserArmyUnit (
    user_unit_id INTEGER PRIMARY KEY,
    unit_id INTEGER REFERENCES VillageUnit(unit_id),
    user_id INTEGER REFERENCES UserAccount(user_id),
    amount INTEGER,
    last_change DATETIME,
    deleted_at DATETIME DEFAULT NULL
);

CREATE TABLE UserArmySpell (
    user_spell_id INTEGER PRIMARY KEY,
    spell_id INTEGER REFERENCES VillageSpell(spell_id),
    user_id INTEGER REFERENCES UserAccount(user_id),
    amount INTEGER,
    last_change DATETIME,
    deleted_at DATETIME DEFAULT NULL
);
