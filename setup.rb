require 'sqlite3'

# If you want to overwrite your database you will need
# to delete it before running this file
$db = SQLite3::Database.new "contacts.db"

module ContactsDB
  def self.setup
    $db.execute(
      <<-SQL
        CREATE TABLE contacts (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name VARCHAR(64) NOT NULL,
          last_name VARCHAR(64) NOT NULL,
          address VARCHAR(64) NOT NULL,
          birthday DATE NOT NULL,
          email VARCHAR(64) NOT NULL,
          phone VARCHAR(64) NOT NULL,
          website VARCHAR(64) NOT NULL,
          group VARCHAR(64) NOT NULL,
          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL
        );

        CREATE TABLE groups(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name VARCHAR(64) NOT NULL
        );
      SQL
    )
  end

  def self.seed
    # Add a few records to your database when you start
    $db.execute(
      <<-SQL
        INSERT INTO contacts
          (first_name, last_name, address, birthday, email, phone, website, group, created_at, updated_at)
        VALUES
          ('Brick','Thornton', '717 California St. San Francisco, CA', DATE('2011-01-01'), 'brick@thornton.com', '555.555.5555', 'http://www.brick.com', 'Dev Bootcamp Friends', DATETIME('now'), DATETIME('now')),
          ('Nota', 'Fakeperson', '1234 happy place. Santa Cruz, CA', DATE('2000-12-15'), 'itsa@burrito.com', '650.999.1234', 'http://www.yeay.com', 'Google Friends', DATETIME('now'), DATETIME('now'));

        INSERT INTO groups
          (name)
        VALUES
          ('Dev Bootcamp Friends'),
          ('Google Friends'),
          ('Yelp Friends');
      SQL
    )
  end
end


ContactsDB.setup

ContactsDB.seed