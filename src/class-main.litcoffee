Class Main
==========

#### The module’s only entry-point




Define the `Main` class
-----------------------

The `Main` class is synonymous with the module itself, so its identifier `I` 
and version `V` are the same as the module’s `ªI` and `ªV`. Note that `ªI` and 
`ªV` will be injected during the build process by `akaybe-build`, which gets 
the current title and version from ‘package.json’. 

    class Main
      I: ªI
      V: ªV
      toString: -> "[object #{@I}]"




Define private class properties
-------------------------------

By convention, private properties are prefixed with an underscore. Developers 
should avoid getting or setting these directly. 

#### `_rules`
See `ªpopulate()` for a description of the `rule` format. 

      _rules:
        config: [
          ['title','Untitled','string',/^[^\x00-\x1F]{1,24}$/]
          ['url',false,'string',/^[-:.\/a-z0-9]{1,64}$/] #@todo improve regexp
          ['plugin','','string',/^[^\x00-\x08\x0E-\x1F]{0,10000}$/] #@todo improve regexp
        ]




Define private instance properties
----------------------------------

      constructor: (config={}) ->

#### `_config`
The instance configuration. Use `config()` to get and set it. 

        @_config = {}



#### `_articles`
The page or site content. Use `browse()`, `read()`, `edit()`, `add()` and 
`destroy()`, to perform [BREAD operations](http://goo.gl/pJ6ME5) on it. 

        @_articles = []




Constructor functionality
-------------------------

Validate `config` against `_rules.config`, and populate `_config` if it passes. 

        if errors = ªpopulate config, @_config, @_rules.config
          throw new Error 'Invalid `config`:\n  ' + errors.join '\n  '




Define public methods
---------------------

#### `config()`
Gets or sets the current configuration. When setting configuration, `config()` 
usually returns `undefined`. However, an attempt to set the configuration to 
an invalid state will fail, and return an array of error messages. 

      config: (key, value) ->
        switch arguments.length

- `config()` returns a clone of the current configuration, as an object

          when 0
            ªclone @_config, @_rules.config


          when 1
            switch ªtype key

- `config('recognized')` returns the current value of `recognized`
- `config('X')` returns `undefined`, assuming 'X' is not a recognized key

              when ªS
                @_config[key]

- `config({a:1, b:1})` sets `a` and `b` to new values, and returns `undefined`
- `config({a:'X', b:'X'})` leaves `a` and `b` alone, returning two errors
- `config({a:1, b:'X'})` leaves `a` and `b` alone, returning one error

Note this last example: the value of `a` is valid, but because `b`’s value is 
invalid the whole operation fails, so `a`’s value remains unchanged. 

              when ªO
                ªpopulate key, @_config, @_rules.config, yes #@todo test the `updating` arg

- `config('foo', 'ok value')` sets `foo` to 'ok value', and returns `undefined`
- `config('bar', 'X')` leaves `bar` alone, and returns an error-message array

          when 2
            obj = {}
            obj[key] = value
            @config obj




#### `browse()`
Returns an array summarising the current articles. @todo filter/search, paginate, customize returned objects

      browse: () -> ((a)->{id:a.id,order:a.order})(a) for a in @_articles




#### `read()` and `destroy()`
Both these methods take an `identifier` argument, which can be the article ID, 
or its index in the `_articles` array. 

`read()` returns a clone of the instance, because returning an actual reference 
to the instance would allow the caller to modify it in unexpected ways, and 
possibly leave the apage instance in an invalid state. Also, returning a clone 
means that `destroy()` is guaranteed to purge the program of all references to 
the instance, allowing garbage-collection to remove it from system memory. 

      read: (identifier) ->
        art = ªretrieve @_articles, identifier
        art.clone()

`destroy()` removes all references to the instance, and runs the article’s 
`destructor()` method. It then returns a reference to this `apage` instance, to 
allow chaining, eg `myApage.destroy(0).destroy(0).add({ id:'foo.txt' })`. 

      destroy: (identifier) ->
        art = ªretrieve @_articles, identifier
        delete @_articles[art.id]
        @_articles.splice art.index, 1
        art.destructor()
        @ # allow chaining




#### `edit()`
Amends an article. As with `read()` and `destroy()`, `identifier` can be the 
article ID or its index in the `@_articles` array. The `amend` argument is an 
object, where each key must match one of the article’s editable properties, and 
each value must be a valid replacement value for that key. If any errors occur, 
the article is left completely untouched, ie `amend` is atomic. Like `add()` 
and `destroy()`, `edit()` returns a reference to this `apage` instance, to 
allow chaining. 

      edit: (identifier, amend) ->
        art = ªretrieve @_articles, identifier
        if errors = art.edit amend
          throw new Error 'Invalid `amend`:\n  ' + errors.join '\n  '
        @ # allow chaining




#### `add()`
Adds an article to `_articles`. Throws an error if `article` is invalid. 

      add: (article) ->
        if ! article then return @
        instance = new Article article
        if @_articles[instance.id]
          throw new Error "'#{instance.id}' already exists"
        instance.index = @_articles.length # used by `destroy()` @todo more elegant?
        @_articles.push instance #@todo reorder
        @_articles.sort (a, b) ->
          if a.order > b.order then return 1
          if a.order < b.order then return -1
          if a.id    > b.id    then return 1 # identical order-numbers
          if a.id    < b.id    then return -1
          0 # probably not possible, since IDs are unique @todo is it possible?
        @_articles[instance.id] = instance
        @ # allow chaining




#### `render()`
Returns the html page, based on the current configuration. 

      render: ->
        "#{page @_config, @_articles}"



