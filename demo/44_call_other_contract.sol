// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract CallTestContract {
    function setTestX(address _addr, uint _x) external {
        TestContract(_addr).setX(_x);
    }

    function setTestXandSendEther(address _addr, uint _x) external payable {
        TestContract(_addr).setXandSendEther{value: msg.value}(_x);
    }

    function getTestX(address _addr) external view returns (uint) {
        return TestContract(_addr).getX();
    }

    function getTestXandValue(address _addr) external view returns (uint x, uint value) {
        (x, value) = TestContract(_addr).getXandValue();
    }
}

// 修改/获取 x
// 修改/获取 x and value
contract TestContract {
    uint x;
    uint value;

    function setX(uint _x) external {
        x = _x;
    }

    function getX() external view returns (uint) {
        return x;
    }

    function getXandValue() external view returns (uint, uint) {
        return (x, value);
    }

    function setXandSendEther(uint _x) external payable {
        x = _x;
        value += msg.value;
    }
}