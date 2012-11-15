require 'uri'
require 'rest_client'

module RokuPackager
  class Uploader
    def initialize(host)
      @host = host
    end

    def run(file)
      delete
      upload(file)
    end

    def upload(file)
      parameters = { archive: File.new(file), mysubmit: 'Replace' }
      RestClient.post url.to_s, parameters
    end

    def delete
      parameters = { mysubmit: 'Delete', archive: nil, multipart: true }
      RestClient.post url.to_s, parameters
    end

    def url
      @url ||= URI::HTTP.build(host: @host, path: '/plugin_install')
    end
  end
end
