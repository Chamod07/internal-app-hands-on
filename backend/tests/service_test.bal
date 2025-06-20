// Copyright (c) 2024, WSO2 LLC. (https://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 LLC. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/http;
import ballerina/io;
import ballerina/test;

http:Client testClient = check new ("http://localhost:9090/api/v1");

final string testEmployeeId = "LK99";
final string testEmail = "test.user@wso2.com";

@test:BeforeSuite
function beforeSuiteFunc() {
    io:println("Starting Employee API Tests");
}

# Test create employee resource.
#
# + return - Error if so
@test:Config {}
function testCreateEmployee() returns error? {
    json payload = {
        "employeeId": testEmployeeId,
        "workEmail": testEmail,
        "firstName": "Test",
        "lastName": "User",
        "jobRole": "QA Engineer",
        "employeeThumbnail": "https://example.com/test.jpg"
    };

    http:Response response = check testClient->/employees.post(payload);
    test:assertEquals(response.statusCode, 201, "Assertion Failed: Employee creation should return 201 Created");

    json responseJson = check response.getJsonPayload();
    test:assertEquals(responseJson.employeeId, testEmployeeId, "Assertion Failed: Response should contain the correct employee ID");
    test:assertEquals(responseJson.message, "Employee created successfully", "Assertion Failed: Response message incorrect");

    json invalidPayload = {
        "firstName": "Test",
        "lastName": "User"
    };

    http:Response errorResponse = check testClient->/employees.post(invalidPayload);
    test:assertTrue(errorResponse.statusCode >= 400, "Assertion Failed: Invalid request should return error status code");
}

# Test get employee by ID resource.
#
# + return - Error if so
@test:Config {
    dependsOn: [testCreateEmployee]
}
function testGetEmployee() returns error? {
    http:Response response = check testClient->/employees/[testEmployeeId].get();
    test:assertEquals(response.statusCode, 200, "Assertion Failed: Get employee should return 200 OK");

    json responseJson = check response.getJsonPayload();
    test:assertEquals(responseJson.employeeId, testEmployeeId);
    test:assertEquals(responseJson.workEmail, testEmail);
    test:assertEquals(responseJson.firstName, "Test");
    test:assertEquals(responseJson.lastName, "User");
    test:assertEquals(responseJson.jobRole, "QA Engineer");
    test:assertEquals(responseJson.jobRole, "QA Engineer");

    UserInfoResponse|error convertedData = responseJson.cloneWithType();
    if convertedData is error {
        test:assertFail("Assertion Failed: Malformed employee response");
    }
    http:Response errorResponse = check testClient->/employees/["NONEXISTENT"].get();
    test:assertEquals(errorResponse.statusCode, 404, "Assertion Failed: Non-existing employee should return 404");
}

# Test search employees resource.
#
# + return - Error if so
@test:Config {
    dependsOn: [testCreateEmployee]
}
function testSearchEmployees() returns error? {
    http:Response response = check testClient->/employees.get();
    test:assertEquals(response.statusCode, 200, "Assertion Failed: Search employees should return 200 OK");

    json[] employees = <json[]>check response.getJsonPayload();
    test:assertTrue(employees.length() > 0, "Assertion Failed: Employee list should not be empty");

    response = check testClient->/employees.get(searchTerm = "Test");
    test:assertEquals(response.statusCode, 200);

    employees = <json[]>check response.getJsonPayload();
    boolean found = false;
    foreach json emp in employees {
        if (emp.employeeId == testEmployeeId) {
            found = true;
            break;
        }
    }
    test:assertTrue(found, "Assertion Failed: Search should find the test employee");

    response = check testClient->/employees.get(jobRole = "QA Engineer");
    test:assertEquals(response.statusCode, 200);

    employees = <json[]>check response.getJsonPayload();
    test:assertTrue(employees.length() > 0, "Assertion Failed: Job role search should return results");
}

# Test update employee resource.
#
# + return - Error if so
@test:Config {
    dependsOn: [testGetEmployee]
}
function testUpdateEmployee() returns error? {
    json payload = {
        "employeeId": testEmployeeId,
        "workEmail": testEmail,
        "firstName": "Updated",
        "lastName": "User",
        "jobRole": "Senior QA Engineer",
        "employeeThumbnail": "https://example.com/updated.jpg"
    };

    http:Response response = check testClient->/employees/[testEmployeeId].put(payload);
    test:assertEquals(response.statusCode, 200, "Assertion Failed: Update employee should return 200 OK");

    json responseJson = check response.getJsonPayload();
    test:assertEquals(responseJson.message, "Employee updated successfully", "Assertion Failed: Update message incorrect");

    response = check testClient->/employees/[testEmployeeId].get();
    responseJson = check response.getJsonPayload();
    test:assertEquals(responseJson.firstName, "Updated", "Assertion Failed: First name should be updated");
    test:assertEquals(responseJson.jobRole, "Senior QA Engineer", "Assertion Failed: Job role should be updated");

    response = check testClient->/employees/["NONEXISTENT"].put(payload);
    test:assertEquals(response.statusCode, 404, "Assertion Failed: Update non-existing employee should return 404");
}

# Test delete employee resource.
#
# + return - Error if so
@test:Config {
    dependsOn: [testUpdateEmployee]
}
function testDeleteEmployee() returns error? {
    http:Response response = check testClient->/employees/[testEmployeeId].delete();
    test:assertEquals(response.statusCode, 204, "Assertion Failed: Delete employee should return 204 No Content");

    response = check testClient->/employees/[testEmployeeId].get();
    test:assertEquals(response.statusCode, 404, "Assertion Failed: Deleted employee should return 404 Not Found");

    response = check testClient->/employees/["NONEXISTENT"].delete();
    test:assertEquals(response.statusCode, 404, "Assertion Failed: Delete non-existing employee should return 404");
}

@test:AfterSuite
function afterSuiteFunc() {
    io:println("Employee API Tests Completed");
}
