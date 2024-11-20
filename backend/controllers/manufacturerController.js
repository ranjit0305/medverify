const Manufacturer = require('../models/manufacturerModel');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

// Helper function: Generate JWT Token
const generateToken = (id) => jwt.sign({ id }, process.env.JWT_SECRET, { expiresIn: '1h' });

// Manufacturer Registration
const registerManufacturer = async (req, res) => {
    const { companyName, manufacturerName, username, password } = req.body;

    try {
        // Check if the manufacturer username already exists
        const existingManufacturer = await Manufacturer.findOne({ username });
        if (existingManufacturer) {
            return res.status(400).json({ message: 'Manufacturer username already exists' });
        }

        // Hash the password
        const hashedPassword = await bcrypt.hash(password, 10);

        // Save manufacturer to the database
        const manufacturer = await Manufacturer.create({
            companyName,
            manufacturerName,
            username,
            password: hashedPassword,
        });

        res.status(201).json({
            message: 'Manufacturer registered successfully',
            manufacturer: {
                id: manufacturer._id,
                companyName: manufacturer.companyName,
                manufacturerName: manufacturer.manufacturerName,
                username: manufacturer.username,
            },
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error', error: error.message });
    }
};

// Manufacturer Login
const loginManufacturer = async (req, res) => {
    const { username, password } = req.body;

    try {
        // Check if manufacturer exists
        const manufacturer = await Manufacturer.findOne({ username });
        if (!manufacturer) {
            return res.status(401).json({ message: 'Invalid username or password' });
        }

        // Compare password
        const isMatch = await bcrypt.compare(password, manufacturer.password);
        if (!isMatch) {
            return res.status(401).json({ message: 'Invalid username or password' });
        }

        // Generate JWT Token
        const token = generateToken(manufacturer._id);

        res.status(200).json({
            message: 'Login successful',
            manufacturer: {
                id: manufacturer._id,
                companyName: manufacturer.companyName,
                manufacturerName: manufacturer.manufacturerName,
                username: manufacturer.username,
            },
            token,
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error', error: error.message });
    }
};

module.exports = { registerManufacturer, loginManufacturer };
