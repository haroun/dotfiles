const reducer = (state = {}, action = {}) => {
  const {type, payload} = action
  switch (type) {
    case 'FOO': return {...state, ...payload}
    default: return state
  }
}

