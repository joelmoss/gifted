module AuthorDecorator
  module AdminDecorator
    def name
      "#{super} (admin)"
    end
  end

  def reverse_name
    name.reverse
  end

  def capitalized_name
    name.capitalize
  end
end
