// https://eips.ethereum.org/EIPS/eip-20
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IERC20 {
    /// @param _owner The address from which the balance will be retrieved
    /// @return balance the balance
    function balanceOf(address _owner) external view returns (uint256 balance);

    /// @notice send `_value` token to `_to` from `msg.sender`
    /// @param _to The address of the recipient
    /// @param _value The amount of token to be transferred
    /// @return success Whether the transfer was successful or not
    function transfer(address _to, uint256 _value) external returns (bool success);

    /// @notice send `_value` token to `_to` from `_from` on the condition it is approved by `_from`
    /// @param _from The address of the sender
    /// @param _to The address of the recipient
    /// @param _value The amount of token to be transferred
    /// @return success Whether the transfer was successful or not
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);

    /// @notice `msg.sender` approves `_addr` to spend `_value` tokens
    /// @param _spender The address of the account able to transfer the tokens
    /// @param _value The amount of wei to be approved for transfer
    /// @return success Whether the approval was successful or not
    function approve(address _spender  , uint256 _value) external returns (bool success);

    /// @param _owner The address of the account owning tokens
    /// @param _spender The address of the account able to transfer the tokens
    /// @return remaining Amount of remaining tokens allowed to spent
    function allowance(address _owner, address _spender) external view returns (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract ERC20T is IERC20 {
    uint256 constant private MAX_UINT256 = 2**256 - 1;
    string public name = "Solidity by Example";
    string public symbol = "SOLBYEX";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    // 记录账户余额的 balanceof
    mapping(address => uint) public balanceOf;
    // 授权账本
    mapping(address => mapping(address => uint)) public allowance;

    constructor(uint _initalAmount) {
        balanceOf[msg.sender] = _initalAmount;
        totalSupply = _initalAmount;
    }

    // msg.sender 向 to 进行转账
    // 转账数量：_value
    function transfer(address _to, uint256 _value) external returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "token balance is lower than then value requested");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        success = true;
    }

    // 与 approve 相关
    // msg.sender 使用被代理的钱转向 _to
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success) {
        uint allowaValue = allowance[_from][msg.sender];
        // _from 需要拥有过的 token && 授权了那么多 token
        require(balanceOf[_from] >= _value && allowaValue >= _value, "token balance or allowance is lower than value requested");

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        if (allowaValue < MAX_UINT256) {
            // 对授权账本进行修改
            allowance[_from][msg.sender] -= _value;            
        }

        emit Transfer(msg.sender, _to, _value);
        success = true;
    }

    // msg.sender 授权 _value 数量的 token 给 _spender
    function approve(address _spender, uint256 _value) external returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "token balance is lower than value");
        require(_value < MAX_UINT256, "can not approve so much token");

        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        success = true;
    }
}

contract Standard_Token is IERC20 {
    uint256 constant private MAX_UINT256 = 2**256 - 1;
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;
    uint256 public totalSupply;
    /*
    NOTE:
    The following variables are OPTIONAL vanities. One does not have to include them.
    They allow one to customise the token contract & in no way influences the core functionality.
    Some wallets/interfaces might not even bother to look at this information.
    */
    string public name;                   //fancy name: eg Simon Bucks
    uint8 public decimals;                //How many decimals to show.
    string public symbol;                 //An identifier: eg SBX

    constructor(uint256 _initialAmount, string memory _tokenName, uint8 _decimalUnits, string  memory _tokenSymbol) {
        balanceOf[msg.sender] = _initialAmount;               // Give the creator all initial tokens
        totalSupply = _initialAmount;                        // Update total supply
        name = _tokenName;                                   // Set the name for display purposes
        decimals = _decimalUnits;                            // Amount of decimals for display purposes
        symbol = _tokenSymbol;                               // Set the symbol for display purposes
    }

    function transfer(address _to, uint256 _value) public override returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "token balance is lower than the value requested");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value); //solhint-disable-line indent, no-unused-vars
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool success) {
        uint256 allow = allowance[_from][msg.sender];
        require(balanceOf[_from] >= _value && allow >= _value, "token balance or allowance is lower than amount requested");
        balanceOf[_to] += _value;
        balanceOf[_from] -= _value;
        if (allow < MAX_UINT256) {
            allowance[_from][msg.sender] -= _value;
        }
        emit Transfer(_from, _to, _value); //solhint-disable-line indent, no-unused-vars
        return true;
    }

    // function balanceOf(address _owner) public override view returns (uint256 balance) {
    //     return balances[_owner];
    // }

    function approve(address _spender, uint256 _value) public override returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value); //solhint-disable-line indent, no-unused-vars
        return true;
    }

    // function allowance(address _owner, address _spender) public override view returns (uint256 remaining) {
    //     return allowed[_owner][_spender];
    // }
}