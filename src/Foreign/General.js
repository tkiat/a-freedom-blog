exports.isPreferColorSchemeDark = () => window.matchMedia('(prefers-color-scheme: dark)').matches
exports.goLastPage = () => () => history.go(-1)
