// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

/**
 * @title AttestationStationSchema
 * @author Marvellous @literallymarvel
 * @notice Schema for AttestationStation.
 * @dev This contract is originally from the Optimism monorepo.
 *       https://github.com/ethereum-optimism/optimism/blob/develop/packages/contracts-periphery/contracts/universal/op-nft/AttestationStation.sol
 */
contract AttestationStationSchema {
    bytes32 schema = hex"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff";
    bytes32 key = "animal-farm.school.grades";

    struct Field {
        string info;
        string value;
    }

    struct Value {
        string valueType;
        bytes value;
    }

    struct AttestationType {
        Field[] key;
        Value[] value;
    }

    function createAttestationType(Field[] memory fields, Value[] memory values) external {}
    // function createAttestationType(AttestationKey memory key, AttestationValue memory value) external {}
}
