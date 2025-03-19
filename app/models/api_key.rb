class ApiKey < ApplicationRecord
  belongs_to :user

  before_validation :assign_random_token, on: :create

  validates :token, presence: true, uniqueness: true
  validates :name, presence: true

  private

  def assign_random_token
    self.token = SecureRandom.hex
  end

  def self.generate_name
    "#{Time.now.to_fs(:long)} API Key"
  end
end
