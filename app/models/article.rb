require_dependency '../validators/restricted_word_validator'

class Article < ApplicationRecord
    has_one_attached :cover
    has_one :content, as: :contentable, autosave: true, dependent: :destroy
    accepts_nested_attributes_for :content
    delegate :title, :description, to: :content, allow_nil: true
    validates :title, presence: true, length: { minimum: 1, maximum: 50 }
    
    validates_with RestrictedWordValidator
end
