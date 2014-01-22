require 'sqlite3'

$db = SQLite3::Database.open "address_book.db"


class Contact
  attr_accessor :first_name, :last_name, :company, :phone, :email

  def initialize(args)
    @id = args[:id]
    @first_name = args[:first_name]
    @last_name = args[:last_name]
    @company = args[:company]
    @phone = args[:phone]
    @email = args[:email]
  end

  def save!
    contact_exists? ? self.update : self.insert
  end

  def contact_exists?
    if $db.execute("SELECT * FROM contacts WHERE id='#{@id}';") != []
      true
    elsif $db.execute("SELECT * FROM contacts WHERE id='#{@id}';") == []
      false
    end
  end

  def insert
    $db.execute(
      <<-SQL
      INSERT INTO contacts
        (id, first_name, last_name, company, phone, email)
      VALUES
        ('#{@id}','#{@first_name}', '#{@last_name}', '#{@company}', '#{@phone}', '#{@email}');
      SQL
    )
  end

  def update
    $db.execute(
      <<-SQL
      UPDATE contacts SET
        id = '#{@id}',
        first_name = '#{@first_name}',
        last_name = '#{@last_name}',
        company = '#{@company}',
        phone = '#{@phone}',
        email = '#{@email}'
      WHERE id='#{@id}'
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

# # 1. Adding George Bush:
bush = Contact.new({
                  :id => 6,
                  :first_name => "George",
                  :last_name => "Bush",
                  :company => "America",
                  :phone => "1-800-1234",
                  :email => "george@bush.gov"
                  })


# 2. Updating George Bush:
bush.first_name = "Martha"
bush.save!