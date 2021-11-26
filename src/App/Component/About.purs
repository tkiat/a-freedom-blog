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
        R.text "I am Theerawat. My hobbies include coding, writing blogs, reading, and sustainability. My contact is tkiat@tutanota.com and my website is "
      , R.a {href: "https://tkiat.github.io", children: [R.text "tkiat.github.io"]}
      ]
    , R.h1_ [R.text "About This Blog"]
    , R.p_ [R.text "I am gravitated towards the true freedom, any action that reasonably respects others' freedom. Of course, the word 'reasonably' is subjective and I don't want to write my long definition here. I just want to say that the articles here tend to favor free software, DRM-free media, and a less impact lifestyle. All posts are not associated with anyone or any organization unless explicitly say so."]
    , R.p_ [R.text "This blog is written from scratch using Purescript and React.js. The style of this website is very simple because I want the reader to focus on content. I also love to write concise content. If there is no absolute need to write very long, why do it?"]
    , R.p_ [R.text ""]
    , R.h1_ [R.text "Credits"]
    , R.p_ [
        R.a {href: "https://github.com/twitter/twemoji", children: [R.text "favicon"]}
      , R.text " from Twemoji"
      ]
    ]
  }
