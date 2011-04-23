=begin
require 'happymapper'

class MethodResponse
  class Value
    include HappyMapper

    element :string, String
  end

  class Params
    include HappyMapper

    #has_many :params, Param
    has_many :values, Value
  end
end
=end

require 'roxml'

class MethodResponse
  include ROXML

  
end
