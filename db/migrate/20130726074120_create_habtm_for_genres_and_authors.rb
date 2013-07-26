class CreateHabtmForGenresAndAuthors < ActiveRecord::Migration
  def up
    create_table :authors_genres, :id => false do |t|
      t.integer :author_id
      t.integer :genre_id
    end

    add_index :authors_genres, [:author_id, :genre_id]
  end

  def down
    drop_table :authors_genres
  end
end
