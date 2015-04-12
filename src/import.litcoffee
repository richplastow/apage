Import
======

#### Load this module’s dependencies

First, try importing modules via AMD, eg [RequireJS](http://requirejs.org/). 

    if ªF == typeof define and define.amd
      #@todo

Next, try importing via CommonJS, eg [Node](http://goo.gl/Lf84YI). 

    else if ªO == typeof module and module and module.exports
      marked = require 'marked'

Otherwise, assume we are in the browser, and modules have already been loaded. 

    else
      marked = window.marked




#### Set marked options @todo

    marked.setOptions { }
