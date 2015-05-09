Pagination
==========

#### @todo brief explanation

@todo longer discussion




Inject CSS
----------

    $ 'style'
     .innerHTML += """

    /* injected by Apage’s Pagination plugin */
    article { display: none; }
    article.active { display: block; }
    """



‘Article Not Found’
-------------------

Create a ‘Not Found’ article, which works like a ‘404 Not Found’ page. 

    $ref = document.createElement 'article'
    $ref.setAttribute 'class', 'apage'
    $ref.setAttribute 'id'   , 'apage_undefined'
    $ref.innerHTML = """
    <!-- injected by Apage’s Pagination plugin -->
    <h1>Article Not Found</h1>
    """
    d.body.appendChild $ref

Record the ‘Not Found’ article in `arts`, like any other article. 

    arts.push
      id:    'undefined'
      opath: '' #@todo needed?
      dname: ''
      order: 0
      front: []
      title: 'Article Not Found'
      $ref:  $ref




Allow Article Lookup by ID
--------------------------

Allow articles to be queried '#/with/a/path'. 

    for art in arts
      arts[ art.id ] = art

Add a route to the 0th article which catches '/', eg 'http://example.com/#/'. 

    arts['_'] = arts[0] || arts.undefined;




Resolver
--------

Add the `Pagination` plugin’s resolver function to Apage’s list of resolvers. 

    resolvers.push (query) ->

        if ! query     then return { art: arts[0] }     # eg '#' or no hash
        if arts[query] then return { art: arts[query] } # eg '#57'
        query = 'apage' + query
        if arts[query] then return { art: arts[query] } # eg '#/apage_foo'
        { backstop: arts.undefined } # like a 404 error




Updater
-------

Add the `Pagination` plugin’s updater function to Apage’s list of updaters. 

    updaters.push (current) ->

When called, this updater appends the `active` class to the current article, 
and removes the `active` class from all others. The CSS injected by this plugin 
will then hide all articles except the current one. 

      for art in arts
        art.$ref.className = art.$ref.className.replace /\s*active|\s*$/g, '' #@todo better regexp
      current.$ref.className += ' active'

Update the document title, which is usually visible at the very top of the 
browser window, and is also used in the browser’s ‘History’ menu. 

      d.title = current.title



    

