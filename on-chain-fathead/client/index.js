const { ethers, Wallet } = require("ethers");

// A Web3Provider wraps a standard Web3 provider, which is
// what Metamask injects as window.ethereum into each page
//https://rinkeby.infura.io/v3/1cd04cb98bb744c59d01758cd9e9729e
//https://mainnet.infura.io/v3/1cd04cb98bb744c59d01758cd9e9729e
// const provider = new ethers.providers.Web3Provider(window.ethereum);
const provider =  new ethers.providers.InfuraProvider('rinkeby',process.env.WEB3_INFURA_PROJECT_ID);
const imgURI=process.env.TEST_IMG_URL;
// The Metamask plugin also allows signing transactions to
// send ether and pay to change state within the blockchain.
// For this, you need the account signer...
// const signer = provider.getSigner();
CONTRACT_ADDRESS=process.env.TEST_CONTRACT_ADDRESS;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
//9824e6b84f77de92b52874c74c6282518d52be7c0d90cec350ff9096bd6b2865
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
    const price = ethers.utils.parseEther("0.125");
    console.log(price);

    // const signer = provider.getSigner();
    const contract = await new ethers.Contract(CONTRACT_ADDRESS,ABI,wallet);
    const mintjson = {
    gasLimit: 500_000,
    value: price,
    gasPrice: "30000000000000"};
    //console.log(contract);
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