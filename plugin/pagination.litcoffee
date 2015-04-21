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

Add the `pagination` plugin’s resolver function to Apage’s list of resolvers. 

    resolvers.push (query) ->

        if ! query     then return { art: arts[0] }     # eg '#' or no hash
        if arts[query] then return { art: arts[query] } # eg '#57' or '#/foo'
        { backstop: arts.undefined } # like a 404 error




Updater
-------

Add the `pagination` plugin’s updater function to Apage’s list of updaters. 

    updaters.push (current) ->

Remove the `active` class from all articles, and then add it to the current 
article. The CSS injected above hides all articles except the `active` one. 

      for art in arts
        art.$ref.className = art.$ref.className.replace /\s*active|\s*$/g, ''
      current.$ref.className += ' active'

      d.title = current.title



    

