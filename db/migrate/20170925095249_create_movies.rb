class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :name
      t.integer :episodes
      t.string :status
      t.text :summary
      t.string :poster
      t.float :point, default: 0

      t.timestamps
    end
  end
end
