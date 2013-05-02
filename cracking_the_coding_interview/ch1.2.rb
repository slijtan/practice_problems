class String
  def my_reverse!
    replace split('').inject { |new_str, char| "#{char}#{new_str}" }
  end
end
