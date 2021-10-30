// Give the contract some SVG code
// output NFT URI with this SVG code
// storing all NFT metadata on-chain
//ERC721URIStorage.sol
//SPDX-License
pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "base64-sol/base64.sol";

contract FatheadOnChain is ERC721URIStorage{
    uint256 public tokenCounter;
    address public owner;

    event CreatedSVGNFT(uint256 indexed tokenId, string tokenURI);

    constructor() ERC721 ("Fat Head on chain","FatHeadOnChain"){
        tokenCounter=0;
        owner = msg.sender;
    }

    function create(bytes memory imgBytes) public {
        _safeMint(msg.sender, tokenCounter);
        //imageUri
        string memory imageURI= toImageURI(imgBytes);
        //tokenUri
        string memory tokenURI = formatTokenURI(imageURI);
        _setTokenURI(tokenCounter, tokenURI);
        emit CreatedSVGNFT(tokenCounter, tokenURI);
        tokenCounter = tokenCounter +1;
    }



    function createFromSVG(string memory svg) public {
        _safeMint(msg.sender, tokenCounter);
        //imageUri
        string memory imageURI= svgToImageURI(svg);
        //tokenUri
        string memory tokenURI = formatTokenURI(imageURI);
        _setTokenURI(tokenCounter, tokenURI);
        emit CreatedSVGNFT(tokenCounter, tokenURI);
        tokenCounter = tokenCounter +1;
    }

        function createFromPNG(string memory png) public {
        _safeMint(msg.sender, tokenCounter);
        //imageUri
        string memory imageURI= pngToImageURI(png);
        //tokenUri
        string memory tokenURI = formatTokenURI(imageURI);
        _setTokenURI(tokenCounter, tokenURI);
        emit CreatedSVGNFT(tokenCounter, tokenURI);
        tokenCounter = tokenCounter +1;
    }

    function toImageURI(bytes memory imgBytes) public pure returns (string memory){
        //data:image/png+xml;base64,<base54-encoding>
        string memory baseURL = "data:image/png+xml;base64,";
        string memory base64Encoded = Base64.encode(imgBytes);
        string memory imageURI = string(abi.encodePacked(baseURL, base64Encoded));
        return imageURI;
    }

    
    function svgToImageURI(string memory svg) public pure returns (string memory){
        //data:image/svg+xml;base64,<base54-encoding>
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));
        string memory imageURI = string(abi.encodePacked(baseURL, svgBase64Encoded));
        return imageURI;
    }

     function pngToImageURI(string memory png) public pure returns (string memory){
        //data:image/svg+xml;base64,<base54-encoding>
        string memory baseURL = "data:image/png+xml;base64,";
        string memory pngBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(png))));
        string memory imageURI = string(abi.encodePacked(baseURL, pngBase64Encoded));
        return imageURI;
    }   

    function formatTokenURI(string memory imageURI) public pure returns (string memory) {
        string memory baseURL= "data:application/json;base64,";
        return string(abi.encodePacked(baseURL,
        Base64.encode(
         bytes(abi.encodePacked('{"name": "FatHead","description": "FatHead on chain!", "attributes": "", "image":', imageURI,'"}')))
         ));
    }
}