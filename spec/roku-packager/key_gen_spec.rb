require 'spec_helper'

describe RokuPackager::KeyGen do
  describe '#create' do
    before do
      @key_gen = RokuPackager::KeyGen.new('192.168.1.10')
    end

    it 'returns parsed_output' do
      @key_gen.expects(:generate).returns('output_from_device')
      @key_gen.expects(:parse)
        .with('output_from_device').returns(['devid', 'password'])

      @key_gen.create.must_equal ['devid', 'password']
    end

    it 'raises exception if dev_id is nil' do
      @key_gen.stubs(:generate).returns(nil)
      @key_gen.stubs(:parse).returns([nil, 'password'])

      lambda {
        @key_gen.create
      }.must_raise RokuPackager::KeyGen::GenerationError
    end

    it 'raises exception if password is nil' do
      @key_gen.stubs(:generate).returns(nil)
      @key_gen.stubs(:parse).returns(['devid', nil])

      lambda {
        @key_gen.create
      }.must_raise RokuPackager::KeyGen::GenerationError
    end
  end
end

