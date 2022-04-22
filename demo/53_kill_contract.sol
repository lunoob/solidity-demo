// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Kill {

    constructor() payable {}

    // 销毁合约
    function kill() public {
        // 把当前合约下的主币强制发送给 msg.sender
        selfdestruct(payable(msg.sender));
    }

    function test() external pure returns (uint) {
        return 123;
    }
}

contract Helper {
    function kill(address _kill) external {
        Kill(_kill).kill();
    }

    // 获取当前合约余额
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}