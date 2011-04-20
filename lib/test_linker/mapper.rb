require 'happymapper'

class MethodResponse
  class Value
    include HappyMapper

    element :string, String
  end

  class Param
    include HappyMapper

    element :value, Value
  end

  class Params
    include HappyMapper

    has_many :params, Param
  end
end

