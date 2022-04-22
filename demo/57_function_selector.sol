// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Selector {

    function getSelector(string memory fn) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(fn)));
    }

}

// 函数选择器
contract Testor {
    event Log(bytes data);

    function trasfer(address _addr, uint num) public {
        emit Log(msg.data);
    }
}

// 说明合约中允许存在同名函数，只要参数类型/顺序不一样都行
// 0x4745b6cd --> 函数对应的位数
// 0000000000000000000000004b20993bc481177ec7e8f571cecae8a9e22c02db
// 000000000000000000000000000000000000000000000000000000000000000a