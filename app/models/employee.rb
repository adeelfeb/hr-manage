class Employee < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :city, presence: true
  validates :address, presence: true
  validates :phone, presence: true
end


def name
  "#{first_name} #{last_name}"
end
