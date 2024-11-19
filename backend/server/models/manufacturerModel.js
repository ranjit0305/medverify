const mongoose = require('mongoose');

const manufacturerSchema = new mongoose.Schema({
    companyName: {
        type: String,
        required: true,
    },
    manufacturerName: {
        type: String,
        required: true,
    },
    username: {
        type: String,
        required: true,
        unique: true,
    },
    password: {
        type: String,
        required: true,
    },
});

const Manufacturer = mongoose.model('Manufacturer', manufacturerSchema);
module.exports = Manufacturer;
