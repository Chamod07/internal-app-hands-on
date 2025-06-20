# Represents the response structure for retrieving user information.
public type UserInfoResponse record {|
    # Id of the employee
    string employeeId;
    # Email of the employee
    string workEmail;
    # First name of the employee
    string firstName;
    # Last name of the employee
    string lastName;
    # Job role
    string jobRole;
    # Thumbnail of the employee
    string? employeeThumbnail;
    # User Privileges
    int[]? privileges = ();
|};

# Collection of employees for search results
public type EmployeeCollection record {|
    # Number of total records
    int count;
    # List of employees
    UserInfoResponse[] employees;
|};

# Response for employee creation
public type EmployeeCreationResponse record {|
    # Id of the created employee 
    string employeeId;
    # Status message
    string message;
|};

# Response for employee update
public type EmployeeUpdateResponse record {|
    # Status message
    string message;
|};

# Error response model
public type ErrorResponse record {|
    # Error message
    string message;
    # Detailed error description
    string errorDetail;
|};

# Employee search parameters
public type EmployeeSearchParams record {|
    # Optional search term for filtering
    string? searchTerm = ();
    # Optional job role filter
    string? jobRole = ();
|};
