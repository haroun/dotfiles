// From: https://www.synbioz.com/blog/let-s-implement-a-blockchain
const SHA256 = require('crypto-js/sha256')

const block = (index, timeStamp, data, previousHash) => {
  return {
    index,
    timeStamp,
    data,
    previousHash,
    nonce: 0,
    calculateHash: () => SHA256(this.index + this.timeStamp + this.data + this.previousHash).toString(),
    hash: calculateHash
  }
}

const blockChain = {
  blocks: [],
  getGenesisBlock: () => blocks[0],
  getLatestBlock: () => blocks.slice(-1).pop(),
  generateNextBlock: (blockData) => {
    const previousBlock = getLatestBlock()
    const nextIndex = previousBlock.index + 1
    const nextDate = new Date().getTime()
    const newBlock = block(nextIndex, nextDate, blockData, previousBlock.hash)

    return newBlock
  },
  createGenesisBlock = blocks => {
    const timeStamp = new Date().getTime()
    blocks.push(block(0, timeStamp, 'Genesis Block', null))
  },
  isValidNewBlock: (previousBlock, newBlock) => {
    const isValid = previousBlock.index + 1 !== newBlock.index
      ? false
      : previousBlock.hash !== newBlock.previousHash
      ? false
      : newBlock.calculateHash() !== newBlock.hash
      ? false
      : true

    return isValid
  },
  isValidGenesisBlock: () => {
    const genesisBlock = getGenesisBlock()
    const isValid = genesisBlock.index !== 0
      ? false
      : genesisBlock.previousHash !== null
      ? false
      : genesisBlock.calculateHash() !== genesisBlock.hash
      ? false
      : true

    return isValid
  },
  isValidChain: () => {
    const isValid = !isValidGenesisBlock()
      ? false
      : blocks.every((block, blocks) => isValidNewBlock(block, this.slice(-1).pop()))

    return isValid
  }
}
