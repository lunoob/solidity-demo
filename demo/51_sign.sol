
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/* Signature Verification

How to Sign and Verify
# Signing
1. Create message to sign
2. Hash the message
3. Sign the hash (off chain, keep your private key secret)

# Verify
1. Recreate hash from the original message
2. Recover signer from signature and hash
3. Compare recovered signer to claimed signer
*/

contract VerifySignature {
    // 获取消息签名 hash the message
    function getMessageHash(string memory message) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(message));
    }

    function getEthSignedMessageHash(bytes32 _messageHash) public pure returns (bytes32) {
        return keccak256(
            abi.encodePacked("\x19Ethereum Signed Message:\n32", _messageHash)
        );
    }

    function splitSignature(bytes memory _signature) public pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(_signature.length == 65, "invalid signature length");

        // 使用内联汇编
        assembly {
            // first 32 bytes, after the length prefix
            r := mload(add(_signature, 32))
            // second 32 bytes
            s := mload(add(_signature, 64))
            // final byte (first byte of the next 32 bytes)
            v := byte(0, mload(add(_signature, 96)))
        }
    }

    // 还原地址
    function recover(bytes32 _ethSignedMessageHash, bytes memory _signature) public pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);

        // solidity 内置方法: ecrecover
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function verify(address _signer, string memory _message, bytes memory _sig) external pure returns (bool) {
        // 先对消息进行签名
        bytes32 messageHash = getMessageHash(_message);
        // 增加一个 nonce, 对消息进行二次签名
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        // 进行地址还原
        // 对比地址是否一致
        return recover(ethSignedMessageHash, _sig) == _signer;
    }
}

// 0xfa26db7ca85ead399216e7c6316bc50ed24393c3122b582735e7f3b0f91b93f0
// 0x7612859d07A6713f0aaf9Ba1e877FE30Dc2c500E
// 0x2c5cab10a4c113445720ee3fc862d741e0e275f5862013d0c933e1bf474eefa802f15f1231c5a7612495a766f34fc41b64005506523f14f7f212b8c6644f4def1b