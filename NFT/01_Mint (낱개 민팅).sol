// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract MintNFT is ERC721Enumerable {
    mapping(uint => string) public metadataURIs;

    constructor() ERC721("BlockChainSchool", "BCS") {}

    function mintNFT() public {
        uint tokenId = totalSupply() + 1;

        _mint(msg.sender, tokenId);
    }

    // tokenId와 메타데이터 연결짓기
    function setTokenURI(uint _tokenId, string memory _metadataURI) public {
        metadataURIs[_tokenId] = _metadataURI;
    }

    // 메타데이터 조회
    function tokenURI(uint _tokenId) public override view returns(string memory) {
        // override를 사용하면 부모컨트랙트에서 사용중인 중복함수를 무시하고 동일 이름을 사용할수 있다
        return metadataURIs[_tokenId];
    }
}