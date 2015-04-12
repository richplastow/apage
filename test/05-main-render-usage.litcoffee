`apage.render()` Usage
======================

Typical use of `render()` on the `Apage` class. 


    tudor.page    "`apage.render()` Usage"

    tudor.section "No argument"

    tudor.is [

      -> new Main

      "`render()` is a function"
      ªF
      (mock) -> mock.render

      "Returns a string"
      ªS
      (mock) -> mock.render()

    ]

    tudor.equal [

      "Returned string is expected length"
      2725
      (mock) -> mock.render().length

      "Shorter `title` changes string length"
      2713
      (mock) -> mock.config 'title', 'OK'; mock.render().length

    ]

