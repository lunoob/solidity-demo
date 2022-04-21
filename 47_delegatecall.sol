// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract B {
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) external payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract A {
    uint public num;
    address public sender;
    uint public value;

    function setVars(address _contract, uint _num) external payable {
        (bool success,) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );

        require(success, "delegatecall failed");
    }
}

/*
    相当于合约 A 委托调用合约 B, 执行 B 的方法逻辑；
    对 B 的代码逻辑进行复用的意思
*/