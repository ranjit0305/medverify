const mongoose = require('mongoose');

// Define the schema for the user model
const userSchema = new mongoose.Schema(
    {
        name: {
            type: String,
            required: [true, 'Name is required'],
        },
        email: {
            type: String,
            required: [true, 'Email is required'],
            unique: true, // Ensures email uniqueness
        },
        password: {
            type: String,
            required: [true, 'Password is required'],
        },
    },
    {
        timestamps: true, // Adds createdAt and updatedAt fields automatically
    }
);

// Compile the schema into a model
const User = mongoose.model('User', userSchema);

module.exports = User;
