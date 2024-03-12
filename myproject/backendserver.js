const express = require('express');
const mysql = require('mysql2');

const app = express();
const PORT = process.env.PORT || 3000;


// MySQL database connection
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '21a81a4330', // Replace with your actual MySQL password
  database: 'goproject' // Your database name
});

// Connect to MySQL database
db.connect((err) => {
  if (err) {
    console.error('Error connecting to MySQL:', err);
    return;
  }
  console.log('Connected to MySQL database');
});

// Define routes
app.get('/api/users', (req, res) => {
  // Example route to fetch users from the database
  db.query('SELECT * FROM users', (err, results) => {
    if (err) {
      console.error('Error fetching users:', err);
      res.status(500).json({ error: 'Internal Server Error' });
      return;
    }
    res.json(results);
  });
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
