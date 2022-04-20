// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract A {
    event Log(string message);

    function foo() public virtual {
        emit Log("A.foo");
    }

    function baz() public virtual {
        emit Log("A.baz");
    }
}

contract B is A {
    function foo() public virtual override {
        emit Log("B.foo");
        super.foo();
    }

    function baz() public virtual override {
        emit Log("B.baz");
        super.baz();
    }
}

contract C is A {
    function foo() public virtual override {
        emit Log("C.foo");
        super.foo();
    }

    function baz() public virtual override {
        emit Log("C.baz");
        super.baz();
    }
}

contract D is B, C {
    function foo() public override(B, C) {
        emit Log("D.foo");
        super.foo();
    }

    function baz() public override(B, C) {
        emit Log("D.baz");
        super.baz();
    }
}