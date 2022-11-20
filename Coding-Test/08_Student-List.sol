// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*
A - Alice, 1, 1990, 95
B - Bob, 2, 1995, 85
C - Charlie, 3, 1997, 75
D- Dickson, 4, 1999, 65
E - Eric, 5, 2002, 55
*/

/*
1번 지갑은 선생님입니다. 2,3,4,5,6,7,8,9,10번은 학생입니다.
이름, 번호, 생일, 점수 그리고 학점을 포함한 
학생이라는 구조체를 생성하고 학생을 추가하고 삭제하고 조회하는 기능을 추가하세요.

학점은 90점 이상이면 A, 90점 미만 80점 이상이면 B, 
80점 미만 70점 이상이면 C, 70점 미만 60점 이상이면 D 그 이외는 F 입니다.

학생 추가 기능 - 이 기능은 누구나 사용할 수 있습니다만 = 보통 학생들이 직접 사용할 예정입니다. 
                학생들이 본인의 정보를 추가할 때 자신의 지갑주소와 mapping이 될 수 있게 해주세요. 
                (값은 임의대로 넣으세요)

학생 삭제 기능 - 이 기능은 특정 주소의 지갑소유자(선생님)만이 실행할 수 있습니다. 
                삭제할 때는 학생의 지갑주소를 기반으로 삭제합니다.

학생 조회 기능 - 이 기능은 누구나 사용할 수 있습니다. 
                조회할 때는 학생의 지갑 주소를 기반으로 조회합니다. 
                조회는 이름, 번호, 생일, 점수 그리고 학점을 모두 조회할 수 있어야 합니다.

심화반 신청 - 학생들이 사용하는 기능입니다. 학점이 B 이상인 학생들만 수강할 수 있는 반입니다.

선생님 신청 - 지갑의 주소가 선생임을 증명할 수 있게 선생님 신청을 할 수 있는 기능을 만들어주세요.
*/

contract A {
    struct student {
        string name;
        uint number;
        uint birthday;
        uint score;
        string credit;
    }

    mapping(address => student) list;

    // 점수에 따른 학점 결정 함수
    function creditSet(uint a) public returns(string memory) {
        if(a>=90) {
            return "A";
        } else if(a>=80) {
            return "B";
        } else if(a>=70) {
            return "C";
        } else if(a>=60) {
            return "D";
        } else {
            return "F";
        }
    }

    // 학생 추가 기능
    function setStudent(string memory _name, uint _number, uint _birthday, uint _score) public {
        string memory _credit;
        _credit = creditSet(_score); // 입력된 점수가 creditSet 함수에서 걸러져 나와서 결정된다
        list[msg.sender] = student(_name, _number, _birthday, _score, _credit);
    }

    // 해당 학생이 있는지 여부 확인 기능
    function getValue() public view returns(uint) {
        return list[msg.sender].number * list[msg.sender].birthday * list[msg.sender].score;
    }

    // 학생 조회 기능
	function getStudent(address _a) public view returns(string memory, uint, uint, uint, string memory) {
        require(getValue()!=0); // 0이 아닐때 실행
        return (list[_a].name, list[_a].number, list[_a].birthday, list[_a].score, list[_a].credit);
        // mapping 으로 주소 입력된값의 값을 반환
    }

    // 학생 삭제 기능
    function deleteStudent(address _a) public {
        require(msg.sender == teacher); // 선생님이 맞을때 실행
        delete list[_a]; // mapping 으로 주소 입력된값
    }

    address teacher;
    // 선생님 신청 기능
    function setTeacher() public {
        teacher = msg.sender; // 1번 계좌를 선생님으로 설정
    }

    address[] extra;
    // 심화반 신청 기능
    function extraCur() public {
        require(keccak256(bytes(list[msg.sender].credit)) == keccak256("A") || keccak256(bytes(list[msg.sender].credit)) == keccak256("B"));
        // 해쉬화 시킨 mapping 입력값의 학점이 = 해쉬화 시킨 A 와 같을때 / B도 마찬가지
        extra.push(msg.sender); // 심화반 배열에 주소 추가
    }

    // 심화반 신청 완료 확인기능
    function getLength() public view returns(uint) {
        return extra.length;
    }
}