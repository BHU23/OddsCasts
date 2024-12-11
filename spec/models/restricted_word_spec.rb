require 'rails_helper'

RSpec.describe RestrictedWord, type: :model do
  describe "validations" do
    it "is valid with a valid word" do
      restricted_word = RestrictedWord.new(word: "Fxxxxx")
      expect(restricted_word).to be_valid
    end

    it "is invalid without a word" do
      restricted_word = RestrictedWord.new(word: nil)
      expect(restricted_word).not_to be_valid
      expect(restricted_word.errors[:word]).to include("can't be blank")
    end

    it "is invalid with a duplicate word" do
      RestrictedWord.create!(word: "Fxxxxx")
      duplicate = RestrictedWord.new(word: "Fxxxxx")
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:word]).to include("has already been taken")
    end
  end
end
