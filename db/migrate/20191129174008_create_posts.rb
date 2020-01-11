# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.integer :score
      t.timestamp :expires_at

      t.timestamps
    end
  end
end
