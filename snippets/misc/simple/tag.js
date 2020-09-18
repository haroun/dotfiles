const assert = require('assert').strict

const tagMixin = ({name}) => {
  const state = {
    name
  }

  assert.notEqual(null, state.name, 'name is empty')

  return Object.freeze(state)
}

module.exports = tagMixin
