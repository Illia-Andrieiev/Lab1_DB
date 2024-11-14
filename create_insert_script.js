try {
  db.AdminAccount.drop();
  db.UnitType.drop();
  db.BuildingType.drop();
  db.UserAccount.drop();
  db.VillageUnit.drop();
  db.UserArmyUnit.drop();
  print("Collections dropped successfully");
} catch (e) {
  print("Error dropping collections: " + e.message);
}


try {
  db.createCollection("AdminAccount");
  db.createCollection("UnitType");
  db.createCollection("BuildingType");
  db.createCollection("UserAccount");
  db.createCollection("VillageUnit");
  db.createCollection("UserArmyUnit");
  print("Collections created successfully");
} catch (e) {
  print("Error creating collections: " + e.message);
}


try {
  db.AdminAccount.insertMany([
    { admin_id: 1, admin_name: "Illia" },
    { admin_id: 2, admin_name: "someone else" }
  ]);
  print("AdminAccount inserted successfully");
} catch (e) {
  print("Error inserting into AdminAccount: " + e.message);
}

try {
  db.UnitType.insertMany([
    { unit_type_id: 1, u_type: "ground", modified_by: 1 },
    { unit_type_id: 2, u_type: "fly", modified_by: 2 }
  ]);
  print("UnitType inserted successfully");
} catch (e) {
  print("Error inserting into UnitType: " + e.message);
}

try {
  db.BuildingType.insertMany([
    { building_type_id: 1, b_type: "defence", modified_by: 1 },
    { building_type_id: 2, b_type: "resourses", modified_by: 1 },
    { building_type_id: 3, b_type: "any", modified_by: 2 }
  ]);
  print("BuildingType inserted successfully");
} catch (e) {
  print("Error inserting into BuildingType: " + e.message);
}

try {
  db.UserAccount.insertOne({
    user_id: 1,
    clan_id: null,
    nickname: "Warrior123",
    level: 10,
    experience: 1500,
    clan_position: "Leader",
    current_trophies: 2000,
    max_trophies: 2500,
    builder_village_trophies: 300,
    max_builder_village_trophies: 350,
    battle_stars_won: 500,
    builder_town_hall_level: 5,
    last_change: new Date()
  });
  print("UserAccount inserted successfully");
} catch (e) {
  print("Error inserting into UserAccount: " + e.message);
}

try {
  db.VillageUnit.insertMany([
    { unit_id: 1, user_id: 1, building_target_type: 1, unit_type_id: 1, level: 1, hp: 1000, damage_per_second: 50, takes_space: 5, damage_type: "Physical", speed: 10, unit_name: "Warrior", training_time: 60, special_skills: "None", last_change: new Date() },
    { unit_id: 2, user_id: 1, building_target_type: 2, unit_type_id: 2, level: 2, hp: 1500, damage_per_second: 75, takes_space: 10, damage_type: "Magic", speed: 8, unit_name: "Mage", training_time: 120, special_skills: "Fireball", last_change: new Date() },
    { unit_id: 3, user_id: 1, building_target_type: 1, unit_type_id: 1, level: 3, hp: 2000, damage_per_second: 100, takes_space: 15, damage_type: "Ranged", speed: 12, unit_name: "Archer", training_time: 90, special_skills: "Piercing Arrow", last_change: new Date() }
  ]);
  print("VillageUnit inserted successfully");
} catch (e) {
  print("Error inserting into VillageUnit: " + e.message);
}

try {
  db.UserArmyUnit.insertMany([
    { user_unit_id: 1, unit_id: 1, user_id: 1, amount: 10, last_change: new Date(), deleted_at: null },
    { user_unit_id: 2, unit_id: 2, user_id: 1, amount: 20, last_change: new Date(), deleted_at: null },
    { user_unit_id: 3, unit_id: 3, user_id: 1, amount: 30, last_change: new Date(), deleted_at: null },
    { user_unit_id: 4, unit_id: 1, user_id: 1, amount: 15, last_change: new Date(), deleted_at: null },
    { user_unit_id: 5, unit_id: 2, user_id: 1, amount: 25, last_change: new Date(), deleted_at: null },
    { user_unit_id: 6, unit_id: 3, user_id: 1, amount: 35, last_change: new Date(), deleted_at: null }
  ]);
  print("UserArmyUnit inserted successfully");
} catch (e) {
  print("Error inserting into UserArmyUnit: " + e.message);
}
