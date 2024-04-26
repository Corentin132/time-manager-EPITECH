[
  import_deps: [:ecto, :phoenix],
  inputs: ["*.{ex,exs}", "priv/*/seeds.exs", "{config,lib,test}/**/*.{ex,exs}"],
  subdirectories: ["priv/*/migrations"],
  exclude: [
    "dev.exs",
    "_build",
    "deps",
    "priv/static",
    "priv/*/static",
    "tmp",
    "node_modules",
    "assets/node_modules"
  ]
]
