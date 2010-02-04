# This module houses the ConfigReader class and the 
# ConfigTranslator class which both were developed
# to parse and read configuration files.  The files
# are developed much like apache config files and
# read similarly.
module ConfigurationFiles
  # This class reads through the translated key/value
  # pairs of each hash array and sets the configuration
  # data to @configuration[:somename].  The value can
  # then be translated by the program into usable data.
  class ConfigReader
    # normal attribute reader variables
    attr_reader :file,:configuration
    # This method is setting up our file and configuration vars.
    # The configuration var being passed to it is a hash array.
    def initialize(file,configuration=[])
      @file = file
      @configuration = configuration
    end
    # This method reads through the initial @file that was
    # first initialized through the new class and sets the
    # configuration vars to @configuration[:name] where :name
    # is the name of the key on each line.
    def config_reader
      unless @file.nil?
        @file.each do |key, value|
          @configuration[key.to_sym] = value
        end
        return @configuration
      end
    end
    # This method does exactly what config_reader does except
    # that it's being passed a file extension which is different
    # than the initial file first ready through the new class
    # instantiation.  It then updates all keys within the
    # configuration file.  This is an updater method.
    def config_update(ext)
      unless ext.nil?
        ext.each do |key, value|
          @configuration[key.to_sym] = value
        end
        return @configuration
      end
    end
    # This method destroys the keys within the configuration file.
    def config_destroy
      @configuration = []
    end    
  end
  # This class translates files into key/value hash pairs,
  # skipping any # comment lines.  Each key/value is stored
  # in a hash.
  class ConfigTranslator
    # standard attribute of file
    attr_reader :file
    # This method initializes @file.
    def initialize(file)
      @file = file
    end
    # This method creates a config hash, and then reads the
    # existing file line by line, stripping out all comments
    # within the file.  It then stores the key=value into
    # the hash and returns the hash to be read by the
    # ConfigReader class.
    def file_config
      config = {}
      unless !File.exists?(@file)
        File.foreach(@file) do |line|
          line.strip!
          # Skip comments and whitespace
          if (line[0] != ?# and line =~ /\S/ )
            i = line.index('=')
            if (i)
              config[line[0..i - 1].strip] = line[i + 1..-1].strip
            else
              config[line] = ''
            end
          end
        end
      else
        config = nil
      end
      return config
    end
  end

end
