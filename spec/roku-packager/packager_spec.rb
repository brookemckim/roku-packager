require 'spec_helper'

describe RokuPackager::Packager do
  before do
    host = '192.168.0.10'
    name_and_version = 'Lol 1.0'
    password = 'sporks'

    @packager = RokuPackager::Packager.new(host, name_and_version, password)
  end

  describe '#url' do
    it 'builds a the proper url' do
      @packager.url.must_equal URI('http://192.168.0.10/plugin_package')
    end
  end

  describe '#submit' do
    it 'builds a download url for the submitted package' do
      @packager.expects(:submission_response).returns(nil)
      @packager.expects(:pull_out_relative_package_path).returns([nil,'pkg/blah.zip'])

      @packager.submit.must_equal URI('http://192.168.0.10/pkg/blah.zip')
    end
  end
end

