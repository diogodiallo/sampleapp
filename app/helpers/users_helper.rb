module UsersHelper
  
  def gravatar_for(user, options = { :size => 50 })
    gravatar_image_tag(user.email.downcase, :alt => user.nom,
                                            :class => "gravatar",
                                            :options => options
                      )
  end
  
end
