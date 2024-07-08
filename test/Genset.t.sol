// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Genset.sol";

contract GensetTest is Test {
    Gensets public gensets;

    function setUp() public {
        gensets = new Gensets();
    }

    function test_Mint() public {
        uint256 _quantity;
        bytes32 _customerName;
        bytes32 _sellerName;
        uint32 _publishedDate;
        bytes32 _sertificateName;
        bytes32 _sertiticateModel;

        _quantity = 3;  
        _customerName = keccak256(abi.encodePacked("customerName"));
        _sellerName = keccak256(abi.encodePacked("sellerName"));
        _publishedDate = 1688243200;
         _sertificateName = keccak256(abi.encodePacked("sertificateName"));
        _sertiticateModel = keccak256(abi.encodePacked("sertiticateModel"));

        gensets.mint{value: gensets.MINT_PRICE() * _quantity}(_quantity, _customerName, _sellerName, _publishedDate, _sertificateName, _sertiticateModel);
    }


    function test_getGensetInformation() public {
        uint256 _quantity;
        bytes32 _customerName;
        bytes32 _sellerName;
        uint32 _publishedDate;
        bytes32 _sertificateName;
        bytes32 _sertiticateModel;

        _quantity = 3;  
        _customerName = keccak256(abi.encodePacked("customerName"));
        _sellerName = keccak256(abi.encodePacked("sellerName"));
        _publishedDate = 1688243200;
        _sertificateName = keccak256(abi.encodePacked("sertificateName"));
        _sertiticateModel = keccak256(abi.encodePacked("sertiticateModel"));

        gensets.mint{value: gensets.MINT_PRICE() * _quantity}(_quantity,  _customerName, _sellerName, _publishedDate, _sertificateName, _sertiticateModel);

        Gensets.Information memory gensetInformation = gensets.getGensetInformation(keccak256(abi.encode(2)));

        assertEq(gensetInformation.sertificateName, _sertificateName);
        assertEq(gensetInformation.sertiticateModel, _sertiticateModel);
        assertEq(gensetInformation.publishedDate, _publishedDate);
        assertEq(gensetInformation.customerName, _customerName);
        assertEq(gensetInformation.sellerName, _sellerName);
    }


    function test_getUserGensets() public {
        uint256 _quantity;
        bytes32 _customerName;
        bytes32 _sellerName;
        uint32 _publishedDate;
        bytes32 _sertificateName;
        bytes32 _sertiticateModel;

        _quantity = 3;  
        _customerName = keccak256(abi.encodePacked("customerName"));
        _sellerName = keccak256(abi.encodePacked("sellerName"));
        _publishedDate = 1688243200;
        _sertificateName = keccak256(abi.encodePacked("sertificateName"));
        _sertiticateModel = keccak256(abi.encodePacked("sertiticateModel"));
        
        
        gensets.mint{value: gensets.MINT_PRICE() * _quantity}(_quantity, _customerName, _sellerName, _publishedDate, _sertificateName, _sertiticateModel);

        bytes32[] memory userGensets = gensets.getUserGensets(address(this));

        assertEq(userGensets.length, 3);
    }

}
