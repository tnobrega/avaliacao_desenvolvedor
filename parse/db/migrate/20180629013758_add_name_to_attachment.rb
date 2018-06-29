class AddNameToAttachment < ActiveRecord::Migration[5.2]
  def change
    add_column :attachments, :name, :string
  end
end
