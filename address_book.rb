require 'sqlite3'

$db = SQLite3::Database.open "address_book.db"


class Contact
  attr_accessor :first_name, :last_name, :company, :phone, :email

  def initialize(args)
    @first_name = args[:first_name]
    @last_name = args[:last_name]
    @company = args[:company]
    @phone = args[:phone]
    @email = args[:email]
  end

  def save!
    $db.execute(
      <<-SQL
      INSERT INTO contacts
        (first_name, last_name, company, phone, email)
      VALUES
        ('#{@first_name}', '#{@last_name}', '#{@company}', '#{@phone}', '#{@email}');
      SQL
    )
  end
end


class Group
  attr_accessor :group_name

  def initialize(args)
    @group_name = args[:group_name]
  end

  def save!
    $db.execute(
      <<-SQL
      INSERT INTO groups
        (group_name)
      VALUES
        ('#{@group_name}');
      SQL
    )
  end
end


class ContactGroup
  attr_accessor :contact_id, :group_id

  def initialize(args)
    @contact_id = args[:contact_id]
    @group_id = args[:group_id]
  end

  def save!
    $db.execute(
      <<-SQL
      INSERT INTO contacts_groups
        (contact_id, group_id)
      VALUES
        ('#{@contact_id}', '#{@group_id}');
      SQL
    )
  end
end


#-----DRIVERS-----

# # Adding Spencer to Contacts
# spencer = Contact.new({
#                       :first_name => "Spencer",
#                       :last_name => "Smitherman",
#                       :company => "Uber",
#                       :phone => "123-678-3242",
#                       :email => "spencer@uber.com"
#                       })
# spencer.save!

# # Adding Spencer to the DBC group:
# spencers_group = ContactGroup.new({:contact_id => 5, :group_id => 1})
# spencers_group.save!

# # Adding new Magical Beings group:
# magic_beings = Group.new({:group_name => "Magical beings"})
# magic_beings.save!

# # Adding Mary Poppins to Magical beings group:
# marys_group = ContactGroup.new({:contact_id => 2, :group_id => 2})
# marys_group.save!