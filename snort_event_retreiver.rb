#!/usr/bin/ruby
#Ensure the config.yml file is created in the same directory as snort_event_receiver.rb
#Configure config.yml with the MySQL DB info
require 'mysql'
require 'json'
require 'rest-client'
require 'yaml'

begin
  while(true)
    pwd = File.expand_path(File.dirname(__FILE__))
    config = YAML.load_file("#{pwd}/config.yml")
    con = Mysql.new config['host'], config['user'], config['password'], config['database']
    rs = con.query "SELECT * FROM event WHERE abuse_sent IS NULL"
    rs.each_hash do |row|
       timestamp = row['timestamp']
       cid = row['cid']
       RestClient.post "http://localhost:3000/snort_event_collectors", row.to_json, {content_type: :json, accept: :json}
       update = con.query "UPDATE event set abuse_sent = 'Y' where timestamp = '#{timestamp}' and cid = '#{cid}'"
    end      
  end
rescue Mysql::Error => e
    puts e    
ensure
    con.close if con
end
