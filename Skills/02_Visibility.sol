// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*
이 코드에는solidity 내 함수의 visibility에 대한 내용이 들어있음.
visibility란 접근 가능 범위를 의미함.
종류에는 private, public, internal, external이 있음.
*/

// view 👉 function 밖의 변수들을 읽을 수 있으나 변경 불가능
// pure 👉 function 밖의 변수들을 읽지 못하고 / 변경도 불가능 (순수하게 function 내에서 변수로만 구성)

// view 나 pure 둘다 명시 안할 경우 👉 function 밖의 변수들을 읽어서 / 변경을 할 경우

// external 👉 모두 접근 가능하나 / external이 정의된 컨트랙트에서는 접근 불가
// internal 👉 internal이 정의된 자기 컨트랙트에서만 가능 / internal이 정의된 컨트랙트를 상속

contract Visibility {

    function privateF() private pure returns (string memory) {
        return "private";
    }
    function testPrivate() public pure returns (string memory) {
        return privateF();
    }

    function internalF() internal pure returns (string memory) {
        return "internal";
    }

    function testInternal() public pure virtual returns (string memory) {
        return internalF();
    }

    function publicF() public pure returns (string memory) {
        return "public";
    }

    function externalF() external pure returns (string memory) {
        return "external";
    }
}

contract Child is Visibility {
    function testInternal2() public pure returns(string memory) {
        return internalF();
    }

    function testPublic() public pure returns(string memory) {
        return publicF();
    }
}