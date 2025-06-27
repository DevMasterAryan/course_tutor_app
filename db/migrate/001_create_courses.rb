class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :duration_hours, null: false
      
      t.timestamps
    end
    
    add_index :courses, :name, unique: true
  end
end
