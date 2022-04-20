// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// 运行父级合约构造函数
contract A {
    string public name;
    constructor(string memory _name) {
        name = _name;
    }
}

contract B {
    string public str;
    constructor(string memory _str) {
        str = _str;
    }
}

contract C is A("hello"), B("world") {
}

contract D is A, B("world") {
    constructor(string memory _name) A(_name) {}
}

// 执行顺序
// A -> B -> E
contract E is A, B {
    constructor(string memory _name, string memory _str) A(_name) B(_str) {}
}