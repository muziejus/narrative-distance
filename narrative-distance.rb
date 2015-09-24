require_relative "model"

class Chunk

  def initialize(text)
    @text = File.read(text)
    @text_array = @text.split(" ")
    @observations = {}
  end

  def raw
    @text
  end

  def array
    @text_array
  end

  def process
    raise Error::NoTokens if Token.all.length == 0
    @text_array.each.with_index(1) do |word, index|
      Token.each do |token|
        @observations[index] = token.id if word =~ /^#{token.string}/
      end
    end
  end

  module Error
    class NoTokens < StandardError
      def message
        "No Tokens defined"
      end
    end
  end

end
