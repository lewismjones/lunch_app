class AddPostLunchColumnToSurvey < ActiveRecord::Migration[5.2]
  def change
    add_column :surveys, :post_lunch, :boolean
  end
end
