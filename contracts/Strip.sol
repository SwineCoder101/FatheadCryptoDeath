// pragma solidity ^0.7.0;
// /**
//  * @title Degenz Genesis Stripz contract
//  * @dev Extends ERC721 Non-Fungible Token Standard basic implementation
//  */
// contract Strip is ERC721, Ownable {
//     using SafeMath for uint256;

//     string public STRIPS_PROVENANCE = "";

//     uint256 public MAX_STRIPS;

//     bool public mintIsActive = false;

//     mapping(address => bool) whitelisted;
//     mapping(address => bool) minted;

//     constructor(string memory name, string memory symbol, uint256 maxNftSupply) ERC721(name, symbol) {
//         MAX_STRIPS = maxNftSupply;
//     }

//     function withdraw() public onlyOwner {
//         uint balance = address(this).balance;
//         msg.sender.transfer(balance);
//     }

//     /*     
//     * Set provenance once it's calculated
//     */
//     function setProvenanceHash(string memory provenanceHash) public onlyOwner {
//         STRIPS_PROVENANCE = provenanceHash;
//     }

//     function setBaseURI(string memory baseURI) public onlyOwner {
//         _setBaseURI(baseURI);
//     }

//     /*
//     * whitlist addresses to be able to mint genesis strip
//     */
//     function whitelistAddresses(address[] calldata wallets) public onlyOwner {
//         for(uint256 i=0; i<wallets.length;i++) {
//             whitelisted[wallets[i]] = true;
//         }
//     }

//     /*
//     * Pause sale if active, make active if paused
//     */
//     function flipMintState() public onlyOwner {
//         mintIsActive = !mintIsActive;
//     }

//     /**
//     * Mints Strip
//     */
//     function mintStrip() public {
//         require(mintIsActive, "Genesis stripz minting is not active");
//         require(!minted[msg.sender],"Only one Genesis stripz mint per wallet is allowed");
//         require(whitelisted[msg.sender],"Not eligible to mint Genesis stripz");
//         require(totalSupply().add(1) <= MAX_STRIPS, "Purchase would exceed max supply of Genesis stripz");
        
//         uint mintIndex = totalSupply();
//         if (totalSupply() < MAX_STRIPS) {
//             minted[msg.sender] = true;
//             _safeMint(msg.sender, mintIndex);
//         }
//     }
// }