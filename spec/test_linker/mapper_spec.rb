require_relative '../spec_helper'

require 'test_linker/mapper'

#describe Mapper do
describe MethodResponse do
#describe Value do
  it "parses a response" do
    #response = Value.parse(RESPONSE[:about])
    #response = Param.parse(RESPONSE[:about])
    #response = Params.parse(RESPONSE[:about])
    response = MethodResponse::Params.parse(RESPONSE[:about])
    puts response.inspect
  end
end
