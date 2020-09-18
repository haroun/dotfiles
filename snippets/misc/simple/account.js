const assert = require('assert').strict

const accountMixin = ({number, owner, balance = 0}) => {
  const state = {
    number,
    owner: {...owner},
    balance: Number.parseInt(balance, 10),
    transactions: []
  }

  assert.notEqual(null, state.number, 'number is empty')
  assert.notEqual('', state.owner.username, `Invalid owner, received ${owner}`)
  assert.notEqual(NaN, state.balance, `balance invalid, received ${balance}`)

  return Object.freeze(state)
}

module.exports = accountMixin
