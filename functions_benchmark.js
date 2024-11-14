// init n from mongosh

if (typeof n === 'undefined' || isNaN(n) || n <= 0) {
console.log(`define n from console`);
}

console.log(`n = ${n}`);

function benchmark_function(func, func_name, n){
    let i = n;
    const start = new Date();
    while (i > 0) {
      func();
      i -= 1;
    }
    const end = new Date();
    const executionTime = (end - start) / n;
    console.log(`${func_name} execution time: ${executionTime} ms`);
}

benchmark_function(getUserUnitsSummary, "getUserUnitsSummary",n);
benchmark_function(() => getTotalAmount(1, 'fly'), 'getTotalAmount', n);
benchmark_function(() => updateUnitType(1,"Benchmark_changed",1 ), 'updateUnitType', n);
benchmark_function(() => softDeleteUserArmyUnit(1), 'softDeleteUserArmyUnit', n);
benchmark_function(() => restoreUserArmyUnit(1), 'restoreUserArmyUnit', n);