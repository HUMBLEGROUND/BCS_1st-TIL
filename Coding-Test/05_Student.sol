// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/* 학생이라는 구조체를 만들자. 번호, 이름, 성적, 반이 포함되어있음. 
번호 : 1,2,3,4,5 
이름 : a,b,c,d,e 
점수 : 90, 70, 60, 55, 85 
90점이상은 A반, 80점 이상은 B반, 70점 이상은 C반 그 이하는 D반
반을 갈라주는 함수를 구현하시오
(채점자) : 점수를 넣고 반이 잘 갈라지는지를 확인할 것 */

contract I {
    struct student {
        uint num; 
        string name;
        uint point;
        string class;
    } // 구조체

    student[] Students; // 빈배열 생성

    function pushStudent(uint _num, string memory _name) public {
        Students.push(student(_num, _name, 0, "x"));
        // 구조체로 구성된 배열 push
        // 순번과 이름 설정해주는 입력 함수
    }

    function setScore(uint _num, uint _point) public {
        Students[_num-1].point = _point; // 입력하는 번호의 점수가 input 값의 점수

        if(_point >= 90) {
            Students[_num-1].class = "A";
        } else if (_point >= 80) {
            Students[_num-1].class = "B";
        } else if (_point >= 70) {
            Students[_num-1].class = "C";
        } else {
            Students[_num-1].class = "D";
        } // 입력하는 번호의 점수의 조건 👉 반 나누기

        // 순번의 점수를 설정해주는 입력 함수
    }

    function getStudentInfo (uint _num) public view returns (string memory, uint, string memory) {
        return (Students[_num-1].name, Students[_num-1].point, Students[_num-1].class);
    } // 입력하는 번호가 해당 배열의 값 👉 세가지 정보 리턴 조회


//----------------------------------------------------

    function getAverage() public view returns(uint) { // 평균값구하기
        uint a;
        for(uint i=1; i<Students.length+1; i++) { 
            // 배열의 길이 + 1 까지 반복
            a += Students[i-1].point;
            // 입력된 배열의 점수 다 더하기
        }
        return a/Students.length; // 다 더해진 값 나누기
    }

//----------------------------------------------------

    // 배열 초기화
    student[] c; // 구조체 배열 초기화

    function erase() public { // 배열 초기화하기
        Students = c;
    }
}

// contract AA {
//     uint[] a;
//     function pushNumber(uint _a) public {
//         a.push(_a);
//     }

//     function erase() public {
//         uint[] memory b;
//         a=b;
//     }

//     function getLength() public view returns (uint) {
//         return a.length;
//     }
// }
