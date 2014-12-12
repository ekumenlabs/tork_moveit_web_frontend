class CreateSimulationNodes < ActiveRecord::Migration
  def change
    create_table :simulation_nodes do |t|
      t.string :address
      t.references :user, index: true

      t.timestamps
    end
  end
end
