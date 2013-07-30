class CreateWines < ActiveRecord::Migration
  def change
    create_table :wines do |t|
      t.string :name
      t.string :varietal
      t.string :tags
      t.string :vintage
      t.string :producer
      t.string :origin
      t.string :appellation
      t.decimal :alcohol, :precision => 4, :scale => 2
      t.string :lcbo
      t.decimal :price, :precision => 7, :scale => 2
      t.string :image_thumb_url
      t.string :availability
      t.string :size_in_ml

      t.timestamps
    end
  end
end

