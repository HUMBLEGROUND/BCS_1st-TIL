// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Con3_3 {
    uint number;

    constructor(uint _a) {
        number = _a; // 배포할때 숫자를 입력할수 있음
    }

    function setNumber(uint _a) public {
        number = _a; // 배포할때 입력한 숫자를 변경
    }

    function getNumber() public view returns(uint) {
        return number; // 변경되는 숫자를 조회
    }
}

contract Con3_3_2 { // Con3_3 이랑 같은코드임
    uint number;

    constructor(uint _a) {
        number = _a;
    }

    function setA(uint _a) public {
        number = _a;
    }

    function getA() public view returns(uint) {
        return number;
    }
}

contract Con3_4_2 is Con3_3_2(2) {
    function getNumber2() public view returns(uint) {
        return number;
    }
}

contract Con3_4 is Con3_3(2) { // Con3_3 컨트랙트에 default 값으로 2를 입력해서 배포
    function getNumber2() public view returns(uint) {
        return number; // 2가 조회됨
    }

    // Con3_3 컨트랙트에 함수들을 그대로 사용할수도 있음
    // Con3_3 컨트랙트자체에서 setNumber 함수로 값을 4로 바꿔도 
    
    // Con3_4 컨트랙트에서는 2가 조회됨
    // Con3_4 컨트랙트 내에 상속받아온 setNumber 함수로 값을 5로 바꾸면
    // 5로 조회됨
}