// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract A {
    uint[] a;

    function push(uint _a) public {
        a.push(_a);
    }

    function pop() public {
        a.pop();
    }

    // 배열에서 현재값 조회
    function get(uint i) public view returns(uint) {
        return a[i-1];
    }

    // 배열 길이 조회
    function getLength() public view returns(uint) {
        return a.length;
    }

    // 배열 전체 조회
    function getArr() public view returns(uint[] memory) {
        return a;
    } 
}