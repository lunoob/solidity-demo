// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// It is executed either when
// - a function that does not exist is called or
// - Ether is sent directly to a contract but receive() does not exist or msg.data is not empty

// 回退函数 (fallback)
/*
    Which function is called, fallback() or receive()?

           send Ether
               |
         msg.data is empty?
              / \
            yes  no
            /     \
receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
*/

contract FallBack {
    event Log(string func, address sender, uint value, bytes data);

    fallback() external {
        emit Log('fallback', msg.sender, 0, msg.data);
    }

    receive() external payable {
        emit Log("receive", msg.sender, msg.value, "");
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
