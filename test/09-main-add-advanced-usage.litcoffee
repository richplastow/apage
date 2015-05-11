Xx. @todo intro

    tudor.add [
      "09 `apage.add()` Advanced Usage"

    


      "Adding articles with non-mandatory config keys"
      -> new Main

      tudor.equal

      
      "`id` can be set explicitly during instantiation"
      '{"id":"apage_xyz","path":"abc.md","order":"abc"}'
      (mock) -> mock.add { path:'abc.md', id:'apage_xyz' }; JSON.stringify mock.read 0

    ]

