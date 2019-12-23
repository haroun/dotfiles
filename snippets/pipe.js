// pipe :: ([Function]) -> (Any) -> Any
// Create a pipeline of functions to iterate over left to right
const pipe = (...functions) => (initial) => functions.reduce((accumulator, current) => current(accumulator), initial)

