exports.goLastPage = () => () => history.go(-1)
exports.isPreferColorSchemeDark = () => window.matchMedia('(prefers-color-scheme: dark)').matches
