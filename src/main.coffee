exports.fun = ({ init, once, call, state }) ->
  (input) ->
    state ?= {}

    for key, fn of init
      value = input[key] if input
      context = { value }
      state[key] = fn.call context

    if once
      once.call state

    call.bind state
