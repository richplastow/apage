Export Module
=============

#### The `Main` class, ‘class-main.litcoffee’, is the module’s only entry-point

First, try defining an AMD module, eg for [RequireJS](http://requirejs.org/). 

    if F == typeof define and define.amd
      define -> Main

Next, try exporting for CommonJS, eg [Node](http://goo.gl/Lf84YI). 

    else if O == typeof module and module and module.exports
      module.exports = Main

Otherwise, add it to global scope, eg `myApage = new window.Apage()`. 

    else @[I] = Main




