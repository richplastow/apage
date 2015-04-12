`apage.append()` Errors
=======================

Use of the `Apage` class’s `append()` method which leads to an exception. 


    tudor.page    "`apage.append()` Errors"

    tudor.section "Invalid `article` argument"

    tudor.throws [

      "`config` is a number"
      "Invalid `config`:\n  `candidate` is type 'number' not 'object'"
      (mock) -> mock.append 456

      #@todo an invalid object should not be appended to `_articles`

    ]

    tudor.section "Invalid `path` field"

    tudor.throws [

      "`path` is not set"
      "Invalid `config`:\n  Missing field 'path' is mandatory"
      (mock) -> mock.append { }

      "`path` is a boolean"
      "Invalid `config`:\n  Field 'path' is type 'boolean' not 'string'"
      (mock) -> mock.append { path:true }

      "`path` is an empty string"
      "Invalid `config`:\n  Field 'path' fails /^[-.\\/a-zA-Z0-9]{1,64}$/"
      (mock) -> mock.append { path:'' }

      "`path` is too long"
      "Invalid `config`:\n  Field 'path' fails /^[-.\\/a-zA-Z0-9]{1,64}$/"
      (mock) -> mock.append { path:(new Array 66).join '-' } # 65 hyphens

      "`path` contains an invalid character"
      "Invalid `config`:\n  Field 'path' fails /^[-.\\/a-zA-Z0-9]{1,64}$/"
      (mock) -> mock.append { path:'a\\b' }

      #@todo duplicate path not allowed

    ]

    tudor.section "Invalid `raw` field"

    tudor.throws [

      "`raw` is an object"
      "Invalid `config`:\n  Field 'raw' is type 'object' not 'string'"
      (mock) -> mock.append { path:'a', raw:{} }

      "`raw` is too long"
      "Invalid `config`:\n  Field 'raw' fails /^[^\\x00-\\x08\\x0E-\\x1F]{0,10000}$/"
      (mock) -> mock.append { path:'c', raw:(new Array 10002).join '-' } # 10001

      "`raw` contains an invalid character"
      "Invalid `config`:\n  Field 'raw' fails /^[^\\x00-\\x08\\x0E-\\x1F]{0,10000}$/"
      (mock) -> mock.append { path:'d', raw:'x\bz' }

    ]
