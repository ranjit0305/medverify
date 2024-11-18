const mongoose = require('mongoose');
const dotenv = require('dotenv');

// Load environment variables from .env file
dotenv.config();

// Debugging log to check the loaded URI
console.log('Mongo URI:', process.env.MONGO_URI);

const connectDB = async () => {
    try {
        // Establish MongoDB connection using the URI from the environment variables
        if (!process.env.MONGO_URI) {
            console.error('Mongo URI is missing in environment variables!');
            process.exit(1); // Exit if the URI is missing
        }

        const conn = await mongoose.connect(process.env.MONGO_URI, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
        });

        console.log(`MongoDB connected: ${conn.connection.host}`);
    } catch (err) {
        console.error('MongoDB Connection Error:', err);
        process.exit(1); // Exit on failure
    }
};

module.exports = connectDB;
