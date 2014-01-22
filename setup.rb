require 'sqlite3'

# If you want to overwrite your database you will need
# to delete it before running this file
$db = SQLite3::Database.new "address_book.db"

module AddressBookDB
  def self.setup
    $db.execute_batch(
            <<-SQL
      CREATE TABLE contacts (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      first_name VARCHAR(64) NOT NULL,
      last_name VARCHAR(64) NOT NULL,
      company VARCHAR(64),
      phone_number VARCHAR(12),
      email VARCHAR(64),

      -- add the additional attributes here!

      created_at DATETIME NOT NULL,
      updated_at DATETIME NOT NULL
      );
      CREATE TABLE groups (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name VARCHAR(64) NOT NULL,
      -- add the additional attributes here!

      created_at DATETIME NOT NULL,
      updated_at DATETIME NOT NULL
        );
      

      CREATE TABLE contacts_groups (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      contact_id INTEGER NOT NULL,
      group_id INTEGER NOT NULL,
      created_at DATETIME NOT NULL,
      updated_at DATETIME NOT NULL,
      FOREIGN KEY(contact_id) REFERENCES contacts(id),
      FOREIGN KEY(group_id) REFERENCES groups(id)
      );
      SQL
          )
  end


  def self.drop_tables
    $db.execute_batch(
            <<-SQL
      DROP TABLE IF EXISTS contacts_groups;
      DROP TABLE IF EXISTS contacts;
      DROP TABLE IF EXISTS groups;
      SQL
    )
  end

  def self.seed
    # Add a few records to your database when you start
    $db.execute_batch(
            <<-SQL
      INSERT INTO contacts
      (first_name, last_name, company, phone_number, email, created_at, updated_at)
      VALUES
      ('Brick','Thornton', 'DBC','123-123-1234', 'brick@dbc.com', DATETIME('now'), DATETIME('now'));

      INSERT INTO groups
      (name, created_at, updated_at)
      VALUES
      ('DBC', DATETIME('now'), DATETIME('now'));

      INSERT INTO contacts_groups
      (contact_id, group_id, created_at, updated_at)
      VALUES
      (1,1, DATETIME('now'), DATETIME('now'));
      SQL
    )
  end
end


