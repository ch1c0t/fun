{ fun } = require '@ch1c0t/fun'

describe 'main', ->
  it 'works', ->
    Some = fun
      init:
        name: -> @
      call: (surname) ->
        "Hello, #{@name} #{surname}."

    greeting = Some name: 'Alice'
    string = greeting 'Bob'

    expect(string).toContain 'Hello, Alice Bob'
