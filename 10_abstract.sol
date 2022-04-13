// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

abstract contract Ownable {
    address private owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(isOwner(), "not the contract owner");
        _;
    }

    function sayHello() public pure virtual returns (string memory);

    function isOwner() public view returns (bool) {
        return msg.sender == owner;
    }
}

contract Main is Ownable {
    string public name = "";

    function modifyName(string memory _name) public onlyOwner {
        name = _name;
    }

    function sayHello() public pure override returns (string memory) {
        return "hello world";
    }
}
