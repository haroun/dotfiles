// compose :: ([Function]) => (Any) -> Any
// Create a pipeline of functions to iterate over right to left
const compose = (...functions) => (initial) => functions.reduceRight((accumulator, current) => current(accumulator), initial)

