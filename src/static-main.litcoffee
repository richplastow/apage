Static Main
===========

#### Static private functions, called by the `Main` class

These functions are visible to all code defined in ‘src/’ and ‘test/’, but are 
hidden from code defined elsewhere. They are characterized as follows: 

- They return the same output for a given set of arguments
- They have no side-effects, other than logging
- They run identically in all modern environments (browser, server, desktop, …)




#### `page()`
Returns the html page. 

    page = (config, articles) ->
      out = [
        """
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <title>#{config.title}</title>
      <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
      <meta name="generator" content="#{ªI} #{ªV} http://apage.richplastow.com/">
      <style>
        #{style config}
      </style>
    #{script config, articles}
    </head>
    <body>

      <nav class="nav" tabindex="-1" onclick="this.focus()">
        <div class="container">
        </div>
      </nav>
      <div class="btn btn-sm btn-close">×</div>

      <div class="container">
        <div class="col content"></div>
      </div>

        """
      ]

Begin each article, adding Apage’s standard data attributes. 
@todo better data-apage-front formatting, esp for long data
@todo is data-apage-opath needed?

      for article,i in articles
        id = tidypath article.path
        out.push """
    <article      id="_#{id}"
      data-apage-opath="/#{article.path}"
      data-apage-dname="_#{dirname article.path}"
      data-apage-order="#{ordername article.path}"
      data-apage-front='#{(JSON.stringify article.front).replace /'/g,"&#39;"}'
      data-apage-title="#{article.title}"
                 class="apage">
        """

Add the article content, and finish the article. 

        out.push filterLine config, line for line in article.html
        out.push "</article><!-- #/#{id} -->\n\n"

Finish up, and return the page HTML

      out.push '<!-- NB, Apage plugins may inject elements below this line -->'
      out.join('\n  ') + '\n\n</body>\n</html>'




