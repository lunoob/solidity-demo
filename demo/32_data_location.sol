// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// calldata 只能存在输入参数中
// 使用 calldata 可以节约 gas 费用
// 内存引用传递的时候，使用 calldata 比 memory 会好

contract DataLocations {
    string name;
    struct MyStruct {
        uint foo;
        string text;
    }
    mapping(address => MyStruct) myStruct;

    function example() external returns (MyStruct memory) {
        myStruct[msg.sender] = MyStruct({ foo: 123, text: "luoob" });

        MyStruct memory myS = myStruct[msg.sender];

        return myS;
    }

    // 测试返回 memory 位置变量
    function testBackMemory(uint[] calldata arr) external pure returns (uint[] memory) {
        return arr;
    }

    // 测试返回 calldata 位置变量
    function testBackCallData(uint[] calldata arr) external pure returns (uint[] calldata) {
        return arr;
    }

    // 测试传输 memory
    function transferMemory(uint[] calldata arr) external pure returns (uint result) {
        result = _memoryGetHead(arr);
    }

    function _memoryGetHead(uint[] memory arr) internal pure returns (uint) {
        return arr[0];
    }

    // 测试传输 calldata
    function transferCallData(uint[] calldata arr) external pure returns (uint result) {
        result = _memoryGetHead(arr);
    }

    function _callDataGetHead(uint[] calldata arr) internal pure returns (uint) {
        return arr[0];
    }

    function getName() external view returns(string memory) {
        return name;
    }
}