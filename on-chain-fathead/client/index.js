const { ethers, Wallet } = require("ethers");

// A Web3Provider wraps a standard Web3 provider, which is
// what Metamask injects as window.ethereum into each page
//https://rinkeby.infura.io/v3/1cd04cb98bb744c59d01758cd9e9729e
//https://mainnet.infura.io/v3/1cd04cb98bb744c59d01758cd9e9729e
// const provider = new ethers.providers.Web3Provider(window.ethereum);
const provider =  new ethers.providers.InfuraProvider('rinkeby','1cd04cb98bb744c59d01758cd9e9729e');
const imgURI="https://ipfs.io/ipfs/QmRew4KnHQzbtLruqdoXjb4SLDKK336ru8QJzcu8nXWxo4";

// The Metamask plugin also allows signing transactions to
// send ether and pay to change state within the blockchain.
// For this, you need the account signer...
// const signer = provider.getSigner();
CONTRACT_ADDRESS='0xe23997D62b453bF78E7FE1F9d93E10008909434F';
PRIVATE_KEY='8616ed595260f39e20fbd23b3c8b5c0faf2e82416cbb848097d7f2edc4f0b13a';
// balance = await provider.getBalance("ethers.eth");
// ethers.utils.formatEther(balance);
// ethers.utils.parseEther("1.0");
wallet =  new ethers.Wallet(PRIVATE_KEY,provider);
main();
let arrAtt=[];

function setArrAtt(arr){
    arrAtt=arr;
}
async function main(){
    const ABI=['function mintBanner(string memory imageURI, string []  memory attributeArr) public payable'];
    console.log(wallet);
    // const readOnlyContract = new ethers.Contract(CONTRACT_ADDRESS,ABI,provider);
    // const value = await readOnlyContract.tokenURI(0);

    // console.log(value.toString());

    // const signer = provider.getSigner();
    const contract = await new ethers.Contract(CONTRACT_ADDRESS,ABI,wallet);
    const mintjson = {
    gasLimit: 500_000,
    value: 110,
    gasPrice: "30000000000000"};
    console.log(contract);
    outTrans = await contract.mintBanner(imgURI,["banner","test","twitter"],mintjson);


    // await signer.sendTransaction()
}


async function transact(){

}

async function getWalletConnected(){

}

function getImageURI(){
}

function getOpenseaURI(){
}

function getEtherscanURI(){
}