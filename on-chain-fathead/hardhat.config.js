require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");
require('hardhat-deploy');
// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more
require('dotenv').config();
const RINKEBY_RPC_URL = process.env.RINKEBY_RPC_URL;
const MNEMONIC= process.env.MNEMONIC;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  defaultNetwork: "hardhat",
  networks: { 
    hardhat: {},
    // kovan: {
    //   url: process.env.KOVAN_RPC_URL,
    //   // accounts: [PRIVATE_KEY],
    //   accounts: {
    //       mnemonic: MNEMONIC,
    //   },
    //   saveDeployments: true,
    // },    
    rinkeby:{
      url: RINKEBY_RPC_URL,
      accounts: [PRIVATE_KEY],
      // accounts:{
      //   mnemonic: MNEMONIC
      // },
      saveDeployments: true,
    }
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: process.env.ETHERSCAN_API_KEY
  },
  namedAccounts: {
    deployer: {
      default:0,
      "rinkeby":'0x6c96Ab2e710360073a847a30f993261be830dC3C',
    }
  },
  solidity: {
    compilers: [
        {
            version: "0.8.0"
        },
        {
            version: "0.7.0"
        },
        {
            version: "0.6.6"
        },
        {
            version: "0.4.24"
        }
    ],
  }
}
