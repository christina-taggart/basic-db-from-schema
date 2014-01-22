require 'sqlite3'
$db = SQLite3::Database.new 'address_book.db'

class Contact

  attr_accessor :id, :first_name, :last_name, :company, :phone, :email
  def initialize(contact)
    @id = get_id
    @first_name = contact.fetch(:first_name)
    @last_name = contact.fetch(:last_name) {nil}
    @company = contact.fetch(:company) {nil}
    @phone = contact.fetch(:phone) {nil}
    @email = contact.fetch(:email) {nil}
    @created_at = Time.now
  end

  def get_id
    id = $db.execute(
      <<-SQL
        SELECT id FROM contacts ORDER BY id DESC LIMIT 1;
      SQL
      ).flatten.first + 1
    id
  end

  def save
    if exists?
      $db.execute(
        <<-SQL
          UPDATE contacts SET first_name = '#{@first_name}', last_name = '#{@last_name}', company = '#{@company}', phone = '#{@phone}', email = '#{@email}', updated_at = '#{Time.now}' WHERE id = '{@id}';
        SQL
        )
    else
      $db.execute(
        <<-SQL
          INSERT INTO contacts
            (first_name, last_name, company, phone, email, created_at, updated_at)
          VALUES
            ('#{@first_name}','#{@last_name}','#{@company}','#{@phone}', '#{@email}', '#{@created_at}', DATETIME('now'));
        SQL
      )
    end
  end

  def id
    $db.execute(
      <<-SQL
        SELECT id FROM contacts WHERE first_name = '#{@first_name}' and created_at = '#{@created_at}';
      SQL
      )
  end

  def exists?
    $db.execute(
      <<-SQL
        SELECT EXISTS (SELECT * FROM contacts WHERE id = '#{@id}');
      SQL
      ).flatten.first == 1
  end
end

class Groups
end

thor = Contact.new({first_name: "Chris"})
thor.save
thor.first_name = "Donald"
thor.save
