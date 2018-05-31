# Used by "mix format"
[
  inputs: ["mix.exs", "{config,lib,test}/**/*.{ex,exs}"],
  line_length: 140,
  locals_without_parens: [field: :*, belongs_to: :*, from: :*, has_many: :*, resources: :*, get: :*]
]
