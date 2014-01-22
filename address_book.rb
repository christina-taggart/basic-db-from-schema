require 'sqlite3'

$db = SQLite3::Database.new "address_book.db"

class Contacts
  def initialize(args)
    attr_reader :id,:first_name, :last_name, :company, :phone_number, :email
    @id = args[:id]
    @first_name = args[:first_name]
    @last_name = args[:last_name]
    @company = args[:company]
    @phone_number = args[:phone_number]
    @email = args[:email]
  end

  def save
    $db.execute("INSERT INTO contacts (first_name,last_name,company,phone_number,email)
    VALUES ('Elizabeth','Fitzpatrick','JW Michaels','2129229386','efitz_at_jw_com');")
  end

  def delete(id)
    $db.execute("DELETE FROM contacts WHERE id = @id;")
  end

  def

end

class Group_contacts
end

class Groups
end