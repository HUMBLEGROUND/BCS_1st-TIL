// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract A {
    address owner; 

    constructor() {
        owner = msg.sender;
    }

    function setOwner() public {
        owner = msg.sender; // 버튼을 누르는 사람이 owner가 됨
    }

    function getOwner() public view returns(address) {
        return owner; // owner 조회
    }
}

contract B {
    uint a;

    constructor(uint _a) {
        a = _a; // 숫자 아무거나 입력
    }

    function geta() public view returns(uint) {
        return a; // 그대로 받아옴
    }
}

contract C_1 {
    uint a;
    constructor() {
        a = 70; // a 를 70으로 고정
    }

    function AA(uint _a) public view returns(uint) {
        if(_a > a) { // 입력하는 값이 70보다 크면 1 반환
            return 1;
        } else {
            return 2; // 아니면 2 반환
        }
    }
}

contract C_2 {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    uint a;

    function setA(uint _a) public {
        require(owner == msg.sender); // owner가 일치하면 실행
        a = _a;
    }

    function getA() public view returns(uint) {
        return a;
    }
}

