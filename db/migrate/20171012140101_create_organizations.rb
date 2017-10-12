class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :full_name
      t.string :short_name
      t.string :address

      t.timestamps
    end
  end
end
