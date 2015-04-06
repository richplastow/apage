Main
====

#### The module’s only entry-point




Define the `Main` class
-----------------------

The `Main` class is synonymous with the module itself, so its identifier `@I` 
is set to the module’s identifier `I` (defined in ‘akaybe-helpers.litcoffee’). 

    class Main
      I: I
      toString: -> "[object #{@I}]"




Define private class properties
-------------------------------

By convention, private properties are prefixed with an underscore. Developers 
should avoid getting or setting these directly. 

#### `_rules`
See `ª.populate()` for a description of the `rule` format. 

      _rules:
        config: [
          ['title','Untitled','string',/^[^\x00-\x1F]{1,24}$/]
        ]




Define private instance properties
----------------------------------

      constructor: (config={}) ->

#### `_c`
The instance configuration. Use `config()` to get and set it. 

        @_c = {}




Constructor functionality
-------------------------

Validate `config` against `_rules.config`, and populate `_c` if it passes. 

        if errors = ª.populate config, @_c, @_rules.config
          throw new Error 'Invalid `config`:\n  ' + errors.join '\n  '




Define public methods
---------------------

#### `config()`
Gets or sets the current configuration. When setting configuration, `config()` 
usually returns `undefined`. However, an attempt to set the configuration to 
an invalid state will fail, and return an array of error messages. 

      config: (key, value) ->
        switch arguments.length

`config()` returns a clone of the current configuration, as an object

          when 0
            ª.clone @_c, @_rules.config

`config 'recognized'` returns the current value of `recognized`  
`config 'unknown'` returns `undefined`, if 'unknown' is not a recognized key  
`config {a:1, b:1}` sets `a` and `b` to new values, and returns `undefined`  
`config {a:'X', b:'X'}` leaves `a` and `b` alone, returning two error-messages  
`config {a:1, b:'X'}` leaves `a` and `b` alone, returning one error-message

Note this last example: the value of `a` is valid, but because `b`’s value is 
invalid the whole operation fails. The `a` configuration remains unchanged. 

          when 1
            switch ª.type key
              when S
                @_c[key]
              when O
                ª.populate key, @_c, @_rules.config, yes #@todo test the `updating` arg

`config 'foo', 'ok value'` sets `foo` to 'ok value', and returns `undefined`  
`config 'bar', 'nope!'` leaves `bar` alone, and returns an error-message array

          when 2
            obj = {}
            obj[key] = value
            @config obj




#### `render()`
Returns the html page, based on the current configuration. 

      render: ->
        header @_c # defined in ‘static-main.litcoffee’



