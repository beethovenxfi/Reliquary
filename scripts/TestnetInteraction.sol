// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "contracts/Reliquary.sol";
import "contracts/emission_curves/Constant.sol";
import "contracts/nft_descriptors/NFTDescriptorSingle4626.sol";
import "contracts/helpers/DepositHelper.sol";

contract TestnetInteraction is Script {
    Reliquary public reliquary;
    INFTDescriptor public nftDescriptor;
    DepositHelper public helper;

    address public constant USER = 0x1B07eb7641E161C24f8F9F55eBeb32563Dd332B1;
    address public constant USER2 = 0x785ED52D14922a016a9a31B245b888A97e239e9A;

    function run() external {
        //vm.createSelectFork("fantom", 43052549);

        vm.startBroadcast();

        // IERC20 oath = IERC20(0x67af5D428d38C5176a286a2371Df691cDD914Fb8);
        reliquary = Reliquary(0x300DaA195a19DC39719237655eCadA053031359d);
        PoolInfo memory info = reliquary.getPoolInfo(0);
        console.log("pool name: %s", info.name);
        console.log("pool accre: %s", info.accRewardPerShare);
        console.log("pool lastre: %s", info.lastRewardTime);
        console.log("pool alloc: %s", info.allocPoint);
        IERC20 fakeBPT = IERC20(0x547Dd1aF43305a4aAa604856b2A9a2DA96852983);
        fakeBPT.approve(address(reliquary), 1000000000000000000000);
        reliquary.createRelicAndDeposit(
            0x1B07eb7641E161C24f8F9F55eBeb32563Dd332B1,
            0,
            1000000000000000000000
        );

        // IERC20 fbeetsBpt = IERC20(0x80dD2B80FbcFB06505A301d732322e987380EcD6);

        // IERC20 otherBpt = IERC20(0x1ecDb4cf3e8BAD87bA409475216F72f237e8309B);

        // // fbeetsBpt.approve(address(reliquary), 1000000000000000000000 ether);
        // // otherBpt.approve(address(reliquary), 1000000000000000000000 ether);

        // // reliquary.createRelicAndDeposit(USER, 0, 1000 ether);
        // // reliquary.createRelicAndDeposit(USER, 1, 1000 ether);

        // // two relics with 1000lp each, id 3 and 4

        // // reliquary.split(4, 250, USER2);
        // // reliquary.split(3, 200, USER);
        // // reliquary.split(3, 20, USER);

        // /// user has now 4 relics for fbeets: 3/800, 6/200, 7/20 and one relic for other 4/750
        // /// user2 has 1 relic: 5/250

        // // shift from user1 to user1
        // reliquary.shift(3, 6, 50);

        // /// user has 4 relics for fbeets: 3/750, 6/250, 7/20 and one relic for other 4/750
        // /// user2 has 1 relic: 5/250

        // reliquary.merge(6, 7);

        // /// user has 3 relics for fbeets: 3/750, 7/270 and one relic for other 4/700
        // /// user2 has 1 relic: 5/300

        vm.stopBroadcast();
    }
}
