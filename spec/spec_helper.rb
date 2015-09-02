module Kernel
  # For testing purposes. Never do this
  def print(msg = '')
    ($output ||= []) << msg
  end
  def puts(msg = '')
    ($output ||= []) << msg
  end
  # Oh god never do this
  def gets
    Struct.new(:chomp).new
  end
end

# Overriding Todo methods for easier testing
class Todo
  def get_input
    ($input ||= []).last #Use our global input instead of asking for actual user input
  end
  def save!
    nil # Don't change our test file
  end
end
# Dont touch ^^^


