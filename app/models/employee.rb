class Employee < ApplicationRecord
    validates :name, presence: true
    validates :position, presence: true
    validates :department, presence: true
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
end
