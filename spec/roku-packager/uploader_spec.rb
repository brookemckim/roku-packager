require 'spec_helper'

describe RokuPackager::Uploader do
  before do
    @uploader = RokuPackager::Uploader.new("192.168.0.10")
  end

  describe '#run' do
    it 'deletes and then uploads the file' do
      @uploader.expects(:delete)
      @uploader.expects(:upload).with('afile')

      @uploader.run('afile')
    end
  end

  describe '#url' do
    it 'builds a proper url' do
      @uploader.url.must_equal URI("http://192.168.0.10/plugin_install")
    end
  end
end
