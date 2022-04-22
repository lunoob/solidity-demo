// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract Donation {
    mapping(address => uint256) public ledger;
    mapping(address => bool) public donors;
    address[] public donorList;

    // adjust whether is donor
    function isDonors(address pAddr) internal view returns (bool) {
        return donors[pAddr];
    }

    function donate() public payable {
        if (msg.value >= 1 ether) {
            if (!isDonors(msg.sender)) {
                donors[msg.sender] = true;
                donorList.push(msg.sender);
            }

            ledger[msg.sender] += msg.value;
        } else {
            revert("sorry, your donate amount is less than 1 ether");
        }
    }
}
