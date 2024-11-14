const db = connect("mongodb://localhost:27017/clashofclans");

db.system.js.deleteOne({ _id: "softDeleteUserArmyUnit" });
db.system.js.deleteOne({ _id: "restoreUserArmyUnit" });
db.system.js.deleteOne({ _id: "updateUnitType" });
db.system.js.deleteOne({ _id: "getTotalAmount" });
db.system.js.deleteOne({ _id: "getUserUnitsSummary" });

function softDeleteUserArmyUnit(user_unit_id) {
  db.UserArmyUnit.updateOne(
    { user_unit_id: user_unit_id },
    {
      $set: {
        deleted_at: new Date(),
        last_change: new Date()
      }
    }
  );
}

function restoreUserArmyUnit(user_unit_id) {
  db.UserArmyUnit.updateOne(
    { user_unit_id: user_unit_id },
    {
      $set: {
        deleted_at: null,
        last_change: new Date()
      }
    }
  );
}

function updateUnitType(p_unit_type_id,p_new_u_type,p_modified_by ){
	db.UnitType.updateOne(
  	  { unit_type_id: p_unit_type_id },
   	 {
     	   $set: {
      	      u_type: p_new_u_type,
      	      modified_by: p_modified_by
      	  }
 	   }
	);
}


function getTotalAmount(user_id, u_type) {
  const result = db.UserArmyUnit.aggregate([
    {
      $match: {
        user_id: user_id,
      }
    },
    {
      $lookup: {
        from: "VillageUnit",
        localField: "unit_id",
        foreignField: "unit_id",
        as: "village_units"
      }
    },
    { $unwind: "$village_units" },
    {
      $lookup: {
        from: "UnitType",
        localField: "village_units.unit_type_id",
        foreignField: "unit_type_id",
        as: "unit_types"
      }
    },
    { $unwind: "$unit_types" },
    {
      $match: {
        "unit_types.u_type": u_type
      }
    },
    {
      $group: {
        _id: null,
        total_amount: { $sum: "$amount" }
      }
    }
  ]).toArray();

  return result.length > 0 ? result[0].total_amount : 0;
}

function getUserUnitsSummary() {
  return db.UserAccount.aggregate([
    {
      $lookup: {
        from: "UserArmyUnit",
        localField: "user_id",
        foreignField: "user_id",
        as: "user_army_units"
      }
    },
    { $unwind: "$user_army_units" },
    {
      $lookup: {
        from: "VillageUnit",
        localField: "user_army_units.unit_id",
        foreignField: "unit_id",
        as: "village_units"
      }
    },
    { $unwind: "$village_units" },
    {
      $lookup: {
        from: "UnitType",
        localField: "village_units.unit_type_id",
        foreignField: "unit_type_id",
        as: "unit_types"
      }
    },
    { $unwind: "$unit_types" },
    {
      $match: {
        $or: [
      { "user_army_units.deleted_at": { $exists: false } },
      { "user_army_units.deleted_at": null }
    ]
      }
    },
    {
      $group: {
        _id: {
          user_id: "$user_id",
          nickname: "$nickname",
          unit_name: "$village_units.unit_name",
          u_type: "$unit_types.u_type"
        },
        total_units: { $sum: "$user_army_units.amount" }
      }
    },
    {
      $project: {
        _id: 0,
        user_id: "$_id.user_id",
        nickname: "$_id.nickname",
        unit_name: "$_id.unit_name",
        u_type: "$_id.u_type",
        total_units: 1
      }
    }
  ]).toArray();
}



db.system.js.insertOne({
  _id: "softDeleteUserArmyUnit",
  value: softDeleteUserArmyUnit
});
db.system.js.insertOne({
  _id: "getTotalAmount",
  value: getTotalAmount
});
db.system.js.insertOne({
  _id: "updateUnitType",
  value: updateUnitType
});
db.system.js.insertOne({
  _id: "restoreUserArmyUnit",
  value: restoreUserArmyUnit
});
db.system.js.insertOne({
  _id: "getUserUnitsSummary",
  value: getUserUnitsSummary
});

