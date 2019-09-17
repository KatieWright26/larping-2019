class UpdateUsersToSupportOAuth < ActiveRecord::Migration[5.1]
  def change
    def change
      change_table :users, bulk: true do |t|
        t.string :provider, limit: 50, null: false, default: ""
        t.string :uid, limit: 500, null: false, default: ""
      end
    end
  end
end
