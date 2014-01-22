require 'sqlite3'

$db = SQLite3::Database.new "address_book.db"

module AddressBook
  def self.setup

$db.execute(
<<-SQL
  CREATE TABLE contacts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(64) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    company VARCHAR(64) NOT NULL,
    phone_number VARCHAR(64) NOT NULL,
    email VARCHAR(64) NOT NULL
    );
  SQL
  )

$db.execute(
  <<-SQL
  CREATE TABLE group_contacts(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    group_id INTEGER NOT NULL,
    contact_id INTEGER NOT NULL,
    FOREIGN KEY(group_id) REFERENCES group(id)
    FOREIGN KEY(contact_id) REFERENCES contacts(id)
    );
  SQL
  )

$db.execute(
<<-SQL
  CREATE TABLE groups(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL
    );
  SQL
    )
  end

  def self.seed
    $db.execute(
      <<-SQL
      INSERT INTO contacts (first_name, last_name, company, phone_number, email) VALUES
      ('Emily','Foley','JW Michaels', 7328093405, 'foleyemilym_at_gmail_com');
      SQL
      )

    $db.execute(
      <<-SQL
      INSERT INTO groups (name) VALUES ('Ruby Developers');
      SQL
      )

    $db.execute(
      <<-SQL
      INSERT INTO group_contacts (group_id, contact_id) VALUES (1,1);
      SQL
      )
  end
end

