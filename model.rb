require 'data_mapper'

DataMapper.setup(:default, 'sqlite:///users/moacir/Projects/narrative-distance/db.db')

class Token
  include DataMapper::Resource

  property :id, Serial
  property :string, String
end

class Edge
  include DataMapper::Resource

  property :id, Serial
  property :token_1, Integer
  property :token_2, Integer
  property :distance, Integer
end

class AverageEdge
  include DataMapper::Resource

  property :id, Serial
  property :token_1, Integer
  property :token_2, Integer
  property :average_distance, Float
end


# DataMapper.finalize # sets up the models for first time use.
DataMapper.auto_migrate!

