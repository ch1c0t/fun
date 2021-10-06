{ fun } = require '@ch1c0t/fun'

Server = fun
  init:
    path: -> @value or 'some/path'
    port: -> @value or 8080
  once: ->
    @some = "#{@path} #{@port}"
  call: ->
    @some

describe 'once', ->
  it 'works', ->
    server = Server()
    string = server()

    expect(string).toBe 'some/path 8080'
