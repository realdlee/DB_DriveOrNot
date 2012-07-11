
#   attr_accessor :location, :tag, :db
#
#   def initialize(location,tag)
#     @location = location
#     @tag = tag
#     if !File.exists? "drive_or_not_test.db"
#       @db = SQLite3::Database.new('drive_or_not_test.db')
#       @db.execute <<-SQL
#         CREATE TABLE addresses(
#           id INTEGER PRIMARY KEY AUTOINCREMENT,
#           address VARCHAR NOT NULL,
#           name VARCHAR NOT NULL
#         );
#         SQL
#     else
#       @db = SQLite3::Database.open('drive_or_not_test.db')
#     end
#     save_db
#   end
#
#   def save_db
#     @db.execute <<-SQL
#       INSERT INTO addresses(address, name) VALUES('#@location', '#@tag')
#     SQL
#   end
#
# end

class Address
  attr_accessor :location, :tag, :db

  def initialize
    @location = location
    @tag = tag
    if !File.exists? "drive_or_not_test.db"
      @db = SQLite3::Database.new('drive_or_not_test.db')
      @db.execute <<-SQL
        CREATE TABLE addresses(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          address VARCHAR NOT NULL,
          name VARCHAR NOT NULL
        );
        SQL
    else
      @db = SQLite3::Database.open('drive_or_not_test.db')
    end
  end

  def save_db(location,tag)
    @db.execute <<-SQL
      INSERT INTO addresses(address, name) VALUES('#@location', '#@tag')
    SQL
  end

end