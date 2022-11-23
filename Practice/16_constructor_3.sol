// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Con4 {
    string public name;
    uint public age;

    constructor(string memory _name, uint _age) {
        name = _name;
        age = _age;
    }

    function get() public view returns(string memory, uint) {
        return (name, age);
    }

    function set(string memory _name, uint _age) public {
        name = _name;
        age = _age;
    }
}

contract Con5 {
    Con4 c = new Con4("a", 2); // Con4 컨트랙트를 c 로 선언 / a, 2 를 대입
		
    Con4 c2 = Con4(0x1c91347f2A44538ce62453BEBd9Aa907C662b4bD);
    // Con4 배포하고 나온 주소를 하드코딩함

    function get() public view returns(string memory, uint) {
        return (c.name(), c.age()); // a, 2 를 반환
    }

    function get2() public view returns(string memory, uint) {
        return(c2.name(), c2.age()); // Con4 컨트랙트의 name, age 값을 반환
    }
}