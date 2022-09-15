class CreateMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
    
    #one membership per group
    add_index :memberships, [:user_id, :group_id], :unique => true
  end
end
