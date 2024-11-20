const mongoose = require('mongoose');

const connectDB = async () => {
  try {
    const uri = process.env.MONGO_URI;
    if (!uri) {
      throw new Error("Mongo URI is not defined in the environment variables.");
    }
    await mongoose.connect(uri, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log('MongoDB connected');
  } catch (error) {
    console.error('Error connecting to MongoDB:', error);
    process.exit(1);  // Exit if connection fails
  }
};

module.exports = connectDB;
