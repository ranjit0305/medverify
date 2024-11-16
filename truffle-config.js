module.exports = {
  networks: {
    // Configuration for Ganache local blockchain
    development: {
      host: "127.0.0.1", // Localhost (default)
      port: 7545,        // Default Ganache port
      network_id: "*",   // Match any network ID
    },
  },

  // Specify the Solidity compiler version
  compilers: {
    solc: {
      version: "0.8.0",  // Replace with your contract's Solidity version
      settings: {
        optimizer: {
          enabled: true, // Enable optimization
          runs: 200,     // Optimize for how many times you intend to run the code
        },
      },
    },
  },

  // Enable console logs during migration
  plugins: ["truffle-plugin-verify"],

  // Add paths or settings if needed for plugins or extensions
};
