const express = require('express');
const bcrypt = require('bcryptjs');
const Manufacturer = require('../models/manufacturerModel.js');
const jwt = require('jsonwebtoken');
const router = express.Router();

// Middleware to parse JSON request bodies
router.use(express.json());  // Ensures the server can parse incoming JSON

// Manufacturer signup
router.post('/signup', async (req, res) => {
  const { companyName, manufacturerName, username, password, email } = req.body;

  try {
    // Check if the manufacturer already exists
    const existingManufacturer = await Manufacturer.findOne({ username });
    if (existingManufacturer) {
      return res.status(400).json({ message: 'Username already exists' });
    }

    // Hash the password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    // Create a new manufacturer
    const newManufacturer = new Manufacturer({
      companyName,
      manufacturerName,
      username,
      email,
      password: hashedPassword,
    });

    // Save to the database
    await newManufacturer.save();

    // Generate JWT
    const token = jwt.sign({ manufacturerId: newManufacturer._id }, process.env.JWT_SECRET, { expiresIn: '1h' });

    res.status(201).json({
      message: 'Manufacturer registered successfully',
      token,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Server error', error: error.message });
  }
});

module.exports = router;
