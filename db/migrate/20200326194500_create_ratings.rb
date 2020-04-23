class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.integer :rating_value, null: false
      t.integer :user_id, null: false
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
