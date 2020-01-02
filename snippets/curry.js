// curry :: (Function, Array) -> Any
// Autocurry, return a function that takes multiple parameters one at a time
const curry = (f, arr = []) =>
  (...args) => (
    a => a.length === func.length
      ? f(...a)
      : curry(f, a)
  )([...arr, ...args])
