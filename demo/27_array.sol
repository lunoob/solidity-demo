// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Array {
    uint[] public arr;
    uint[] public arr2 = [1, 2, 3];
    uint[10] public myFixedSizeArr;

    function get(uint i) public view returns (uint) {
        return arr[i];
    }

    function getArrFromMemory() public view returns(uint[] memory) {
        return arr;
    }

    function push(uint i) public {
        arr.push(i);
    }

    function pop() public {
        arr.pop();
    }

    function getLength() public view returns (uint) {
        return arr.length;
    }

    function remove(uint idx) public {
        delete arr[idx];
    }

    function push2(uint j) public {
        arr2.push(j);
    }

    function getLength2() public view returns (uint) {
        return arr2.length;
    }

    function example() public pure returns (uint[] memory) {
        uint[] memory innerArr;
        innerArr[0] = 1;
        innerArr[1] = 2;

        return innerArr;
    }
}