// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/*
    public
        - any contract and account can call
        - 公开，内部外部都可以访问
    private 
        - only inside the contract that defines the function
        - 只有本合约内部可以访问, 子合约也不可访问
    internal 
        - only inside contract that inherits an internal function
        - 只有内部才能访问, 类似 protected, 子合约也可以访问
    external 
        - only other contracts and accounts can call
        - 只有外部合约或者用户交互才能访问的到
        - 本合约无法访问（通过 this.xx 可以访问，但会消耗较多的 gas）
*/

contract VisibleBase {
    uint public x = 1;
    uint private y = 2;
    uint internal n = 3;

    function getY() public view returns (uint) {
        return y;
    }

    function getN() external view returns (uint) {
        return n;
    }

    function getInner() private pure returns (string memory) {
        return "hello world";
    }

    function useExternalFunction() external view returns (uint) {
        return this.getN();
    }
}

contract VisibleChild is VisibleBase {
    function test() public view returns (uint) {
        string memory str = VisibleBase.getInner();
        return x + n;
    }
}