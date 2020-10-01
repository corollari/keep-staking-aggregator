const KEEPAggregator = artifacts.require("KEEPAggregator");

module.exports = function(deployer) {
  deployer.deploy(KEEPAggregator);
};
