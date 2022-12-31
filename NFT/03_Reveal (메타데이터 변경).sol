// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MintNFT is ERC721Enumerable, Ownable {
    // mapping(uint => string) public metadataURIs;

    // constructor() ERC721("BlockChainSchool", "BCS") {}

    string public metadataURI;
    uint constant public TOTAL_NFT = 100; // 총 발행량
    // constant로 작성한 변수는 변경 불가하다 
    string public notRevealedURI; // 리빌되기전 URI 주소
    bool public isRevealed; // true false 로 메타데이터 바꿔주기

    constructor(string memory _metadataURI, string memory _notRevealedURI) ERC721("BlockChainSchool", "BCS") {
        metadataURI = _metadataURI;
        notRevealedURI = _notRevealedURI;
    }

    function mintNFT() public onlyOwner {
        require(TOTAL_NFT > totalSupply(), "No more mint."); // 발행량 100개가 넘어가는순간 실행안되도록

        uint tokenId = totalSupply() + 1;

        _mint(msg.sender, tokenId);
    }

    // tokenId와 메타데이터 연결짓기
    // function setTokenURI(uint _tokenId, string memory _metadataURI) public {
    //     metadataURIs[_tokenId] = _metadataURI;
    // }

    // 멀티민팅 함수
    function multiMint(uint _amount) public {
        for(uint i = 0; i < _amount; i++) {
            mintNFT();
        }
    }

    // 메타데이터 조회
    function tokenURI(uint _tokenId) public override view returns(string memory) {
        // override를 사용하면 부모컨트랙트에서 사용중인 중복함수를 무시하고 동일 이름을 사용할수 있다
        // return metadataURIs[_tokenId];
        if(isRevealed == false) return notRevealedURI;

        return string(abi.encodePacked(metadataURI, "/", Strings.toString(_tokenId), "./json"));
        // _tokenId 가 숫자여서 string 으로 바꿔줘야하는데 import 해야한다
    }

    // 메타데이터 리빌
    function reveal() public onlyOwner {
        isRevealed = true;
    }
}