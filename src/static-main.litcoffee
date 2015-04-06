Static Main
===========

#### Static private functions, called by the `Main` class

These functions are visible to all code defined in ‘src/’ and ‘test/’, but are 
hidden from code defined elsewhere. They are characterized as follows: 

- They return the same output for a given set of arguments
- They have no side-effects, other than logging
- They run identically in all modern environments (browser, server, desktop, …)




#### `header()`
Returns the html header, from the opening DOCTYPE to the end of the topnav. 

    header = (config) ->
      """
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <title>#{config.title}</title>
        <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
        <style>
          #{style()}
        </style>
      </head>
      <body>
        <h1>#{config.title}</h1>
      """




#### `style()`
Returns inline CSS for the header. 

    style = ->
      """
      /* normalize.css v3.0.3 | MIT License | github.com/necolas/normalize.css */

          /* Document */
          html { font-family:sans-serif; -ms-text-size-adjust:100%; -webkit-text-size-adjust:100% }
          body { margin:0 }

          /* HTML5 */
          article,aside,details,figcaption,figure,footer,header,hgroup,main,menu,nav,
          section,summary { display: block }
          audio,canvas,progress,video { display:inline-block; vertical-align:baseline }
          audio:not([controls]) { display:none; height:0 }
          [hidden],template { display:none }

          /* Links */
          a { background-color:transparent }
          a:active,a:hover { outline:0 }

          /* Text */
          abbr[title] { border-bottom: 1px dotted }
          b, strong { font-weight: bold }
          dfn { font-style: italic }
          h1 { font-size: 2em; margin: 0.67em 0 }
          mark { background: #ff0; color: #000 }
          small { font-size: 80% }
          sub,sup { font-size:75%; line-height:0; position:relative; vertical-align:baseline }
          sup { top: -0.5em }
          sub { bottom: -0.25em }

          /* Embedded */
          img { border: 0 }
          svg:not(:root) { overflow: hidden }

          /* Grouping */
          figure { margin: 1em 40px }
          hr { box-sizing: content-box; height: 0 }
          pre { overflow: auto }
          code,kbd,pre,samp { font-family:monospace,monospace; font-size:1em }

          /* Forms */
          button,input,optgroup,select,textarea { color:inherit; font:inherit; margin:0 }
          button { overflow:visible }
          button,select { text-transform:none }
          button,html input[type="button"],input[type="reset"],
          input[type="submit"] { -webkit-appearance:button; cursor:pointer }
          button[disabled],html input[disabled] { cursor:default }
          button::-moz-focus-inner,input::-moz-focus-inner{ border:0; padding:0 }
          input { line-height:normal }
          input[type="checkbox"],input[type="radio"] { box-sizing:border-box; padding:0 }
          input[type="number"]::-webkit-inner-spin-button,
          input[type="number"]::-webkit-outer-spin-button { height:auto }
          input[type="search"] { -webkit-appearance:textfield; box-sizing:content-box }
          input[type="search"]::-webkit-search-cancel-button,
          input[type="search"]::-webkit-search-decoration { -webkit-appearance:none }
          fieldset { border:1px solid #c0c0c0; margin:0 2px; padding:0.35em 0.625em 0.75em }
          legend { border:0; padding:0 }
          textarea { overflow:auto }
          optgroup { font-weight:bold }

          /* Tables */
          table { border-collapse:collapse; border-spacing:0 }
          td,th { padding:0 }

      """


