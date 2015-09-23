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

end
