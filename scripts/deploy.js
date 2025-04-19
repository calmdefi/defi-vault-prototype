const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with account:", deployer.address);

  // Deploy MockERC20 token
  const MockERC20 = await ethers.getContractFactory("MockERC20");
  const mockToken = await MockERC20.deploy("Mock Token", "MTKN");
  console.log("MockERC20 deployed to:", mockToken.target);

  // Deploy Vault with the mock token address
  const Vault = await ethers.getContractFactory("Vault");
  const vault = await Vault.deploy(mockToken.target);
  console.log("Vault deployed to:", vault.target);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });