// Import dependencies
const express = require('express');
const dotenv = require('dotenv');
const connectDB = require('../config/db');  // Corrected path
const userRoutes = require('../routes/userRoutes');  // Corrected path
const manufacturerRoutes = require('../routes/manufacturerRoutes');  // Corrected path
const distributorRoutes = require('../routes/distributorRoutes');  // Corrected path
const cors = require('cors');  // Enable CORS for cross-origin requests
const { errorHandler } = require('../middleware/errorMiddleware'); // Corrected import path

// Initialize app and configure environment variables
dotenv.config();  // This should be the very first line to load environment variables

// Initialize the app
const app = express();

// Middleware setup
app.use(express.json());  // To parse JSON in request body
app.use(cors());  // Enable CORS for all domains

// Connect to MongoDB
connectDB();

// Define Routes
app.use('/api/users', userRoutes);
app.use('/api/manufacturers', manufacturerRoutes);
app.use('/api/distributors', distributorRoutes);  // Add Distributor Routes

// Global error handling middleware
app.use(errorHandler);

// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
