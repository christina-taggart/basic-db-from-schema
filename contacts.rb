require 'sqlite3'

class Contact

  attr_reader :first_name, :last_name, :email, :phone, :created_at, :updated_at
  def initialize(data = {})
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @email = data[:email]
    @phone = data[:phone]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def add(database)
    database.execute(
      <<-SQL
        INSERT INTO contacts
          (first_name, last_name, email, phone, created_at, updated_at)
        VALUES
          ('#{first_name}','#{last_name}', '#{email}', '#{phone}', '#{created_at}', '#{updated_at}');
        SQL
    )
  end

  def delete(database)
    database.execute("delete from contacts where first_name = '#{first_name}' and last_name = '#{last_name}'")
  end

   def self.update_record(database, attribute, value, id)
    database.execute("update contacts set #{attribute} = '#{value}' where id = #{id}")
  end

end


class Group
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def add(database)
    database.execute(
      <<-SQL
        INSERT INTO groups
          (name)
        VALUES
          ('#{name}');
        SQL
    )
  end

  def delete(database)
    database.execute("delete from groups where name = '#{name}'")
  end

end

address_book = SQLite3::Database.new "address_book.db"
andy = Contact.new(first_name: "Andy", last_name: "Lee", email: "email", phone: "123-456-2313",
  created_at: Time.now, updated_at: Time.now)
#andy.add(address_book)
#andy.delete(address_book)
#Contact.update_record(address_book, "email", 'aleebc.edu', 5)

dbc = Group.new("Family")
#dbc.add(address_book)
#dbc.delete(address_book)
