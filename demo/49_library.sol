// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

library Math {
    function max(uint x, uint y) internal pure returns (uint) {
        return x > y ? x : y;
    }
}

contract Test {
    function getMax(uint _x, uint _y) public pure returns (uint) {
        return Math.max(_x, _y);
    }
}

library Arraylib {
    function findIndex(uint[] storage arr, uint value) internal view returns (uint) {
        uint i = 0;
        while (i < arr.length) {
            if (arr[i] == value) {
                return i;
            }
            i += 1;
        }

        revert("not found index");
    }
}

contract ArrayTest {
    uint[] arr = [1, 2, 3];
    // use using for
    using Arraylib for uint[];

    function testFind(uint _value) public view returns (uint) {
        // return Arraylib.findIndex(arr, _value);
        return arr.findIndex(_value);
    }
}