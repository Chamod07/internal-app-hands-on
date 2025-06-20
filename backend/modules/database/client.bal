import ballerinax/mysql;
import ballerinax/mysql.driver as _;

// Database Client Configuration.
configurable DatabaseConfig databaseConfig = {
    host: "localhost",
    user: "chamod",
    password: "Chamod@2005",
    database: "employee_schema",
    port: 3306,
    connectionPool: {
        maxOpenConnections: 15,
        minIdleConnections: 5
    }
};

DatabaseClientConfig databaseClientConfig = {
    ...databaseConfig,
    options: {
        ssl: {
            mode: mysql:SSL_REQUIRED
        },
        connectTimeout: 10
    }
};

function initSampleDbClient() returns mysql:Client|error
=> new (
    host = databaseConfig.host,
    user = databaseConfig.user,
    password = databaseConfig.password,
    database = databaseConfig.database,
    port = databaseConfig.port,
    connectionPool = databaseConfig.connectionPool
);

# Database Client.
final mysql:Client dbClient = check initSampleDbClient();
