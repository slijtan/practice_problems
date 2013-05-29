class String
  def encode_spaces
    res = ''
    each_char do |char|
      res << (char == ' ' ? "%20" : char)
    end

    self.replace(res)
  end
end
