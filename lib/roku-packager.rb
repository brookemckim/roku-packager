require 'roku-packager/version'
require 'roku-packager/client'

module RokuPackager
  def self.new(*args)
    Client.new(*args)
  end
end
