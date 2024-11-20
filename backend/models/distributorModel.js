const mongoose = require('mongoose');

const distributorSchema = mongoose.Schema({
    companyName: {
        type: String,
        required: true,
    },
    distributorName: {
        type: String,
        required: true,
    },
    username: {
        type: String,
        required: true,
        unique: true, // Ensure the username is unique
    },
    password: {
        type: String,
        required: true,
    },
}, {
    timestamps: true,
});

const Distributor = mongoose.model('Distributor', distributorSchema);

module.exports = Distributor;
