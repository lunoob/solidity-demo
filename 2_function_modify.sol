// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

// 如果不是合约创建人则 return 的操作
contract FunctionModify {
    uint256 count = 0;
    address owner;

    // check the sender whether is contract owner
    modifier checkOwner() {
        require(msg.sender == owner, "not contract owner");
        _;
    }

    constructor() {
        owner = address(msg.sender);
    }

    function addCount(uint256 number) public returns (uint256) {
        count += number;
        return number;
    }

    // only contract owner can call
    function subtractCount(uint256 number) public checkOwner returns (uint256) {
        count -= number;
        return number;
    }

    // only contract owner can call
    function getOwnerAddress() public view checkOwner returns (address) {
        return owner;
    }

    function queryCount() public view returns (uint256) {
        return count;
    }
}
