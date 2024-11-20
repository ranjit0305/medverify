const express = require('express');
const { registerDistributor, loginDistributor } = require('../controllers/distributorController');
const router = express.Router();

// Register Distributor
router.post('/register', registerDistributor);

// Login Distributor
router.post('/login', loginDistributor);

module.exports = router;
