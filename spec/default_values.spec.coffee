{ fun } = require '@ch1c0t/fun'

describe 'main', ->
  beforeAll ->
    @Server = fun
      init:
        path: -> @value or "some/path"
        port: -> @value or 8080
      call: ->
        "#{@path} #{@port}"

  it 'works when all the arguments were passed', ->
    server = @Server path: 'another/path', port: 8081
    string = server()

    expect(string).toBe 'another/path 8081'

  it 'works when some of the arguments were passed', ->
    server = @Server port: 8082
    string = server()

    expect(string).toBe 'some/path 8082'

  it 'works when no arguments were passed', ->
    server = @Server()
    string = server()

    expect(string).toBe 'some/path 8080'
