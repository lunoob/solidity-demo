// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// fallback function
// 不允许传入参数、也不允许返回任何东西
// 调用合约不存在的方法时会触发 fallback function
// 给合约转账并且没有携带 data 时会触发 fallback function

// fallback 可能是无意间被触发的，因为 fallback function 内最好减少 gas 的消耗
// 尽量少于 2300 gas
// 以下行为可能会大于 2300 gas，在 fallback 中尽量不要使用
// Modify storage
// Create a Contract
// Call an external function
// Send ether

// Contract 如果没有定义 fallback function，在收到 ether 时，将触发 exception 并且退回 ether
// 如果 Contract 想收 ether 必须定义 fallback function
// 并且需要加上 payable modifier 来宣告该 function 可以收取 ether

contract FallbackExample {
    event LogFallback(string message);
    event LogBalance(uint256 balance);

    function Fallback() public {
        emit LogFallback("Fallback");
        emit LogBalance(address(this).balance);
    }
}
