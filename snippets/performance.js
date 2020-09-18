const range1 = (start, end) => Array.from({length: end - start + 1}, (x, i) => i + start)
const range2 = (start, end) => new Array(end - start + 1).fill(0).map((x, i) => i + start)

const timer = (fn, limit = 1000, startTime = Date.now()) => {
  let ops = 0
  while (Date.now() - startTime < limit) {
    ops += 1
    fn()
  }

  return [fn(), ops]
}

const [output1, opsPerSec1] = timer(() => range1(1, 10))
const [output2, opsPerSec2] = timer(() => range2(1, 10))
console.log(output1, opsPerSec1)
console.log(output2, opsPerSec2)
