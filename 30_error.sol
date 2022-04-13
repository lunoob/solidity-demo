// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// revert
// require
// assert
// custom error
contract Error {
    uint count;

    error myError(string message);

    function testRequire(uint value) public view returns (bool) {
        require(count <= value, "count too large");
        return true;
    }

    function testAssert(uint value) public view returns (bool) {
        assert(count <= value);
        return true;
    }

    function testRevert(uint value) public view returns (bool) {
        if (count <= value) {
            revert("count too large");
        }
        return true;
    }

    function testCustomError(uint value) public view returns (bool) {
        if (count <= value) {
            revert myError("count too large");
        }
        return true;
    }

    function setCount(uint val) public {
        count = val;
    }
}