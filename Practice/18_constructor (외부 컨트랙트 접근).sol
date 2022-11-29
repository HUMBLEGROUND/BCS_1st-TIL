// SPDX-License-Identifier: GPL-3.0
// 221121

/*
B contract는 특정 주소의 A를 상속
C contract는 새로 생성함

A에는 변수 a,b를 선언하고 따름
B는 따로 변수를 불러오는 함수를 선언하기
*/

pragma solidity >=0.7.0 <0.9.0;

contract A {
    string name;
    uint age;
    address owner;

    constructor(string memory _name, uint _age) { // 초기설정
        name = _name;
        age = _age;
        owner = msg.sender; // owner를 버튼 누르는사람으로 설정
    }

    // 조회기능
    function get() public view returns(string memory, uint) {
        return(name, age);
    }

    // 변경기능 (비공개)
    function set(string memory _name, uint _age) private {
        name = _name;
        age = _age;
    }

    // 변경기능 (검증을 통해)
    function set2(string memory _name, uint _age) public {
        require(msg.sender == owner); // owner 가 맞을경우
        set(name, age); // private 함수를 건들수 있다
    }    
}

contract B {
    A cont_a;
    constructor(address _A) { // A 컨트랙트 주소를 넣음
        cont_a = A(_A);
    }
    function setAB(string memory _name, uint _age) public {
        cont_a.set2(_name, _age); // A 컨트랙트의 set2 를 건드린다
        // 실행은 내가(msg.sender) 하지만 실제로는 컨트랙트 B가 건드린다
    }
}