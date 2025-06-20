import ballerina/sql;

# Build query to insert a new employee.
#
# + employee - Employee to be added
# + return - sql:ParameterizedQuery - Insert query for the employees table
isolated function buildInsertEmployeeQuery(Employee employee)
    returns sql:ParameterizedQuery =>
`
    INSERT INTO employees
    (
        employeeId,
        workEmail,
        firstName,
        lastName,
        jobRole,
        employeeThumbnail
    )
    VALUES
    (
        ${employee.employeeId},
        ${employee.workEmail},
        ${employee.firstName},
        ${employee.lastName},
        ${employee.jobRole},
        ${employee.employeeThumbnail}
    )
`;

# Build query to retrieve an employee by ID.
#
# + id - ID of the employee to retrieve
# + return - sql:ParameterizedQuery - Select query for the employees table
isolated function buildGetEmployeeQuery(string id) returns sql:ParameterizedQuery =>
`
    SELECT
        employeeId,
        workEmail,
        firstName,
        lastName,
        jobRole,
        employeeThumbnail
    FROM
        employees
    WHERE
        employeeId = ${id}
`;

# Build query to search for employees based on criteria.
#
# + searchTerm - Optional search term to filter by name, email
# + jobRole - Optional role to filter by
# + rowLimit - Limit of the data
# + offset - Offset of the query
# + return - sql:ParameterizedQuery - Select query for the employees table
isolated function buildSearchEmployeesQuery(string? searchTerm = (), string? jobRole = (), int? rowLimit = 100, int? offset = 0)
    returns sql:ParameterizedQuery {
    sql:ParameterizedQuery mainQuery = `
        SELECT
            employeeId,
            workEmail,
            firstName,
            lastName,
            jobRole,
            employeeThumbnail
        FROM
            employees
        WHERE 1=1
    `;

    // Add filters based on parameters
    if searchTerm is string {
        string term = "%" + searchTerm + "%";
        mainQuery = sql:queryConcat(mainQuery,
                ` AND (employeeId LIKE ${term} OR workEmail LIKE ${term} OR firstName LIKE ${term} OR lastName LIKE ${term})`);
    }

    if jobRole is string {
        mainQuery = sql:queryConcat(mainQuery, ` AND jobRole = ${jobRole}`);
    }

    // Add pagination
    if rowLimit is int {
        mainQuery = sql:queryConcat(mainQuery, ` LIMIT ${rowLimit}`);
        if offset is int {
            mainQuery = sql:queryConcat(mainQuery, ` OFFSET ${offset}`);
        }
    }

    return mainQuery;
}

# Build query to update an employee.
#
# + id - ID of the employee to update
# + employee - Updated employee information
# + return - sql:ParameterizedQuery - Update query for the employees table
isolated function buildUpdateEmployeeQuery(string id, Employee employee)
    returns sql:ParameterizedQuery =>
`
    UPDATE employees
    SET
        workEmail = ${employee.workEmail},
        firstName = ${employee.firstName},
        lastName = ${employee.lastName},
        jobRole = ${employee.jobRole},
        employeeThumbnail = ${employee.employeeThumbnail}
    WHERE
        employeeId = ${id}
`;

# Build query to delete an employee.
#
# + id - ID of the employee to delete
# + return - sql:ParameterizedQuery - Delete query for the employees table
isolated function buildDeleteEmployeeQuery(string id)
    returns sql:ParameterizedQuery =>
`
    DELETE FROM employees
    WHERE employeeId = ${id}
`;
