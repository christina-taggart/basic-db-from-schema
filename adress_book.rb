require 'sqLite3'

class Contact
  def initialize
   @db = SQLite3::Database.open "contacts.db"
  end

  def add(first_name, last_name, address, birthday, email, phone, website, group, created_at, updated_at)
  @db.execute("INSERT INTO contacts (first_name, last_name, address, birthday, email, phone, website, group, created_at, updated_at)
      VALUES('#{first_name}','#{last_name}','#{address}', '#{birthday}','#{email}', '#{phone}', '#{website}', '#{group}, 'DATETIME('2013-01-01'), DATETIME('2014-01-01') )")
  end

  def delete(name)
    @db.execute("DELETE FROM contacts WHERE first_name = '#{name}'")
  end

  def list
    @db.execute("SELECT * FROM contacts")
  end

  def update_name(first_name, last_name)
    @db.execute ("UPDATE contacts SET first_name = '#{first_name}' WHERE last_name = '#{last_name}'")
  end

  def update_address(new_address, last_name)
    @db.execute ("UPDATE contacts SET address = '#{new_address}' WHERE last_name = '#{last_name}'")
  end


end

class Group
  def initialize
       @db = SQLite3::Database.open "contacts.db"
  end

  def add(name)
    @db.execute("INSERT INTO groups (name)
      VALUES('#{name}')")
  end

  def delete(group_name)
    @db.execute("DELETE FROM contacts WHERE name = '#{group_name}'")
  end

end


address_book = Contact.new

# puts address_book.list
# address_book.add('darcey', 'lachtman', '175 willowbrook dr', '1991-01-16', 'dslachtman@gmail.com', '650-799-9406', 'www.blogger.com', DateTime.now, DateTime.now)
puts address_book.list
# address_book.delete('darcey')
# puts address_book.update_name('Lucy', 'Fakeperson')