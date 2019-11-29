class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def as_hash
    {
      name: name,
      age: age
    }
  end
end
