// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*학생 점수관리 프로그램입니다.
여러분은 한 학급을 맡았습니다.
학생은 번호, 이름, 점수로 구성되어 있고(구조체)
가장 점수가 낮은 사람을 집중관리하려고 합니다.

가장 점수가 낮은 사람의 정보를 보여주는 기능,
총 점수 합계, 총 점수 평균을 보여주는 기능,
특정 학생을 구현하는 기능, 
가능하다면 학생 전체를 반환하는 기능을 구현하세요.
*/

contract A {
    struct class {
        uint num;
        string name;
        uint score;
    }

    class[] classz;
    class lowest; // student자료형 변수 lowest 

    // 학생 등록
    uint minimum_score = 9999;
    function setStudent(string memory _name, uint _score) public {
        classz.push(class(classz.length+1, _name, _score));
        if(_score < minimum_score) {
            lowest = class(classz.length, _name, _score);
            minimum_score = lowest.score;
        }
    }

    // 특정 학생 조회
    function getStudent(uint _a) public view returns (uint, string memory, uint) {
        return (classz[_a-1].num, classz[_a-1].name, classz[_a-1].score);
    }

    // 가장 점수가 낮은 사람 정보 조회
    function getLength() public view returns(uint) {
        return classz.length;
    }
    function getLowest() public view returns(uint, string memory, uint) {
        return (lowest.num, lowest.name, lowest.score);
    }
    function getLowest2() public view returns(class memory) {
        return lowest;
    }

    // 총 점수 합계
    function getTotalScore() public view returns(uint) {
        uint a;
        for(uint i; i < classz.length; i++) {
            a += classz[i].score;
        }
        return a;
    }

    // 총 점수 평균
    function getTotalScoreAverage() public view returns(uint) {
        uint a;
        for(uint i; i < classz.length; i++) {
            a += classz[i].score;
        }
        return a/classz.length+1;
    }
}