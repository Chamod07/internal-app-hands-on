import ballerina/sql;

# Employee record for database operations
public type Employee record {|
    # Employee ID
    string employeeId;
    # Work email address
    string workEmail;
    # Employee's first name
    string firstName;
    # Employee's last name
    string lastName;
    # Employee's job role
    string jobRole;
    # URL to employee's thumbnail image
    string? employeeThumbnail;
|};

# Inserts a new employee into the database
#
# + employee - The employee record to insert
# + return - True if successful, or an error
public function insertEmployee(Employee employee) returns boolean|error {
    sql:ExecutionResult result = check dbClient->execute(buildInsertEmployeeQuery(employee));

    if result.affectedRowCount > 0 {
        return true;
    } else {
        return error("Failed to insert employee");
    }
}

# Retrieves an employee by ID
#
# + id - The ID of the employee to retrieve
# + return - The employee record or an error if not found
public function getEmployee(string id) returns Employee|error {
    Employee employee = check dbClient->queryRow(buildGetEmployeeQuery(id));

    return employee;
}

# Searches for employees based on provided criteria
#
# + searchTerm - Optional search term to filter email, name, or ID
# + jobRole - Optional job role to filter by
# + return - An array of employees matching the criteria or an error
public function searchEmployees(string? searchTerm = (), string? jobRole = ()) returns Employee[]|error {
    sql:ParameterizedQuery query = buildSearchEmployeesQuery(searchTerm, jobRole);

    stream<Employee, error?> resultStream = dbClient->query(query);

    Employee[] employees = [];
    check from Employee employee in resultStream
        do {
            employees.push(employee);
        };

    return employees;
}

# Updates an employee in the database
#
# + id - The ID of the employee to update
# + employee - The updated employee information
# + return - True if successful, or an error
public function updateEmployee(string id, Employee employee) returns boolean|error {
    sql:ExecutionResult result = check dbClient->execute(buildUpdateEmployeeQuery(id, employee));

    if result.affectedRowCount > 0 {
        return true;
    } else {
        return error("Employee not found or no changes applied");
    }
}

# Deletes an employee from the database
#
# + id - The ID of the employee to delete
# + return - True if successful, or an error
public function deleteEmployee(string id) returns boolean|error {
    sql:ExecutionResult result = check dbClient->execute(buildDeleteEmployeeQuery(id));

    if result.affectedRowCount > 0 {
        return true;
    } else {
        return error("Employee not found");
    }
}
