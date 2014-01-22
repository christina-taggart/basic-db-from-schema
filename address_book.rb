require 'sqlite3'

$db = SQLite3::Database.open "address_book.db"


#-----ADDRESSBOOKOBJECT SUPERCLASS-----

class AddressBookObject
  def initialize
    @commands = {}
  end

  def save!
    entry_exists? ? self.update : self.insert
  end

  def delete!
    $db.execute(@commands[:delete])
    self.delete_matching_contact_groups
  end

  def delete_matching_contact_groups
    $db.execute(@commands[:delete_matching])
  end

  def entry_exists?
    if $db.execute(@commands[:exists]) != []
      true
    elsif $db.execute(@commands[:exists]) == []
      false
    end
  end

  def insert
    $db.execute(@commands[:insert])
  end

  def update
    $db.execute(@commands[:update])
  end
end

#-----CONTACT, GROUP, AND CONTACT_GROUP CLASSES

class Contact < AddressBookObject
  attr_accessor :id, :first_name, :last_name, :company, :phone, :email

  def initialize(args)
    @id = args[:id]
    @first_name = args[:first_name]
    @last_name = args[:last_name]
    @company = args[:company]
    @phone = args[:phone]
    @email = args[:email]

    @commands = {
      :delete => "DELETE FROM contacts WHERE id='#{@id}';",
      :delete_matching => "DELETE FROM contacts_groups WHERE contact_id='#{@id}';",
      :exists => "SELECT * FROM contacts WHERE id='#{@id}';",
      :insert => "INSERT INTO contacts
                    (id, first_name, last_name, company, phone, email)
                  VALUES
                    ('#{@id}','#{@first_name}', '#{@last_name}', '#{@company}', '#{@phone}', '#{@email}');",
      :update =>  "UPDATE contacts SET
                    id = '#{@id}',
                    first_name = '#{@first_name}',
                    last_name = '#{@last_name}',
                    company = '#{@company}',
                    phone = '#{@phone}',
                    email = '#{@email}'
                  WHERE id='#{@id}'"
    }
  end
end


class Group < AddressBookObject
  attr_accessor :id, :group_name

  def initialize(args)
    @id = args[:id]
    @group_name = args[:group_name]

    @commands = {
      :delete => "DELETE FROM groups WHERE id='#{@id}';",
      :delete_matching => "DELETE FROM contacts_groups WHERE group_id='#{@id}';",
      :exists => "SELECT * FROM groups WHERE id='#{@id}';",
      :insert => "INSERT INTO groups
                    (id, group_name)
                  VALUES
                    ('#{@id}','#{@group_name}');",
      :update =>  "UPDATE groups SET
                    id = '#{@id}',
                    group_name = '#{@group_name}'
                  WHERE id='#{@id}'"
    }
  end
end


class ContactGroup < AddressBookObject
  attr_accessor :id, :contact_id, :group_id

  def initialize(args)
    @id = args[:id]
    @contact_id = args[:contact_id]
    @group_id = args[:group_id]

    @commands = {
      :delete => "DELETE FROM contacts_groups WHERE id='#{@id}';",
      :exists => "SELECT * FROM contacts_groups WHERE id='#{@id}';",
      :insert => "INSERT INTO contacts_groups
                    (id, contact_id, group_id)
                  VALUES
                    ('#{@id}', '#{contact_id}', '#{@group_id}');",
      :update =>  "UPDATE groups SET
                    id = '#{@id}',
                    contact_id = '#{contact_id}',
                    group_id = '#{@group_id}'
                  WHERE id='#{@id}'"
    }
  end
end


#-----DRIVERS-----

# # 1. Adding George Bush:
# martha = Contact.new({
#                   :id => 7,
#                   :first_name => "Martha",
#                   :last_name => "Smith",
#                   :company => "Google",
#                   :phone => "1-800-1234",
#                   :email => "martha@google.com"
#                   })
# martha.save!


# # 2. Updating George Bush:
# bush.first_name = "Martha"
# bush.save!

# 3. Adding a group:
# former_presidents = Group.new({:id => 4, :group_name => "Some Former Presidents"})
# former_presidents.save!


# # 4. Updating a group:
# former_presidents.group_name = "Disliked Former Presidents"
# former_presidents.save!

# # 5. Deleting a contact:
# bush.delete!

#6. Adding ContactGroup
# johns_group = ContactGroup.new({:id => 34, :contact_id => 4, :group_id => 2})
# johns_group.save!