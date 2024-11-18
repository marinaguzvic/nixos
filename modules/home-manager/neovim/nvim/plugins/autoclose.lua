require('autoclose').setup ({
  options = {
    pair_spaces = false,
  },
  keys = {
    ["'"] = { escape = true, close = false, pair = "''" },
  },
})
