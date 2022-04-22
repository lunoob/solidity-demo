// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
// hash 算法特点
// 输入值相同，输出值一定相同
// 不管输入值多大，输出值为定长，并且不可逆向
// keccak256
/*
    abi 加密方法
    abi.encode(arg);
    abi.encodePacked(arg);

    encode 与 encodePacked 区别
    encode 会对结果进行补 0
    encodePacked 则不会补 0，会有一定几率产生相同的 hash 值
    ("AAAA", "BBB") == ("AAA", "ABBB")
    解决方法：插入一个值在中间
*/

contract HashFunc {
    // 使用 keccak256
    function hash(string calldata name, uint num, address addr) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(name, num, addr));
    }
    
    function encode(string calldata _str01, string calldata _str02) external pure returns (bytes memory) {
        return abi.encode(_str01, _str02);
    }

    function encodePacked(string calldata _str01, string calldata _str02) external pure returns (bytes memory) {
        return abi.encodePacked(_str01, _str02);
    }

    function collision(string calldata _str01, uint x, string calldata _str02) external pure returns (bytes memory) {
        return abi.encodePacked(_str01, x, _str02);
    }
}