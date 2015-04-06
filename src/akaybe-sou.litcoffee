Akaybe Simple Object Utilities
==============================

#### A collection of functions which operate on simple objects. 
A ‘simple object’ is defined as a standard JavaScript object created using the 
`{}` syntax, whose values are any of the following `<sotype>` types: 

- `boolean`
- `number`
- `string`
- `undefined`
- `null`

Since simple objects cannot contain arrays or objects, the `sou` functions are 
much easier to use and understand. 




#### `populate()`
Checks whether a candidate’s keys and values conform to a given set of rules. 
If `candidate` breaks any rules, `populate()` returns an array of error 
messages, one for each broken rule. Otherwise, it populates `subject` with new 
values and returns `undefined`. 

    ª.populate = (candidate, subject, rules, updating) ->

      if O != ª.type candidate
        return ["`candidate` is type '#{ª.type candidate}' not 'object'"]

Every `rule` must contain four elements:

- `key  <string>` Specifies the key to be tested
- `use  <sotype>` `undefined` for mandatory keys, else the default value to use
- `type <string>` The expected result when `type()` is called on the value
- `test <object>` An object with `test()` and `toString()` methods, eg a regexp

Enforce each `rule` in the `rules` array. 

      errors = []
      for rule in rules

Destructure the rule, and get the canditate’s value (if present). 

        [key,use,type,test] = rule
        value = candidate[key]

Deal with a missing value. This can be safely ignored if `rule` supplies a 
default, or if `populate()` has been called in `updating` mode. @todo test `updating` mode

        if undefined == value
          if updating or undefined != use then continue # not an error
          else errors.push "Missing key '#{key}' is mandatory"

Make sure that the value is of expected `type`, and passes the `test`. 

        else if type != ª.type value
          errors.push "Key '#{key}' is type '#{ª.type value}' not '#{type}'"
        else if ! test.test value
          errors.push "Key '#{key}' fails #{'' + test}"

Return an array of error messages for an invalid `candidate`. 

      if errors.length then return errors

Record the candidate’s values in the subject. 

      for rule in rules
        [key,use,type,test] = rule
        value = candidate[key]

Deal with a missing value. Otherwise record the candidate’s value. @todo thoroughly test this logic

        if undefined == value
          if undefined == subject[key] then subject[key] = use
        else
          subject[key] = value

Return `undefined`, to signify no errors were encountered. 

      return




#### `clone()`
Uses an array of rules (see `populate()` above) to efficiently clone `subject`. 

    ª.clone = (subject, rules) ->
      out = {}
      for rule in rules
        key = rule[0]
        out[key] = subject[key]
      out




