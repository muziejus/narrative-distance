require 'data_mapper'

DataMapper.setup(:default, 'sqlite:///users/moacir/Projects/narrative-distance/db.db')

class Token
  include DataMapper::Resource

  property :id, Serial
  property :string, String

  validates_presence_of :string

  has n, :edges
  has n, :average_edges
end

class Edge
  include DataMapper::Resource

  property :id, Serial
  property :far_token, Integer
  property :distance, Integer

  belongs_to :token
end

class AverageEdge
  include DataMapper::Resource

  property :id, Serial
  property :far_token, Integer
  property :average_distance, Float

  belongs_to :token
end


# DataMapper.finalize # sets up the models for first time use.
DataMapper.auto_migrate!

