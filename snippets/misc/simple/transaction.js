const assert = require('assert').strict

const TYPE_DEPOSIT = 'deposit'
const TYPE_WITHDRAWAL = 'withdrawal'
const PAYMENT_METHOD_CARD = 'card'
const PAYMENT_METHOD_CASH = 'cash'
const PAYMENT_METHOD_CHECK = 'check'
const PAYMENT_METHOD_TRANSFER = 'transfer'

const transactionMixin = ({number, type, date, amount, description = '', paymentMethod}) => {
  const state = {
    number,
    type,
    date: Date.parse(date),
    amount: Number.parseInt(amount, 10),
    description,
    paymentMethod
  }

  assert.notEqual(null, state.number, 'number is empty')
  assert.notEqual(-1, [TYPE_DEPOSIT, TYPE_WITHDRAWAL].indexOf(state.type), `Invalid type, expected ${TYPE_DEPOSIT}|${TYPE_WITHDRAWAL}, received ${type}`)
  assert.notEqual(NaN, state.date, `date invalid, received ${date}`)
  assert.notEqual(NaN, state.amount, `amount invalid, received ${amount}`)
  assert.notEqual(-1, [PAYMENT_METHOD_CARD, PAYMENT_METHOD_CASH, PAYMENT_METHOD_CHECK, PAYMENT_METHOD_TRANSFER].indexOf(state.paymentMethod), `Invalid type, expected ${PAYMENT_METHOD_CARD}|${PAYMENT_METHOD_CASH}|${PAYMENT_METHOD_CHECK}|${PAYMENT_METHOD_TRANSFER}, received ${paymentMethod}`)

  return Object.freeze(state)
}

module.exports = transactionMixin
