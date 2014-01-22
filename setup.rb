require 'sqlite3'

$db = SQLite3::Database.new "address_book.db"

module AddressBookBuilder
  def self.setup_tables
    $db.execute(
      <<-SQL
      CREATE TABLE contacts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        first_name VARCHAR(64) NOT NULL,
        last_name VARCHAR(64) NOT NULL,
        company VARCHAR(64) NOT NULL,
        phone VARCHAR(64) NOT NULL,
        email VARCHAR(64) NOT NULL
      );
      SQL
    )

    $db.execute(
      <<-SQL
      CREATE TABLE groups (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        group_name VARCHAR(64) NOT NULL
      );
      SQL
    )

    $db.execute(
      <<-SQL
      CREATE TABLE contacts_groups (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        contact_id INTEGER,
        group_id INTEGER,
        FOREIGN KEY(contact_id) REFERENCES contacts(id),
        FOREIGN KEY(group_id) REFERENCES groups(id)
      );
      SQL
    )
  end

  def self.populate_tables
    $db.execute(
      <<-SQL
        INSERT INTO contacts
          (first_name, last_name, company, phone, email)
        VALUES
          ('Matt', 'Higgins', 'Amazon', '661-993-3324', 'matthew.alan.higgins@gmail.com'),
          ('Mary', 'Poppins', 'self-employed', '123-456-7890', 'mary.poppins@magic.com'),
          ('Roy', 'Lee', 'Google', '415-345-1783', 'lee.sh.roy@gmail.com'),
          ('John', 'Olmsted', 'Apple', '510-542-1601', 'johnaolmsted@gmail.com');
      SQL
    )

    $db.execute(
      <<-SQL
        INSERT INTO groups
          (group_name)
        VALUES
          ('DBC');
      SQL
    )

    $db.execute(
      <<-SQL
        INSERT INTO contacts_groups
          (contact_id, group_id)
        VALUES
          (1, 1),
          (3, 1),
          (4, 1);
      SQL
    )
  end
end

#-----GENERATE OUR TABLES!!-----
AddressBookBuilder.setup_tables
AddressBookBuilder.populate_tables