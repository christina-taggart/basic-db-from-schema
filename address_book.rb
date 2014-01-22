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

end


AddressBookDB::drop_tables
AddressBookDB::setup
AddressBookDB::seed

p AddressBook::select_all_contacts
p AddressBook::select_all_groups
p AddressBook::select_all_contacts_groups