{ fun } = require '@ch1c0t/fun'

describe 'main', ->
  it 'works', ->
    Some = fun
      init:
        name: -> @value
      call: (surname) ->
        "Hello, #{@name} #{surname}."

    greeting = Some name: 'Alice'
    string = greeting 'Bob'

    expect(string).toContain 'Hello, Alice Bob'

  it 'works when no arguments were passed', ->
    Server = fun
      init:
        path: -> @value or "some/path"
        port: -> @value or 8080
      call: ->
        "#{@path} #{@port}"

    server = Server()
    string = server()

    expect(string).toBe 'some/path 8080'