#### `style()`
Returns a block of CSS for the header. 

    style = (config) -> #@todo add custom styles from config
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


          /* https://raw.githubusercontent.com/owenversteeg/min/gh-pages/compiled/general.css */
          body,
          textarea,
          input,
          select {
            background: 0;
            border-radius: 0;
            font: 16px sans-serif;
            margin: 0;
          }
          .addon,
          .btn-sm,
          .nav,
          textarea,
          input,
          select {
            outline: 0;
            font-size: 14px;
          }
          .smooth {
            transition: all .2s;
          }
          .btn,
          .nav a {
            text-decoration: none;
          }
          .container {
            margin: 0 20px;
            width: auto;
          }
          @media (min-width: 1310px) {
            .container {
              margin: auto;
              width: 1270px;
            }
          }
          .btn,
          h2 {
            font-size: 2em;
          }


          /* https://raw.githubusercontent.com/owenversteeg/min/gh-pages/compiled/navbar.css */
          .nav,
          .nav .current,
          .nav a:hover {
            background: #000;
            color: #fff;
          }
          .nav {
            height: 24px;
            padding: 11px 0 15px;
            /* TODO: migrate to ems (currently we don't use them because of iOS compatibility problems (has to do with unicode icon for close)) */
            /* Uncomment for animations
            max-height: 1.5em;
            */
          }
          .nav a {
            color: #aaa;
            padding-right: 1em;
            position: relative;
            top: -1px;
          }
          .nav .pagename {
            font-size: 22px;
            top: 1px;
          }
          .btn.btn-close {
            background: #000;
            float: right;
            font-size: 25px;
            margin: -54px 7px;
            display: none;
          }
          @media (max-width: 500px) {
            .btn.btn-close {
              display: block;
            }
            .nav {
              /* transition: max-height .5s ease-in-out, height .5s ease-in-out; */
              overflow: hidden;
            }
            .pagename {
              margin-top: -11px;
            }
            .nav:active,
            .nav:focus {
              height: auto;
              /* Necesary for animations
              max-height: 500px;
              height: 100%;
              */
            }
            .nav div:before {
              background: #000;
              border-bottom: 10px double;
              border-top: 3px solid;
              content: '';
              float: right;
              height: 4px;
              position: relative;
              right: 3px;
              top: 14px;
              width: 20px;
            }
            .nav a {
              display: block;
              padding: .5em 0;
              width: 50%;
            }
          }

          /* Custom Apage: Navigation */
          .nav .index  { text-transform:uppercase; }
          .nav .active { color:#fff; }

          /* Custom Apage: Definition List */
          dl, dt, dd { display:inline-block; margin:0; color:#eee }
          dl { margin-top: .5rem; padding:.5em 1em .4em; background: #333; border-radius:3px }
          dt { text-transform:uppercase; font-size: .7rem; }
          dt:after { content:": " }

          p, ul, ol { line-height:1.4; }

        /* NB, Apage plugins may inject CSS below this line */

      """




#### `filterLine()` @todo more filtering
Used by `page()` to localize URLs, so: 'http://foo.io/#bar' becomes '#bar'. 

    filterLine = (config, line) ->
      if config.url
        rx = new RegExp 'href="' + config.url, 'g' #@todo src
        line.replace rx, 'href="'




#### `tidypath() dirname() filename() ordername()`
Return various useful strings, based on an article’s `path`. @todo unit test these

    tidypath = (p) ->
      name = filename(p).split '-'
      order = name[0]
      name = if isNaN order * 1 then name.join '-' else name.slice(1).join '-'
      dirname(p) + name.split('.').slice(0,-1).join '.'

@todo better char than underscore, must be allowed in IDs but not in filenames

    dirname = (p) -> ªhas p, '/', p.split('/').slice(0,-1).join('_') + '_', ''

    filename = (p) -> p.split('/').slice(-1)[0]

    ordername = (p) ->
      order = filename(p).split('-')[0]
      if isNaN order * 1 then "'#{order}'" else order * 1




#### `script()`
Returns a block of JavaScript for the header. 

    script = (config, articles) ->

No need for any JavaScript if there are no plugins. 

      unless config.plugin then return ''

Render boilerplate Apage JavaScript, and then inject the plugins. 

      """

      <script>

    //// When the DOM is ready, set up Apage and inject the plugins. 
    window.addEventListener('load', function () { (function (d) { 'use strict'; 


    //// Declare iterator, length and HTML-reference variables. 
    var i, l, $ref


    //// Initialize two arrays which are available to all Apage plugins. 
     ,arts      = []
     ,resolvers = []
     ,updaters  = []


    //// Like jQuery, but native. 
     ,$  = d.querySelector.bind(d)
     ,$$ = d.querySelectorAll.bind(d)


    //// Gets a reference to all `<article class="apage">` elements. 
     ,$arts = $$('article.apage')


    //// Runs each resolver in order. These are added by the plugins, below. 
    //// Resolvers are used to map a query to an article. 
     ,resolve = function (query) {
        for (var i=0, l=resolvers.length, backstop, result={}; i<l; i++) {
          result = resolvers[i](query);
          if (result.art) { break; } // `query` does resolve to an article
          backstop = result.backstop || backstop; // may return a backstop
        }
        return result.art ? result.art : backstop; //@todo test logic of 'last valid backstop return' with several plugins at once
      }


    //// Runs each updater in order. These are added by the plugins, below. 
    //// Updaters change the current DOM state, eg to show a single article. 
     ,update = function (query) {
        for (var i=0, l=updaters.length, current=resolve(query); i<l; i++) {
          updaters[i](current);
        }
      }


    //// Tidies the URL hash and runs `update()` when the URL hash changes. 
     ,onHashchange = function (event) {
        update( window.location.hash.substr(1).replace(/\\//g,'_') );
        if (event) { event.preventDefault(); }
      }

    ;


    //// Populate the `arts` array using data from our `<ARTICLE>` elements. 
    for (i=0, l=$arts.length; i<l; i++) {
      $ref = $arts[i];
      arts.push({
        id:    $ref.getAttribute('id')
       ,opath: $ref.getAttribute('data-apage-opath')
       ,dname: $ref.getAttribute('data-apage-dname')
       ,order: $ref.getAttribute('data-apage-order')
       ,front: JSON.parse( $ref.getAttribute('data-apage-front') )
       ,title: $ref.getAttribute('data-apage-title')
       ,$ref:  $ref
      });
    }


    //// Begin injecting plugins. 

    #{config.plugin}

    //// End injecting plugins. 


    //// Run each updater when the page loads, and when the URL hash changes. 
    onHashchange();
    window.addEventListener('hashchange', onHashchange);


    }).call(this, document) });

      </script>

      """



