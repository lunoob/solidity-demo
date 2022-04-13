// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Enum {

    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }

    Status public stat;

    function getStatus() public view returns (Status) {
        return stat;
    }

    function set(Status _stat) public {
        stat = _stat;
    }

    function cancel() public {
        stat = Status.Canceled;
    }

    function reset() public {
        // 恢复成默认值
        delete stat;
    }
}