// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

contract Simple {

  uint256 count = 0;

  function add(uint256 number) public {
    count += number;
  }

  function queryCount() public view returns (uint256) {
    return count;
  }
}