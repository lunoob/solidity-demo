// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// 发送主币
// transfer (2300 gas, throws error)
// send (2300 gas, returns bool)
// call (forward all gas or set gas, returns bool)
contract SendEther {
    constructor() payable {}

    // fallback 函数，专门用来收钱（没有 msg.data 时触发）
    receive() external payable {}

    function sendByCall(address _to) public {
       (bool success, ) = _to.call{value: 100}("");
       require(success, "Failed to send Ether with call");
    }

    function sendBySend(address payable _to) public {
        bool success = _to.send(123);
        require(success, "Failed to send Ether with send");
    }

    function sendByTransfer(address payable _to) public {
        _to.transfer(123);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract ReceiveEther {
    event Log(uint amount, uint gas);

    receive() external payable {
        emit Log(msg.value, gasleft());
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}