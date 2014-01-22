
require 'sqlite3'


# If you want to overwrite your database you will need
# to delete it before running this file
$db = SQLite3::Database.new "contacts.db"

module AddressBookDB
  def self.setup
    $db.execute(
      <<-SQL
        CREATE TABLE contacts (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name VARCHAR(64) NOT NULL,
          last_name VARCHAR(64) NOT NULL,
          company VARCHAR(64) NOT NULL,
          phone VARCHAR(64) NOT NULL,
          email VARCHAR(64) NOT NULL,
          group_id INTEGER NOT NULL,
          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL
        );
      SQL
    )
  end

  def self.seed
    # Add a few records to your database when you start
    $db.execute_batch(
      <<-SQL
        INSERT INTO contacts
          (first_name, last_name, company, phone, email, group_id, created_at, updated_at)
        VALUES
          ('Brick','Thornton','Dev Bootcamp','9785342343', 'Brick@brick.com', 1, DATETIME('now'), DATETIME('now'));
        INSERT INTO contacts
          (first_name, last_name, company, phone, email, created_at, updated_at)
        VALUES
          ('Adtiya','Mahesh','Aditya Enterprises','5555551111', 'Aditya@world.com', 1, DATETIME('now'),DATETIME('now'));
        INSERT INTO contacts
          (first_name, last_name, company, phone, email, created_at, updated_at)
        VALUES
          ('Emmanuel','Kaunitz','underground hack hack','4074128736', 'Emmanuel@hackhack.com', 2, DATETIME('now'),DATETIME('now'));
      SQL
    )
  end
end

