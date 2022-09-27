// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/* 이름을 추가할 수 있는 배열을 만들고, 
배열의 길이 그리고 n번째 등록자가 누구인지 
확인할 수 있는 contract를 구현하세요 */

contract Arr {
    string[] NameArray;

    function pushNameArray(string memory _n) public {
        NameArray.push(_n);
    }

    function getNameArray(uint _n) public view returns(string memory) {
        return NameArray[_n-1];
    }

    function nameArrayLength() public view returns(uint) {
        return NameArray.length;
    }

}