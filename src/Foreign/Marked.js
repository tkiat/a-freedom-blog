const marked = require('marked')
const hljs = require('highlight.js')
// const sanitizeHtml = require('sanitize-html')

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

exports.toMarkdown = field => content => {

  const a = sessionStorage.getItem(field)
  const b = parseInt(a)
  const c = isNaN(b) ? 0 : b

  setTimeout(function(){
    window.scrollTo(0, c)
  }, 500)
  return marked(content)
//   return sanitizeHtml(marked(content))
}
