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
          name VARCHAR(64) NOT NULL,
          email VARCHAR(128) NOT NULL,
          phone VARCHAR(128) NOT NULL,
          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL
        );
      SQL
    )
  end

  def self.seed
    # Add a few records to your database when you start
    $db.execute(
      <<-SQL
        INSERT INTO contacts
          (name, email, phone, created_at, updated_at)
        VALUES
          ('Brick Thornton', 'brick@devbootcamp.com','555-555-5555', DATETIME('now'), DATETIME('now'));

          SQL
          )
    end
    # $db.execute(
    #   <<-SQL
    #     INSERT INTO contacts
    #       (name, email, phone, created_at, updated_at)
    #     VALUES
    #     ('Alex Leishman', 'leishman3@gmail.com', '301.351.0949', DATETIME('now'), DATETIME('now'));
    #       SQL
    #       )


    # $db.execute(
    #  <<-SQL
    #   INSERT INTO contacts
    #     (name, email, phone, created_at, updated_at)
    #   VALUES
    #     ('Nicholas Cu', 'nicholascu@gmail.com', '916.215.1110', DATETIME('now'), DATETIME('now'));
    #     SQL
    #     )

end

ContactsDB.setup
ContactsDB.seed