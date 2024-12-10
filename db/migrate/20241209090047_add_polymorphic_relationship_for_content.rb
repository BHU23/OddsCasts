class AddPolymorphicRelationshipForContent < ActiveRecord::Migration[8.0]
  def change
    add_reference :contents, :contentable, polymorphic: true
  end
end
