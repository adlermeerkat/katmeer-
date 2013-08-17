class RemoveTitleFromStatements < ActiveRecord::Migration
  def up
  	remove_column :statements, :title
  end

  def down
  	add_column :statements, :title, :string
  end
end
