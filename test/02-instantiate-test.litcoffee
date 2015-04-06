Set up `tudor`
==============

Create an instance of `Tudor`, to add tests to. 

    tudor = new Tudor
      format: if O == typeof window then 'html' else 'plain'


Allow the `Tudor` instance’s `do()` method to be called by `Apage.runTest()`. 

    Main.runTest = tudor.do




