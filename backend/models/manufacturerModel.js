const mongoose = require('mongoose');

const manufacturerSchema = mongoose.Schema({
    companyName: { type: String, required: true },
    manufacturerName: { type: String, required: true },
    username: { type: String, required: true, unique: true },
    email: { type: String, required: true, unique: true },  // Ensure email is required
    password: { type: String, required: true },
}, { timestamps: true });

module.exports = mongoose.model('Manufacturer', manufacturerSchema);
