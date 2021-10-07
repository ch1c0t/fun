{ fun } = require '@ch1c0t/fun'

describe 'once', ->
  it 'allows to define some additional properties', ->
    Server = fun
      init:
        path: -> @value or 'some/path'
        port: -> @value or 8080
      once: ->
        @some = "#{@path} #{@port}"
      call: ->
        @some

    server = Server()
    string = server()

    expect(string).toBe 'some/path 8080'

  it 'sets @once', ->
    Server = fun
      init:
        path: -> @value or 'some/path'
        port: -> @value or 8080
      once: ->
        @port + 1
      call: ->
        @once

    server = Server()
    string = server()

    expect(string).toBe 8081
