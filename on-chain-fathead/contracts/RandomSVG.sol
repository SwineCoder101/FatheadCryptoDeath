// // Give the contract some SVG code
// // output NFT URI with this SVG code
// // storing all NFT metadata on-chain
// //ERC721URIStorage.sol
// //SPDX-License
// pragma solidity 0.8.0;

// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
// import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";
// import "base64-sol/base64.sol";

// contract RandomSVG is ERC721URIStorage,VRFConsumerBase {
//     bytes32 public keyHash;
//     uint256 public fee;
//     constructor(address _VRFCoordinator, address _linkToken,bytes32 _keyHash, uint256 _fee) 
//     VRFConsumerBase(_VRFCoordinator,_linkToken)
//     ERC721 ("RandomSVG","rsNFT")
//     {
//         keyHash=_keyHash;
//         fee=_fee;
//     }

//     // function create() public return (bytes32 requestId){
//     //     requestId = requestRandomness(keyHash, fee);
//     //     //get a random number
//     //     // use that number to generate some random SVG code
//     //     // base64 encode the SVG code
//     //     // get the toeknURI and mint the NFT
//     //     // keccak()
//     //     // blockchains are deterministic
//     // }

//     // function fulfillRandomness(bytes32 requestId)


// }