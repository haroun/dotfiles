// pipe(...functions: [...Function]) => initial => result
// Create a pipeline of functions to iterate over left to right
const pipe = (...functions) => initial =>
  functions.reduce((accumulator, current) => current(accumulator), initial)

const fill = n => Array(n).fill(null)
const odd = entries => entries.map((_, index) => 2 * index + 1)
const charify = char => entries => entries.map(n => char.repeat(n))
const center = (glue = ' ') => entries =>
  entries.map((n, index, arr) => {
    const glues = glue.repeat(arr.length - 1 - index)

    return glues.concat(n, glues)
  })
const log = (...args) => console.log(...args)

const pyramid = char => n =>
  pipe(
    fill,
    odd,
    charify(char),
    center()
  )(n)

const diamond = char => n =>
  pipe(
    pyramid(char),
    entries => entries.slice(0).reverse().slice(1)
  )(n)

const p10a = pyramid('A')(10)
log(p10a.join('\n'))
const d10a = diamond('A')(10)
log(d10a.join('\n'))
