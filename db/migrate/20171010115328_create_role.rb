class CreateRole < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :label
    end
  end
end
