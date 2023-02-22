class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :tech_stack
      t.string :background_image
      t.text :images
      t.string :source
      t.string :live
      t.text :description

      t.timestamps
    end
  end
end
