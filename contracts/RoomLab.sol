// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/finance/PaymentSplitter.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract RoomLabNFT is ERC721, ERC721Enumerable, Ownable {
  
  using Strings for uint;

  uint private constant MAX_PUBLIC = 300;

  uint private constant PRICE_PUBLIC = 0.1 ether;

  bool public saleEnabled;

  string public baseURI;

  mapping(address => uint) amountNFTsperWalletPublic;

  uint private constant MAX_PER_ADDRESS_DURING_PUBLIC = 3;

  constructor() ERC721("room lab", "RLAB") {}

  function mint(uint _quantity) external payable {
    require(saleEnabled == false, "Sale is not active");
    require(block.timestamp > 1683880200, "Cannot buy yet : 12/05/2023 10:30:00 UTC+2");
    require(amountNFTsperWalletPublic[msg.sender] + _quantity <= MAX_PER_ADDRESS_DURING_PUBLIC, "You cannot mint more than 3 NFTs during the public sale");
    require(totalSupply() + _quantity <= MAX_PUBLIC, "Max supply exceeded");
    require(msg.value >= PRICE_PUBLIC * _quantity, "Not enought funds");
    amountNFTsperWalletPublic[msg.sender] += _quantity;

    _safeMint(msg.sender, _quantity);
    refundIfOver(PRICE_PUBLIC * _quantity);
  }

  function gift(address _account, uint _quantity) external onlyOwner {
    require(totalSupply() + _quantity <= MAX_PUBLIC, "Max supply exceeded");
    amountNFTsperWalletPublic[_account] += _quantity;

    _safeMint(msg.sender, _quantity);
  }

  function refundIfOver(uint256 _price) private {
    require(msg.value >= _price, "Need to send more ETH.");
    if (msg.value > _price) {
      payable(msg.sender).transfer(msg.value - _price);
    }
  }

  function tokenURI(uint _tokenId) public view virtual override(ERC721) returns(string memory) {
    require(_exists(_tokenId), "NFT NOT MINTED");

    return string(abi.encodePacked(baseURI, _tokenId.toString(), ".json"));
  }

  function setBaseURI(string memory _baseURI) external onlyOwner {
    baseURI = _baseURI;
  }

  function _baseURI() internal view virtual override returns (string memory) {
    return baseURI;
  }

  function setSaleEnabled(bool _saleEnabled) external onlyOwner {
    saleEnabled = _saleEnabled;
  }

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
