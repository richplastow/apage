Xx. @todo intro

    tudor.add [
      "08 `apage.read()`, `edit()` and `destroy()` Usage"




      "Basic checks"
      -> new Main


      tudor.is

      "`read()` is a function"
      ªF
      (mock) -> mock.read

      "`edit()` is a function"
      ªF
      (mock) -> mock.edit

      "`destroy()` is a function"
      ªF
      (mock) -> mock.destroy




      "Basic exceptions, with no articles"
      -> new Main


      tudor.throw

      "`read()` without an argument"
      "`identifier` is `undefined`"
      (mock) -> mock.read()

      "`edit()` without any arguments"
      "`identifier` is `undefined`"
      (mock) -> mock.edit()

      "`destroy()` without an argument"
      "`identifier` is `undefined`"
      (mock) -> mock.destroy()


      "`read()` with an invalid identifier"
      "`identifier` is type 'boolean'"
      (mock) -> mock.read true

      "`edit()` with an invalid identifier"
      "`identifier` is type 'array'"
      (mock) -> mock.edit []

      "`destroy()` with an invalid identifier"
      "`identifier` is type 'function'"
      (mock) -> mock.destroy -> 123


      "`read()` with a non-existant numeric identifier"
      "`0` does not exist"
      (mock) -> mock.read 0

      "`edit()` with a non-existant numeric identifier"
      "`918` does not exist"
      (mock) -> mock.edit 918

      "`destroy()` with a non-existant numeric identifier"
      "`44.12` does not exist"
      (mock) -> mock.destroy 44.12


      "`read()` with a non-existant string identifier"
      "'' does not exist"
      (mock) -> mock.read ''

      "`edit()` with a non-existant string identifier"
      "'abc' does not exist"
      (mock) -> mock.edit 'abc'

      "`destroy()` with a non-existant string identifier"
      "'3' does not exist"
      (mock) -> mock.destroy '3'




      "Basic usage"

      tudor.equal

      (mock) -> mock.add { path:'foo.txt' }; mock 

      "Can retrieve using `read()`"
      '{"id":"apage_foo","path":"foo.txt","order":"foo"}'
      (mock) -> JSON.stringify mock.read 0

      "The retrieved object is a clone, not a reference"
      '{"id":"apage_foo","path":"foo.txt","order":"foo"}'
      (mock) -> art = mock.read 0; art.order = 123; JSON.stringify mock.read 0

      "Can change properties using `edit()`"
      'new-order'
      (mock) -> mock.edit 0, { order:'new-order' }; (mock.read 0).order


      tudor.throw

      "`edit()` cannot change properties to invalid values"
      "Invalid `amend`:\n  Field 'id' is type 'null' not 'string'"
      (mock) -> mock.edit 0, { order:'another', id:null }

      "Multiple `edit()` errors are reported"
      """
      Invalid `amend`:
        Field 'id' is type 'null' not 'string'
        Field 'order' is type 'number' not 'string'
      """
      (mock) -> mock.edit 0, { order:-1, id:null }


      tudor.equal

      "`edit()` is atomic, so the previous calls did not change `order`"
      'new-order'
      (mock) -> (mock.read 0).order

      "Can delete using `destroy()`"
      0
      (mock) -> (mock.destroy 0).browse().length

    ]


