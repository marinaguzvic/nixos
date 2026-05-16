vim.g.projectionist_heuristics = {
  ["project.clj"] = {
    ["src/*.clj"] = {
      alternate = "test/{}_test.clj",
      type = "source",
    },
    ["test/*_test.clj"] = {
      alternate = "src/{}.clj",
      type = "test",
    },
  },
  ["deps.edn"] = {
    ["src/*.clj"] = {
      alternate = "test/{}_test.clj",
      type = "source",
    },
    ["test/*_test.clj"] = {
      alternate = "src/{}.clj",
      type = "test",
    },
  },
}

