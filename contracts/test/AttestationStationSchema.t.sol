//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

/* Testing utilities */
import {Test} from "forge-std/Test.sol";
import {AttestationStationSchema} from "../src/AttestationStationSchema.sol";

// contract AttestationStation is AttestationStationSchema {
//     constructor() {}
// }

contract AttestationStationSchemaTest is Test {
    AttestationStationSchema schema;

    function setUp() public {
        schema = new AttestationStationSchema();
    }

    function testCreateSchema() public {
        AttestationStationSchema.Field[] memory fields = new AttestationStationSchema.Field[](4);
        AttestationStationSchema.Field memory project_name =
            AttestationStationSchema.Field({info: "project name", value: "optimisim"});
        AttestationStationSchema.Field memory project_event =
            AttestationStationSchema.Field({info: "event", value: "Retroactive Public Goods Funding"});
        AttestationStationSchema.Field memory season = AttestationStationSchema.Field({info: "season", value: "2"});
        AttestationStationSchema.Field memory proposal =
            AttestationStationSchema.Field({info: "proposal", value: "can vote"});

        fields[0] = project_name;
        fields[1] = project_event;
        fields[2] = season;
        fields[3] = proposal;

        AttestationStationSchema.Value[] memory values = new AttestationStationSchema.Value[](1);

        bytes memory v = abi.encodePacked(uint256(1));
        AttestationStationSchema.Value memory value = AttestationStationSchema.Value({valueType: "uint256", value: v});

        // AttestationStationSchema.AttestationKey memory key = AttestationStationSchema.AttestationKey({fields: fields});
        // AttestationStationSchema.AttestationValue memory val =
        //     AttestationStationSchema.AttestationValue({values: values});
        // schema.createAttestationType();
        assert(true);
    }
}
