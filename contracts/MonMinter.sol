pragma solidity ^0.7.6;
pragma experimental ABIEncoderV2;
import "@openzeppelin/contracts/token/ERC721/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "contracts/UsesMon.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MonMinter is ERC721Burnable, AccessControl, UsesMon {

  modifier onlyAdmin {
    require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Not admin");
    _;
  }

  modifier onlyMinter {
    require(hasRole(MINTER_ROLE, msg.sender), "Not minter");
    _;
  }

  using SafeERC20 for IERC20;
  using Counters for Counters.Counter;

  bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
  Counters.Counter private monIds;

  mapping(uint256 => Mon) public monRecords;

  mapping(uint256 => string) public rarityTable;

  constructor() public ERC721("0xmons.xyz", "0XMON") {

    // Give caller admin permissions
    _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);

    // Make the caller admin a minter
    grantRole(MINTER_ROLE, msg.sender);

    // Send monster #0 to the caller
    mintMonster(
      // to
      msg.sender,
      // parent1Id
      0,
      // parent2Id
      0,
      // minterContract
      address(this),
      // contractOrder
      0,
      // gen
      0,
      // bits
      0,
      // exp
      0,
      // rarity
      0
      );
  }

  // Mints a monster to an address and sets its data
  function mintMonster(address to,
                       uint256 parent1Id,
                       uint256 parent2Id,
                       address minterContract,
                       uint256 contractOrder,
                       uint256 gen,
                       uint256 bits,
                       uint256 exp,
                       uint256 rarity
                      ) public onlyMinter returns (uint256) {
    uint256 currId = monIds.current();
    monIds.increment();
    monRecords[currId] = Mon(
      to,
      parent1Id,
      parent2Id,
      minterContract,
      contractOrder,
      gen,
      bits,
      exp,
      rarity
    );
    _safeMint(to, currId);
    return(currId);
  }

  // Modifies the data of a monster
  function modifyMon(uint256 id,
                     bool ignoreZeros,
                     uint256 parent1Id,
                     uint256 parent2Id,
                     address minterContract,
                     uint256 contractOrder,
                     uint256 gen,
                     uint256 bits,
                     uint256 exp,
                     uint256 rarity
  ) public onlyMinter {
    Mon storage currMon = monRecords[id];
    if (ignoreZeros) {
      if (parent1Id != 0) {
        currMon.parent1Id = parent1Id;
      }
      if (parent2Id != 0) {
        currMon.parent2Id = parent2Id;
      }
      if (minterContract != address(0)) {
        currMon.minterContract = minterContract;
      }
      if (contractOrder != 0) {
        currMon.contractOrder = contractOrder;
      }
      if (gen != 0) {
        currMon.gen = gen;
      }
      if (bits != 0) {
        currMon.bits = bits;
      }
      if (exp != 0) {
        currMon.exp = exp;
      }
      if (rarity != 0) {
        currMon.rarity = rarity;
      }
    }
    else {
      currMon.parent1Id = parent1Id;
      currMon.parent2Id = parent2Id;
      currMon.minterContract = minterContract;
      currMon.contractOrder = contractOrder;
      currMon.gen = gen;
      currMon.bits = bits;
      currMon.exp = exp;
      currMon.rarity = rarity;
    }
  }

  // Modifies the tokenURI of a monster
  function setTokenURI(uint256 id, string memory uri) public onlyMinter {
    _setTokenURI(id, uri);
  }

  // Sets the base URI
  function setBaseURI(string memory uri) public onlyAdmin {
    _setBaseURI(uri);
  }

  // Rescues tokens locked in the contract
  function moveTokens(address tokenAddress, address to, uint256 numTokens) public onlyAdmin {
    IERC20 _token = IERC20(tokenAddress);
    _token.safeTransfer(to, numTokens);
  }

  // Updates the mapping of rarity codes to strings
  function setRarityTitle(uint256 code, string memory s) public onlyAdmin {
    rarityTable[code] = s;
  }

  // Allows admin to add new minters
  function setMinterRole(address a) public onlyAdmin {
    grantRole(MINTER_ROLE, a);
  }
}