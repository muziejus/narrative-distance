require_relative "model"

class Chunk

  def initialize(text) 
    @text = File.read(text)
    @text_array = @text.split(" ")
  end

  def raw
    @text
  end

  def array
    @text_array
  end

  def process
    raise StandardError if Token.all.length == 0
  end

end
