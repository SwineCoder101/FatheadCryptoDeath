const { expect } = require("chai");
const fs = require("fs")

beforeEach(async function () {
    aiBannerContract = await ethers.getContractFactory("AIBanner");
    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();
    hardhatToken = await aiBannerContract.deploy();
    imgURI="https://ipfs.io/ipfs/QmRew4KnHQzbtLruqdoXjb4SLDKK336ru8QJzcu8nXWxo4";
    await hardhatToken.flipSaleState();
  });

describe("AI banner contract Details", function () {
    it("should get correct deployed details", async function () {
      expect(await hardhatToken.name()).to.equal("AI Banner");
      expect(await hardhatToken.symbol()).to.equal("AIBanner");
    });
  });


describe("Minting AI Banner", function () {
    it("should Mint", async function () {
    arrStr = ["dog","brick","fathead"]
    let price = utils.bigNumberify(125000000000000000);
    await hardhatToken.mintBanner(imgURI,arrStr,{value: price});
    expect(await hardhatToken.ownerOf(0)).to.equal(owner.address);
    let tokenURI = await hardhatToken.tokenURI(0)
    console.log(`Here is the token uri: ${tokenURI}`)
    });
  });