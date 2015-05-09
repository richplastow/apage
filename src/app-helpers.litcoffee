App Helpers
===========

#### Static private pure functions, accessible from anywhere within the app

These functions are visible to all code defined in ‘src/’ and ‘test/’, but are 
hidden from code defined elsewhere. They are characterized as follows: 

- They return the same output for a given set of arguments
- They have no side-effects, other than logging
- They run identically in all modern environments (browser, server, desktop, …)
- They are short, typically less than 50 lines each




#### `parseFilename()`
Pulls useful parts from a filename or directory name. 
- `'order'` The digits which prefix the `'title'` (defaults to `'slug'`)
- `'title'` The main text of the filename (error if not present)
- `'slug'` The `'title'`, slugified
- `'ext'` Everything following the first dot (empty string if no dots exist)

    parseFilename = (nm, part) ->

Deal with an invalid `nm`, and initialise the `parts` object. 

      if ªS != ªtype nm then throw new Error "`nm` is #{ªtype nm}, not string"
      parts = {}

Get positions of the first dash and dot characters. Add a null ext, if missing. 

      dash = nm.indexOf '-'
      dot  = nm.indexOf '.'
      if -1 == dot then nm += '.'; dot = nm.length - 1

Get the order, or else set `dash` so that `title` will begin at `nm`s start. 

      if -1 != dash and dash < dot# then nm = '0-' + nm; dash = 1; dot += 2
        parts.order = nm.substr(0, dash) * 1
        if isNaN parts.order then dash = -1
      else
        dash = -1

Get the title and extension. 

      parts.title = nm.substr dash + 1, dot - dash - 1
      parts.ext   = nm.substr dot + 1

Get the slug. 

      parts.slug = parts.title.toLowerCase()
       .replace /[“”‘’,]/g , ''    # remove some punctuation @todo more
       .replace /[\s–—…·:;]/g, '-' # convert some punctuation to hyphens @todo more
       .replace /^-+|-+$/g , ''    # trim leading and trailing hyphens
       .replace /-+/g, '-'         # collapse multiple hyphens
       .replace /[àáäâèéëêìíïîòóöôùúüûñç]/g, (c) -> # decompose accents @todo more
          ªex c, 'àáäâèéëêìíïîòóöôùúüûñç', 'aaaaeeeeiiiioooouuuunc'

Use the slug for ordering, if no valid `order` digits are present. 

      if isNaN parts.order then parts.order = parts.slug * 1
      if isNaN parts.order then parts.order = parts.slug

Return all the parts, or just one. 

      if ! part                  then return parts
      if ªU != ªtype parts[part] then return parts[part]
      throw new Error "`part` not recognised, use 'order|title|slug|ext'"




