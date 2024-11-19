const express = require('express');
const bodyParser = require('body-parser');
const dotenv = require('dotenv');
const bcrypt = require('bcrypt'); // For password hashing
const jwt = require('jsonwebtoken'); // For generating authentication tokens
const connectDB = require('./config/db'); // MongoDB connection
const User = require('./models/userModel'); // User model
const Manufacturer = require('./models/manufacturerModel'); // Manufacturer model

// Initialize Express app
const app = express();

// Load environment variables
dotenv.config();

// Middleware
app.use(bodyParser.json());

// Connect to MongoDB
connectDB();

// Register a new user
app.post('/register', async (req, res) => {
    const { name, email, password } = req.body;

    try {
        // Check if the user already exists
        const userExists = await User.findOne({ email });
        if (userExists) {
            return res.status(400).json({ message: 'User already exists' });
        }

        // Hash the password
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);

        // Create a new user
        const user = new User({ name, email, password: hashedPassword });
        await user.save();

        res.status(201).json({ message: 'User registered successfully', user });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Server error' });
    }
});

// Login a user
app.post('/login', async (req, res) => {
    const { email, password } = req.body;

    try {
        // Find the user by email
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(401).json({ message: 'Invalid credentials' });
        }

        // Compare the password
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(401).json({ message: 'Invalid credentials' });
        }

        // Generate a JWT token
        const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: '1h' });

        res.status(200).json({ message: 'Login successful', token });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Server error' });
    }
});

// Manufacturer signup
app.post('/manufacturer/signup', async (req, res) => {
    const { companyName, manufacturerName, username, password } = req.body;

    try {
        // Check if username already exists
        const existingManufacturer = await Manufacturer.findOne({ username });
        if (existingManufacturer) {
            return res.status(400).json({ message: 'Username already exists' });
        }

        // Hash the password
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);

        // Create a new manufacturer
        const manufacturer = new Manufacturer({
            companyName,
            manufacturerName,
            username,
            password: hashedPassword,
        });

        await manufacturer.save();

        res.status(201).json({ message: 'Manufacturer registered successfully', manufacturer });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Protected route example
app.get('/protected', async (req, res) => {
    const token = req.headers.authorization?.split(' ')[1];
    if (!token) {
        return res.status(403).json({ message: 'No token provided' });
    }

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        res.status(200).json({ message: 'Access granted', userId: decoded.id });
    } catch (err) {
        return res.status(403).json({ message: 'Invalid token' });
    }
});

// Set the port and start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
