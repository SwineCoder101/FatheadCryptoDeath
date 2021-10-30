// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// import 'https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721Enumerable.sol';
// import 'https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol';

// contract Cryptorayrays is ERC721Enumerable, Ownable {

//     using Strings for uint256;

//     string _baseTokenURI;
//     uint256 private _reserved = 500;
//     uint256 private _price = 0.0189 ether;
//     bool public _paused = true;

//     // withdraw addresses
//     address t1 = 0xF75a7D7cC5991630FB44EAA74D938bd28e35E87E;
//     address t2 = 0x5dabFB7F7A31261BD6eeF6DA45158B63D8602ED4;
//     address t3 = 0xAe0db47b54ff2795C6d694dAABF307d7135aA6D5;
    

//     // Crypto rayrays
//     // 9999 dogs in total
//     constructor(string memory baseURI) ERC721("Cryptorayrays", "rayrays")  {
//         setBaseURI(baseURI);

//         // team gets the first 1st Dog
//         _safeMint( t1, 500);
//         _safeMint( t2, 501);
//         _safeMint( t3, 502);
       
//     }

//     function adopt(uint256 num) public payable {
//         uint256 supply = totalSupply();
//         require( !_paused,                              "Sale paused" );
//         require( num < 10,                              "You can adopt a maximum of 10 NFT" );
//         require( supply + num < 10000 - _reserved,      "Exceeds maximum NFT supply" );
//         require( msg.value >= _price * num,             "Ether sent is not correct" );

//         for(uint256 i; i < num; i++){
//             _safeMint( msg.sender, supply + i );
//         }
//     }

//     function walletOfOwner(address _owner) public view returns(uint256[] memory) {
//         uint256 tokenCount = balanceOf(_owner);

//         uint256[] memory tokensId = new uint256[](tokenCount);
//         for(uint256 i; i < tokenCount; i++){
//             tokensId[i] = tokenOfOwnerByIndex(_owner, i);
//         }
//         return tokensId;
//     }

//     // Just in case Eth does some crazy stuff
//     function setPrice(uint256 _newPrice) public onlyOwner() {
//         _price = _newPrice;
//     }

//     function _baseURI() internal view virtual override returns (string memory) {
//         return _baseTokenURI;
//     }

//     function setBaseURI(string memory baseURI) public onlyOwner {
//         _baseTokenURI = baseURI;
//     }

//     function getPrice() public view returns (uint256){
//         return _price;
//     }

//     function giveAway(address _to, uint256 _amount) external onlyOwner() {
//         require( _amount <= _reserved, "Exceeds reserved NFT supply" );

//         uint256 supply = totalSupply();
//         for(uint256 i; i < _amount; i++){
//             _safeMint( _to, supply + i );
//         }

//         _reserved -= _amount;
//     }

//     function pause(bool val) public onlyOwner {
//         _paused = val;
//     }

//     function withdrawAll() public payable onlyOwner {
//         require(payable(t1).send(address(this).balance));
//     }
// }