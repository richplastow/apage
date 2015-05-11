Typical use of `render()` on the `Apage` class. 

    tudor.add [
      "05 `apage.render()` Usage"

    


      "No argument"
      -> new Main


      tudor.is

      "`render()` is a function"
      ªF
      (mock) -> mock.render

      "Returns a string"
      ªS
      (mock) -> mock.render()


      tudor.equal

      "Returned string is expected length"
      468
      (mock) -> mock.render().length

      "Characters up to opening <title> as expected"
      """
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <title>
      """
      (mock) -> mock.render().substr 0, 49

      "Default <title> is 'Untitled'"
      'Untitled'
      (mock) -> mock.render().substr 49, 8

      "Characters from </title> to </html> as expected"
      """
      </title>
        <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
        <meta name="generator" content="Apage #{ªV} http://apage.richplastow.com/">
        <style>
          /* Apage was configured with no plugins, so no CSS is injected here */
        </style>

      </head>
      <body>

        <!-- Apage was rendered with no articles -->

        <!-- Apage was configured with no plugins, so nothing is injected here -->

      </body>
      </html>
      """
      (mock) -> mock.render().substr 57

      "Shorter `title` changes string length"
      462
      (mock) -> mock.config 'title', 'OK'; mock.render().length

    ]
