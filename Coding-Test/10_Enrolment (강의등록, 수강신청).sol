// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*
221122
1,2 번 지갑은 강의자 3-10번은 학생입니다.
아래의 기능들을 구현하세요.

- 강의자 등록 : 1, 2번 지갑을 강의자로 등록합니다. 
구조체 강의자는 이름, 개설한 강의 제목 그리고 개설한 강의수로 구성되어 있고 
등록시 지갑 주소와 연결됩니다.(매핑)

- 학생 등록 : 나머지 지갑들을 학생으로 등록합니다. 
구조체 학생은 번호, 이름, 수강 수업수로 구성되어있고 
등록시 지갑 주소와 연결됩니다.(매핑)

- 수업 등록 : 강의자가 수업을 등록할 수 있게 지원합니다. 
수업명은 string으로 설정하고 각 수업명은 수강자와 연결됩니다.(매핑)

- 수강 신청 : 학생들이 원하는 수업을 수강신청할 수 있게 지원합니다. 
각 수업은 5명까지만 수강이 가능하고, 
각 학생은 3개 이상 수강신청할 수 없습니다.
*/

contract A {
    struct lecturer {
        string name; // 강의자 이름
        string[] lecture_name; // 개설한 강의제목
        uint lecture_num; // 개설된 강의수
    }

    mapping(address => lecturer) lecturers;
    // 선생님 등록시 지갑주소와 연결하기
    // ⭐ struct를 가진 mapping 👉 key 하나에 여러개의 value 를 뽑아낼수 있다

    struct student {
        uint number; // 학생 번호
        string name; // 학생 이름
        uint class_num; // 학생이 수강하고 있는 수업 수
    }

    mapping(address => student) students;
    // 학생 등록시 지갑주소와 연결하기

    mapping(string => address[]) class;
    // 수업명과 수강생들 지갑주소 연결

    // 강의자(선생님) 등록 
    function setTeacher(string memory _name) public {
        lecturers[msg.sender].name = _name;
        // msg.sender 의 이름은 입력값으로 등록
    }

    // 강의자(선생님) 조회
    function getTeacher(address _a) public view returns(string memory, uint) {
        return (lecturers[_a].name, lecturers[_a].lecture_num);
    }

    // 학생 등록
    function setStudent(uint _number, string memory _name) public {
        students[msg.sender].number = _number;
        students[msg.sender].name = _name;
    }

    // 학생 조회
    function getStudent(address _a) public view returns(uint, string memory, uint) {
        return (students[_a].number, students[_a].name, students[_a].class_num);
    }

    // 수업등록, 강의자(선생님)
    function makeClass(string memory _class) public {
        require(keccak256(bytes(lecturers[msg.sender].name)) != 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470);
        // 빈값을 해쉬화한 값이랑 일치하지 않으면 실행 / 선생님인지 확인
        class[_class]; // 수업등록
        lecturers[msg.sender].lecture_name.push(_class); // 개설한 강의 제목
        lecturers[msg.sender].lecture_num++; // 개설한 강의수 증가
    }

    // 수강 신청
    function enrollClass(string memory _class) public {
        require(class[_class].length < 5); // 수강하는 학생은 5명 수강이 불가능
        require(students[msg.sender].class_num < 3); // 학생은 3개 이상 수강신청 불가

        class[_class].push(msg.sender); // 수업명과 수강생의 지갑주소를 연결
        students[msg.sender].class_num++; // 해당 수강생이 수강하고 있는 수업 수 증가
    }
}