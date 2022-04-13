// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Class {
    struct Student {
        string name;
        uint256 score;
        bool active;
    }
    mapping(uint256 => Student) students;

    modifier ActiveStudent(uint256 id) {
        require(students[id].active, "Student is inactive");
        _;
    }

    function register(uint256 id, string memory name) public {
        students[id] = Student(name, 0, false);
    }

    function modifyScore(uint256 id, uint256 score) public ActiveStudent(id) {
        students[id].score = score;
    }

    function getStudent(uint256 id)
        public
        view
        ActiveStudent(id)
        returns (string memory, uint256)
    {
        return (students[id].name, students[id].score);
    }

    function queryStudent(uint256 id) public view returns (Student memory) {
        // 当查询一个不存在的数据时，
        // 它会默认生成一个默认值并返回
        // 这里返回 { name: '', score: 0, active: false }
        return students[id];
    }
}
