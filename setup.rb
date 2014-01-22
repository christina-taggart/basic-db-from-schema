require 'sqlite3'

# If you want to overwrite your database you will need
# to delete it before running this file
$db = SQLite3::Database.new "address_book.db"

module AddressBook
  def self.setup
    $db.execute_batch(
      <<-SQL
        CREATE TABLE contacts (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name VARCHAR(64) NOT NULL,
          last_name VARCHAR(64) NOT NULL,
          email VARCHAR(255) NOT NULL,
          phone VARCHAR(64) NOT NULL,
          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL
        );
          CREATE TABLE groups (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name VARCHAR(64) NOT NULL
        );
          CREATE TABLE contacts_groups (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          contact_id INTEGER NOT NULL,
          group_id INTEGER NOT NULL
        );
      SQL
    )
  end

  def self.seed
    $db.execute_batch(
      <<-SQL
        INSERT INTO contacts
          (first_name, last_name, email, phone, created_at, updated_at)
        VALUES
          ('Brick','Thornton', 'brick@dbc.com', '189-233-2927', DATETIME('now'), DATETIME('now'));
        INSERT INTO contacts
          (first_name, last_name, email, phone, created_at, updated_at)
        VALUES
          ('Andy', 'Lee', 'andy@dbc.com', '123-456-7890', DATETIME('now'), DATETIME('now'));
        INSERT INTO contacts
          (first_name, last_name, email, phone, created_at, updated_at)
        VALUES
          ('Christina', 'Taggart', 'christina@dbc.com', '222-222-2222', DATETIME('now'), DATETIME('now'));
        INSERT INTO groups
          (name)
        VALUES
          ('DBC');
        INSERT INTO contacts_groups
          (contact_id, group_id)
        VALUES
          (1,1);
        INSERT INTO contacts_groups
          (contact_id, group_id)
        VALUES
          (2,1);
        INSERT INTO contacts_groups
          (contact_id, group_id)
        VALUES
          (3,1);
      SQL
    )
  end
end



AddressBook.setup
AddressBook.seed