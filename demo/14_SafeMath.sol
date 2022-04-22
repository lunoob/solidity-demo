// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 这里需要使用 npm 进行本地安装 library 才会生效
// import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Main {
    uint256 public count = 0;

    function add(uint256 value) public returns (uint256) {
        count = SafeMath.add(count, value);
        return count;
    }
}
