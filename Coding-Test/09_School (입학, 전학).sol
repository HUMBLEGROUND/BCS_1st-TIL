// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*
221121
이름 번호 점수를 가진 학생 구조체를 생성하시오. 
학생의 등록과 삭제는 선생님만 가능합니다. 
학생들의 점수 총합을 구하고 이를 확인할 수 있는 기능을 구현하시오. 
학생의 삭제는 전학이라고 생각하시면 됩니다. 
학생 구성의 변화가 있으면 총합의 양도 갱신해주세요. 
번호는 알파벳 순으로 입력하고 전학, 전입시에는 자동으로 갱신해주세요.

학생 구성 
A-84
B-75
C-80
D-85
E-90

D 전학
F 전입
F-95

C전학

번호 예시
평소 -> A - 1번 , B - 2번 , C - 3번
B 전학 -> A - 1번 ,  C - 2번
E 전입 -> A - 1번 ,  C - 2번, E - 3번
*/

contract A2 {

    // 학생 구조체 생성
    struct student { 
        uint numb;
        string name;
        uint score;
    }

    student[] students;

    address teacher;

    constructor() {
        teacher = msg.sender; // teacher를 owner로 설정
    }

    // 학생 등록 기능
    function addStudent(string memory _name, uint _score) public {
        require(msg.sender == teacher); // 선생 일경우만 실행가능
        students.push(student(students.length+1, _name, _score));
        // 배열의 길이(기본이 0 이기때문에 +1을 해준다)
        getTotalScore();
        // 학생 등록이 되면서 총 점수 자동계산
    }

    // 학생 삭제 기능 (전학보내기) + 순서갱신
    function deleteStudent(uint _a) public {
        require(msg.sender == teacher);
        for(uint i=_a-1; i+1 < students.length; i++) {
            students[i+1].numb = i+1; 
            // +1 을 해줘야 실제 배열의 순서처럼 보인다
            // (기본이 0 이기때문에 +1을 해준다)
            students[i] = students[i+1];
        }
        students.pop();
        getTotalScore();
        // 학생 삭제 되면서 총 점수 자동계산
    }

    // 학생 조회 기능
    function getStudent(uint _a) public view returns (uint, string memory, uint) {
        return (students[_a-1].numb, students[_a-1].name, students[_a-1].score);
    }

    // 배열 길이 조회
    function getLength() public view returns(uint) {
        return students.length;
    }

    // 전체 점수 조회
    function getTotalScore() public view returns(uint) {
        uint a;
        for(uint i; i < students.length; i++) {
            a += students[i].score;
        }
        return a;
    }
}