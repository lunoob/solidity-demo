// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// private      仅仅当前合约内可访问
// public       相当于开放式访问
// internal     在合约内部可以自由访问，包括继承，但不暴露给外部调用
// external     部署后有交互访问，但合约内部不能去调用它

contract OpenNature {
    function hello() internal pure returns (string memory) {
        return "hello";
    }

    function helloMsg() public pure returns (string memory) {
        hello();
        return "solidity";
    }
}

contract Main is OpenNature {
    function say() public pure returns (string memory) {
        hello();
        return "say function";
    }
}
