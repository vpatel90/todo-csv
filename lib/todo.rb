require 'csv'

class Todo

  def initialize(file_name)
    @file_name = file_name #Don't touch this line or var
    # You will need to read from your CSV here and assign them to the @todos variable. make sure headers are set to true
    @todos = CSV.read(@file_name, {headers: true})
    #require 'pry'; binding.pry
  end

  def start
    loop do
      system('clear')

      puts "---- TODO.rb ----"

      view_todos
      view_complete

      puts
      puts "What would you like to do?"
      puts "1) Exit 2) Add Todo 3) Mark Todo As Complete 4) Edit Todo 5) Delete Todo"
      print " > "
      action = gets.chomp.to_i
      case action
      when 1 then exit
      when 2 then add_todo
      when 3 then mark_todo
      when 4 then edit_todo
      when 5 then delete_todo
      else
        puts "\a"
        puts "Not a valid choice"
      end
      save!
    end
  end

  def edit_todo
    puts "Which one do you want to edit?"
    num = get_input.to_i
    puts "How should I change it?"
    message = get_input.to_s
    @todos[num - 1]["name"] = message
  end

  def delete_todo
    puts "What do you want to delete?"
    num = get_input.to_i
    @todos.delete(num - 1)
  end

  def view_todos
    puts "Unfinished"
    @todos.select { |todo| todo["completed"] == "no" }.each_with_index do |todo, index|
      puts "#{index + 1}) #{todo["name"]}"
    end
  end

  def view_complete
    puts "Completed"
    @todos.select { |todo| todo["completed"] == "yes" }.each_with_index do |todo, index|
      puts "#{index + 1}) #{todo["name"]}"
    end
  end

  def add_todo
    print "Name of Todo > "
    @todos.push([get_input,"no"])
  end

  def mark_todo
    print "Which todo have you finished?"
    num = get_input.to_i
    @todos[num - 1]["completed"] = "yes"
  end

  def todos
    @todos
  end

  private # Don't edit the below methods, but use them to get player input and to save the csv file
  def get_input
    gets.chomp
  end

  def save!
    File.write(@file_name, @todos.to_csv)
  end
end
