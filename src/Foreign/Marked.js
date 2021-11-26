const marked = require('marked')
const hljs = require('highlight.js')

marked.setOptions({
  highlight: function (code, lang) {
    const hljs = require('highlight.js')
    const language = hljs.getLanguage(lang) ? lang : 'plaintext'
    return hljs.highlight(code, {language}).value
  },
  pedantic: false,
  gfm: true,
  breaks: false,
  sanitize: false,
  smartLists: true,
  smartypants: false,
  xhtml: false,
})
// const sanitizeHtml = require('sanitize-html')

// exports.toMarkdown = (content) => sanitizeHtml(marked(content))
exports.toMarkdown = content => marked(content)
