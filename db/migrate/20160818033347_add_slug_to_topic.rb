class AddSlugToTopic < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :slug, :string
  end
end
