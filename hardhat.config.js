require("dotenv").config();
require("@nomicfoundation/hardhat-toolbox");

const RPC_URL = "http://127.0.0.1:8545";
const PRIV_KEY = ""; // isi private key EOA kamu (tanpa 0x? pakai 0x di depan)

module.exports = {
  solidity: "0.8.24",
  networks: {
    localhost: {
      url: "http://127.0.0.1:8545"
    },
    custom: {
      url: RPC_URL,
      accounts: PRIV_KEY ? [PRIV_KEY] : []
    }
  }
};
