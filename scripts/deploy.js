// scripts/deploy.js
const hre = require("hardhat");

async function main() {
  const Logger = await hre.ethers.getContractFactory("AttendanceLogger");
  const logger = await Logger.deploy();                 // deploy tx dikirim
  await logger.waitForDeployment();                     // tunggu mined

  const addr = await logger.getAddress();               // atau: logger.target
  console.log("AttendanceLogger deployed to:", addr);
}

main().catch((err) => {
  console.error(err);
  process.exitCode = 1;
});
