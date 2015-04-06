`Apage` Constructor Errors
==========================

Instantiation of the `Apage` class which leads to an exception being thrown. 


    tudor.page    "`Apage` Constructor Errors"

    tudor.section "Invalid `config` Argument"

    tudor.throws [

      "`config` is not an object"
      "Invalid `config`:\n  `candidate` is type 'number' not 'object'"
      -> new Main 1

      "`config` is a `Date` object"
      "Invalid `config`:\n  `candidate` is type 'date' not 'object'"
      -> new Main new Date

      "`config` is a `String` object"
      "Invalid `config`:\n  `candidate` is type 'string' not 'object'"
      -> new Main new String 'yikes!'

    ]

    tudor.section "Invalid `config.title`"

    tudor.throws [

      "A number"
      "Invalid `config`:\n  Key 'title' is type 'number' not 'string'"
      -> new Main { title:0 }

      "An empty string"
      "Invalid `config`:\n  Key 'title' fails /^[^\\x00-\\x1F]{1,24}$/"
      -> new Main { title:'' }

      "25 characters long"
      "Invalid `config`:\n  Key 'title' fails /^[^\\x00-\\x1F]{1,24}$/"
      -> new Main { title:'1234567890123456789012345' }

      "Contains a tab"
      "Invalid `config`:\n  Key 'title' fails /^[^\\x00-\\x1F]{1,24}$/"
      -> new Main { title:'tab character: \t' }

    ]

