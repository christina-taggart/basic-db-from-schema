require 'sqlite3'

$db = SQLite3::Database.open "address_book.db"


class Contact
  attr_accessor :id, :first_name, :last_name, :company, :phone, :email

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

  def delete!
    $db.execute("DELETE FROM contacts WHERE id='#{@id}';")
    self.delete_matching_contact_groups
  end

  def delete_matching_contact_groups
    $db.execute("DELETE FROM contacts_groups WHERE contact_id='#{@id}';")
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
  attr_accessor :id, :group_name

  def initialize(args)
    @id = args[:id]
    @group_name = args[:group_name]
  end

  def save!
    group_exists? ? self.update : self.insert
  end

  def delete!
    $db.execute("DELETE FROM groups WHERE id='#{@id}';")
    self.delete_matching_contact_groups
  end

  def delete_matching_contact_groups
    $db.execute("DELETE FROM contacts_groups WHERE group_id='#{@id}';")
  end

  def group_exists?
    if $db.execute("SELECT * FROM groups WHERE id='#{@id}';") != []
      true
    elsif $db.execute("SELECT * FROM groups WHERE id='#{@id}';") == []
      false
    end
  end

  def insert
    $db.execute(
      <<-SQL
      INSERT INTO groups
        (id, group_name)
      VALUES
        ('#{@id}','#{@group_name}');
      SQL
    )
  end

  def update
    $db.execute(
      <<-SQL
      UPDATE groups SET
        id = '#{@id}',
        group_name = '#{@group_name}'
      WHERE id='#{@id}'
      SQL
    )
  end
end


class ContactGroup
  attr_accessor :id, :contact_id, :group_id

  def initialize(args)
    @id = args[:id]
    @contact_id = args[:contact_id]
    @group_id = args[:group_id]
  end

  def save!
    contact_group_exists? ? self.update : self.insert
  end

  def delete!
    $db.execute("DELETE FROM contacts_groups WHERE id='#{@id}';")
  end

  def contact_group_exists?
    if $db.execute("SELECT * FROM contacts_groups WHERE id='#{@id}';") != []
      true
    elsif $db.execute("SELECT * FROM contacts_groups WHERE id='#{@id}';") == []
      false
    end
  end

  def insert
    $db.execute(
      <<-SQL
      INSERT INTO contacts_groups
        (id, contact_id, group_id)
      VALUES
        ('#{@id}', '#{contact_id}', '#{@group_id}');
      SQL
    )
  end

  def update
    $db.execute(
      <<-SQL
      UPDATE groups SET
        id = '#{@id}',
        contact_id = '#{contact_id}',
        group_id = '#{@group_id}'
      WHERE id='#{@id}'
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

# 3. Adding a group Former Presidents:
former_presidents = Group.new({:id => 3, :group_name => "Former Presidents"})


# 4. Updating a group:
former_presidents.group_name = "Disliked Former Presidents"
former_presidents.save!

# 5. Deleting a contact:
bush.delete!