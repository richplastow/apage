11 App Helpers, Errors and Usag: `parseFilename()`
===================================================

Use of the private static function `parseFilename()`. 


    tudor.page    "11 App Helpers, Errors and Usage: `parseFilename()`"

    tudor.section "Basic checks and errors"

    tudor.is [

      "`parseFilename()` is a function"
      ªF
      -> parseFilename

    ]

    tudor.throws [

      "Called with no arguments"
      '`nm` is undefined, not string'
      -> parseFilename()

      "Called with wrong `fn` type"
      '`nm` is number, not string'
      -> parseFilename 1

      "Called with unrecognised `part` string"
      "`part` not recognised, use 'order|title|slug|ext'"
      -> parseFilename 'abc', 123

    ]

    tudor.section "Typical 'order' usage"

    tudor.equal [

      "Get the order from a typical filename"
      3
      -> parseFilename '03-The Third.txt', 'order'

      "Fractional orders are not allowed"
      3
      -> parseFilename '3.1-Only whole numbers allowed.txt', 'order'

      "The order must only contain digits"
      '3b-must-all-be-digits'
      -> parseFilename '3b-Must all be digits.md.txt', 'order'

    ]

    tudor.section "Typical 'title' usage"

    tudor.equal [

      "Get the title from a typical filename"
      'The Third'
      -> parseFilename '03-The Third.txt', 'title'

      "Fractional orders are not allowed"
      '3'
      -> parseFilename '3.1-Only whole numbers allowed.txt', 'title'

      "The order must only contain digits"
      '3b-Must all be digits'
      -> parseFilename '3b-Must all be digits.md.txt', 'title'

    ]

    tudor.section "Typical 'slug' usage"

    tudor.equal [

      "Get the slug from a typical filename"
      'the-third'
      -> parseFilename '03-The Third.txt', 'slug'

      "Fractional orders are not allowed"
      '3'
      -> parseFilename '3.1-Only whole numbers allowed.txt', 'slug'

      "The order must only contain digits"
      '3b-must-all-be-digits'
      -> parseFilename '3b-Must all be digits.md.txt', 'slug'

    ]

    tudor.section "Typical 'ext' usage"

    tudor.equal [

      "Get the ext from a typical filename"
      'txt'
      -> parseFilename '03-The Third.txt', 'ext'

      "Fractional orders are not allowed"
      '1-Only whole numbers allowed.txt'
      -> parseFilename '3.1-Only whole numbers allowed.txt', 'ext'

      "The order must only contain digits"
      'md.txt'
      -> parseFilename '3b-Must all be digits.md.txt', 'ext'

    ]

    tudor.section "Typical usage with no 'part' argument"

    tudor.equal [

      "Get the order from a typical filename"
      3
      -> (parseFilename '03-The Third.txt').order

      "Fractional orders are not allowed"
      '3'
      -> (parseFilename '3.1-Only whole numbers allowed.txt').slug

      "The order must only contain digits"
      'md.txt'
      -> (parseFilename '3b-Must all be digits.md.txt').ext

    ]

    tudor.section "Edge case orders"

    tudor.equal [

      "Filename is all digits"
      123456
      -> parseFilename '123456.txt', 'order'

    ]

    tudor.section "Advanced slugification"

    tudor.equal [

      "Leading, trailing, and multiple whitespace is removed"
      'spaces-and-tabs-before-and-after'
      -> parseFilename ' \t spaces  and tabs   before and after  \t ', 'slug'

      "Some punctuation is removed"
      'its-too-punctuated'
      -> parseFilename '“It’s too, ‘punctuated’”. It’s kept here!', 'slug'

      "Some punctuation marks are converted to hyphens"
      'em-en-etc'
      -> parseFilename 'em —, en – … etc.', 'slug'

      "Some accents are removed"
      'cafe-cafe'
      -> parseFilename 'CAFÉ, café', 'slug'

    ]

