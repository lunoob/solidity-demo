// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// 使用 payable 可以往合约里进行打钱
// payable 可以标识地址或者函数

contract Payable {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    // 支持向合约转主币
    function deposit() public payable {}

    // 获取合约的余额
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}