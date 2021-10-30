// pragma solidity ^0.8.0;

// // import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// // import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";
// // import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// // import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
// import '@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol';
// import '@openzeppelin/contracts/access/Ownable.sol';
// import "base64-sol/base64.sol";

// /**
//  * @title FatHeadCryptoDeath contract
//  * @dev Extends ERC721 Non-Fungible Token Standard basic implementation
//  */
// contract FatHeadCryptoDeath  is ERC721Enumerable, Ownable, ERC721URIStorage{
//     // using SafeMath for uint256;
//     string public FatHead_PROVENANCE = "";
//     uint256 public tokenCounter;
//     uint256 public constant fatHeadPrice = 110000000000000000; //0.11 ETH

//     uint public constant maxFatHeadPurchase = 10;
//     uint256 public MAX_FatHead;

//     bool public saleIsActive = false;

//     bool public customfatHeadMinted = false;

//     mapping(address => bool) whitelisted;
//     mapping(address => bool) minted;
    
//     constructor() ERC721("fatHead", "FATHEAD") {
//         MAX_FatHead = 10;
//     }

//     function withdrawAll() public payable onlyOwner {
//         require(payable(msg.sender).send(address(this).balance));
//     }

//     // function withdraw() public payable onlyOwner {
//     //     uint balance = address(this).balance;
//     //     msg.sender.transfer(balance);
//     // }

//     /**
//      * Set some FatHead aside
//      */
//     function reserveFatHead(uint numFatHead) public onlyOwner {        
//         uint supply = totalSupply();
//         uint i;
//         for (i = 0; i < numFatHead; i++) {
//             _safeMint(msg.sender, supply + i);
//         }
//     }

//     /*     
//     * Set provenance once it's calculated
//     */
//     function setProvenanceHash(string memory provenanceHash) public onlyOwner {
//         FatHead_PROVENANCE = provenanceHash;
//     }

//     // function setBaseURIForFatHead(string memory baseURI) public onlyOwner {
//     //     setBaseURI(baseURI);
//     // }

//     /*
//     * Pause sale if active, make active if paused
//     */
//     function flipSaleState() public onlyOwner {
//         saleIsActive = !saleIsActive;
//     }

//     /**
//     * Mints FatHead
//     */
//     function mintFatHead(uint numberOfTokens) public payable {
//         require(saleIsActive, "Sale must be active to mint FatHead");
//         require(numberOfTokens <= maxFatHeadPurchase, "Can only mint 10 tokens at a time");
//         require((totalSupply() + numberOfTokens) <= MAX_FatHead, "Purchase would exceed max supply of FatHead");
//         require((fatHeadPrice * numberOfTokens) <= msg.value, "Ether value sent is not correct");
//         mintNumberOfTokens(numberOfTokens);
//     }


//     function mintBanner(string memory imageURI, string []  memory attributeArr) public payable{
//         _safeMint(msg.sender, tokenCounter);
//         string memory tokenURI = formatTokenURI(imageURI,attributeArr);
//         _setTokenURI(tokenCounter, tokenURI);
//         // emit CreatedSVGNFT(tokenCounter, tokenURI);
//         tokenCounter = tokenCounter +1;
//     }

//     function formatTokenURI(string memory imageURI,string [] memory attributeArr) public pure returns (string memory) {
//         string memory baseURL= "data:application/json;base64,";
//         string memory attrutributesStr = "";
//         for (uint j = 0; j < attributeArr.length -2; j++) {
//             attrutributesStr = string(abi.encodePacked(attrutributesStr,attributeArr[j],","));
//         }
//         attrutributesStr = string(abi.encodePacked("[",attrutributesStr,attributeArr[attributeArr.length -1],"]"));
//         return string(abi.encodePacked(baseURL,
//         Base64.encode(
//          bytes(abi.encodePacked('{"name": "Banner","description": "NFT AI Generated Banner!", "attributes":',attrutributesStr,', "image":', imageURI,'"}')))
//          ));
//     }



//     function whitelistAddresses(address[] calldata wallets) public onlyOwner {
//         for(uint256 i=0; i<wallets.length;i++) {
//             whitelisted[wallets[i]] = true;
//         }
//     }

//     function mintNumberOfTokens(uint numberOfTokens) private{
//         for(uint i = 0; i < numberOfTokens; i++) {
//             uint mintIndex = totalSupply();
//             if (totalSupply() < MAX_FatHead) {
//                 _safeMint(msg.sender, 500 + mintIndex);
//             }
//         }
//     }

//     function burnTwoForOne(uint256 t1, uint256 t2) public {
//         require(saleIsActive, "Sale must be active to mint FatHead");
//         //require(totalSupply().add(numberOfTokens) <= MAX_FatHead, "Purchase would exceed max supply of FatHead");
//         //require(fatHeadPrice.mul(numberOfTokens) <= msg.value, "Ether value sent is not correct");           
//         burn(t1);
//         burn(t2);
//         mintNumberOfTokens(1);
//     }

//   function burn(uint256 tokenId)
//     private
//   {
//     require(_isApprovedOrOwner(msg.sender, tokenId));
//     require(_exists(tokenId));
//     require(ERC721.ownerOf(tokenId) == msg.sender, string(abi.encodePacked("ERC721: Sender does not own TokenId: ", tokenId)));
//     _burn(tokenId);
//   }

//   function getTokenURI(uint256 tokenId) public view returns(string memory){
//       return ERC721.tokenURI(tokenId);
//   }

// }