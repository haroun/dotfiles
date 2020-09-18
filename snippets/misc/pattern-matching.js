// Pattern matching
const getLength3 = ({ x, y, z }) => Math.sqrt(x ** 2 + y ** 2 + z ** 2)
const getLength2 = ({ x, y, }) => Math.sqrt(x ** 2 + y ** 2)
const getLength1 = ([...etc]) => etc.length

const getLength = vector => (vector.x && vector.y && vector.z && getLength3(vector))
  || (vector.x && vector.y && getLength2(vector))
  || (vector && getLength1(vector))
  || null

console.log([
  getLength({x: 1, y: 2, z: 3}), // 3.74165
  getLength({x: 1, y: 2}), // 2.23607
  getLength([1]), // 1
])
