import {ethers} from "hardhat";

async function main() {

  const name = "GladwynAnderson";
  const symbol = "GAT";
  const[deployer] = await ethers.getSigners() ;
  console.log("Deploying contracts with the account:", deployer.address);
  const token = await ethers.deployContract("MyToken", [name, symbol], {from:deployer.address});
  await token.waitForDeployment();
  console.log(
    `NFT with deployed to ${token.target}`
  );
  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
