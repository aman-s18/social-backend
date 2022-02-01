class User < ApplicationRecord
  has_many :social_accounts, dependent: :destroy
  accepts_nested_attributes_for :social_accounts#, reject_if: :all_blank, allow_destroy: true
  has_many :images, as: :imageable, dependent: :destroy

  def generate_access_token
    self.access_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(access_token: random_token)
    end
    self.username = self.email.split('@')[0].concat("-social-one")
  end

end
