Akaybe Core
===========

#### Define core Akaybe constants, and initialize the `akb` object

Akaybe’s constants and functions are visible to all code defined in ‘src/’ and 
‘test/’, but are hidden from code defined elsewhere in the app. The functions 
are characterized as follows: 

- They return the same output for a given set of arguments
- They have no side-effects, other than logging
- They run identically in all modern environments (browser, server, desktop, …)
- Each Akaybe function minifies to 1024 bytes or less




Name, version, licence and homepage
-----------------------------------

Begin with a comment-block which will be preserved after compilation. The ‘!’ 
tells minifiers to preserve this comment. 

    ###! Apage 0.0.2 //// MIT licence //// apage.richplastow.com ////###
    I = 'Apage'
    V = '0.0.2'


    

Constants which help minification
---------------------------------

These strings can make `*.min.js` a little shorter and easier to read, and also 
make the source code less verbose: `O == typeof x` vs `'object' == typeof x`. 

    A = 'array'
    B = 'boolean'
    E = 'error'
    F = 'function'
    N = 'number'
    O = 'object'
    R = 'regexp'
    S = 'string'
    U = 'undefined'
    X = 'null'




Define the Akaybe object
------------------------

#### `ª()`
In JavaScript, functions are actually objects, which means that we can attach 
properties to them. Akaybe uses the `ª` object as a handy shortcut for 
`console.log()`. Note [`bind()`](http://goo.gl/66ffgl). 

    ª = console.log.bind console




