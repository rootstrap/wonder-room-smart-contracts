require("@nomicfoundation/hardhat-toolbox")
require('dotenv').config();

module.exports = {
  solidity: '0.8.24',
  paths: {
    sources: './src/contracts',
    tests: './src/test',
  },
  networks: {
    polygon: {
      url: process.env.ALCHEMY_RPC_POLYGON_URL,
      accounts: [
        process.env.METAMASK_PRIVATE_KEY,
      ],
    },
    polygonAmoy: {
      url: process.env.ALCHEMY_RPC_POLYGON_AMOY_URL,
      accounts: [
        process.env.METAMASK_PRIVATE_KEY,
      ],
    },
  },
  etherscan: {
    apiKey: {
      polygon: process.env.POLYGON_API_KEY,
      polygonAmoy: process.env.POLYGON_AMOY_API_KEY,
    },
    customChains: [
      {
        network: "polygonAmoy",
        chainId: 80002,
        urls: {
          apiURL:
            "https://www.oklink.com/api/explorer/v1/contract/verify/async/api/polygonAmoy",
          browserURL: "https://www.oklink.com/polygonAmoy",
        },
      },
    ],
  },
  sourcify: {
    enabled: false,
  }
};
