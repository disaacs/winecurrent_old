class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :wine_id
      t.string :reviewer
      t.decimal :score, :precision => 2, :scale => 1
      t.text :review

      t.timestamps
    end
  end
end
