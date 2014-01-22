require 'sqlite3'
require_relative 'setup.rb'

class Contact

  attr_reader :first_name, :last_name, :company, :email, :phone

  def initialize(args)
    @first = args[:first_name]
    @last = args[:last_name]
    @input_company = args[:company]
    @input_phone = args[:phone]
    @input_email = args[:email]
  end


  def save
    $db.execute(
      <<-SQL
        INSERT INTO contacts
          (first_name, last_name, company, phone, email, created_at, updated_at)
        VALUES
          ('#{@first}', '#{@last}', '#{@input_company}', '#{@input_phone}', '#{@input_email}', DATETIME('now'), DATETIME('now'));
        SQL
        )
  end

  def delete
    $db.execute(
      <<-SQL
      DELETE FROM contacts WHERE first_name = '#{@first}' AND last_name = '#{@last}'
      SQL
      )
  end

  def update(field, value, id)
     $db.execute(
      <<-SQL
      UPDATE contacts SET '#{field}' == '#{value}' WHERE id = '#{id}'
      SQL
      )
  end


end

class AddressBook
  def self.all
    people = $db.execute(
      <<-SQL
      SELECT * FROM contacts
      SQL
      )

    people.each do |person|
      puts "#{person[1]} #{person[2]}"
    end
  end

    def self.search_name(name)
    name_to_find = name
    $db.execute(
      <<-SQL
      SELECT * FROM contacts WHERE first_name = '#{name_to_find}'
      SQL
      )
  end
end

class Groups
  attr_reader :id_given
  def initialize(id_given)
    @id_given = id_given
  end

  def self.add_to_groups(id)
    db.execute(
      <<-SQL
      UPDATE contacts SET group_id WHERE id = '#{id}'
      SQL
      )

  end
  def self.all
      <<-SQL
      SELECT *
      FROM contacts
      WHERE group_id = @id_given
      SQL
      )

  end
end

AddressBook.all
puts "-----"
john = Contact.new(:first_name => "John", :last_name => "Smith", :company => "Google", :email => "js@gmail.com", :phone => "9232343453" )
john.save # This executes an INSERT statement and makes a new record
AddressBook.all
puts "-----"
john.update("first_name", "Bob", 1)
AddressBook.all
puts "-----"

