USE `clash_of_clans`;
-- triggers

DELIMITER $$

CREATE TRIGGER  before_insert_village_unit
BEFORE INSERT ON VillageUnit
FOR EACH ROW
BEGIN
    SET NEW.last_change = NOW();
END$$

CREATE TRIGGER before_update_village_unit
BEFORE UPDATE ON VillageUnit
FOR EACH ROW
BEGIN
    SET NEW.last_change = NOW();
END$$

CREATE TRIGGER before_insert_user_army_unit
BEFORE INSERT ON UserArmyUnit
FOR EACH ROW
BEGIN
    SET NEW.last_change = NOW();
END$$

CREATE TRIGGER before_update_user_army_unit
BEFORE UPDATE ON UserArmyUnit
FOR EACH ROW
BEGIN
    SET NEW.last_change = NOW();
END$$

DELIMITER ;

-- procedures & functions
DELIMITER //

CREATE PROCEDURE RestoreUserArmyUnit (
    IN p_user_unit_id INTEGER
)
BEGIN
    UPDATE UserArmyUnit
    SET deleted_at = NULL,
        last_change = NOW()
    WHERE user_unit_id = p_user_unit_id;
END //

CREATE PROCEDURE SoftDeleteUserArmyUnit (
    IN p_user_unit_id INTEGER
)
BEGIN
    UPDATE UserArmyUnit
    SET deleted_at = NOW(),
        last_change = NOW()
    WHERE user_unit_id = p_user_unit_id;
END //
DELIMITER ;
DELIMITER //

CREATE PROCEDURE CreatePlayerUnitView(IN min_level INTEGER)
BEGIN
SET @query = CONCAT('
    CREATE OR REPLACE VIEW PlayerUnitView AS
    SELECT
        ua.user_id,
        vu.unit_type_id,
        ua.level AS user_level,
        vu.level AS unit_level,
        vu.unit_name,
        uau.amount,
        uau.deleted_at
    FROM
        UserAccount ua
    INNER JOIN
        VillageUnit vu ON ua.user_id = vu.user_id
    INNER JOIN
        UserArmyUnit uau ON vu.unit_id = uau.unit_id
    WHERE
        ua.level > ', min_level, ';
');

    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

CREATE PROCEDURE InsertIntoVillageUnit(
    IN p_unit_id INTEGER,
    IN p_user_id INTEGER,
    IN p_building_target_type INTEGER,
    IN p_unit_type_id INTEGER,
    IN p_level INTEGER,
    IN p_hp INTEGER,
    IN p_damage_per_second INTEGER,
    IN p_takes_space INTEGER,
    IN p_damage_type VARCHAR(255),
    IN p_speed INTEGER,
    IN p_unit_name VARCHAR(255),
    IN p_training_time INTEGER,
    IN p_special_skills TEXT
)
BEGIN
    INSERT INTO VillageUnit (
        unit_id,
        user_id,
        building_target_type,
        unit_type_id,
        level,
        hp,
        damage_per_second,
        takes_space,
        damage_type,
        speed,
        unit_name,
        training_time,
        special_skills
    ) VALUES (
        p_unit_id,
        p_user_id,
        p_building_target_type,
        p_unit_type_id,
        p_level,
        p_hp,
        p_damage_per_second,
        p_takes_space,
        p_damage_type,
        p_speed,
        p_unit_name,
        p_training_time,
        p_special_skills
    );
END//
CREATE PROCEDURE InsertIntoBuildingType(
    IN p_building_type_id INTEGER,
    IN p_b_type VARCHAR(255),
    IN p_modified_by INTEGER 
)
BEGIN
    INSERT INTO BuildingType (
        building_type_id,
        b_type,
        modified_by
    ) VALUES (
       p_building_type_id ,
	   p_b_type,
	   p_modified_by
    );
END//
CREATE PROCEDURE InsertIntoUnitType(
    IN p_unit_type_id INTEGER,
    IN p_u_type VARCHAR(255),
    IN p_modified_by INTEGER 
)
BEGIN
    INSERT INTO UnitType (
        unit_type_id,
        u_type,
        modified_by
    ) VALUES (
       p_unit_type_id ,
	   p_u_type,
	   p_modified_by
    );
END//
CREATE PROCEDURE UpdateBuildingType(
    IN p_building_type_id INTEGER,
    IN p_new_b_type VARCHAR(255),
    IN p_modified_by INTEGER
)
BEGIN
    UPDATE BuildingType
    SET 
        b_type = p_new_b_type,
        modified_by = p_modified_by
    WHERE 
        building_type_id = p_building_type_id;
END//

CREATE PROCEDURE UpdateUnitType(
    IN p_unit_type_id INTEGER,
    IN p_new_u_type VARCHAR(255),
    IN p_modified_by INTEGER
)
BEGIN
    UPDATE UnitType
    SET 
        u_type = p_new_u_type,
        modified_by = p_modified_by
    WHERE 
        unit_type_id = p_unit_type_id;
END//

DELIMITER ;

DELIMITER //
CREATE FUNCTION GetTotalAmount(user_id INTEGER, u_type VARCHAR(255))
RETURNS INTEGER
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total_amount INTEGER;
    
    SELECT SUM(ua.amount) INTO total_amount
    FROM UserArmyUnit ua
    JOIN VillageUnit vu ON ua.unit_id = vu.unit_id
    JOIN UnitType ut ON vu.unit_type_id = ut.unit_type_id
    WHERE ua.user_id = user_id
      AND ut.u_type = u_type AND ua.deleted_at IS NULL;
      
    RETURN total_amount;
END //

CREATE PROCEDURE GetUserUnitsSummary()
BEGIN
    SELECT
        ua.user_id,
        ua.nickname,
        vu.unit_name,
        ut.u_type,
        SUM(uau.amount) AS total_units
    FROM
        UserAccount ua
    JOIN
        UserArmyUnit uau ON ua.user_id = uau.user_id
    JOIN
        VillageUnit vu ON uau.unit_id = vu.unit_id
    JOIN
        UnitType ut ON vu.unit_type_id = ut.unit_type_id
	 WHERE 
		uau.deleted_at IS NULL
    GROUP BY
        ua.user_id, ua.nickname, vu.unit_name, ut.u_type;
END //
DELIMITER ;

-- drop procedure GetUserUnitsSummary;
-- drop procedure GetTotalAmount;