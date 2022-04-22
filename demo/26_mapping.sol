// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Mapping {

    mapping(address => uint) public myMap;

    function get(address _addr) public view returns (uint) {
        return myMap[_addr];
    }

    function set(address _addr, uint val) public {
        myMap[_addr] = val;
    }

    function remove(address _addr) public {
        delete myMap[_addr];
    }
}

contract NestedMapping {
    mapping(address => mapping(uint => bool)) public nested;

    function get(address _addr, uint idx) public view returns (bool) {
        return nested[_addr][idx];
    }

    function set(address _addr, uint idx, bool val) public {
        nested[_addr][idx] = val;
    }

    function remove(address _addr, uint idx) public {
        delete nested[_addr][idx];
    }
}