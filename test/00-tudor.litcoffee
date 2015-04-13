Tudor
=====

The easy-to-write, easy-to-read test framework. 




Define the `Tudor` class
------------------------

    class Tudor
      I: 'Tudor'
      toString: -> "[object #{I}]"

      jobs: []




Define the constructor
----------------------

      constructor: (opt={}) ->
        switch opt.format
          when 'html'
            @header =   '<a href="#end" id="top">\u2b07</a>'
            @footer = '\n<a href="#top" id="end">\u2b06</a>'
          else
            @header =   '\u2b07'
            @footer = '\n\u2b06'




Define public methods
---------------------

#### `do()`
Run the test and return the result. 

      do: =>
        md = [] # initialize markdown lines
        passed = failed = 0 # pass, fail
        double = null
        for job in @jobs
          switch ªtype job
            when ªF # a mock-modifier
              double = job(double)
            when ªS # a '- - -' rule, or a page or section heading
              md.push job
            when ªA # assertion in the form `[ runner, name, expect, actual ]`
              [ runner, name, expect, actual ] = job # dereference
              result = runner(expect, actual, double) # run the test
              if ! result
                md.push "\u2713 #{name}  " # Unicode CHECK MARK
                passed++
              else
                md.push "\u2718 #{name}  " # Unicode HEAVY BALLOT X
                md.push "    #{result}  "
                failed++

Generate a summary message. 

          summary = if failed
            "  FAILED #{failed}/#{passed + failed} \u2718"
          else
            "  passed #{passed}/#{passed + failed} \u2714"

Return the result as a string. 

        md.unshift @header + summary
        md.push    @footer + summary
        md.join '\n'




#### `page()`
Add a page heading. 

      page: (text) ->
        @jobs.push "\n\n#{text}\n=" + ( new Array(text.length).join '=' )




#### `section()`
Add a section heading. 

      section: (text) ->
        @jobs.push "\n\n#{text}\n-" + ( new Array(text.length).join '-' ) + '\n'




#### `fail()`
Format a typical fail message. 

      fail: (result, delivery, expect, types) ->
        if types
          result = "#{invisibles result} (#{ªtype result})"
          expect = "#{invisibles expect} (#{ªtype expect})"
        "#{invisibles result}\n    ...was #{delivery}, but expected...\n    #{invisibles expect}"




#### `invisibles()`
Convert to string, and reveal invisible characters. @todo not just space

      invisibles = (value) ->
        value?.toString().replace /^\s+|\s+$/g, (match) ->
          '\u00b7' + (new Array match.length).join '\u00b7'




#### `custom()`
Schedule a list of assertions which all use a single assertion-runner. 

      custom: (al, runner) ->
        i = 0
        while i < al.length
          if ªF == ªtype al[i] # the assert-list element is a mock-modifier...
            @jobs.push al[i]
          else # ...or is the first of three elements which define an assertion
            @jobs.push [
              runner  # <function>  runner  Function to run the assertion
              al[i]   # <string>    name    Short description of the assertion
              al[++i] # <mixed>     expect  Defines a successful assertion
              al[++i] # <function>  actual  Produces the result to assertion
            ]
          i++
        @jobs.push '- - -' # http://goo.gl/TWH3W3




#### `throws()`
An assertion-runner which expects `actual()` to throw an exception. 

      throws: (al) ->
        @custom al, (expect, actual, double) =>
          error = false
          try actual(double) catch e then error = e.message
          if ! error
            "No exception thrown, expected...\n    #{expect}"
          else if expect != error
            @fail error, 'thrown', expect




#### `equal()`
An assertion-runner which expects `actual()` and `expect` to be equal. 

      equal: (al) ->
        @custom al, (expect, actual, double) =>
          error = false
          try result = actual(double) catch e then error = e.message
          if error
            "Unexpected exception...\n    #{error}"
          else if expect != result
            @fail result, 'returned', expect, (result + '' == expect + '')




#### `is()`
An assertion-runner which expects `ªtype( actual() )` and `expect` to be equal. 

      is: (al) ->
        @custom al, (expect, actual, double) =>
          error = false
          try result = actual(double) catch e then error = e.message
          if error
            "Unexpected exception...\n    #{error}"
          else if expect != ªtype result
            @fail "type #{ªtype result}", 'returned', "type #{expect}"




Instantiate the `tudor` object
------------------------------

Create an instance of `Tudor`, to add assertions to. 

    tudor = new Tudor
      format: if ªO == typeof window then 'html' else 'plain'


Expose `todor`’s `do()` function as a module method, so that any consumer of 
this module can run its assertions. In Node, for example:  
`require('foo').runTest();`

    Main.runTest = tudor.do




