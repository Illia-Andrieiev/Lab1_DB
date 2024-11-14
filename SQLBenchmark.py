import mysql.connector
import time

# reads password from file
def read_password_from_file(file_path):
    try:
        with open(file_path, 'r') as file:
            password = file.readline().strip()
        return password
    except FileNotFoundError:
        print(f"File {file_path} not found.")
        return None
    except Exception as e:
        print(f"Error: {e}")
        return None

file_path = 'password.txt'
password = read_password_from_file(file_path)

def benchmark_command(command, func_name, n):
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password=password,
        database="clash_of_clans"
    )

    start_time = time.time()
    for _ in range(n):
        cursor = conn.cursor()
        cursor.execute(command)
        cursor.fetchall()
        cursor.close()
    end_time = time.time()
    execution_time = (end_time - start_time) / n * 1000
    print(f"Execution {func_name}: {execution_time} ms")
    conn.close()


if __name__ == '__main__':
    benchmark_command("CALL UpdateUnitType(1, 'NEW_U_TYPE', 1);", 'UpdateUnitType', 100)
    benchmark_command("SELECT GetTotalAmount(1, 'fly');", 'GetTotalAmount', 100)
    benchmark_command("CALL SoftDeleteUserArmyUnit(1);", 'SoftDeleteUserArmyUnit', 100)
    benchmark_command("CALL RestoreUserArmyUnit(1);", 'RestoreUserArmyUnit', 100)
