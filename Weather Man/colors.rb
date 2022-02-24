# Adding colors to the String class to use for logging into console
class String
  def red
    "\e[32m#{self}\e[0m"
  end

  def blue
    "\e[34m#{self}\e[0m"
  end
end