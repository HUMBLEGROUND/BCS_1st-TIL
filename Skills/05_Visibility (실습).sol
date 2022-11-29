// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*
221116
이 코드에는 다른 contract의 함수를 호출하거나, 
변수의 값이 필요할 때 사용하는 방법에 대한 내용이 포함됨.

실습순서
1. Visibility, Child2, Child3 contract를 모두 deploy
2. Child3 contract deploy시에는 Visibility의 address를 넣은 후 deploy 
3. Visibility에서 실행
   3-0 Visibility의 address 확인
   3-1 showA() 실행 -> 0 확인
   3-2 privateF2() 실행, showA() 실행 -> 10 확인
4. Child2에서 getAddress(), testShowA() 함수 실행 -> 3-0의 Visibility contract address와 3-2 showA() 실행 결과값과 비교
5. Child3에서 getAddress(), testShowA() 실행 -> 3-0의 Visibility contract address와 3-2 showA() 실행 결과값과 비교

Child2의 경우에는 Visibility를 새롭게 정의하였고
Child3의 경우에는 deploy시 Visibility의 주소를 삽입하여 3-1, 3-2의 결과값을 따라감. 
*/

contract Visibility {

    uint a; // 상태변수 선언

    function privateF2() private returns(uint) {
        a = a+10; // 상태변수를 바꾸는 행위, 상태변수가 외부의 요인에 의해서 변화되면 안될 때 이렇게 private 함수 사용
        return a;
    }

    function testPrivate2() public returns(uint) {
        return  privateF2();
    }
		/* privateF2()가 밖에서는 접근할 수 없는 private 함수임.
		따라서, 외부에서 접근할 수 있는 public 함수를 사용하고 그 함수가 
		privateF2()를 호출하는 식으로 접근해야함.
		바로 위의 testPrivate2()처럼 할수도 있지만, 누구나 실행할 수 있기에
		privateF2()를 private으로 설정한 의미가 퇴색됨.
		아래의 testPrivate2_2()처럼 시작할 때 require()를 통해 특정 주소만
		설정할 수 있게 코드를 작성하면 더욱 안전하게 관리할 수 있음.
		*/
    function testPrivate2_2() public returns(uint) {
        require(msg.sender == 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
        return  privateF2();
    }

    function showA() public view returns(uint) {
        return a;
    }
}

contract Child2 {
    Visibility vs = new Visibility(); 
    // uint a = 5; -> uint a; a=5;
    // Visibility형 변수 vs 선언, Visibility vs; vs = new Visibility()

    function testShowA() public view returns(uint) {
        return vs.showA(); //visibility내 showA함수 실행
    }
    
    function getAddres() public view returns(address) {
        return address(vs); //vs의 contract address 함수 실행
    }
}

contract Child3 {
    Visibility public vs;

    constructor(address A) {
        vs = Visibility(A); //특정 address의 값을 삽입
    }

    function testShowA() public view returns(uint) {
        return vs.showA(); //위의 visibility내 showA함수 실행
    }
    
    function getAddres() public view returns(address) {
        return address(vs); //vs의 contract address 반환
    }
}