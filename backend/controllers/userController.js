const User = require('../models/userModel');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const generateToken = (id) => jwt.sign({ id }, process.env.JWT_SECRET, { expiresIn: '1h' });

const registerUser = async (req, res) => {
    const { name, email, password } = req.body;
    try {
        const existingUser = await User.findOne({ email });
        if (existingUser) return res.status(400).json({ message: 'User already exists' });

        const hashedPassword = await bcrypt.hash(password, 10);
        const user = await User.create({ name, email, password: hashedPassword });

        res.status(201).json({ message: 'User registered successfully', user: { id: user._id, name: user.name, email: user.email } });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error: error.message });
    }
};

const loginUser = async (req, res) => {
    const { email, password } = req.body;
    try {
        const user = await User.findOne({ email });
        if (!user) return res.status(401).json({ message: 'Invalid email or password' });

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) return res.status(401).json({ message: 'Invalid email or password' });

        const token = generateToken(user._id);
        res.status(200).json({ message: 'Login successful', user: { id: user._id, name: user.name, email: user.email }, token });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error: error.message });
    }
};

module.exports = { registerUser, loginUser };
