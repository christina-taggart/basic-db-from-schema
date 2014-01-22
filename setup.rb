require 'sqlite3'

$db = SQLite3::Database.new('addressbooks.db')

module AddressBooksDB
  def self.setup
    $db.execute(
      <<-SQL
        CREATE TABLE addressbooks (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          group_id INTEGER,
          FOREIGN KEY (group_id) REFERENCES groups(id)
          );
      SQL
      )
    $db.execute(
      <<-SQL
        CREATE TABLE contacts (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name VARCHAR(64) NOT NULL,
          last_name VARCHAR(64) NOT NULL,
          phone_number VARCHAR(64) NOT NULL,
          email VARCHAR(64) NOT NULL,
          created_at VARCHAR(64) NOT NULL,
          updated_at VARCHAR(64) NOT NULL
          );
      SQL
      )
    $db.execute(
      <<-SQL
        CREATE TABLE groups (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name VARCHAR(64) NOT NULL,
          created_at VARCHAR(64) NOT NULL,
          updated_at VARCHAR(64) NOT NULL
          );
      SQL
      )
    $db.execute(
      <<-SQL
        CREATE TABLE contact_groups (
          id INTEGER PRIMARY KEY AUTOINCREMENT
          group_id INTEGER,
          contact_id INTEGER,
          FOREIGN KEY (group_id) REFERENCES groups(id),
          FOREIGN KEY (contact_id) REFERENCES contacts(id)
          );
      SQL
      )
  end
  def self.seed
    # stuff goes here....
  end
end