// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// 小猪存钱罐
// 所有账户都可以向合约回款
// 只有合约拥有者才能提款
// 提款意味着：把所有钱提出，同时把合约销毁掉
contract PiggyBank {
    address public owner = msg.sender;

    // 存款事件，存了多少
    event Deposit(uint amount);
    // 提款事件
    event Withdraw(uint amount);

    receive() external payable {}
    fallback() external payable {}

    // 提款
    function withdraw() external {
        require(msg.sender == owner, "not owner");
        emit Withdraw(address(this).balance);
        selfdestruct(payable(msg.sender));
    }
}