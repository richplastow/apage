Class Article
=============

#### Represents a single article within the page or site




Define the `Article` class
--------------------------

    class Article
      I: 'Article'
      toString: -> "[object #{@I}]"




Define private class properties
-------------------------------

By convention, private properties are prefixed with an underscore. Developers 
should avoid getting or setting these directly. 

#### `_rules`
See `ªpopulate()` for a description of the `rule` format. 

      _rules:
        config: [
          ['path',undefined       ,'string',/^[-.\/a-zA-Z0-9]{1,64}$/]
          ['raw' ,'@todo\n=====\n','string',/^[^\x00-\x08\x0E-\x1F]{0,10000}$/] #@todo better list of valid characters
        ]




Define private instance properties
----------------------------------

      constructor: (config={}) ->

#### `_config`
The instance configuration. Use `config()` to get and set it. 

        @_config = {}




Constructor functionality
-------------------------

Validate `config` against `_rules.config`, and populate `_config` if it passes. 

        if errors = ªpopulate config, @_config, @_rules.config
          throw new Error 'Invalid `config`:\n  ' + errors.join '\n  '




Define public properties
------------------------

#### `path`
This will usually be a relative path, eg 'doc/03-third-doc-article.md'. 

        @path = @_config.path.replace /^[.\/]+/g, '' # leading '.', '/' or './'




#### `meta`
Meta data is optional, and based on [Jeyll frontmatter](http://goo.gl/4l6k2e). 

        @meta = [] # will remain an empty array if no frontmatter is present
        if '---\n' == @_config.raw.substr 0, 4 # the very top of the file
          @_config.raw = @_config.raw.split '---\n'
          for line,i in @_config.raw[1].split '\n' # each line of frontmatter
            [key, value] = line.split ': '
            if ! key or ! value then continue
            if 'title' == key
              @title = value
            else
              @meta[i] = { key:key, value:value }
          @_config.raw = (@_config.raw.slice 2).join '---\n'
          #@todo validate meta

Trim newlines and extra spaces from the start and end of the raw markdown. 

        @_config.raw = @_config.raw.replace /^\s+|\s+$/g, ''




#### `title`
Unless set in meta, article’s `title` is its first line of markdown. 

        @title = @title || (@_config.raw.split '\n')[0]




#### `html`
The article’s HTML is parsed from the raw data using the `marked` library. 

        @html = (marked @_config.raw).replace(/\\/g, '\\\\').split '\n'




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



