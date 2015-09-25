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
    @observations = {}
    Edge.destroy
    @text_array.each.with_index(1) do |word, index|
      Token.each do |token|
        @observations[index] = token.id if word =~ /^#{token.string}/
      end
    end
    @observations.each do |place, token|
      @observations.each do |far_place, far_token|
        if token < far_token
          Edge.create token_id: token, far_token: far_token, distance: (far_place - place).abs
        end
      end
    end
  end

  def calculate_averages
    AverageEdge.destroy
    Token.all.each do |token|
      far_tokens = token.edges.map { |e| e.far_token }.uniq
      far_tokens.each do |far_token|
        edges = Edge.all(token_id: token.id) & Edge.all(far_token: far_token)
        distance_array = edges.map{|e| e.distance}
        average = distance_array.inject{ |sum, el| sum + el }.to_f / distance_array.size
        AverageEdge.create(token_id: token.id, far_token: far_token, average_distance: average, count: distance_array.size)
      end
    end
  end

  def dump_csv
    %w(tokens average_distances all_edges).each do |dump|
      File.open("#{dump}.csv", "w") do |file|
        if dump == "average_distances"
          file.puts "edge1, edge1name, edge2, edge2name, average_distance, count"
          AverageEdge.all.each do |average|
            file.puts "#{average.token_id}, #{Token.get(average.token_id).string}, #{average.far_token}, #{Token.get(average.far_token).string}, #{average.average_distance}, #{average.count}"
          end
        elsif dump == "all_edges"
          file.puts "edge1, edge1name, edge2, edge2name, distance"
          Edge.all.each do |edge|
            file.puts "#{edge.token_id}, #{Token.get(edge.token_id).string}, #{edge.far_token}, #{Token.get(edge.far_token).string}, #{edge.distance}"
          end
        else
          file.puts "id, token"
          Token.all.each do |token|
            file.puts "#{token.id}, #{token.string}"
          end
        end
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
