// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// 接收主币
// 取钱到合约拥有者
// 合约拥有者权限
// 获取余额
contract EtherWallet {
    address owner;
    modifier onlyOwner() {
        require(msg.sender == owner, "not contract ower");
        _;
    }
    constructor() {
        owner = msg.sender;
    }
    // 收钱, 但不接收数据
    receive() external payable {}
    // 取款到 owner
    function withDraw(uint _amount) external onlyOwner {
        payable(msg.sender).transfer(_amount);
    }
    // 获取余额
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}