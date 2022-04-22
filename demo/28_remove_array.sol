// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ArrayRemoveByShifting {
    // init a dynamic array
    uint[] public arr = [1, 2, 3];

    // [1, 2, 3] -- remove(1) --> [1, 3, 3] --> [1, 3]
    // [1, 2, 3, 4, 5, 6] -- remove(2) --> [1, 2, 4, 5, 6, 6] --> [1, 2, 4, 5, 6]
    // [1, 2, 3, 4, 5, 6] -- remove(0) --> [2, 3, 4, 5, 6, 6] --> [2, 3, 4, 5, 6]
    // [1] -- remove(0) --> [1] --> []

    // 这种方式比较耗费 gas
    // 这种方式可以确保顺序不会错乱
    function remove(uint idx) public {
        uint len = arr.length;
        require(idx < len, "index out of bound");
        uint i = idx;
        for (; i < len; i++) {
            arr[i] = arr[i+1];
        }

        arr.pop();
    }
}

contract ArrayReplaceFromEnd {
    uint[] public arr;

    // 这种方式可以节省 gas
    // 但会打乱列表的顺序
    function remove(uint idx) public {
        arr[idx] = arr[arr.length - 1];
        arr.pop();
    }

    function test() public {
        arr = [1, 2, 3, 4];

        remove(1);
        // [1, 4, 3]
        assert(arr.length == 3);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);

        remove(2);
        assert(arr.length == 2);
        assert(arr[0] == 1);
        assert(arr[0] == 4);
    }
}