require 'rails_helper'

# Classification: Randomness
# Success Rate: 80%
# Suite Required: false
RSpec.describe Post, type: :model do
  describe "post ordered" do
    it "expect many order posts to be in alphabetical order" do
      alphabet = ('a'..'z').to_a
      alphabet.each { |el| Post.create!(title: Faker::String.random(2), body: el) }
      expect(Post.ordered.map(&:body)).to eq(alphabet)
    end
  end
end
