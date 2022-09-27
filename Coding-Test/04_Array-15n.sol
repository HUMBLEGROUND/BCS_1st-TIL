// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/* 1부터 홀수 15개를 배열 a 안에 넣는 함수를 개발하세요. 
배열의 길이와 n번째 요소의 값을 반환하는 함수도 구현하세요 */

contract F {
    uint[] a;
    
    function pushNumber() public {
        for(uint i=1; i<30; i=i+2) {
            a.push(i);
        }
    }

    function getArray() public view returns(uint) {
        return a.length;
    } // 전체 배열 조회
    
    function getArray(uint _n) public view returns(uint) {
        return a[_n-1];
    } // 해당 배열 조회

//-----------------------------------
    //2n+1 - 다른방법 #1
    function pushNumber2() public {
        for(uint i=0; i<15; i++) {
            a.push(2*i+1);
        }
    }
    
    //지역변수 - 다른방법 #2
    function pushNumber3() public {
        uint k=1;
        for(uint i=1; i<16; i++) {
            a.push(k);
            k = k+2;
        }
    }
    //length - 다른방법 #3
    function pushNumber4() public {
        for(uint i=1; a.length<15; i+=2) {
            a.push(i);
        }
    }

    //length -2 - 다른방법 #4
	function pushNumber5() public {
        for(; a.length < 15;) {// while(a.length < 15)
            a.push((a.length * 2) + 1);
        }
    }

	//length - 3 - 다른방법 #5
	function pushNumber6() public {
        a.push(1);
        for(uint i=1;i <15;i++) {
            a.push(a[a.length-1]+2);
        }
    }
}
