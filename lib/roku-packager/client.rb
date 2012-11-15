require 'roku-packager/key_gen'
require 'roku-packager/uploader'
require 'roku-packager/packager'

module RokuPackager
  class Client
    def initialize(development_roku_ip, logger = NullLogger)
      @host = development_roku_ip
      @logger = logger
    end

    attr_reader :password, :dev_id, :download_url

    def package(name, path_to_application_zip)
      @logger.info 'Generating keys...'
      @dev_id, @password = KeyGen.new(@host).create

      @logger.info 'Uploading application file...'
      Uploader.new(@host).upload(path_to_application_zip)

      @logger.info 'Building package...'
      uri = Packager.new(@host, name, @password).submit

      uri.to_s
    end
  end

  class NullLogger
    def info
    end
  end
end
