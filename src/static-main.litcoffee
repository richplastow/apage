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
        /* ‘Inspect Element’ here, for Apage’s injected CSS */
      </style>
    #{script config, articles}
    </head>
    <body>

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
        out.push "</article><!-- / #_#{id} -->\n\n"

Finish up, and return the page HTML

      out.push '<!-- ‘Inspect Element’ here, for Apage’s injected elements -->'
      out.join('\n  ') + '\n\n</body>\n</html>'




#### `filterLine()` @todo more filtering
Used by `page()` to localize URLs, so: 'http://foo.io/#bar' becomes '#bar'. 

    filterLine = (config, line) -> #@todo src
      if config.url
        rx = new RegExp 'href="' + config.url, 'g' #@todo move this to the link renderer in import.litcoffee
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

    script = (config, articles) -> #@todo pass some config to plugins, eg color palette

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


    //// Get a reference to all `<article class="apage">` elements. 
     ,$arts = $$('article.apage')


    //// Convert JavaScript’s native `arguments` object to an array. 
     ,getArgs = function (args, offset) {
        return Array.prototype.slice.call(args, offset || 0);
     }


    //// `unattribute($ref,'data-apage-','opath'...)` removes data attributes. 
     ,unattribute = function ($ref, prefix) {
        for ( var i=0, suffs=getArgs(arguments,2), l=suffs.length; i<l; i++ ) {
          $ref.removeAttribute(prefix + suffs[i]);
        }
      }


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


    //// Populate the `arts` array using data from Apage `<ARTICLE>` elements. 
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
      unattribute($ref,'data-apage-','opath','dname','order','front','title');
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



