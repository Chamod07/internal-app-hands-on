import ballerina/sql;
import ballerinax/mysql;

type DatabaseConfig record {|
    # Database User 
    string user;
    # Database Password
    string password;
    # Database Name
    string database;
    # Database Host
    string host;
    # Database port
    int port;
    # Database connection pool
    sql:ConnectionPool connectionPool;
|};

# Database config record.
type DatabaseClientConfig record {|
    *DatabaseConfig;
    # Additional configurations related to the MySQL database connection
    mysql:Options? options;
|};

# User search parameters
public type UserSearchParams record {|
    # Optional search term for filtering
    string? searchTerm = ();
    # Optional role filter
    string? role = ();
    # Optional active status filter
    boolean? active = ();
|};

# Response for user creation
public type UserCreationResponse record {|
    # Id of the created user
    int id;
    # Status message
    string message;
|};

# Response for user update
public type UserUpdateResponse record {|
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
