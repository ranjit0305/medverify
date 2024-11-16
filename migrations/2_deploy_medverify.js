const MedVerify = artifacts.require("MedVerify");

module.exports = function(deployer) {
  deployer.deploy(MedVerify);
};
