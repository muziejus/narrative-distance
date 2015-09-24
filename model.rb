require 'data_mapper'
require 'dm-validations'

DataMapper.setup(:default, 'sqlite:///users/moacir/Projects/narrative-distance/db.db')

class Token
  include DataMapper::Resource

  property :id, Serial
  property :string, String

  has n, :edges
  has n, :average_edges

  validates_presence_of :string
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

