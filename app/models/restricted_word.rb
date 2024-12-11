class RestrictedWord < ApplicationRecord
    validates :word, presence: true, uniqueness: true
end
