pragma solidity ^0.7.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title FatHeadCryptoDeath contract
 * @dev Extends ERC721 Non-Fungible Token Standard basic implementation
 */
contract FatHeadCryptoDeath is ERC721, Ownable {
    using SafeMath for uint256;

    string public FatHead_PROVENANCE = "";

    uint256 public constant fatHeadPrice = 110000000000000000; //0.11 ETH

    uint public constant maxFatHeadPurchase = 10;
    uint private tokenCounter=0;

    uint256 public MAX_FatHead;

    bool public saleIsActive = false;

    bool public customfatHeadMinted = false;

    constructor() ERC721("fatHead", "FATHEAD") {
        MAX_FatHead = 10;
    }

    function withdraw() public onlyOwner {
        uint balance = address(this).balance;
        msg.sender.transfer(balance);
    }

    /**
     * Set some FatHead aside
     */
    function reserveFatHead(uint numFatHead) public onlyOwner {        
        uint supply = totalSupply();
        uint i;
        for (i = 0; i < numFatHead; i++) {
            _safeMint(msg.sender, supply + i);
        }
    }

    /*     
    * Set provenance once it's calculated
    */
    function setProvenanceHash(string memory provenanceHash) public onlyOwner {
        FatHead_PROVENANCE = provenanceHash;
    }

    function setBaseURI(string memory baseURI) public onlyOwner {
        _setBaseURI(baseURI);
    }

    /*
    * Pause sale if active, make active if paused
    */
    function flipSaleState() public onlyOwner {
        saleIsActive = !saleIsActive;
    }

    function tokenCounter() public {
        return totalSupply();
    }

    /**
    * Mints FatHead
    */
    function mintFatHead(uint numberOfTokens) public payable {
        require(saleIsActive, "Sale must be active to mint FatHead");
        require(numberOfTokens <= maxFatHeadPurchase, "Can only mint 10 tokens at a time");
        require(totalSupply().add(numberOfTokens) <= MAX_FatHead, "Purchase would exceed max supply of FatHead");
        require(fatHeadPrice.mul(numberOfTokens) <= msg.value, "Ether value sent is not correct");
        
        for(uint i = 0; i < numberOfTokens; i++) {
            uint mintIndex = totalSupply();
            if (totalSupply() < MAX_FatHead) {
                _safeMint(msg.sender, mintIndex);
            }
        }
    }
}