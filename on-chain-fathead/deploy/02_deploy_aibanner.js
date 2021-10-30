const fs = require("fs")
let { networkConfig } = require('../helper-hardhat-config')

module.exports = async ({
    getNamedAccounts,
    deployments,
    getChainId
}) => {
    const {deploy,log} = deployments;
    const {deployer} = await getNamedAccounts();
    const chainId = await getChainId();
    log("=========================================")
    log(`here is the deployer ${deployer}`)
    const aiBannerContract = await deploy('AIBanner', {
        from: deployer,
        log: true
    })
    log(`you have deployed an NFT contract to ${aiBannerContract.address}`)
}