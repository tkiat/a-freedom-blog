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
    , R.p_ [R.text "Despite having advanced technologies and knowledge nowadays, we still don't respect others' freedom as much as I wish we do. The amount of killing in the meat industry and subtle violations of human rights are staggering."]
    , R.p_ [R.text "This is why I write this blog to promote freedom. The content favors free software, sustainable products, and lifestyle. All posts are not associated with anyone or any organization unless explicitly say so."]
    , R.p_ [
        R.text "I made this website from scratch (using Purescript, SCSS, and React.js) mainly because I wanted to personalize my blog. The source code is on "
      , R.a {href: "https://github.com/tkiat/a-freedom-blog", children: [R.text "GitHub"]}
      , R.text "."
      ]
    , R.h1_ [R.text "Credits"]
    , R.p_ [
        R.text "Favicon from "
      , R.a {href: "https://github.com/twitter/twemoji", children: [R.text "Twemoji"]}
      ]
    ]
  }
