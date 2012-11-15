require 'spec_helper'

describe RokuPackager::GenkeyOutput do
  before do
    class Genkey
      extend RokuPackager::GenkeyOutput
    end

    @output =<<EOF
.
.
.
.
+
+
+
Password: jO3nThMQZxaAMSH2a1mIiw==
DevID: 65b331d470432d609fec8c5f78e09683559e56b9
>
EOF
  end

  it 'parses out devid and password' do
    Genkey.parse(@output).must_equal [
      '65b331d470432d609fec8c5f78e09683559e56b9',
      'jO3nThMQZxaAMSH2a1mIiw=='
    ]
  end
end
