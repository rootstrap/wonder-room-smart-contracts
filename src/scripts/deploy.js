const { ethers } = require('hardhat');
const { writeFileSync } = require('fs');


async function main() {
  const [owner, ..._] = await ethers.getSigners();
  console.log('DigitalTwinGuitars Contract Owner:', owner);
  const Contract = await ethers.getContractFactory('DigitalTwinGuitars');
  const deployedContract = await Contract.deploy();
  writeDeployedContractData(deployedContract);
}

function writeDeployedContractData(object) {
  writeFileSync('deploy.json', JSON.stringify(object, null, 2));
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
