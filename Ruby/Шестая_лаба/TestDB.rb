require 'mysql2'


client = Mysql2::Client.new(
  :host => "localhost",
  :username => "root",
  :database => "stuff"
)

def test_select(client)
  results = client.query("SELECT * FROM employees")
  results.each do |row|
    puts row
  end
end


test_select client