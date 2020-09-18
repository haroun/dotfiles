const updateCounter = (state = 0, action) => {
  const {type, data: amount} = action
  const cases = {
    INCREMENT: state + amount,
    DECREMENT: state - amount,
    RESET: 0,
    default: state
  }

  return cases[type] || cases['default']
}

const updateCounter2 = (state = 0, action) => {
  const {type, data: amount} = action
  const cases = {
    INCREMENT: () => state + amount,
    DECREMENT: () => state - amount,
    RESET: () => 0,
    default: () => state
  }

  return (cases[type] || cases['default'])()
}

const updateCounter3 = (state = 0, action) => {
  const {type, data: amount} = action
  const cases = {
    INCREMENT: () => state + amount,
    DECREMENT: () => state - amount,
    RESET: () => 0,
    default: () => state
  }

  return (cases[type] && cases[type]()) || cases['default']()
}

console.log(updateCounter(10, {type: 'RESET', data: 1}))
console.log(updateCounter(10, {type: 'INCREMENT', data: 1}))
console.log(updateCounter(10, {type: 'DECREMENT', data: 1}))
console.log(updateCounter(10, {type: 'DECREMENT'}))
console.log(updateCounter(10, {data: 1}))
console.log('---')
console.log(updateCounter2(10, {type: 'RESET', data: 1}))
console.log(updateCounter2(10, {type: 'INCREMENT', data: 1}))
console.log(updateCounter2(10, {type: 'DECREMENT', data: 1}))
console.log(updateCounter2(10, {type: 'DECREMENT'}))
console.log(updateCounter2(10, {data: 1}))
console.log('---')
console.log(updateCounter3(10, {type: 'RESET', data: 1}))
console.log(updateCounter3(10, {type: 'INCREMENT', data: 1}))
console.log(updateCounter3(10, {type: 'DECREMENT', data: 1}))
console.log(updateCounter3(10, {type: 'DECREMENT'}))
console.log(updateCounter3(10, {data: 1}))
