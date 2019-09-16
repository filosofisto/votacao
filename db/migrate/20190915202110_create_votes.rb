class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.string :cpf
      t.integer :vote

      t.timestamps
    end
  end
end
