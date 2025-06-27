class CreateTutors < ActiveRecord::Migration[7.0]
  def change
    create_table :tutors do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.integer :experience_years, null: false, default: 0
      t.references :course, null: false, foreign_key: true
      
      t.timestamps
    end
    
    add_index :tutors, :email, unique: true
  end
end
