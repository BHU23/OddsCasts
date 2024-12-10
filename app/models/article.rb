class Article < ApplicationRecord
    has_one_attached :cover
    has_one :content, as: :contentable, autosave: true, dependent: :destroy
    accepts_nested_attributes_for :content
    delegate :title, :description, to: :content
    before_validation :build_content_if_nil poly

    private

    def build_content_if_nil
        self.content ||= build_content
  end
end
