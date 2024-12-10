class Video < ApplicationRecord
    has_one_attached :cover
    has_one :content, as: :contentable, autosave: true, dependent: :destroy
    accepts_nested_attributes_for :content
    delegate :title, :description, to: :content
end
