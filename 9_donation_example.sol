// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Donation {
    struct DonorInfo {
        address[] donors;
        mapping(address => uint256) ledger;
    }
    mapping(address => DonorInfo) DonorHistory;

    event LogDonate(
        address streamer,
        address donor,
        string nickname,
        string message
    );
    event LogDonateInfo(address steamer, address user, uint256 value);

    /*
     * donate action
     * @param {address} _streamer
     * @param {string memory} _nickname
     * @param {string memory} _message
     * @returns {void}
     */
    function donate(
        address _streamer,
        string memory _nickname,
        string memory _message
    ) public payable {
        require(msg.value > 0, "donate amount must be more than zero");
        payable(_streamer).transfer(msg.value);
        if (DonorHistory[_streamer].ledger[msg.sender] == 0) {
            DonorHistory[_streamer].donors.push(msg.sender);
        }
        DonorHistory[_streamer].ledger[msg.sender] += msg.value;
        // 传输一些数据出去
        emit LogDonate(_streamer, msg.sender, _nickname, _message);
    }

    /*
     * list the donor info list according to msg.sender
     * @returns {any}
     */
    function listDonorInfo() public {
        for (uint256 i = 0; i < DonorHistory[msg.sender].donors.length; i++) {
            address user = DonorHistory[msg.sender].donors[i];
            emit LogDonateInfo(
                msg.sender,
                user,
                DonorHistory[msg.sender].ledger[user]
            );
        }
    }

    /*
     * get donors according to msg.sender
     * @returns {any}
     */
    function getDonors() public view returns (address[] memory) {
        return DonorHistory[msg.sender].donors;
    }
}
