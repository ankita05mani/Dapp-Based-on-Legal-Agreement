// ABI and contract address
const abi = ABI.json 
const contractAddress = 0xd9145CCE52D386f254917e481eB44e9943F39138

// Connect to web3 and get contract instance
const web3 = new web3('http://localhost:8545')
const contract = new web3.eth.Contract(abi, contractAddress)

// Create contract
await contract.methods.createContract(party2Address, terms, amount).send({from: party1Address, value: amount})

// Execute contract 
await contract.methods.executeContract(contractId).send({from: executorAddress})

// Get contract 
const result = await contract.methods.getContract(contractId).call()
const [party1, party2, terms, isExecuted, amount] = result
