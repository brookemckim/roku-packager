require 'net/telnet'
require 'roku-packager/genkey_output'

module RokuPackager
  class KeyGen
    class ConnectionError < StandardError; end
    class GenerationError < StandardError; end

    def initialize(roku_hostname)
      @hostname = roku_hostname
    end

    def create
      dev_id, password = parse(generate)

      if dev_id && password
        [dev_id, password]
      else
        raise GenerationError, 'Error generating credentials'
      end
    end

    def generate
      output_from_connection = ''

      connection.cmd('genkey') do |output|
        output_from_connection << output
      end
    rescue Timeout::Error
      output_from_connection
    end

    def connection
      @connection ||= Net::Telnet::new("Host" => @hostname, "Port" => '8080')
    rescue Errno::ECONNREFUSED
      raise ConnectionError, 'Connection to device was refused. Possibly wrong host.'
    rescue Timeout::Error
      raise ConnectionError, 'Connection to device failed. Host is possibly down.'
    end

    private

    include GenkeyOutput
  end
end
