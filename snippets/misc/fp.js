const pipe = (...fns) =>
  x =>
    fns.reduce((v, f) => f(...v), x);

const curry = (
  f, arr = []
) => (...args) => (
  a => a.length === f.length ?
    f(...a) :
    curry(f, a)
)([...arr, ...args]);
