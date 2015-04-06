Akaybe Helpers
==============

#### `type()`
To detect the difference between 'null', 'array', 'regexp' and 'object' types, 
we use [Angus Croll’s one-liner](http://goo.gl/WlpBEx). This can be used in 
place of JavaScript’s familiar `typeof` operator, with one important exception: 
when the variable being tested does not exist, `typeof foobar` will return 
`undefined`, whereas `ª.type foobar` will throw an error. 

    ª.type = (x) ->
      ({}).toString.call(x).match(/\s([a-z|A-Z]+)/)[1].toLowerCase()




