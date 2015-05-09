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

      constructor: (@opt={}) ->
        switch @opt.format
          when 'html'
            @header = (summary) -> """
              <style>
                 b.pass   { color: #393 }
                 b.fail   { color: #933 }
                 div      { padding: .5em; }
                 div.fn   { background-color: #ccc }
                 div.pass { background-color: #cfc }
                 div.fail { background-color: #fcc }
              </style>
              <a href="#end" id="top">\u2b07</a>  #{summary}
              """
            @footer = (summary) -> """
              \n<a href="#top" id="end">\u2b06</a>  #{summary}
              <script>
                document.title='#{summary.replace /<\/?[^>]+>/g,''}';
              </script>
              """
            @tick   = '<b class="pass">\u2713</b>' # Unicode CHECK MARK
            @cross  = '<b class="fail">\u2718</b>' # Unicode HEAVY BALLOT X
          else
            @header = (summary) ->   "\u2b07  #{summary}"
            @footer = (summary) -> "\n\u2b06  #{summary}"
            @tick   =   '\u2713' # Unicode CHECK MARK
            @cross  =   '\u2718' # Unicode HEAVY BALLOT X




Define public methods
---------------------

#### `do()`
Run the test and return the result. 

      do: =>
        md = [] # initialize markdown lines
        passed = failed = 0
        mock = null
        for job in @jobs
          switch ªtype job
            when ªF # a mock-modifier
              try mock = job mock catch e then error = e.message
              if error then md.push @formatMockModifierError job, error
            when ªS # a '- - -' rule, or a page or section heading
              md.push @sanitize job
            when ªA # assertion in the form `[ runner, name, expect, actual ]`
              [ runner, name, expect, actual ] = job # dereference
              result = runner(expect, actual, mock) # run the test
              if ! result
                md.push "#{@tick} #{@sanitize name}  "
                passed++
              else
                md.push "#{@cross} #{@sanitize name}  "
                md.push result
                failed++

Generate a summary message. 

          summary = if failed
            "FAILED #{failed}/#{passed + failed} #{@cross}"
          else
            "Passed #{passed}/#{passed + failed} #{@tick}"

Return the result as a string, with summary at the start and end. 

        md.unshift @header summary
        md.push    @footer summary
        md.join '\n'




#### `page()`
Add a page heading. 

      page: (text) ->
        @jobs.push "\n\n#{text}\n=" + ( new Array(text.length).join '=' )




#### `section()`
Add a section heading. 

      section: (text) ->
        @jobs.push "\n\n#{text}\n-" + ( new Array(text.length).join '-' ) + '\n'




#### `formatFail()`
Format a typical fail message. 

      formatFail: (result, delivery, expect, types) ->
        if types
          result = "#{result} (#{ªtype result})"
          expect = "#{expect} (#{ªtype expect})"
        switch @opt.format
          when 'html' then """
            <div class="fail">#{@sanitize @reveal result}</div>
            ...was #{delivery}, but expected...
            <div class="pass">#{@sanitize @reveal expect}</div>
            """
          else """
            #{@sanitize @reveal result}
            ...was #{delivery}, but expected...
            #{@sanitize @reveal expect}
            """




#### `formatException()`
Format an exception message. 

      formatException: (intro, error) ->
        switch @opt.format
          when 'html' then """
            #{intro}
            <div class="fail">#{@sanitize error.message}</div>
            """
          else """
            #{intro}
            #{@sanitize error.message}
            """




#### `formatMockModifierError()`
Format an exception message encountered by a mock-modifier function. 

      formatMockModifierError: (fn, error) ->
        switch @opt.format
          when 'html' then """
            <div class="fn">#{@sanitize fn+''}</div>
            ...encountered an exception:
            <div class="fail">#{@sanitize error}</div>
            """
          else """
            #{@sanitize fn+''}
            ...encountered an exception:
            #{@sanitize error}
            """




#### `reveal()`
Convert to string and reveal invisibles. @todo deal with very long strings, reveal [null] etc, ++more

      reveal: (value) ->
        value?.toString().replace /^\s+|\s+$/g, (match) ->
          '\u00b7' + (new Array match.length).join '\u00b7'




#### `sanitize()`
Escape a string for display, depending on the current `format` option.

      sanitize: (value) ->
        switch @opt.format
          when 'html'
            value?.toString().replace /</g, '&lt;'
          else
            value




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
        @custom al, (expect, actual, mock) =>
          error = false
          try actual mock catch e then error = e
          if ! error
            @formatException 'No exception thrown, expected', expect
          else if expect != error.message
            @formatFail error.message, 'thrown', expect




#### `equal()`
An assertion-runner which expects `actual()` and `expect` to be equal. 

      equal: (al) ->
        @custom al, (expect, actual, mock) =>
          error = false
          try result = actual mock catch e then error = e
          if error
            @formatException 'Unexpected exception', error
          else if expect != result
            @formatFail result, 'returned', expect, (result+'' == expect+'')




#### `is()`
An assertion-runner which expects `ªtype( actual() )` and `expect` to be equal. 

      is: (al) ->
        @custom al, (expect, actual, mock) =>
          error = false
          try result = actual mock catch e then error = e
          if error
            @formatException 'Unexpected exception', error
          else if expect != ªtype result
            @formatFail "type #{ªtype result}", 'returned', "type #{expect}"




Instantiate the `tudor` object
------------------------------

Create an instance of `Tudor`, to add assertions to. 

    tudor = new Tudor
      format: if ªO == typeof window then 'html' else 'plain'


Expose `todor`’s `do()` function as a module method, so that any consumer of 
this module can run its assertions. In Node, for example:  
`require('foo').runTest();`

    Main.runTest = tudor.do




