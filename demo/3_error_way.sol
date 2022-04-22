// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// revert();                会返还剩余的 gas，同时中断代码执行，状态会回滚
// require(condition);      会返还剩余的 gas，同时中断代码执行，状态会回滚
// assert(condition);       不会返还剩余的 gas，同时中断代码执行，状态会回滚
// https://blog.csdn.net/tianlongtc/article/details/80261757
contract ErrorWay {
    bool isValid;

    constructor() {
        isValid = true;
    }

    function useRevert() public returns (uint8) {
        isValid = false;
        revert("not the contract owner");
    }

    function useRequire() public returns (uint8) {
        isValid = false;
        require(false, "not the contract owner");
        return 0;
    }

    function useAssert() public returns (uint8) {
        isValid = false;
        assert(false);
        return 0;
    }
}
