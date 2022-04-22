// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./IERC721Metadata.sol";
import "./IERC721Receiver.sol";
import "./lib_address.sol";

contract LuLu is IERC721Metadata {
    using Address for address;

    string private _name;
    string private _symbol;
    string private _baseUrl;

    mapping(address => uint) private _balances;
    mapping(uint => address) private _owners;
    // Mapping from token ID to approved address
    mapping(uint => address) private _tokenApprovals;
    // Mapping from onwer to operater approval
    mapping(address => mapping(address => bool)) _operatorApprovals;

    constructor(string memory baseUrl) {
        _name = "LuLu";
        _symbol = "LL";
        _baseUrl = baseUrl;
    }

    // 进行授权操作 (一个 tokenId 对应一个地址)
    function _approve(address owner, address to, uint256 tokenId) private {
        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    function _isTokenExist(uint tokenId) private view returns (bool) {
        return _owners[tokenId] != address(0);
    }

    function _isZeroAddr(address addr) private pure returns (bool) {
        return addr != address(0);
    }

    function _isApprovedOrOwner(address owner, address spender, uint tokenId) 
        private
        view
        returns (bool)
    {
        return 
            owner == spender ||
            _tokenApprovals[tokenId] == spender ||
            _operatorApprovals[owner][spender];
    }

    function _transfer(address owner, address from, address to, uint tokenId) private {
        // 重置授权记录，这是仅限一个地址仅一个 token 的情况
        _approve(owner, address(0), tokenId);

        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

    // 判断 to 地址是否为合约地址
    // 如果为合约地址，是否符合 IERC721Receiver 的要求
    function _checkOnERC721Received(
        address from,
        address to,
        uint tokenId,
        bytes memory _data
    ) private returns (bool) {
        if (to.isContract()) {
            return 
                IERC721Receiver(to).onERC721Received(
                    msg.sender,
                    from,
                    tokenId,
                    _data
                ) == IERC721Receiver.onERC721Received.selector;
        } else {
            return true;
        }
    }

    function _safeTransfer(
        address owner,
        address from,
        address to,
        uint tokenId,
        bytes memory _data
    ) private {
        _transfer(owner, from, to, tokenId);
        require(_checkOnERC721Received(from, to, tokenId, _data), "not ERC721Receiver");
    }

    // 代币名字
    function name() public view override returns (string memory) {
        return _name;
    }

    // 获取代币简称
    function symbol() public view override returns (string memory) {
        return _symbol;
    }

    // 设置基础 url
    function setBaseUrl(string calldata baseUrl) public {
        _baseUrl = baseUrl;
    }

    // 获取 tokenId 对应的 url
    function tokenURI(uint256 tokenId) external view override returns (string memory) {

    }

    // 获取地址对应的 token 数量
    function balanceOf(address owner) public view override returns (uint256 balance) {
        require(owner != address(0), "owner is zero address");
        balance = _balances[owner];
    }

    // 根据 tokenId 获取对应的拥有者地址
    function ownerOf(uint256 tokenId) public view override returns (address owner) {
        // 判断 tokenId 是否存在
        owner = _owners[tokenId];
        require(owner != address(0), "token doesn't exist");
    }

    // 授权，msg.sender 授权给 to
    function approve(address to, uint256 tokenId) external override {
        // 判断 tokenId 的 owner 是否为 msg.sender
        address owner = _owners[tokenId];
        require(
            owner == msg.sender, 
            "not owner"
        );
        _approve(owner, to, tokenId);
    }

    // 根据 tokenId 获取对应的授权者地址
    function getApproved(uint256 tokenId) external view override returns (address operator) {
        // 判断 tokenId 是否存在
        require(_isTokenExist(tokenId), "token not exist");
        return _tokenApprovals[tokenId];
    }

    // msg.sender的所有代币全部授权给 operator
    // 不能自己授权给自己
    function setApprovalForAll(address operator, bool _approved) external override {
        require(
            msg.sender != operator,
            "can not approval yourself"
        );
        _operatorApprovals[msg.sender][operator] = _approved;
        emit ApprovalForAll(msg.sender, operator, _approved);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public override {
        require(_isZeroAddr(from) || _isZeroAddr(to), "address is error");
        address owner = ownerOf(tokenId);
        require(_isApprovedOrOwner(owner, from, tokenId));
        _safeTransfer(owner, from, to, tokenId, data);
    }

    // 安全转移代币
    function safeTransferFrom(address from, address to, uint256 tokenId) external override {
        safeTransferFrom(from, to, tokenId, "");
    }

    // 转移代币给别人
    function transferFrom(address from, address to, uint256 tokenId) external override {
        // 判断 tokenId owner == from
        require(!_isZeroAddr(from) || !_isZeroAddr(to), "invaild address");

        address owner = _owners[tokenId];
        require(_isApprovedOrOwner(owner, from, tokenId), "not owner or approved");

        _transfer(owner, from, to, tokenId);
    }

    // 支持接口验证
    function supportsInterface(bytes4 interfaceId) external pure override returns (bool) {
        return
            interfaceId == type(IERC721Metadata).interfaceId ||
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC165).interfaceId;
    }

    // 根据拥有者地址，操作放地址。可判断当前是否已全部授权给 operator
    function isApprovedForAll(address owner, address operator) external view returns (bool) {
        return _operatorApprovals[owner][operator];
    }
}