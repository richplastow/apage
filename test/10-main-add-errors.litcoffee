10 `apage.add()` Errors
=======================

Use of the `Apage` class’s `add()` method which leads to an exception. 


    tudor.page    "10 `apage.add()` Errors"

    tudor.section "Invalid `article` argument"

    tudor.throws [

      -> new Main

      "`config` is a number"
      "Invalid `config`:\n  `candidate` is type 'number' not 'object'"
      (mock) -> mock.add 456

    ]

    tudor.equal [

      "Invalid object is not added"
      0
      (mock) -> mock.browse().length

    ]

    tudor.section "Invalid `path` field"

    tudor.throws [

      "`path` is not set"
      "Invalid `config`:\n  Missing field 'path' is mandatory"
      (mock) -> mock.add { }

      "`path` is a boolean"
      "Invalid `config`:\n  Field 'path' is type 'boolean' not 'string'"
      (mock) -> mock.add { path:true }

      "`path` is an empty string"
      "Invalid `config`:\n  Field 'path' fails /^[a-z0-9][-\\/a-z0-9]{0,63}\\.[.a-z0-9]+$/i"
      (mock) -> mock.add { path:'' }

      "`path` is too long"
      "Invalid `config`:\n  Field 'path' fails /^[a-z0-9][-\\/a-z0-9]{0,63}\\.[.a-z0-9]+$/i"
      (mock) -> mock.add { path:(new Array 66).join '-' } # 65 hyphens

      "`path` contains a backslash"
      "Invalid `config`:\n  Field 'path' fails /^[a-z0-9][-\\/a-z0-9]{0,63}\\.[.a-z0-9]+$/i"
      (mock) -> mock.add { path:'a\\b' }

      "`path` contains an underscore"
      "Invalid `config`:\n  Field 'path' fails /^[a-z0-9][-\\/a-z0-9]{0,63}\\.[.a-z0-9]+$/i"
      (mock) -> mock.add { path:'a_b' }

      "`path` begins with a hyphen"
      "Invalid `config`:\n  Field 'path' fails /^[a-z0-9][-\\/a-z0-9]{0,63}\\.[.a-z0-9]+$/i"
      (mock) -> mock.add { path:'-a' }

      "Duplicate `id`, due to identical `path` slugs"
      "'apage_a' already exists"
      (mock) -> mock.add { path:'00-A.txt' }; mock.add { path:'3-a.jpeg' }; 

      #@todo duplicate path not allowed

    ]

    tudor.section "Invalid `raw` field"

    tudor.throws [

      "`raw` is an object"
      "Invalid `config`:\n  Field 'raw' is type 'object' not 'string'"
      (mock) -> mock.add { path:'a.md', raw:{} }

      "`raw` is too long"
      "Invalid `config`:\n  Field 'raw' fails /^[^\\x00-\\x08\\x0E-\\x1F]{0,10000}$/"
      (mock) -> mock.add { path:'b.md', raw:(new Array 10002).join '-' } # 10001

      "`raw` contains an invalid character"
      "Invalid `config`:\n  Field 'raw' fails /^[^\\x00-\\x08\\x0E-\\x1F]{0,10000}$/"
      (mock) -> mock.add { path:'b.md', raw:'x\bz' }

    ]

    tudor.equal [

      "Invalid objects still not added"
      1 # just '00-A.txt', above 
      (mock) -> mock.browse().length

      #(mock) -> console.log mock.render(); mock

    ]
