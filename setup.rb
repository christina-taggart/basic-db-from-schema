require 'sqlite3'

$db = SQLite3::Database.new "address_book.db"

module AdressBook
  def self.setup
    $db.execute <<-SQL
            CREATE TABLE contacts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            first_name VARCHAR(64) NOT NULL,
            last_name VARCHAR(64) NOT NULL,
            company VARCHAR(64) NOT NULL,
            phone_number VARCHAR(64) NOT NULL,
            email VARCHAR(64) NOT NULL
            );
    SQL

    $db.execute <<-SQL
            CREATE TABLE contacts_groups (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            contact_id INTEGER,
            group_id INTEGER
            );
    SQL

    $db.execute <<-SQL
            CREATE TABLE groups (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name VARCHAR(64)
            );
    SQL
  end

   def self.seed
    $db.execute <<-SQL
        INSERT INTO contacts
          (first_name, last_name, company, phone_number, email)
        VALUES
          ('David', 'Goodman', 'DBC', '7268397263', 'theHammer@hotmail.com'),
          ('Eli', 'Shkurkin', 'Sony Records', '8273736271', 'shkurkin@okcupid.com')

    SQL

    $db.execute <<-SQL

          INSERT INTO groups
          (name)
          VALUES
          ('republicans'),
          ('Sea Lions'),
          ('David Enthusiasts')
          ;
    SQL

    $db.execute <<-SQL

          INSERT INTO contacts_groups
          (contact_id, group_id)
          VALUES
          (1, 2),
          (2, 1),
          (2, 2),
          (1,3),
          (2,3)
          ;
    SQL
  end
end


#AdressBook.setup
#AdressBook.seed
$db.execute2("select * from contacts join contacts_groups on contact_id = contacts.id join groups on group_id = groups.id").each{|row| p row}
# $db.execute("SELECT * FROM contacts").each{|row| p row}
# $db.execute("SELECT * FROM contacts_groups").each{|row| p row}