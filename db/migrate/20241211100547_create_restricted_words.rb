class CreateRestrictedWords < ActiveRecord::Migration[8.0]
  def change
    create_table :restricted_words do |t|
      t.string :word

      t.timestamps
    end
  end
end
