// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Event {
    event Log(string message);
}

// 调用父级合约方法
contract A is Event {
    function ar() public {
        emit Log("from A");
    }
}

contract B is Event {
    function br() public {
        emit Log("from B");
    }
}

contract C is A, B {

    function callA() external {
        A.ar();
    }

    function callB() external {
        B.br();
    }

    function superA() external {
        super.ar();
    }

    function superB() external {
        super.br();
    }

}