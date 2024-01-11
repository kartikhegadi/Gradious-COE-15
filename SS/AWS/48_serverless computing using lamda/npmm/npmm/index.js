const mysql = require('mysql');

exports.handler = async (event) => {
  // RDS MySQL database configuration
  const dbConfig = {
    host: ' database-1.c5usk8ag8mpj.ap-south-1.rds.amazonaws.com ',
    user: 'admin',
    password: 'password',
    database: 'simpleDB',
  };

  // Create a MySQL connection
  const connection = mysql.createConnection(dbConfig);

  // Connect to the database
  connection.connect();

  // MySQL query to fetch data
  const query = 'SELECT * FROM CUSTOMERS';

  try {
    // Execute the query
    const results = await executeQuery(query, connection);

    // Process the query results
    const data = results.map((row) => {
      return {
        id: row.ID,
        name: row.NAME,
        age: row.AGE,
        address: row.ADDRESS,
        salary: row.SALARY,
      };
    });

    const response = {
      statusCode: 200,
      body: JSON.stringify(data),
    };

    return response;
  } catch (error) {
    const errorResponse = {
      statusCode: 500,
      body: JSON.stringify({ message: error.message }),
    };

    return errorResponse;
  } finally {
    // Close the database connection
    connection.end();
  }
};

function executeQuery(query, connection) {
  return new Promise((resolve, reject) => {
    connection.query(query, (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
}

