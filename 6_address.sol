// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// address 代表一个以太坊地址
// 由 20 bytes 组成
// 1 Ether = 10^18 Wei
// Wei 是 Ethereum 中的最小单位

// address.send(uint256 amount)
// 对 address 送出 amount Wei
// 本 function 会 forward 2300 gas 作为调用的 gas
// 因为 send 将会触发 address 中的 fallback function
// 当执行失败，返回 false, 否则返回 true

// address.transfer(uint256 amount)
// 对 address 送出 amount Wei.
// 本 function 会 forward 2300 gas 作为调用的 gas
// 因为 send 将会触发 address 中的 fallback function
// 当执行失败，将 throw exception

// transfer vs send
// transfer 保证了转义 ether 的正确性，因为失败的时候会让整个 transation 收到 throw 而终止
// send 在执行失败只会返回 false，因此在使用 send 时，应该每次都检查它的返回结果
// 可以搭配 require

contract AddressExample {
    // 用来接收 ether
    receive() external payable {}

    function Send() public {}

    function Balance() public view returns (uint256) {
        return address(this).balance;
    }

    function Transfer(uint256 amount) public returns (bool) {
        payable(msg.sender).transfer(amount * 1 ether);
        return true;
    }

    function SendWithoutCheck(uint256 amount) public returns (bool) {
        payable(msg.sender).send(amount * 1 ether);
        return true;
    }

    function SendWithCheck(uint256 amount) public returns (bool) {
        require(payable(msg.sender).send(amount * 1 ether), "send failed");
        return true;
    }
}
