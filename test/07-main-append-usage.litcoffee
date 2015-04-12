`apage.append()` Usage
======================

Typical use of `append()` on the `Apage` class. 


    tudor.page    "`apage.append()` Usage"

    tudor.section "No argument"

    tudor.is [

      -> new Main

      "`append()` is a function"
      ªF
      (mock) -> mock.append

      "Returns an object"
      ªO
      (mock) -> mock.append()

    ]

    tudor.equal [

      "Returned object is the instance itself"
      true
      (mock) -> mock.append() == mock

      "The `path` field is rendered to inline script"
      2670
      (mock) -> mock.append({ path:'abcxyz' }).render().indexOf 'abcxyz'

      "Default `html` field is rendered to inline script"
      2721
      (mock) -> mock.render().indexOf '@todo'

      "`html` field is parsed by markdown"
      2706
      (mock) -> mock.render().indexOf '<h1 id="-todo">@todo</h1>'

    ]
