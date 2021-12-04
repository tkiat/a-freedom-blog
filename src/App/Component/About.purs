module App.Component.About where

import React.Basic.DOM as R
import React.Basic.Hooks as React

about :: React.JSX
about =
  R.div {
    className: "about"
  , children: [
      R.h1_ [R.text "About Me"]
    , R.p_ [
        R.text "I am Theerawat. My hobbies include coding, writing blogs, reading, and less-impact living. My contact is tkiat@tutanota.com and my personal website is "
      , R.a {href: "https://tkiat.github.io", children: [R.text "tkiat.github.io"]}
      ]
    , R.h1_ [R.text "About This Blog"]
    , R.p_ [R.text "The theme of this blog is freedom, anything that reasonably (by my standard) respects others' freedom. Articles usually favor free software and sustainable products and lifestyle. All posts are not associated with anyone or any organization unless explicitly say so."]
    , R.p_ [R.text "I intend to write everything here and post a few of them to other (more) popular public sites later. I made this website from scratch (using Purescript, SCSS, and React.js) mainly because I wanted to personalize my blog and decouple the article metadata from the Markdown content."]
    , R.h1_ [R.text "Credits"]
    , R.p_ [
        R.text "Favicon from "
      , R.a {href: "https://github.com/twitter/twemoji", children: [R.text "Twemoji"]}
      ]
    ]
  }
