class User < ApplicationRecord
  has_many :designers

  def self.from_auth(email)
    user = User.find_by(email: email)
    if user.nil?
      User.create(email: email)
    end
    user
  end

end