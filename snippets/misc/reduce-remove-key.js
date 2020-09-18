{
  /**
   * Remove empty attributes from object
   * @param  {Object} obj The object
   * @return {Object}     The new object without null values
   */
  //
  removeEmpty: (obj) => {
    const returnObj = obj
    Object.keys(returnObj).forEach((key) => {
      if (returnObj[key] == null || returnObj[key].length === 0) {
        delete returnObj[key]
      } else if (returnObj[key] && typeof returnObj[key] === 'object') {
        utils.removeEmpty(returnObj[key])
      }
    })

    return returnObj
  }
  // .reduce((r, i) => (
  //     typeof obj[i] === 'object'
  //       ? { ...r, [i]: removeEmpty(obj[i]) } // Recurse
  //       : { ...r, [i]: obj[i] },
  //   ), {}),
}
