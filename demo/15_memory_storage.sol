// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Main {
    string public message = "hello";

    function setMsg(string calldata str) public pure returns (string memory) {
        string memory amsg = str;
        return amsg;
        // string memory mmsg = str;
        // return mmsg;
    }
}

// memory 代表存储在内存中，运行完后即释放
// storage 代表存储在区块链上，一般状态变量使用
// calldata 和 memory 大致一样，但它是只读的
// constant 只能修饰状态变量