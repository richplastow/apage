Instantiation of the `Apage` class which leads to an exception being thrown. 

    tudor.add [
      "02 `Apage` Constructor Errors"




      "Invalid `config` argument"
      -> new Main


      tudor.throw

      "`config` is not an object"
      "Invalid `config`:\n  `candidate` is type 'number' not 'object'"
      -> new Main 1

      "`config` is a `Date` object"
      "Invalid `config`:\n  `candidate` is type 'date' not 'object'"
      -> new Main new Date

      "`config` is a `String` object"
      "Invalid `config`:\n  `candidate` is type 'string' not 'object'"
      -> new Main new String 'yikes!'




      "Invalid `config.title`"


      "A number"
      "Invalid `config`:\n  Field 'title' is type 'number' not 'string'"
      -> new Main { title:0 }

      "An empty string"
      "Invalid `config`:\n  Field 'title' fails /^[^\\x00-\\x1F]{1,24}$/"
      -> new Main { title:'' }

      "25 characters long"
      "Invalid `config`:\n  Field 'title' fails /^[^\\x00-\\x1F]{1,24}$/"
      -> new Main { title:'1234567890123456789012345' }

      "Contains a tab"
      "Invalid `config`:\n  Field 'title' fails /^[^\\x00-\\x1F]{1,24}$/"
      -> new Main { title:'tab character: \t' }

    ]
