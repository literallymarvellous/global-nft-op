//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

/* Testing utilities */
import {Test} from "forge-std/Test.sol";
import {AttestationStation} from "../src/AttestationStation.sol";
import {GlobalPassportNFT} from "../src/GlobalPassportNFT.sol";

contract GlobalPassportNFTTest is Test {
    GlobalPassportNFT nft;
    AttestationStation attestationStation;
    address alice = address(128);
    address bob = address(256);

    function setUp() public {
        attestationStation = new AttestationStation();
        nft = new GlobalPassportNFT("passport", "GPN", address(attestationStation));
    }

    function testCreateAttestation() public {
        AttestationStation.AttestationData[] memory attestationDataArr = new AttestationStation.AttestationData[](
                1
            );
        AttestationStation.AttestationData memory attestationData =
            AttestationStation.AttestationData({about: bob, key: bytes32("test-key:string"), val: bytes("test-value")});

        // make attestation
        vm.startPrank(alice);
        attestationDataArr[0] = attestationData;

        nft.mint(bob);
        nft.createAttestation(attestationDataArr, 1);

        vm.stopPrank();

        (, bytes32 key, bytes memory val) = nft.attestationsReceivedByToken(1, 0);
        assertEq(key, attestationData.key);
        assertEq(val, attestationData.val);
    }
}
