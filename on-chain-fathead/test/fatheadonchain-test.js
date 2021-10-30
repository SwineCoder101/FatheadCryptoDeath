const { expect } = require("chai");
const fs = require("fs")

beforeEach(async function () {
    // Get the ContractFactory and Signers here.
    FatHeadContract = await ethers.getContractFactory("FatheadOnChain");
    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();

    // To deploy our contract, we just have to call Token.deploy() and await
    // for it to be deployed(), which happens once its transaction has been
    // mined.
    hardhatToken = await FatHeadContract.deploy();
  });


describe("Fathead on chain contract", function () {
  it("should get correct deployed details", async function () {
    expect(await hardhatToken.name()).to.equal("Fat Head on chain");
    expect(await hardhatToken.symbol()).to.equal("FatHeadOnChain");
    expect(await hardhatToken.owner()).to.equal(owner.address);
  });
  it("should see the correct owner", async function () {
    expect(await hardhatToken.owner()).to.equal(owner.address);
  });  
});

describe("Minting FatHead tests", function () {
    it("should upload SVG to onchain", async function () {
      let filepath = "C:/dev/on-chain-fathead/img/triangle.svg"
      let svg = fs.readFileSync(filepath, {encoding: "utf8"})
      await hardhatToken.createFromSVG(svg)
      expect(await hardhatToken.ownerOf(0)).to.equal(owner.address);
      let tokenURI = await hardhatToken.tokenURI(0)
      console.log(`Here is the token uri: ${tokenURI}`)
    });
    it("should upload encoded bytes to onchain", async function () {
      let filepath = "C:/dev/on-chain-fathead/img/low-res-img.PNG"
      let encodedBytes = fs.readFileSync(filepath, {encoding: "utf8"}) //base64
      // let encodedBytes= getByteArray(filepath)
      // utils.formatBytes32String(text)

      console.log(`Here is the type: ${typeof encodedBytes}`)
      await hardhatToken.createFromPNG(encodedBytes)
      expect(await hardhatToken.ownerOf(0)).to.equal(owner.address);
      let tokenURI = await hardhatToken.tokenURI(0)
      console.log(`Here is the token uri: ${tokenURI}`)
    });
  });

  function getByteArray(filePath){
    let fileData = fs.readFileSync(filePath, {encoding: "base64"}).toString('hex');
    let result = []
    for (var i = 0; i < fileData.length; i+=2)
      result.push('0x'+fileData[i]+''+fileData[i+1])
    return result;
}