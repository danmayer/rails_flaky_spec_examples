require 'rails_helper'

RSpec.describe Person, type: :model do

  describe "person created" do
    it "creates expected attributes" do
      person = Person.new('first', 1)
      expected = {name: 'first', age: 1}
      expect({name: 'first', age: 1}).to eq person.as_hash
    end

  end
end
