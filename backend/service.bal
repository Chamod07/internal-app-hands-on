import backend.database;

import ballerina/http;

# RESTful service for managing employees
@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"],
        allowCredentials: false,
        allowHeaders: ["Content-Type", "Authorization"],
        allowMethods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
        maxAge: 84900
    }
}
service /api/v1 on new http:Listener(9090) {

    # Creates a new employee
    # + payload - The employee information
    # + return - Success or error response
    resource function post employees(@http:Payload UserInfoResponse payload) returns http:Created|http:BadRequest|error {
        // Convert UserInfoResponse to database.Employee
        database:Employee dbEmployee = {
            employeeId: payload.employeeId,
            workEmail: payload.workEmail,
            firstName: payload.firstName,
            lastName: payload.lastName,
            jobRole: payload.jobRole,
            employeeThumbnail: payload.employeeThumbnail
        };

        boolean|error result = database:insertEmployee(dbEmployee);

        if result is boolean {
            return <http:Created>{
                body: {employeeId: payload.employeeId, message: "Employee created successfully"}
            };
        } else {
            return <http:BadRequest>{
                body: {message: "Failed to create employee", errorDetail: result.message()}
            };
        }
    }

    # Gets an employee by ID
    # + id - The ID of the employee to retrieve
    # + return - The employee or an error if not found
    resource function get employees/[string id]() returns UserInfoResponse|http:NotFound|error {
        database:Employee|error result = database:getEmployee(id);

        if result is database:Employee {
            // Convert from database.Employee to UserInfoResponse
            UserInfoResponse response = {
                employeeId: result.employeeId,
                workEmail: result.workEmail,
                firstName: result.firstName,
                lastName: result.lastName,
                jobRole: result.jobRole,
                employeeThumbnail: result.employeeThumbnail
            };
            return response;
        } else {
            return <http:NotFound>{
                body: {message: "Employee not found", errorDetail: result.message()}
            };
        }
    }

    # Searches for employees based on criteria
    # + searchTerm - Optional search term to filter by
    # + jobRole - Optional job role to filter by
    # + return - An array of matching employees or an error
    resource function get employees(@http:Query string? searchTerm = (), @http:Query string? jobRole = ()) returns UserInfoResponse[]|error {
        database:Employee[]|error results = database:searchEmployees(searchTerm, jobRole);

        if results is database:Employee[] {
            UserInfoResponse[] response = [];
            foreach database:Employee emp in results {
                response.push({
                    employeeId: emp.employeeId,
                    workEmail: emp.workEmail,
                    firstName: emp.firstName,
                    lastName: emp.lastName,
                    jobRole: emp.jobRole,
                    employeeThumbnail: emp.employeeThumbnail
                });
            }
            return response;
        } else {
            return results;
        }
    }

    # Updates an employee
    # + id - The ID of the employee to update
    # + payload - The updated employee information
    # + return - Success or error response
    resource function put employees/[string id](@http:Payload UserInfoResponse payload) returns http:Ok|http:NotFound|error {
        // Convert UserInfoResponse to database.Employee
        database:Employee dbEmployee = {
            employeeId: payload.employeeId,
            workEmail: payload.workEmail,
            firstName: payload.firstName,
            lastName: payload.lastName,
            jobRole: payload.jobRole,
            employeeThumbnail: payload.employeeThumbnail
        };

        boolean|error result = database:updateEmployee(id, dbEmployee);

        if result is boolean {
            return <http:Ok>{
                body: {message: "Employee updated successfully"}
            };
        } else {
            return <http:NotFound>{
                body: {message: "Failed to update employee", errorDetail: result.message()}
            };
        }
    }

    # Deletes an employee
    # + id - The ID of the employee to delete
    # + return - Success or error response
    resource function delete employees/[string id]() returns http:NoContent|http:NotFound|error {
        boolean|error result = database:deleteEmployee(id);

        if result is boolean {
            return <http:NoContent>{};
        } else {
            return <http:NotFound>{
                body: {message: "Employee not found", errorDetail: result.message()}
            };
        }
    }
}
