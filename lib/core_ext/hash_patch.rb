class Hash
  def symbolize_keys
    inject({ }) do |options, (key, value)|
      new_key = case key
      when String
        if key.to_i.eql? 0
          key.to_sym
        else
          key.to_i
        end
      end
      
      new_value = case value
      when Hash then value.symbolize_keys
      else value
      end
      
      options[new_key] = new_value
      options
    end
  end

  def symbolize_keys!
    self.replace(self.symbolize_keys)
  end
end
