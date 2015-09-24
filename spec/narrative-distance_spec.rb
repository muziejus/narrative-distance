require_relative '../narrative-distance'
require 'factory_girl'

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
      it "relies on Tokens" do
        FactoryGirl.create :token
        FactoryGirl.create :token1
        expect(Token.all.length).to be > 0
      end
    end

    context "when there are no Tokens" do
      it "errors out" do
        Token.destroy
        expect { chunk.process }.to raise_error StandardError
      end
    end
  end

end

RSpec.describe Token do
  # Um, I trust datamapper to work correctly
end

RSpec.describe Edge do
  # Um, I trust datamapper to work correctly
end

RSpec.describe AverageEdge do
  # Um, I trust datamapper to work correctly
end

FactoryGirl.define do
  factory :token do
    string "Madrid"
  end

  factory :token1, class: Token do
    string "Bozeman"
  end
end
