class SocialAccount < ApplicationRecord
  belongs_to :user
  validates_presence_of :account_url, :account_name
end
