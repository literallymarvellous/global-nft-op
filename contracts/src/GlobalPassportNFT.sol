// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import {ERC721} from "@solmate/tokens/ERC721.sol";
import {AttestationStation} from "./AttestationStation.sol";

/**
 * @title GlobalPassortNft ERC-721 Contract
 * @author Marvellous @literallymarvel
 * @notice A GlobalNFT is an NFT minted to anyone reccords attestations made to the nft holder.
 * @dev ""
 */
contract GlobalPassportNFT is ERC721 {
    event TokenAttestationCreated(address indexed creator, uint256 indexed id, bytes32 indexed key, bytes val);

    /// @notice Optimism's AttestationStation contract
    address immutable attestationStation;

    /// @notice Token id
    uint256 tokenId;

    /// @notice Maps addresses that have minted a token
    mapping(address => bool) public mintedAddress;

    /// @notice Maps tokenId to attestations
    mapping(uint256 => AttestationStation.AttestationData[]) public attestationsReceivedByToken;

    constructor(string memory _name, string memory _symbol, address attestationContract) ERC721(_name, _symbol) {
        attestationStation = attestationContract;
    }

    /// @notice Mints single token to address that has not minted yet
    /// @dev Explain to a developer any extra details
    /// @param to address to mint to
    function mint(address to) external {
        require(!mintedAddress[to], "1 mint per address");

        ++tokenId;
        _mint(to, tokenId);
    }

    function tokenURI(uint256 id) public view virtual override returns (string memory) {}

    /// @notice Creates a new attestation
    /// @param attestationData An array of attestation data
    /// @param id TokenId for which attestation is created
    function createAttestation(AttestationStation.AttestationData[] calldata attestationData, uint256 id) external {
        require(_ownerOf[id] != address(0), "NOT_MINTED");
        uint256 attestationDataLength = attestationData.length;

        for (uint256 i = 0; i < attestationDataLength;) {
            AttestationStation.AttestationData memory attestation = attestationData[i];
            attestationsReceivedByToken[id].push(attestation);

            emit TokenAttestationCreated(msg.sender, id, attestation.key, attestation.val);

            unchecked {
                ++i;
            }
        }

        AttestationStation(attestationStation).attest(attestationData);
    }
}
