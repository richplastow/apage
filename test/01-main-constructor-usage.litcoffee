Typical instantiation of the `Apage` class (called `Main` internally). 

    tudor.add [
      "01 Main Constructor Usage"




      "No `config` Argument"
      -> new Main


      tudor.is

      "Class is a function"
      ªF
      -> Main

      "Instance is an object"
      ªO
      (mock) -> mock


      tudor.equal

      "`toString()` is '[object Apage]'"
      '[object Apage]'
      (mock) -> '' + mock

      "`config` is null"
      '[object Apage]'
      -> '' + new Main null




      "Basic `config`"


      "Set the title"
      '[object Apage]'
      -> '' + new Main { title:'Café' }


    ]

