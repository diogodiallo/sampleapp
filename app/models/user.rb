# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  nom        :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  #attr_accessible :nom, :email, :password, :password_confirmation

#Definition d'une regex (expression regulière) pour les adresses email
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

#Teste des validation des champs (champs non nuls, )
  validates :nom, :presence => true,
                  :length   => { :maximum => 50 }
                  
  validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
                    
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => 6..40 }
                       
                       
  before_save :encrypt_password
  
  
  #LES METHODES CALLBACK
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  
  private
  #Cryptage du mot de passe avec salage (ajout de sel. cf make_salt)
  
    def encrypt_password
        self.salt = make_salt if new record?
        self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
        secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
        secure_hash("#{salt}--#{password}")
    end
    
    def secure_hash(string)
       Digest::SHA2.hexdigest(string)
    end
    
    
    def self.authenticate(email, submitted_password)
        user = find_by_email(email)
        return nil if user.nil?
        return user if user.has_password?(submitted_password)
        
        # equivaut à : user && user.has_password?(submitted_password) ? user : nil
    end
  
end