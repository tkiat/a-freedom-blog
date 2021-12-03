exports.goLastPage = () => () => history.go(-1)
exports.getYPos = () => {
  console.log('noob', window.scrollY)
  return window.scrollY
}
exports.isPreferColorSchemeDark = () => window.matchMedia('(prefers-color-scheme: dark)').matches
exports.scrollTo = pos => () => window.scrollTo(0, pos)
