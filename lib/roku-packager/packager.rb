require 'rest-client'
require 'time'

module RokuPackager
  class Packager
    def initialize(host, name_and_version, password)
      @host = host
      @name_and_version = name_and_version
      @password = password
    end

    def submit
      relative_path = pull_out_relative_package_path(submission_response)

      URI::HTTP.build(host: @host, path: '/' + relative_path)
    end

    def submission_response
      parameters = { passwd: @password,
                     pkg_time: Time.now.to_i,
                     app_name: @name_and_version,
                     mysubmit: 'Package',
                     multipart: true }

      RestClient.post url.to_s, parameters
    end

    def url
      @url ||= URI::HTTP.build(host: @host, path: '/plugin_package')
    end

    private

      def pull_out_relative_package_path(html_body)
        /a href=\\"(pkgs\S*)\\">/.match(html_body)[1]
      end
  end
end
