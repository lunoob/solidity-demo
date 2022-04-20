// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Event {
    event Log(string message);
    event IndexLog(address indexed addr, string message);

    function storageMessage(string calldata message) external {
        emit Log(message);
    }

    function storageIndexMessage(string calldata message) external {
        emit IndexLog(msg.sender, message);
    }
}