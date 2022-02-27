class AddReasonToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :reason, :string
  end
end
