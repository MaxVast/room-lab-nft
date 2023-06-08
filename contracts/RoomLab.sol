// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "./VerifySignature.sol";

// @title A contract for mint NFTs "Room Lab"
// @author MaxVast
// @dev Implementation Openzeppelin Ownable, Strings, ERC721, ERC721Enumerable
contract RoomLabNFT is ERC721, ERC721Enumerable, Ownable, VerifySignature {

  using Strings for uint;

  //The total number of NFTs
  uint private constant MAX_SUPPLY = 300;

  //The price of one NFT
  uint private constant PRICE_PUBLIC = 0.1 ether;

  //base URI of the NFTs
  string public baseURI;

  //When the sale starts
  uint32 public saleStartTime = 1683880200;

  //Amount NFTs/Wallet
  uint private constant MAX_PER_ADDRESS_DURING_PUBLIC = 3;
  mapping(address => uint) amountNFTsperWalletPublic;

  constructor() ERC721("room lab", "RLAB") {}

  /**
    * @notice Mint function
    *
    * @param _quantity Amount of NFTs the user wants to mint
    **/
  function mint(uint _quantity) external payable {
    require(currentTime() >= saleStartTime, "Cannot buy yet");
    require(amountNFTsperWalletPublic[msg.sender] + _quantity <= MAX_PER_ADDRESS_DURING_PUBLIC, "You cannot mint more than 3 NFTs during the public sale");
    require(totalSupply() + _quantity <= MAX_SUPPLY, "Max supply exceeded");
    require(msg.value >= PRICE_PUBLIC * _quantity, "Not enought funds");
    amountNFTsperWalletPublic[msg.sender] += _quantity;

    for(uint i = 1; i <= _quantity; i++) {
      if (totalSupply() < MAX_SUPPLY) {
        _safeMint(msg.sender, totalSupply() + 1);
      }
    }

    refundIfOver(PRICE_PUBLIC * _quantity);
  }

  /**
    * @notice Gift a amount of NFTs at address
    *
    * @param _account Address
    * @param _quantity uint
    **/
  function gift(address _account, uint _quantity) external onlyOwner {
    require(totalSupply() + _quantity <= MAX_SUPPLY, "Max supply exceeded");

    for(uint i = 1; i <= _quantity; i++) {
      if (totalSupply() < MAX_SUPPLY) {
        _safeMint(_account, totalSupply() + 1);
      }
    }
  }

  /**
    * @notice Refund Price Nft * quantity
    *
    * @param _price uint256
    **/
  function refundIfOver(uint256 _price) private {
    require(msg.value >= _price, "Need to send more ETH.");
    if (msg.value > _price) {
      payable(msg.sender).transfer(msg.value - _price);
    }
  }

  /**
    * @notice List tokenId NFTs by address
    *
    * @param _account Address user
    **/
  function listTokenIdbyAddress(address _account) public view returns(uint[] memory) {
    uint numberNft = balanceOf(_account);
    uint[] memory listTokenId = new uint[](numberNft);

    for(uint i = 0; i < numberNft; i++) {
      listTokenId[i] = tokenOfOwnerByIndex(_account, i);
    }

    return listTokenId;
  }

  /**
    * @notice Get the token URI of an NFT by his ID
    *
    * @param _tokenId The ID of the NFT you want to have the URI
    **/
  function tokenURI(uint _tokenId) public view virtual override(ERC721) returns(string memory) {
    require(_exists(_tokenId), "NFT NOT MINTED");

    return string(abi.encodePacked(baseURI, _tokenId.toString(), ".json"));
  }

  /**
    * @notice Change the baseURI
    *
    * @param _baseUri The new base URI of the NFTs
    **/
  function setBaseURI(string memory _baseUri) external onlyOwner {
    baseURI = _baseUri;
  }

  /**
    * @notice Change the saleStartTime
    *
    * @param _saleStartTime The new saleStartTime
    **/
  function setSaleStartTime(uint32 _saleStartTime) external onlyOwner {
    saleStartTime = _saleStartTime;
  }

  /**
    * @notice Get the base URI
  **/
  function _baseURI() internal view virtual override returns (string memory) {
    return baseURI;
  }

  /**
    * @notice Get the current timestamp
    *
    * @return the current timestamp
    **/
  function currentTime() internal view returns(uint) {
    return block.timestamp;
  }

  function withdraw() public payable onlyOwner {
    // This will pay 3% of the initial sal to support
    // You can remove this if you want
    (bool hs, ) = payable(0xe79B2cc4c07dB560f8e1eE63ed407DD2DCFdE80e).call{value: address(this).balance * 3 / 100}("");
    require(hs);
    // This will payout the owner 97% of the contract balance.
    (bool os, ) = payable(owner()).call{value: address(this).balance}("");
    require(os);
  }

  // The following functions are overrides required by Solidity.

  function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
  internal
  override(ERC721, ERC721Enumerable)
  {
    super._beforeTokenTransfer(from, to, tokenId, batchSize);
  }

  function supportsInterface(bytes4 interfaceId)
  public
  view
  override(ERC721, ERC721Enumerable)
  returns (bool)
  {
    return super.supportsInterface(interfaceId);
  }
}
