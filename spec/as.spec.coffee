{ fun } = require '@ch1c0t/fun'

# A function to value functions as types.
as = (fn) ->
 -> if @value then fn @value else fn()

Server = fun
  init:
    path: -> @value or 'some/path'
    port: -> @value or 8080
  call: (input) ->
    "#{@path}.#{@port}.#{input}"

Env = fun
  init:
    server: as Server
  call: (input) ->
    @server input

describe 'as', ->
  it 'works', ->
    env = Env()
    string = env 'some input'

    expect(string).toBe 'some/path.8080.some input'
