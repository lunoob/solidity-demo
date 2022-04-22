// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface ICounter {
    function count() external view returns (uint);
    function dec() external;
    function inc() external;
}

contract CallInterface {
    uint public count;

    function dec(address _addr) public {
        ICounter(_addr).dec();
        count = ICounter(_addr).count();
    }

    function inc(address _addr) public {
        ICounter(_addr).inc();
        count = ICounter(_addr).count();
    }
}