`Apage` Constructor Usage
=========================

Typical instantiation of the `Apage` class (called `Main` internally). 


    tudor.page    "`Apage` Constructor Usage"

    tudor.section "No `config` Argument"

    tudor.is [

      "Class is a function"
      F
      -> Main

      -> new Main

      "Instance is an object"
      O
      (mock) -> mock

    ]

    tudor.equal [

      "`toString()` is '[object Apage]'"
      '[object Apage]'
      (mock) -> '' + mock

      "`config` is null"
      '[object Apage]'
      -> '' + new Main null

    ]

    tudor.section "Basic `config`"

    tudor.equal [

      "Set the title"
      '[object Apage]'
      -> '' + new Main { title:'Café' }

    ]




