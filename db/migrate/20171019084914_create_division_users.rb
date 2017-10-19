class CreateDivisionUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :division_users do |t|
      t.references :division, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
