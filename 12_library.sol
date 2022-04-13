// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// library 没有 state variable
// 不能继承他人，也不能被继承
// 无法接收 ether
library Set {
    struct store {
        mapping(uint256 => bool) data;
    }

    function Insert(store storage d, uint256 key) public returns (bool) {
        if (d.data[key]) {
            return false;
        }
        d.data[key] = true;
        return true;
    }

    function Remove(store storage d, uint256 key) public returns (bool) {
        if (!d.data[key]) {
            return false;
        }
        d.data[key] = false;
        return true;
    }

    function Contain(store storage d, uint256 key) public view returns (bool) {
        return d.data[key];
    }
}

// contract Main {
//     Set.store data;

//     function Insert(uint256 key) public returns (bool) {
//         return Set.Insert(data, key);
//     }

//     function Remove(uint256 key) public returns (bool) {
//         return Set.Remove(data, key);
//     }

//     function Contain(uint256 key) public view returns (bool) {
//         return Set.Contain(data, key);
//     }
// }
