require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => "db/bart_drive.sqlite3"
)

unless File.exists?("db/bart_drive.sqlite3")
  puts "Creating yo database..."
  ActiveRecord::Schema.define do
    create_table :addresses do |t|
      t.column :full_address,   :string, :null => false
      t.column :created_at,     :datetime, :default => 'CURRENT_TIMESTAMP'
      t.column :user_id,        :integer
    end

   create_table :users do |t|
      t.column :first_name,     :string
      t.column :last_name,      :string
      t.column :created_at,     :datetime, :default => 'CURRENT_TIMESTAMP'
    end
  end
end