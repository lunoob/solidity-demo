// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract FunctionModifier {

    address public owner;
    bool public lock;
    uint public count = 5;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not contract owner");
        _;
    }

    // 传递参数
    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not valid address");
        _;
    }

    modifier noReentrancy() {
        require(!lock, "No reentrancy");
        lock = true;
        _;
        lock = false;
    }

    function setOwner(address _owner) public onlyOwner validAddress(_owner) {
        owner = _owner;
    }

    function decrement(uint i) public noReentrancy {
        count -= 1;

        if (i > 1) {
            decrement(i - 1);
        }
    }
}