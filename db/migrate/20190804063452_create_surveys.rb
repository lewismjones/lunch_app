class CreateSurveys < ActiveRecord::Migration[5.2]
  def change
    create_table :surveys do |t|
      t.string :participant
      t.string :response

      t.timestamps
    end
  end
end
