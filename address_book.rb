require_relative 'setup.rb'
require 'sqlite3'

module AddressBook

	def self.select_all_contacts
    $db.execute(
            <<-SQL
      SELECT * FROM contacts;
      SQL
    )
	end

	def self.select_all_groups
		$db.execute(
			<<-SQL
			SELECT * FROM groups;
			SQL
			)
	end

	def self.select_all_contacts_groups
		$db.execute(
			<<-SQL
			SELECT * FROM contacts_groups;
			SQL
			)
	end

	def self.add_contact(contact)
		$db.execute(
			<<-SQL
			INSERT INTO contacts
			(first_name, last_name, company, phone_number, email, created_at, updated_at)
			values
			('#{contact.first_name}', '#{contact.last_name}', '#{contact.company}', 
				'#{contact.phone_number}', '#{contact.email}', DATETIME('now'), DATETIME('now'));
			SQL
			)
	end


	def self.add_group(group)
		$db.execute(
			<<-SQL
			INSERT INTO groups
			(name, created_at, updated_at)
			values
			('#{group.name}', DATETIME('now'), DATETIME('now'));
			SQL
			)
	end
end

class Contact
	attr_accessor :first_name, :last_name, :company, :phone_number, :email

	def initialize(params = {})
		@first_name = params[:first_name]
		@last_name = params[:last_name]
		@company = params[:company]
		@phone_number = params[:phone_number]
		@email = params[:email]
	end

end

class Group
	attr_accessor :name

	def initialize(params = {})
		@name = params[:name]
	end
end


AddressBookDB::drop_tables
AddressBookDB::setup
AddressBookDB::seed

p AddressBook::select_all_contacts
p AddressBook::select_all_groups
p AddressBook::select_all_contacts_groups

# Release 2: Add a contact

contact = Contact.new(first_name: "Kevin", last_name: "Federline",
											company: "addidas", phone_number: "123-123-1234",
											email: "kfed@email.com")

AddressBook::add_contact(contact)
p AddressBook::select_all_contacts

group = Group.new(name: 'exes')

AddressBook::add_group(group)
p AddressBook::select_all_groups