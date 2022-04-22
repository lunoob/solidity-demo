// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// The wallet owners can

// submit a transaction
// approve and revoke approval of pending transcations
// anyone can execute a transcation after enough owners has approved it.

// 合约拥有多个拥有者
// 合约可以接受主币
// 每发起一笔交易，都需要其他拥有者进行确认
// 确认量达到限定值后，即可进行交易

contract MultiSigWallet {
    struct Transaction {
        address to;
        uint value;
        bytes data;
        bool executed;
        uint confirmationNum;
    }

    event SubmitTransaction(
        address owner,
        uint txIndex,
        address to,
        uint value,
        bytes data
    );
    event Deposit(address indexed sender, uint amount, uint balance);
    event ConfirmTransaction(address indexed owner, uint indexed txIndex);
    event RevokeTransaction(address indexed owner, uint indexed txIndex);
    event ExecuteTransaction(address indexed owner, uint indexed txIndex);

    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");
        _;
    }

    // 交易申请存在
    modifier txExist(uint txId) {
        require(txId < transactions.length, "transaction not exist");
        _;
    }

    // 交易申请未被执行
    modifier noExecute(uint txId) {
        require(!transactions[txId].executed, "transaction is executed");
        _;
    }

    address[] owners;
    mapping(address => bool) public isOwner;
    uint minApprovalNum;
    // 交易申请数组
    Transaction[] transactions;
    // 对于交易授权的人数数量映射
    mapping(uint => mapping(address => bool)) isConfirm;

    receive() external payable {}

    // 在合约部署的时候就确定所有的合约拥有者
    // 并且设定一个最小确认量
    constructor(address[] memory _owners, uint _minApprovalNum) {
        // 地址数量需要 > 0
        require(_owners.length > 0, "owners required");
        // 授权数量需要 > 0 && <= 拥有者数量
        require(
            _minApprovalNum > 0 && _minApprovalNum <= _owners.length,
            "invalid number of required _minApprovalNum"
        );

        uint i = 0;
        while (i < _owners.length) {
            address addr = _owners[i];
            // 判断地址是否为 0 地址
            require(addr != address(0), "invalid owner");
            // 地址不可重复
            require(!isOwner[addr], "owner not unique");

            owners.push(addr);
            isOwner[addr] = true;
            i += 1;
        }
        minApprovalNum = _minApprovalNum;
    }

    // 提交申请
    // 只有拥有者才有权限发起申请
    function submitTransaction(address _to, uint _value, bytes memory _data) public onlyOwner {
        // 使用一个数组存储交易申请
        // 使用一个对象存储交易申请信息
        transactions.push(Transaction({
            to: _to,
            value: _value,
            data: _data,
            confirmationNum: 0,
            executed: false
        }));

        // 广播一个事件
        emit SubmitTransaction(
            msg.sender,
            transactions.length - 1,
            _to,
            _value,
            _data
        );
    }

    // 批准申请
    // 合约拥有者
    // 交易存在
    // 交易未被执行
    // 之前未对该交易申请确认过
    function approvalTransaction(uint txId) public onlyOwner txExist(txId) noExecute(txId) {
        require(!isConfirm[txId][msg.sender], "transaction is confirmed");

        Transaction storage transaction = transactions[txId];
        transaction.confirmationNum += 1;
        isConfirm[txId][msg.sender] = true;

        emit ConfirmTransaction(msg.sender, txId);
    }

    // 撤销申请
    function revokeTransaction(uint txId)
        public
        onlyOwner
        txExist(txId)
        noExecute(txId) 
    {
        require(isConfirm[txId][msg.sender], "transaction is not confirmed");

        Transaction storage transaction = transactions[txId];
        transaction.confirmationNum -= 1;
        isConfirm[txId][msg.sender] = false;

        emit RevokeTransaction(msg.sender, txId);
    }

    // 获取交易申请
    function getTransaction(uint txId)
        public
        view
        txExist(txId)
        returns (
            address to,
            uint value,
            bytes memory data,
            bool executed,
            uint numConfirmations
        ) 
    {
        Transaction storage transaction = transactions[txId];
        
        return (
            transaction.to,
            transaction.value,
            transaction.data,
            transaction.executed,
            transaction.confirmationNum
        );
    }

    // 执行交易申请
    function executeTransaction(uint txId)
        public
        onlyOwner
        txExist(txId)
        noExecute(txId)
    {
        Transaction storage transaction = transactions[txId];

        require(transaction.confirmationNum >= minApprovalNum, "cannot execute transaction");

        transaction.executed = true;

        (bool success,) = transaction.to.call{value: transaction.value}(
            transaction.data
        );
        require(success, "execute transaction fail");

        emit ExecuteTransaction(msg.sender, txId);
    }

    // 获取交易数量
    function getTransactionCount() public view returns (uint) {
        return transactions.length;
    }

    // 获取 owners
    function getOwners() public view returns (address[] memory) {
        return owners;
    }
}

// 什么时候需要使用事件
// 提交交易申请
// 批准交易申请
// 撤销交易申请
// 执行交易申请