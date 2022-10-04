// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/* 학생이라는 구조체에 이름, 생일, 번호를 선언하고 배열을 만들어
학생의 인적사항 (이름, 생일, 번호)를 입력하는 함수를 만들고
몇명의 학생이 등록되었는지 조회하는 함수를 구현하고
학생번호를 입력하면 생일을 조회할수 있는 함수를 구현하세요 */


contract AAA {
		//같은 자료형만 허용하는 배열과 다르게 서로 다른 자료형을 포함시킬 수 있음
    struct student { //student라는 구조체에 
        string name; //string형 name, uint형 birthday와 number가 포함
        uint birthday;
        uint number;
    }
		//student형 자료들이 들어가는 배열 Students
    student[] Students;

    function pushStudent(string memory _name, uint _birthday, uint _number) public {
        Students.push(student(_name, _birthday, _number));
				//배열명.push(구조체명(구조체내 요소들))
    }

    function getLength() public view returns(uint) {
        return Students.length;
    }

    function getStudent(uint a) public view returns(uint) {
        return Students[a-1].birthday; //a-1번 구조체의 birthday
		}
}