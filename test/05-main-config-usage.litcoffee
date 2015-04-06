`apage.config()` Usage
======================

Typical use of `config()` on the `Apage` class. 


    tudor.page    "`apage.config()` Usage"

    tudor.section "No argument"

    tudor.is [

      -> new Main

      "`config()` is a function"
      F
      (mock) -> mock.config

      "Returns an object"
      O
      (mock) -> mock.config()

    ]

    tudor.equal [

      "Returned object contains expected defaults"
      '{"title":"Untitled"}'
      (mock) -> JSON.stringify mock.config()

      "Returns a new object each time"
      false
      (mock) -> mock.config() == mock.config()

    ]

    tudor.section "Retrieve a config value"

    tudor.equal [

      "Default `title` is 'Untitled'"
      'Untitled'
      (mock) -> mock.config 'title'

      -> new Main { title:'外国語の学習と教授' }

      "After constructing with Japanese `title`"
      '外国語の学習と教授'
      (mock) -> mock.config 'title'

      "Key not recognized"
      undefined
      (mock) -> mock.config 'unrecognized'

    ]

    tudor.section "Set a valid config value"

    tudor.equal [

      "Set a Chinese `title`, two arg syntax, returns `undefined`"
      undefined
      (mock) -> mock.config 'title', '語文教學・语文教学'

      "Check that Chinese `title` has been set"
      '語文教學・语文教学'
      (mock) -> mock.config 'title'

      "Set a Greek `title`, object syntax, returns `undefined`"
      undefined
      (mock) -> mock.config { title: 'Γλωσσική Εκμὰθηση' }

      "Check that Greek `title` has been set"
      'Γλωσσική Εκμὰθηση'
      (mock) -> mock.config 'title'

    ]

    tudor.section "Set an invalid config value"

    tudor.is [

      "Returns an array"
      A
      (mock) -> mock.config 'title', ''

    ]

    tudor.equal [

      "The array has one element"
      1
      (mock) -> (mock.config 'title', '').length

      "The array element is an expected error message"
      "Key 'title' fails /^[^\\x00-\\x1F]{1,24}$/"
      (mock) -> (mock.config 'title', '')[0]

    ]




