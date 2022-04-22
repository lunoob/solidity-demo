// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract EventLog {
    string information;
    uint256 balance;

    // event identifier 会被 Keccak-256 加密
    // 占用 logs 中的 topics 首位
    event LogCreate(string information, uint256 balance);
    event LogCreateIndex(string indexed information, uint256 indexed balance);

    constructor() {
        information = "default";
        balance = 100;
        // 此处有一个 topic, 因为 event name 会被
        emit LogCreate(information, balance);
        emit LogCreateIndex(information, balance);
    }
}
