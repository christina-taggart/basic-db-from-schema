require 'sqlite3'
$db = SQLite3::Database.open("address_book.db")

class Group
  attr_reader :name
  def initialize(args)
    @name = args[:name]
  end

  def save
    $db.execute(
      "INSERT INTO groups
          (name)
        VALUES
          (?)",
        [name]
        )
  end

  def self.delete(group_id)
    $db.execute(
      "DELETE FROM groups
      WHERE id=#{group_id}")

    $db.execute(
      "DELETE FROM contacts_groups
      WHERE contact_id=#{group_id}")
  end

  def self.all
    $db.execute(
      "SELECT * FROM groups").each {|row| puts row}
  end
end


class Contact
  attr_reader :first_name, :last_name, :company, :phone_number, :email
  def initialize(args)
    @first_name = args[:first_name]
    @last_name = args[:last_name]
    @company = args[:company]
    @phone_number = args[:phone_number]
    @email = args[:email]
    raise "Invalid Phone Number.  Please enter in the XXX-XXX-XXXX Format" if @phone_number.match(/\d{3}-\d{3}-\d{4}$/) == nil
    raise "Invalid Email.  Please eneter a valid email address" if @email.match(/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/) == nil
  end

  def save
    $db.execute(
        "INSERT INTO contacts
            (first_name, last_name, company, phone_number, email)
        VALUES
            (?, ?, ?, ?, ?)",
        [first_name, last_name, company, phone_number, email]
    )
  end



  def self.delete(where_val)

     $db.execute(
      "DELETE FROM contacts
      WHERE #{where_val}"
      )
  end

  def self.all
    $db.execute(

      "SELECT * FROM contacts"

      ).each {|row| puts row}
  end

  def self.update(column_name, new_value, where_val)
    $db.execute("UPDATE contacts
      SET #{column_name}=#{new_value}
      WHERE #{where_val}")
  end

end


person = Contact.new({first_name: 'Joe', last_name: 'Momma', company: 'Nike', phone_number: '345-543-3463', email: 'ahfyfb@email.com'})
 person.save
# Contact.delete("first_name = 'Eli'")

# new_group = Group.new({name: 'Eli Toleraters'})
# new_group.save

# p $db.execute("SELECT * FROM groups")

# Group.delete("id = '4'")
# Group.all

Contact.update("email", "'dgoodz1224@gmail.com'", "first_name = 'David'")
p $db.execute("SELECT * FROM contacts")
