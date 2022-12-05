// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract str {
    function getMatch(string memory _a, string memory _b) public view returns(bool, uint) {
         bytes memory aa = bytes(_a); // _a를 바이트화 시킨값을 👉 aa 에넣음
         bytes memory bb = bytes(_b); // _b를 바이트화 시킨값을 👉 bb 에넣음
        // 길이 비교

         uint a_len = bytes(_a).length;
         uint b_len = bytes(_b).length;
        // 길이값 받아오기 (글자수)

        bytes memory part = new bytes(b_len);

         for(uint i=0; i < (a_len - b_len + 1); i++) {
             // i 값 👉 어디서부터 시작할지 지정 (시작점)
             for(uint j=0; j < b_len; j++) {
                 // j 값 👉 그때부터 몇번째 까지 가져올지
                part[j] = aa[i+j];
             }
             if(keccak256(part) == keccak256(bb)) {
                 return (true, i+1); // 찾았을경우 찾은 순번에서 +1 해주기
                 // (default가 0번째 부터 시작이라서 +1) 
             }
         }
         return (false, 999); // 못찾았을 경우 리턴
    }
}