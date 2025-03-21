### Project 3 [CS251 Course](https://cs251.stanford.edu/hw/proj3.pdf)
* run npm install --save-dev hardhat
* npm install --save-dev @nomiclabs/hardhat-ethers ethers
* npm install ethers@5.4.0
* npx hardhat compile
* copy abi field from artifacts/contracts/mycontract.sol/Splitwise.json to sripts.js
* npx hardhat node
* npx hardhat run --network local sripts/deploy.js
* open index.html