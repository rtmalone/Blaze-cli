require 'rubygems'
require 'bundler/setup'
require 'active_record'

project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + "/../models/*.rb").each{|f| require f}

require 'database'
require 'logger'

class Environment
  def self.environment= environment
    @@environment = environment
  end

  def self.database_connection
    connection_details = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection
  end

  def self.logger
    @@logger ||= Logger.new("log/#{@@environment}.log")
  end
end
