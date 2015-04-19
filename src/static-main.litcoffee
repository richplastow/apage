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
        <script>
      #{script config, articles}
        </script>
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

      </body>
      </html>
      """




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

      """




#### `filterLine()` @todo more filtering
Used by `script()` to localize URLs, so: 'http://foo.io/#bar' becomes '#bar'. 

    filterLine = (config, line) ->
      if config.url
        rx = new RegExp 'href="' + config.url, 'g' #@todo src
        line = line.replace rx, 'href="'
      "          '#{line}',"




#### `tidypath() dirname() filename() ordername()`
Return various useful strings, based on an article’s `path`. @todo unit test these

    tidypath = (p) ->
      name = filename(p).split '-'
      order = name[0]
      name = if isNaN order * 1 then name.join '-' else name.slice(1).join '-'
      dirname(p) + name.split('.').slice(0,-1).join '.'

    dirname = (p) -> ªhas p, '/', p.split('/').slice(0,-1).join('/') + '/', ''

    filename = (p) -> p.split('/').slice(-1)[0]

    ordername = (p) ->
      order = filename(p).split('-')[0]
      if isNaN order * 1 then "'#{order}'" else order * 1




#### `script()`
Returns a block of JavaScript for the header. 

    script = (config, articles) ->

Begin the output-array. 

      out = [
        '(function (root) { \'use strict\';'
        '  var'
        ''
        '    //// Define the articles. '
        '    arts = ['
      ]

Add each article. 

      for article,i in articles
        out = out.concat [
          "      { order: #{ordername article.path},"
          "        path:  '/#{article.path}',"
          "        tidy:  '/#{tidypath article.path}',"
          "        dname: '/#{dirname  article.path}',"
          "        title: '#{article.title}',"
          "        meta: ["
        ]
        out.push "          ['#{field.key}','#{field.value}']," for field in article.meta
        out = out.concat [
          "        ],"
          "        html: ["
        ]
        out.push filterLine config, line for line in article.html
        out = out.concat [
          "        ]"
          "      },"
        ]

Add functionality to show pages, and return the output as a string. 

      out = out.concat ["""
        ]


        //// Format meta data as HTML. 
       ,formatMeta = function (meta) {
          var o=['<div class="meta">'];
          for (var i=0,l=meta.length; i<l; i++) {
            o = o.concat(
              '  <dl>'
             ,'    <dt>' + meta[i][0] + '</dt>'
             ,'    <dd>' + meta[i][1] + '</dd>'
             ,'  </dl>'
            );
          }
          return o.concat('</div>').join('\\n');
        }


        //// Generate the menu as HTML. 
       ,formatMenu = function (curr) {
          var o=['<div class="menu">'];
          for (var i=0,l=arts.length,a,c; i<l; i++) {
            a = arts[i];
            c = [];
            if (0 === a.order)        { c.push('index'); }
            if (curr.tidy === a.tidy) { c.push('active'); }
            if (0 === a.order || curr.dname === a.dname) {
              o.push(
                '  <a href="#' + a.tidy + '" ' +
                ' class="' + c.join(' ') + '">' +
                a.title + '</a>'
              );
            }
          }
          return o.concat('</div>').join('\\n');
        }


        //// One-liner jQuery ;-)
       ,$ = function (s) { return document.querySelector(s); }


        //// Return a renderable object based on a given query. 
       ,resolve = function (query) {
          if (! query) { return arts[0]; } // eg '#' or no hash
          if (arts[query]) { return arts[query]; } // eg '#57' or '#/foo'
        }


        //// Change the window content, eg display an article. 
       ,update = function (query) {
          var a = resolve(query) || arts.undefined;
          $('.content').innerHTML =
            a.html.join('\\n') +
            '\\n<hr>\\n' +
            formatMeta(a.meta)
          ;
          $('.nav .container').innerHTML = formatMenu(a);
          document.title = a.title;
        }


        //// Called when the page loads, and when the URL hash changes. 
       ,onHashchange = function (event) {
          update( window.location.hash.substr(1) ); // trim leading '#'
          event.preventDefault();
        }


      ;

      //// Add default articles. 
      arts['/'] = arts[0]; // define homepage at 'example.com/#/'
      arts.undefined = {
        order: 0,
        path:  '',
        tidy:  '',
        dname: '',
        title: 'Article Not Found',
        meta: [],
        html: ['<h1>Article Not Found</h1>']
      };


      //// Allow articles to be queried '#/with/a/path'. 
      for (var i=0,l=arts.length; i<l; i++) { arts[ arts[i].tidy ] = arts[i]; }


      //// Show the article specified in the URL, when the page loads...
      window.addEventListener('load', onHashchange);


      //// ...and when the URL hash changes. 
      window.addEventListener('hashchange', onHashchange);

    //
    """
      ]

Inject custom functionality, if the `plugin` config field has been set. 

      if config.plugin
        out = out.concat [
          '\n  //// Begin plugin code.\n'
          config.plugin
          '\n  //// End plugin code.\n'
        ]

      out.push '}).call(this);'
      out.join '\n'



