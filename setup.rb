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
          company VARCHAR(64) NOT NULL,
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
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          group_id INTEGER,
          contact_id INTEGER,
          FOREIGN KEY (group_id) REFERENCES groups(id),
          FOREIGN KEY (contact_id) REFERENCES contacts(id)
          );
      SQL
      )
  end
end

class Contacts
  def initialize(args)
    @first_name = args[:first_name]
    @last_name = args[:last_name]
    @company = args[:company]
    @phone_number = args[:phone_number]
    @email = args[:email]
    raise "Phone number must be formatted like so: XXX-XXX-XXXX" if @phone_number.match(/(\d{3}-\d{3}-\d{4})$/) == nil
    raise "Please enter a valid e-mail address!" if @email.match(/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/) == nil # <=== Had to use someone else's Regex...
  end

  def add
    $db.execute(
      <<-SQL
        INSERT INTO contacts
          (first_name, last_name, company, phone_number, email, created_at, updated_at)
        VALUES
          ("#{@first_name}", "#{@last_name}", "#{@company}", "#{@phone_number}", "#{@email}", DATETIME('now'), DATETIME('now'))
      SQL
    )
  end

  def update(column, value, location)
    $db.execute("UPDATE contacts SET #{column} = #{value} WHERE #{location}")
  end

  def delete(id)
    $db.execute("DELETE FROM contacts WHERE id = #{id}")
  end

end

class Groups
  def initialize(args)
    @name = args[:name]
  end

  def add
    $db.execute(
      <<-SQL
        INSERT INTO groups
          (name, created_at, updated_at)
        VALUES
          ("#{@name}", DATETIME('now'), DATETIME('now'))
      SQL
    )
  end

  def delete_group(id)
    $db.execute("DELETE FROM groups WHERE id = #{id}")
  end
end

bobby = Contacts.new({first_name: 'Johnny', last_name: 'fischer', company: 'chess exiled', phone_number: '113-123-1441', email: 'ilovechess@chessmaster', })
#bobby.update("company", "'chessterplex'", 3)
chess_masters = Groups.new({name: 'chess_players_suck'})
#chess_masters.add
bobby.add
bobby.delete(7)
#chess_masters.delete_group(2)

