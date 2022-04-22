// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// bytes32 比 string 消耗的 gas 要小的多
// private 比 public 变量更节约 gas 费用

contract AccessControl {
    // 0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    // 0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));
    mapping(bytes32 => mapping(address => bool)) public roles;

    event GrantRole(bytes32 role, address _addr);
    event RevokeRole(bytes32 role, address _addr);

    modifier onlyAdmin(bytes32 role) {
        require(roles[role][msg.sender], "not permission");
        _;
    }

    constructor() {
        // 对合约创建者分配管理员角色
        _grantRole(ADMIN, msg.sender);
    }

    // 内部授予权限
    function _grantRole(bytes32 _role, address _addr) internal {
        roles[_role][_addr] = true;
        // 广播授权事件
        emit GrantRole(_role, _addr);
    }

    // 外部授予权限, 只有管理员有权限
    function grantRole(bytes32 _role, address _addr) external onlyAdmin(ADMIN) {
        roles[_role][_addr] = true;
        // 广播授权事件
        emit GrantRole(_role, _addr);
    }

    // 外部撤销权限，只有管理员有权限
    function revokeRole(bytes32 _role, address _addr) external onlyAdmin(ADMIN) {
        roles[_role][_addr] = false;
        // 广播授权事件
        emit RevokeRole(_role, _addr);
    }
}