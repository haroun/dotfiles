const assert = require('assert').strict

const a = {
  a: 'a'
}

const obj = {
  getThis: () => this,
  getThis2() {
    return this
  }
}
obj.getThis3 = obj.getThis.bind(obj)
obj.getThis4 = obj.getThis2.bind(obj)

const expected = [
  obj,
  obj,
  obj,
  a,
  obj,
  obj,
  obj,
  a
]

const actual = [
  obj.getThis(),
  obj.getThis.call(a),
  obj.getThis2(),
  obj.getThis2.call(a),
  obj.getThis3(),
  obj.getThis3.call(a),
  obj.getThis4(),
  obj.getThis4.call(a)
]

// assert.deepEqual([[[1, 2, 3]], 4, 5], [[[1, 2, '3']], 4, 5])
console.log(actual)
// assert.deepEqual(actual, expected)

