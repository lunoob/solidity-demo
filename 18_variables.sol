// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Variables {
    // State variables are stored on the blockchain.
    string public text = "Hello";
    uint public num = 123;

    function doSomething() public view returns (uint i, uint timestamp, address sender) {
        // Local variables are not saved to the blockchain.
        i = 456;

        // Here are some global variables
        timestamp = block.timestamp;           // Current block timestamp
        sender = msg.sender;                // address of the caller
    }
}
