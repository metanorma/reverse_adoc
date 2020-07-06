module ReverseAdoc
  class Error < StandardError
  end

  class UnknownTagError < Error
  end

  class InvalidConfigurationError < Error
  end
end
