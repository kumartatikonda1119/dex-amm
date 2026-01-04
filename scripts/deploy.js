const { ethers } = require("hardhat");

async function main() {
  console.log("Deploying DEX and MockERC20 tokens...");

  // Deploy MockERC20 tokens
  const MockERC20 = await ethers.getContractFactory("MockERC20");
  const tokenA = await MockERC20.deploy("Token A", "TKA");
  await tokenA.deployed();
  console.log("TokenA deployed to:", tokenA.address);

  const tokenB = await MockERC20.deploy("Token B", "TKB");
  await tokenB.deployed();
  console.log("TokenB deployed to:", tokenB.address);

  // Deploy DEX
  const DEX = await ethers.getContractFactory("DEX");
  const dex = await DEX.deploy(tokenA.address, tokenB.address);
  await dex.deployed();
  console.log("DEX deployed to:", dex.address);

  console.log("Deployment completed!");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
