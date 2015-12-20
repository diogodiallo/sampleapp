module ApplicationHelper
  def titre
    base_titre = "Sample app Ruby-on-Rails"
    if @titre.nil?
        base_titre
    else
        "#{base_titre} | #{@titre}"
    end
  end
  
  def logo
    image_tag("logo.png", :alt => "Application exemple", :class => "round", size: "80x70")
  end
end

=begin
#Class décrivant une méthode palindrome (mot qui se lit à l'endroit et à l'envers)
class Mot
  def palindrome?(string)
    return string if string == string.reverse
    return string.shuffle.upcase
  end
end

w = Mot.new
puts w.palindrome?("foobar")
puts w.palindrome?("level")
=end
