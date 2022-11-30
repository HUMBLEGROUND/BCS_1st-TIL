// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.12;

// ⭐ 컨트랙트와 컨트랙트간 연결 & 호출을 할때는 bytes32 를 쓴다
contract AA {
    string a;

    function setString(string memory _a) public {
        a = _a;        
    }

    function get() public view returns(string memory) {
        return a;
    }

    // bytes 용량이 가변적
    function getBytes() public view returns(bytes memory) {
        return bytes(a);
    }

    // bytes 용량이 1 로 정해짐
    function getBytes2() public view returns(bytes1, bytes1, bytes1) {
        return (bytes(a)[0], bytes(a)[1], bytes(a)[2]);
    }

    // bytes 용량이 1, 2, 3 으로 정해짐
    function getBytes3() public view returns(bytes1, bytes2, bytes3) {
        return (bytes(a)[0], bytes(a)[1], bytes(a)[2]);
    }

    function getFirst() public returns(string memory) {
        bytes memory first = new bytes(1);
        first[0] = bytes(a)[0];
        return string(first);
    }

    function getSecond() public view returns(string memory) {
        bytes memory second = new bytes(1);
        second[0] = bytes(a)[1];
        return string(second);
    }

    function getSecond2() public view returns(bytes memory, string memory) {
        bytes memory second = new bytes(1);
        second[0] = bytes(a)[1];
        return (second, string(second));
    }

    // 원하는 위치의 값 출력
    function getPosition() public view returns(string memory) {
        bytes memory Position = new bytes(2); // 두개 출력
        Position[0] = bytes(a)[0];
        Position[1] = bytes(a)[1];

        return string(Position);
    }

    // 쉼표로 끊어진 string 합치기
    function stringConcat(string memory _c, string memory _d) public view returns(string memory) {
        return (string.concat(_c, _d));
    }

    // bytes 의 개수
    function getLength(string memory _a) public view returns(uint) {
        return bytes(_a).length;
    }
    
}