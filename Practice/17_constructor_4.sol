// SPDX-License-Identifier: GPL-3.0
// 20221118

pragma solidity 0.8.0;

/*
B contract는 특정 주소의 A를 상속
C contract는 새로 생성함

A에는 변수 a,b를 선언하고 따름
B는 따로 변수를 불러오는 함수를 선언하기
*/

contract A {
    uint a;
    uint b;

    constructor(uint _a, uint _b) {
        a = _a;
        b = _b;
    }

    function getAB() public view returns(uint, uint) {
        return (a,b);
    }

    function setAB(uint _a, uint _b) public {
        a = _a;
        b = _b;
    }
}

contract B {
    A c; // contract A를 변수 c 로 설정함
    constructor(address _A) { // contract A 의 컨트랙트 주소값을 입력해서 배포
        c = A(_A); // 
    }

    function get() public view returns(uint, uint) { // contract A 의 a, b 값을 그대로 가져옴
        return c.getAB(); 
        // contract A 에서 a, b 값을 변경하면 똑같이 변경됨
    }
}

contract C {
    A c = new A(3,5); // contract A를 변수 c 로 설정하고 3, 5 로 배포

    function getAB2() public view returns(uint, uint) {
        return c.getAB(); // 3, 5 를 반환함
    } // setAB2 함수를 실행하고 다시 조회하면 2, 4를 반환함

    function setAB2() public {
        c.setAB(2,4); // 2, 4를 자동입력하여 실행
    }
}