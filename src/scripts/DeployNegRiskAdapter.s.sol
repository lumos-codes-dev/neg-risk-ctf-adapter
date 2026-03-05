// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {vm} from "../dev/libraries/Vm.sol";
import {NegRiskAdapter} from "src/NegRiskAdapter.sol";

contract DeployNegRiskAdapter {
    function run(address _ctf, address _collateral, address _vault) external returns (address negRiskAdapter) {
        vm.broadcast();
        negRiskAdapter = address(new NegRiskAdapter(_ctf, _collateral, _vault));
    }
}
