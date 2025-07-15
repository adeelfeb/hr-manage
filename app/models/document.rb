class Document < ApplicationRecord


  DOC_TYPES = ["Domicile", "Sanad", "DMC", "CNIC"].freeze
  
  
  belongs_to :employee

  validates :name, :doc_type, presence: true


end
