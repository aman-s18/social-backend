class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images, id: :uuid do |t|
      t.string :file_name
      t.references :imageable, polymorphic: true, type: :uuid, index: true
      t.timestamps
    end
  end
end
