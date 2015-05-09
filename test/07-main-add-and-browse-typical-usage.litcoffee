07 `apage.add()` and `apage.browse()` Typical Usage
===================================================

    tudor.page "07 `apage.add()` and `apage.browse()` Typical Usage"

    tudor.section "Basic checks and usage, with zero articles"

    tudor.is [

      -> new Main

      "`add()` is a function"
      ªF
      (mock) -> mock.add

      "`add()` returns an object"
      ªO
      (mock) -> mock.add()

      "`browse()` is a function"
      ªF
      (mock) -> mock.browse

      "`browse()` returns an array"
      ªA
      (mock) -> mock.browse()

      "Returned `browse()` array is not a shared reference"
      ªU
      (mock) -> a = mock.browse(); a.foo = 1; mock.browse().foo

    ]

    tudor.equal [

      "Returned `add()` object is the instance itself"
      true
      (mock) -> mock.add() == mock

      "Returned `browse()` array is initially empty"
      0
      (mock) -> mock.browse().length

    ]

    tudor.section "Appending some articles"

    tudor.equal [


      "A very minimal article with numeric name"
      """
      <article id="apage_123"
              class="apage"
        data-apage-opath="/123.md"
        data-apage-dname="_"
        data-apage-order="123"
        data-apage-front='[]'
        data-apage-title="">
        
        </article><!-- / #apage_123 -->
      """
      (mock) -> mock.add({ path:'123.md' }).render().substr 329, 206


      "`browse().length` after adding one article"
      1
      (mock) -> mock.browse().length

      "Use `browse()` to get article ‘apage_123’s id"
      'apage_123'
      (mock) -> mock.browse()[0].id

      "Use `browse()` to get article ‘apage_123’s order"
      123
      (mock) -> mock.browse()[0].order

      "A `browse()` element is not a shared reference"
      undefined
      (mock) -> o = mock.browse()[0]; o.foo = 1; mock.browse()[0].foo


      "A fairly minimal article with an ordered name"
      """
      <article id="apage_a_b"
              class="apage"
        data-apage-opath="/A/5-b.c.MaRkDoWn"
        data-apage-dname="_A_"
        data-apage-order="5"
        data-apage-front='[["foo","bar"]]'
        data-apage-title="Ok">
        <h1>Ok</h1>
        <p>Lorem.</p>
        
        </article><!-- / #apage_a_b -->
      """
      (mock) ->
        mock.add(
          path: 'A/5-b.c.MaRkDoWn'
          raw:  '---\nfoo:bar\n---\nOk\n==\nLorem.'
        ).render().substr 329, 261

      "Use `browse()` to get article ‘apage_a_b’s id"
      'apage_a_b'
      (mock) -> mock.browse()[0].id

      "Use `browse()` to get article ‘apage_a_b’s order"
      5
      (mock) -> mock.browse()[0].order


      "An article which uses frontmatter to override defaults"
      """
      <article id="apage_foo"
              class="apage"
        data-apage-opath="/7-foo.txt"
        data-apage-dname="_"
        data-apage-order="2"
        data-apage-front='[["My  Custom","Field  : Here"]]'
        data-apage-title="Foo">
        <p>Not the title</p>
        
        </article><!-- / #apage_foo -->
      """
      (mock) ->
        mock.add(
          path: '7-foo.txt'
          raw: """
          ---
            id : apage_foo 
             title:Foo   
          order:02.2
               My  Custom  :  Field  : Here   
          ---
          Not the title
          """
        ).render().substr 329, 263

      "Use `browse()` to get article ‘apage_foo’s id"
      'apage_foo'
      (mock) -> mock.browse()[0].id

      "Use `browse()` to get article ‘apage_foo’s order"
      2
      (mock) -> mock.browse()[0].order


      "`browse()` orders after adding three articles"
      '2 5 123 undefined'
      (mock) -> browse = mock.browse(); "#{browse[0].order} #{browse[1].order} #{browse[2].order} #{browse[3]}"


      "Ordering falls back to `id`, when `order` is duplicate"
      """
      "id": "apage_2",
      "order": 2
      "id": "apage_e",
      "order": 2
      "id": "apage_foo",
      "order": 2
      "id": "apage_g",
      "order": 2
      "id": "apage_h",
      "order": 2
      "id": "apage_a_b",
      "order": 5
      "id": "apage_123",
      "order": 123
      """
      (mock) ->
        JSON.stringify(mock
         .add({ path:'2-h.md' }) # duplicate order
         .add({ path:'2-e.md' })
         .add({ path:'2.md'   })
         .add({ path:'2-G.md' })
         .browse()
         ,null ,2 # pretty format JSON
        ).replace /\s \},\n  \{\n|    /g, '' # more succinct
         .slice 6, -6

    ]

