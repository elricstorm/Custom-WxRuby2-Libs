module ConfigurationFiles

  class ConfigReader
    
    attr_reader :file,:configuration

    def initialize(file,configuration=[])
      @file = file
      @configuration = configuration
    end

    def config_reader
      unless @file.nil?
        @file.each do |key, value|
          @configuration[key.to_sym] = value
        end
        return @configuration
      end
    end

    def config_update(ext)
      unless ext.nil?
        ext.each do |key, value|
          @configuration[key.to_sym] = value
        end
        return @configuration
      end
    end

    def config_destroy
      @configuration = []
    end
    
  end

end
