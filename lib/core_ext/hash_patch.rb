class Hash
  def symbolize_keys
    inject({ }) do |options, (key, value)|
      new_key = case key
      when String
        Integer(key) rescue key.to_sym
      end
      
      new_value = case value
      when Hash then value.symbolize_keys
      when String
        Integer(value) rescue value
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
