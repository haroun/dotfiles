const assert = require('assert').strict

const UPDATE_AVATAR = 'UPDATE:AVATAR'
const UPDATE_EMAIL = 'UPDATE:EMAIL'

const ownerMixin = ({username, avatar = null, email}) => {
  const state = {
    username,
    avatar,
    email
  }

  assert.notEqual(null, state.username, 'username is empty')
  assert.notEqual(null, state.avatar, 'avatar is empty')
  assert.notEqual(null, state.email, 'email is empty')

  return Object.freeze(state)
}

const update = (state, action = {}) => {
  const {type, data} = action
  switch (type) {
    case UPDATE_AVATAR:
      return {...state, avatar: data}
    case UPDATE_EMAIL:
      return {...state, email: data}
    default:
      return state
  }
}

module.exports = ownerMixin
module.exports.update = update
