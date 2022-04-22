// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract TodoList {
    struct Todo {
        string text;
        bool complete;
    }
    Todo[] todo;
    
    // set、get、update、complete
    function set(string calldata text) external {
        todo.push(Todo({ text: text, complete: false }));
    }

    function get(uint index) external view returns (Todo memory) {
        return todo[index];
    }

    function update(uint index, string calldata text) external returns (bool) {
        todo[index].text = text;
        return true;
    }

    function toggleStatus(uint index) external returns (bool) {
        todo[index].complete = !todo[index].complete;
        return true;
    }
}