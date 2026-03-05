// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import {vm} from "../dev/libraries/Vm.sol";
import {NegRiskCtfExchange} from "src/NegRiskCtfExchange.sol";

contract DeployNegRiskCtfExchange {
    function run(
        address _collateral,
        address _ctf,
        address _negRiskAdapter,
        address _proxyFactory,
        address _safeFactory
    ) external returns (address negRiskCtfExchange) {
        vm.broadcast();
        negRiskCtfExchange =
            address(new NegRiskCtfExchange(_collateral, _ctf, _negRiskAdapter, _proxyFactory, _safeFactory));
    }
}
