class CreateAbilities < ActiveRecord::Migration
  def change
    create_table :abilities do |t|
      t.integer :job_id
      t.string :kind
      t.string :name
      t.integer :mp
      t.integer :speed
      t.integer :jp

      t.timestamps
    end
  end
end
