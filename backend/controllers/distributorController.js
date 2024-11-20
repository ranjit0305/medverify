const Distributor = require('../models/distributorModel');
const bcrypt = require('bcryptjs');

// Register Distributor
const registerDistributor = async (req, res) => {
    const { companyName, distributorName, username, password } = req.body;

    try {
        // Check if distributor already exists
        const existingDistributor = await Distributor.findOne({ username });
        if (existingDistributor) {
            return res.status(400).json({ message: 'Distributor username already exists' });
        }

        // Hash password before saving
        const hashedPassword = await bcrypt.hash(password, 10);

        // Create new distributor
        const distributor = new Distributor({
            companyName,
            distributorName,
            username,
            password: hashedPassword,
        });

        // Save distributor to DB
        await distributor.save();

        res.status(201).json({
            message: 'Distributor registered successfully!',
            distributor: {
                id: distributor._id,
                companyName: distributor.companyName,
                distributorName: distributor.distributorName,
            },
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Server error, please try again.' });
    }
};

// Login Distributor
const loginDistributor = async (req, res) => {
    const { username, password } = req.body;

    try {
        const distributor = await Distributor.findOne({ username });
        if (!distributor) {
            return res.status(400).json({ message: 'Invalid credentials' });
        }

        const isMatch = await bcrypt.compare(password, distributor.password);
        if (!isMatch) {
            return res.status(400).json({ message: 'Invalid credentials' });
        }

        res.status(200).json({
            message: 'Login successful!',
            distributor: {
                id: distributor._id,
                companyName: distributor.companyName,
                distributorName: distributor.distributorName,
            },
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Server error, please try again.' });
    }
};

module.exports = { registerDistributor, loginDistributor };
