require 'sqlite3'
$db = SQLite3::Database.new 'address_book.db'

module AddressBookDB
  def self.setup
    $db.execute(
      <<-SQL
        CREATE TABLE contacts (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name VARCHAR(64) NOT NULL,
          last_name VARCHAR(64),
          company VARCHAR(64),
          phone VARCHAR(64),
          email VARCHAR(64),
          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL
          );
      SQL
      )
    $db.execute(
      <<-SQL
        CREATE TABLE groups (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name VARCHAR(64) NOT NULL
          );
      SQL
      )
    $db.execute(
      <<-SQL
        CREATE TABLE contacts_groups(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          contact_id INTEGER NOT NULL,
          group_id INTEGER NOT NULL
          );
        SQL
        )
  end

  def self.seed
    # Add a few records to your database when you start
    $db.execute(
      <<-SQL
        INSERT INTO contacts
          (first_name, last_name, company, phone, email, created_at, updated_at)
        VALUES
          ('Brick','Thornton','Dev Bootcamp','555-555-1234', 'brick@dbc.com', DATETIME('now'), DATETIME('now')),
          ('Roy','Lee',NULL,'555-555-0167', 'royleebiv@gmail.com', DATETIME('now'), DATETIME('now')),
          ('Patrick','Vilhena',NULL,'555-555-2057', 'plvilhena@gmail.com', DATETIME('now'), DATETIME('now'));
          SQL
          )
    $db.execute(
      <<-SQL
        INSERT INTO groups
          (name)
        VALUES
          ('DBC'),
          ('Cal'),
          ('Reading Buddies');
      SQL
      )
    $db.execute(
      <<-SQL
        INSERT INTO contacts_groups
          (contact_id, group_id)
        VALUES
          (2, 3),
          (2, 1),
          (1, 1),
          (3, 1),
          (3, 2),
          (3, 3);
      SQL
      )
  end
end

AddressBookDB.setup
AddressBookDB.seed