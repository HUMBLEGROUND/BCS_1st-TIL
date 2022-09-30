// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/* a와 10, b와 20 그리고 c와 30을 연결해주세요.
map을 써서 그리고 확인도 할 수 있게 해주세요. */

contract M {
    mapping(uint => uint) map;

    function push(uint index, uint _a) public {
        map[index] = _a;
        index++;
    } // 숫자, 숫자 입력

    function get(uint _index) public view returns(uint) {
        return map[_index];
    } // 숫자 입력하면 👉 숫자 반환 

//--------------------------------
    mapping(string => uint) map2;

    function push2(string memory index, uint _a) public {
        map2[index] = _a;
    } // string, 숫자 입력

    function get2(string memory _a) public view returns(uint) {
        return map2[_a];
    } // string 을 입력하면 👉 입력한 숫자 반환

//--------------------------------
    mapping(address => uint) map3;

    function push3() public {
        map3[msg.sender] = msg.sender.balance;
    } // 내 주소, 내 잔고

    function get3() public view returns (uint) {
        return map3[msg.sender];
    } // 내 주소에 있는 잔고 반환
}