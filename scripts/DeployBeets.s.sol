// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "contracts/Reliquary.sol";
import "contracts/emission_curves/BeetsConstantEmissionCurve.sol";
import "contracts/nft_descriptors/BeetsNftDescriptor.sol";
import "contracts/helpers/DepositHelper.sol";

contract DeployBeets is Script {
    uint[] _maBeetsMaturities = [
        0,
        604800,
        1209600,
        1814400,
        2419200,
        3024000,
        3628800,
        4233600,
        4838400,
        5443200,
        6048000
    ];
    uint[] _maBeetsMultipliers = [4, 25, 35, 40, 44, 46, 50, 60, 80, 94, 100];

    bytes32 public constant OPERATOR = keccak256("OPERATOR");
    bytes32 public constant EMISSION_CURVE = keccak256("EMISSION_CURVE");

    address public constant DAO_MSIG = 0x6Daeb8BB06A7CF3475236C6c567029d333455E38;
    address public constant LM_MSIG = 0x97079F7E04B535FE7cD3f972Ce558412dFb33946;
    IERC20 public constant BEETS = IERC20(0x2D0E0814E62D80056181F5cd932274405966e4f0);

    Reliquary public reliquary;
    DepositHelper public helper;

    function run() external {
        // vm.createSelectFork("fantom", 43052549);
        vm.startBroadcast();

        BeetsConstantEmissionCurve curve = new BeetsConstantEmissionCurve(0);
        curve.grantRole(curve.DEFAULT_ADMIN_ROLE(), DAO_MSIG);
        curve.grantRole(curve.OPERATOR(), LM_MSIG);

        reliquary = new Reliquary(address(BEETS), address(curve));

        address freshBeets = 0x10ac2F9DaE6539E77e372aDB14B1BF8fBD16b3e8;
        BeetsNftDescriptor nftDescriptor = new BeetsNftDescriptor(reliquary);

        reliquary.grantRole(OPERATOR, tx.origin);

        reliquary.addPool(
            100,
            freshBeets,
            address(0),
            _maBeetsMaturities,
            _maBeetsMultipliers,
            "maBeets",
            address(nftDescriptor)
        );

        reliquary.renounceRole(OPERATOR, tx.origin);

        reliquary.grantRole(reliquary.DEFAULT_ADMIN_ROLE(), DAO_MSIG);
        reliquary.grantRole(OPERATOR, LM_MSIG);
        reliquary.grantRole(EMISSION_CURVE, LM_MSIG);
        reliquary.renounceRole(reliquary.DEFAULT_ADMIN_ROLE(), tx.origin);

        // helper = new DepositHelper(address(reliquary));

        vm.stopBroadcast();
    }
}
