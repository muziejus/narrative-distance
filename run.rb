require_relative 'narrative-distance'

chunk = Chunk.new("sample.txt")

# This should go in a seeds file.
%w(Andalucia Spain Madrid Bozeman Montana U.S.A.).each do |word|
  Token.create(string: word)
end
