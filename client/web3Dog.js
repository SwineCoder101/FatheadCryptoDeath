const Web3 = require('web3')
const rpcURL = "https://rinkeby.infura.io/v3/1cd04cb98bb744c59d01758cd9e9729e"
const web3 = new Web3(rpcURL)
const accountAddress= "0x6c96Ab2e710360073a847a30f993261be830dC3C"

console.log("Running web3 js client code....");
web3.eth.getBalance(address, (err, wei) => {
    balance = web3.utils.fromWei(wei, 'ether')
  })



async function getCurrentAccount() {
    const accounts = await window.web3.eth.getAccounts();
    console.log(accounts[0]);
    return accounts[0];
}

// async function Mint() {

//     var dop = document.getElementById("count").value;
//     console.log(dop);

//     const account = await getCurrentAccount();
//     console.log(account);

//     var NTF_VALUE = await window.contract.methods.getPrice().call();
//     const NTF_estimation = NTF_VALUE * dop
//     const coolNumber = await window.contract.methods.adopt(dop).send({from: account, value: NTF_estimation});
//     updateStatus('You Have Minted ' + dop + ' Dog Successfully.' + ' ' + ' <a href="https://opensea.io/">View NFT @ OpenSea</a>');
// }