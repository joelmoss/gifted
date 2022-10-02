module BookDecorator
  module AdminDecorator
    def truncated_name
      truncate 'joelmoss', length: 6
    end

    def name_from_ivar
      "Name: #{controller.instance_variable_get(:@name)} (admin)"
    end
  end

  def reverse_title
    title.reverse
  end

  def upcased_title
    title.upcase
  end

  def link
    link_to title, "#{request.protocol}#{request.host_with_port}/assets/sample.png", class: 'title'
  end

  def cover_image
    image_tag 'cover.png'
  end

  def name_from_ivar
    "Name: #{controller.instance_variable_get(:@name)}"
  end

  def errata
    poof!
  end

  def errata2
    title.boom!
  end

  def error
    'ERROR'
  end
end
