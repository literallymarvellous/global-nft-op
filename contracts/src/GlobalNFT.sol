// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import ERC721 from "@solmate/tokens/ERC721.sol"

/**
 * @title GlobalNft ERC-721 Contract
 * @author Marvellous @literallymarvel
 * @notice A GlobalNFT is an NFT minted to anyone reccords attestations made to the nft holder.
 * @dev ""
 */
contract GlobalNFT is ERC721 {

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {}
}