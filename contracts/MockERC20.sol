// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title MockERC20
 * @notice Simple ERC20 token used for testing the DEX
 */
contract MockERC20 is ERC20 {

    /**
     * @notice Creates a mock token and mints 1,000,000 tokens to deployer
     * @param name Token name
     * @param symbol Token symbol
     */
    constructor(string memory name, string memory symbol)
        ERC20(name, symbol)
    {
        _mint(msg.sender, 1_000_000 ether);
    }

    /**
     * @notice Mint tokens for testing purposes
     * @param to Address to receive tokens
     * @param amount Amount of tokens to mint
     */
    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}
