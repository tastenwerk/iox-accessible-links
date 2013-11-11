class IoxPrivileges < ActiveRecord::Migration
  def change
    create_table :iox_privileges do |t|

      t.boolean     :can_write, default: false
      t.boolean     :can_delete, default: false
      t.boolean     :can_share, default: false

      t.string      :email, index: true
      t.string      :access_key, unique: true, index: true
      t.datetime    :confirmed_at

      t.integer     :access_counter_quota, default: 0
      t.integer     :access_counter
      t.datetime    :expires_at

      t.integer     :created_by
      t.integer     :updated_by

      t.string      :type

      t.belongs_to  :user

      t.references  :accessible, polymorphic: true

      t.timestamps
    end
  end
end