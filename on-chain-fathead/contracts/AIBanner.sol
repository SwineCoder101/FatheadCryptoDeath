// Give the contract some SVG code
// output NFT URI with this SVG code
// storing all NFT metadata on-chain
//ERC721URIStorage.sol
//SPDX-License
pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "base64-sol/base64.sol";
import '@openzeppelin/contracts/access/Ownable.sol';

contract AIBanner is ERC721URIStorage, Ownable{
    uint256 public tokenCounter;
    uint256 public constant price = 125000000000000000; //0.125 ETH
    uint256 public constant MAX_Tokens = 8888;
    event CreatedAIBanner(uint256 indexed tokenId, string tokenURI);
    bool public saleIsActive = false;

    constructor() ERC721 ("AI Banner","AIBanner"){
        tokenCounter=0;
    }

    /*
    * Pause sale if active, make active if paused
    */
    function flipSaleState() public onlyOwner {
        saleIsActive = !saleIsActive;
    }

    function mintBanner(string memory imageURI, string []  memory attributeArr) public payable{
        require(price == msg.value, "Ether value sent is not correct");
        require(saleIsActive, "Sale must be active to mint tokens");
        require((tokenCounter + 1) <= MAX_Tokens, "Purchase would exceed max supply of tokens");

        _safeMint(msg.sender, tokenCounter);
        string memory tokenURI = formatTokenURI(imageURI,attributeArr);
        _setTokenURI(tokenCounter, tokenURI);
        emit CreatedAIBanner(tokenCounter, tokenURI);
        tokenCounter = tokenCounter +1;
    }

    function formatTokenURI(string memory imageURI,string [] memory attributeArr) private pure returns (string memory) {
        string memory baseURL= "data:application/json;base64,";
        string memory attrutributesStr = "";
        for (uint j = 0; j < attributeArr.length -1; j++) {
            attrutributesStr = string(abi.encodePacked(attrutributesStr,attributeArr[j],","));
        }
        attrutributesStr = string(abi.encodePacked("[",attrutributesStr,attributeArr[attributeArr.length -1],"]"));
        return string(abi.encodePacked(baseURL,
        Base64.encode(
         bytes(abi.encodePacked('{"name": "Banner","description": "NFT AI Generated Banner!", "attributes":',attrutributesStr,', "image":', imageURI,'"}')))
         ));
    }

}