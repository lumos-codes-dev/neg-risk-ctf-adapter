// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import {vm} from "../dev/libraries/Vm.sol";
import {NegRiskFeeModule} from "src/NegRiskFeeModule.sol";

contract DeployNegRiskFeeModule {
    function run(address _negRiskCtfExchange, address _negRiskAdapter, address _ctf)
        external
        returns (address negRiskFeeModule)
    {
        vm.broadcast();
        negRiskFeeModule = address(new NegRiskFeeModule(_negRiskCtfExchange, _negRiskAdapter, _ctf));
    }
}
