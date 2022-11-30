// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract abiencodePackedSamples{

    // 인자를 입력해서 해쉬화 시킬경우 👉 입력값의 타입을 지정
    function abiSample(uint _a, uint _b) public view returns(bytes32) {
        return keccak256(abi.encodePacked(_a, _b));
    }

    // 함수 안에서 해쉬화 시킬 값이 있을경우 👉 해당값의 타입을 지정
    function abiSample2() public view returns(bytes32) {
        return keccak256(abi.encodePacked(uint(1), uint(2)));
    }
}