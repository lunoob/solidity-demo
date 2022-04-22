// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// 低级 call 调用其他合约方法
contract Caller {
    bytes public data;

    function callFoo(address _addr) external payable {
        (bool success, bytes memory _data) = _addr.call{value: msg.value}(
            // 需要保证函数名字参数这块不能有多余的空格
            abi.encodeWithSignature(
                "foo(string,uint256)", "call foo", 123
            )
        );
        require(success, "call foo failed");
        data = _data;
    }

    function callNotExist(address _addr) external payable {
        (bool success, ) = _addr.call{value: msg.value}(
            abi.encodeWithSignature("notExist")
        );
        require(success, "call not exist fn failed");
    }
}

contract Test {
    string public message;
    uint public x;

    event Log(string message);

    // fallback
    fallback() external payable {
        emit Log("fallback was called");
    }

    function foo(string memory _message, uint _x) public returns (bool, uint) {
        message = _message;
        x = _x;
        return (true, 999);
    }
}