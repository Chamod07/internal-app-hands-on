# Employee Management API

## Version: 1.0.0

This API provides endpoints to manage employee information including creating, retrieving, updating, and deleting employee records.

### /api/v1/employees

#### GET

##### Summary:

Search and retrieve employees based on optional criteria.

##### Parameters

| Name       | Located in | Description                  | Required | Schema |
| ---------- | ---------- | ---------------------------- | -------- | ------ |
| searchTerm | query      | Filter by name, email, or ID | No       | string |
| jobRole    | query      | Filter by job role           | No       | string |

##### Responses

<table>
  <thead>
    <tr>
      <th>Code</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>200</td>
      <td>OK<br/>
  
  ```json
  [
    {
      "employeeId": "LK01",
      "workEmail": "john@wso2.com",
      "firstName": "John",
      "lastName": "Smith",
      "jobRole": "Software Engineer",
      "employeeThumbnail": "https://abcd.com/john.jpg",
      "privileges": []
    },
    {
      "employeeId": "LK02",
      "workEmail": "jane@wso2.com",
      "firstName": "Jane",
      "lastName": "Doe",
      "jobRole": "Senior Software Engineer",
      "employeeThumbnail": "https://abcd.com/jane.jpg",
      "privileges": []
    }
  ]
  ```
  </td>
    </tr>
    <tr>
      <td>500</td>
      <td>Internal Server Error<br/>
  
  ```json
  {
    "message": "Failed to search employees",
    "errorDetail": "Database connection error"
  }
  ```
  </td>
    </tr>
  </tbody>
</table>

#### POST

##### Summary:

Create a new employee in the system.

##### Parameters

<table>
<thead>
  <tr>
    <th>Name</th>
    <th>Located in</th>
    <th>Description</th>
    <th>Required</th>
    <th>Schema</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>employee</td>
    <td>body</td>
    <td>Employee information</td>
    <td>Yes</td>
    <td>

```json
{
  "employeeId": "LK06",
  "workEmail": "newuser@wso2.com",
  "firstName": "New",
  "lastName": "User",
  "jobRole": "Product Manager",
  "employeeThumbnail": "https://abcd.com/newuser.jpg"
}
```

  </td>
  </tr>
</tbody>
</table>

##### Responses

<table>
  <thead>
    <tr>
      <th>Code</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>201</td>
      <td>Created<br/>
  
  ```json
  {
    "employeeId": "LK06",
    "message": "Employee created successfully"
  }
  ```
  </td>
    </tr>
    <tr>
      <td>400</td>
      <td>Bad Request<br/>
  
  ```json
  {
    "message": "Failed to create employee",
    "errorDetail": "Missing required fields"
  }
  ```
  </td>
    </tr>
  </tbody>
</table>

### /api/v1/employees/{id}

#### GET

##### Summary:

Retrieve a specific employee by their ID.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ------ |
| id   | path       | Employee ID | Yes      | string |

##### Responses

<table>
  <thead>
    <tr>
      <th>Code</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>200</td>
      <td>OK<br/>
  
  ```json
  {
    "employeeId": "LK01",
    "workEmail": "john@wso2.com",
    "firstName": "John",
    "lastName": "Smith",
    "jobRole": "Software Engineer",
    "employeeThumbnail": "https://abcd.com/john.jpg",
    "privileges": []
  }
  ```
  </td>
    </tr>
    <tr>
      <td>404</td>
      <td>Not Found<br/>
  
  ```json
  {
    "message": "Employee not found",
    "errorDetail": "No employee with ID LK99 exists"
  }
  ```
  </td>
    </tr>
  </tbody>
</table>

#### PUT

##### Summary:

Update an existing employee's information.

##### Parameters

| Name     | Located in | Description                  | Required | Schema |
| -------- | ---------- | ---------------------------- | -------- | ------ |
| id       | path       | Employee ID                  | Yes      | string |
| employee | body       | Updated employee information | Yes      | object |

<table>
<thead>
  <tr>
    <th>Name</th>
    <th>Located in</th>
    <th>Description</th>
    <th>Required</th>
    <th>Schema</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>employee</td>
    <td>body</td>
    <td>Updated employee information</td>
    <td>Yes</td>
    <td>

```json
{
  "employeeId": "LK01",
  "workEmail": "john.updated@wso2.com",
  "firstName": "John",
  "lastName": "Smith",
  "jobRole": "Senior Software Engineer",
  "employeeThumbnail": "https://abcd.com/john.jpg"
}
```

  </td>
  </tr>
</tbody>
</table>

##### Responses

<table>
  <thead>
    <tr>
      <th>Code</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>200</td>
      <td>OK<br/>
  
  ```json
  {
    "message": "Employee updated successfully"
  }
  ```
  </td>
    </tr>
    <tr>
      <td>404</td>
      <td>Not Found<br/>
  
  ```json
  {
    "message": "Failed to update employee",
    "errorDetail": "Employee not found"
  }
  ```
  </td>
    </tr>
  </tbody>
</table>

#### DELETE

##### Summary:

Delete an employee from the system.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ------ |
| id   | path       | Employee ID | Yes      | string |

##### Responses

<table>
  <thead>
    <tr>
      <th>Code</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>204</td>
      <td>No Content</td>
    </tr>
    <tr>
      <td>404</td>
      <td>Not Found<br/>
  
  ```json
  {
    "message": "Employee not found",
    "errorDetail": "No employee with ID LK99 exists"
  }
  ```
  </td>
    </tr>
  </tbody>
</table>

## Setup and Installation

1. Ensure you have Ballerina 2201.12.6 or higher installed
2. Configure the MySQL database using the SQL scripts in `/backend/resources/database/`
3. Update the database configuration in `/backend/Config.toml`
4. Run the service using: `bal run backend`

## Testing

Run the test suite using: `bal test backend`
