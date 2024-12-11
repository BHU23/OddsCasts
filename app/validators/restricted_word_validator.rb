class RestrictedWordValidator < ActiveModel::Validator
    def validate(record)
        return if record.title.blank?

        RestrictedWord.all.each do |restricted_word|
            regex = /\b#{Regexp.escape(restricted_word.word.downcase)}\b/i
            if record.title.downcase.match?(regex)
            record.errors.add :title, "contains a restricted word: '#{restricted_word.word}'"
            end
        end
    end
end
  