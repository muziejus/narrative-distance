require_relative '../narrative-distance'

RSpec.describe Chunk do

  let(:chunk) { Chunk.new("sample.txt") }

  describe '#initialize' do
    context "when a chunk (sample.txt) is passed" do
      it "gets initialized" do
        expect(chunk.class).to be Chunk
      end
      it "ensures that sample.txt exists" do
        expect(File.exists? "sample.txt").to eq true
      end
      it "assigns @text" do
        expect(chunk.instance_variable_get(:@text)).to_not be_nil
      end
      it "assigns @observations, a Hash" do
        expect(chunk.instance_variable_get(:@observations).class).to eq Hash
      end
      it "assigns @text_array, an Array" do
        expect(chunk.instance_variable_get(:@text_array).class).to eq Array
      end
    end
    context "when there is no chunk passed" do
      it "errors out" do
        expect { Chunk.new }.to raise_error ArgumentError
      end
    end
  end

  describe '#raw' do
    it "returns the bare text" do
      expect(chunk.raw).to eq File.read("sample.txt")
    end
  end

  describe '#array' do
    it "returns the @text_array array" do
      expect(chunk.array.class).to eq Array
    end
  end

  describe '#process' do

    context "when there are Tokens" do
      before (:all) do
        # This is really fixtury...
        create :token
        create :token1
      end
      it "relies on Tokens" do
        expect(Token.all.length).to be > 0
      end
      it "looks for instances of a token (@observations) in the text" do
        chunk.process
        expect(chunk.instance_variable_get(:@observations).length).to be > 0
      end
    end
      
    context "when there are no Tokens" do
      it "errors out" # do
        # Token.destroy
        # expect { chunk.process }.to raise_error Chunk::Error::NoTokens
      # end
    end
  end

  describe '#calculate_averages' do
    pending
  end

  describe '#dump_csv' do
    pending
  end
end

RSpec.describe Token do
  it { should have_property :string }
  it { should validate_presence_of :string }
  it { should have_many :edges }
  it { should have_many :average_edges }
end
 
RSpec.describe Edge do
  it { should belong_to :token }
 end
 
RSpec.describe AverageEdge do
  it { should belong_to :token }
end

FactoryGirl.define do
  factory :token do
    string "Madrid"
  end

  factory :token1, class: Token do
    string "Bozeman"
  end
end

