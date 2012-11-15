module RokuPackager
  module GenkeyOutput
    def parse(output)
      dev_id, password = nil, nil

      if (match = /Password: (\S*)/.match(output))
        password = match[1]
      end

      if (match = /DevID: (\S*)/.match(output))
        dev_id = match[1]
      end

      [dev_id, password]
    end
  end
end
