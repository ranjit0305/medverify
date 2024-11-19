const mongoose = require('mongoose');
const dotenv = require('dotenv');

// Load environment variables
dotenv.config();

// Debugging log for MongoDB URI (remove in production for security reasons)
if (!process.env.MONGO_URI) {
    console.error('Error: MongoDB URI is not defined in the .env file!');
    process.exit(1); // Exit if the URI is missing
}

const connectDB = async () => {
    try {
        // Connect to MongoDB
        const conn = await mongoose.connect(process.env.MONGO_URI, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
        });

        console.log(`MongoDB connected: ${conn.connection.host}`);
    } catch (error) {
        console.error(`MongoDB connection error: ${error.message}`);
        process.exit(1); // Exit process on failure
    }
};

module.exports = connectDB;
