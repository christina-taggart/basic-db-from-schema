require 'sqlite3'

class Contact
  @@db = SQLite3::Database.open('contacts.db')
  @@db.results_as_hash = true

  attr_accessor :name, :email, :phone
  attr_reader :id


    def initialize (args = {})
      @args = args
      @id = args["id"]
      @name = args["name"]
      @email = args["email"]
      @phone = args["phone"]
    end

    def delete
      @@db.execute("DELETE FROM contacts WHERE id = #{id}")
    end

    def save
      time = "#{Time.now.year}-0#{Time.now.month}-#{Time.now.day}"
      @@db.execute("INSERT INTO contacts ('name', 'email', 'phone', 'created_at', 'updated_at') VALUES ('#{@name}', '#{@email}', '#{@phone}', '#{time}', '#{time}')")
    end
end

contact = Contact.new(:name => "Alex")
contact.id # nil
contact.save # This executes an INSERT statement and makes a new record
contact.id # e.g., 20

contact.name = "Bob"
contact.save # This executes an UPDATE statement