// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

import "ERC721A/ERC721A.sol";
import  "@openzeppelin/contracts/access/Ownable.sol";

contract Gensets is ERC721A, Ownable {

    struct Information {
        bytes32 sertificateName;
        bytes32 sertiticateModel;
        bytes32 serialNumber;
        bytes32 customerName;
        bytes32 sellerName;
        uint32 publishedDate;
    }

    IERC721A public erc721Interface;

    uint256 public constant MAX_SUPPLY = 10000;
    uint256 public constant MINT_PRICE = 0.000002 ether;
    uint256 public currentSupply;
    string private _baseTokenURI;

    mapping(bytes32 => Information) public gensetSerialNumberToInformation;

    constructor() ERC721A("Gensets", "GNST") Ownable(msg.sender){
        
    }


    receive() external payable {}

    error NotValidToMint(
        uint256 _quantity,
        uint256 _sent,
        uint256 _population
    );


    function mint(uint256 _quantity, bytes32 _customerName, bytes32 _sellerName, uint32 _publishedDate, bytes32 _sertificateName, bytes32 _sertiticateModel) external payable {
        uint256 _currentSupply = currentSupply;
        uint256 total = _quantity * MINT_PRICE;
        uint256 population = _currentSupply + _quantity;

        if (
            _quantity > 5 ||
            population > MAX_SUPPLY ||
            msg.value != total
        ) revert NotValidToMint(_quantity, msg.value, _currentSupply);


        for (uint256 i; i < _quantity; ++i) {
            Information storage gensetInformation = gensetSerialNumberToInformation[keccak256(abi.encode(_currentSupply))];
            gensetInformation.sertificateName = _sertificateName;
            gensetInformation.sertiticateModel = _sertiticateModel;
            gensetInformation.publishedDate = _publishedDate;
            gensetInformation.customerName = _customerName;
            gensetInformation.sellerName = _sellerName;
            gensetInformation.serialNumber = keccak256(abi.encode(_currentSupply));
            _currentSupply++;
        }

        _mint(msg.sender, _quantity);

        currentSupply = uint16(_currentSupply);
    }


    function getGensetInformation(bytes32 _gensetSerialNumber) external view returns (Information memory) {
        Information memory gensetInformation = gensetSerialNumberToInformation[_gensetSerialNumber];
        return gensetInformation;
    }


    function setBaseURI(string memory baseURI) public onlyOwner {
        _baseTokenURI = baseURI;
    }

    function getUserGensets(address _user) public view returns (bytes32[] memory) {
        uint256 index;
        uint256 balance = balanceOf(_user);
        bytes32[] memory gensets = new bytes32[](balance);
        uint256 _currentSupply = currentSupply;
        for (uint256 i; i < _currentSupply; ++i) {
            address owner = ownerOf(i);
            if (owner == _user) {
                gensets[index] = keccak256(abi.encode(i));
                index++;
            }
        }
        return gensets;
    }


    function getGensetOwner(uint256 _genset)
        external
        view
        returns (address _owner)
    {
        _owner = ownerOf(_genset);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }
}
