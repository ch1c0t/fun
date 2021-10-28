# Introduction

To install: `npm i @ch1c0t/fun`.

`fun` is a function to create functors. A functor is a function that creates functions.

`fun` takes one argument, [an Object `spec`](#spec) which is a functor specification.
It expects that the `spec` will have the following properties:

- required:
  - [init](#init), an Object;
  - [call](#call), a Function;
- optional:
  - [once](#once), a Function;

A usage example:

```coffee
{ fun } = require '@ch1c0t/fun'

Server = fun
  init:
    path: -> @value or 'default/path'
    port: -> @value or 8080
  call: ->
    "#{@path} #{@port}"

server = Server path: 'some/path', port: 8081
string = server()
string
#=> 'some/path 8081'
```

## `spec`

### `init`

is an Object that specifies how a functor processes its argument.

Each own property of `init` must be associated with a function that returns a value.
When a functor gets called, it executes these functions to obtain values
for the internal state of the function that it returns.

Inside of these functions, `@value` refers to what was passed in the argument.
If nothing was passed, it is `undefined`.

### `call`

is the Function that will be [binded][bind] to the internal state and
returned from a functor.

[bind]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_objects/Function/bind

### `once`

is a Function that will be executed in the context of the internal state,
once [the initial values](#init) were set.

The returned value of this function will be set to the `@once` property
of the internal state:

```coffee
sleep = (ms) ->
  new Promise (resolve) ->
    setTimeout resolve, ms

Server = fun
  init:
    path: -> @value or 'default/path'
    port: -> @value or 8080
  once: ->
    await sleep 200
    'from a Promise'
  call: ->
    string = await @once
    "#{string}: #{@path} #{@port}"

server = Server()
string = await server()
string
#=> 'from a Promise: default/path 8080'
```

# Cautionary remarks

`fun` is such a fundamental concept that sometimes I want to have
`global.fun = fun` when I create applications.
I don't do `global.fun` when I create some libraries, however.
