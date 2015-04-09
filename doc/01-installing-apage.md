Installing Apage
----------------

Old fashioned browser install, providing `window.Apage`: 
```html
<script src="http://apage.richplastow.com/build/apage.js"></script>
<script>console.log( new window.Apage().I ); // -> 'Apage'</script>
```

Install as a [CommonJS Module](http://goo.gl/ZrbaB0), eg for 
[Node](https://nodejs.org/): 
```javascript
var Apage = require('apage');
console.log( new Apage().I ); // -> 'Apage'
```

Install using [RequireJS inline-style](http://goo.gl/mp7Snw), providing `Apage` 
as an argument: 
```html
<script src="lib/require.js"></script>
<script>
  require(['path/to/apage'], function(Apage) {
    console.log( new Apage().I ); // -> 'Apage'
  })
</script>
```

@todo more installation examples, including `$ npm install -g apage`, etc. 




