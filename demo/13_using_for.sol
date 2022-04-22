// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./12_library.sol";

contract Main {
    // 将 Set 的方法赋予在 Set.store 这个 type 身上
    using Set for Set.store;

    Set.store mySet;

    function insert(uint256 key) public returns (bool) {
        return mySet.Insert(key);
    }

    function remove(uint256 key) public returns (bool) {
        return mySet.Remove(key);
    }

    function contain(uint256 key) public view returns (bool) {
        return mySet.Contain(key);
    }
}
