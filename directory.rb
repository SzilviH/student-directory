require 'csv'
@students = [] # an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list"
  puts "4. Load the list"
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    puts "Taking student details..."
    input_students
  when "2"
    puts "Showing student list..."
    show_students
  when "3"
    puts "Student details saved."
    save_students
  when "4"
    puts "Loading student records..."
    load_students
  when "9"
    puts "Good bye!"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you mean, try again"
  end
end

def add_students(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # get cohort
    puts "What cohort are they in? Please provide month."
    cohort = STDIN.gets.chomp
    # if input is empty, default value will be November
    if cohort == ""
      cohort = "november"
    end
    # add the student and their cohort hash to the array
    add_students(name, cohort)
    if @students.count == 1
      puts "Now we have #{@students.count} student"
    else
      puts "Now we have #{@students.count} students"
    end
    # get another name from the user
    name = STDIN.gets.chomp
  end
  # return the array of students
  @students
  puts "Students details received"
  puts "-------------------------"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students_list
  @students.each_with_index do |student, index|
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  if @students.count > 1
    puts "Overall, we have #{@students.count} great students"
  else
    puts "Overall, we have #{@students.count} great student"
  end
end

def save_students
  puts "Enter the filename to save the students' details to:"
  filename = gets.chomp
  if filename.nil?
    filename = "students.csv"
  end
  file = File.open(filename + ".csv", "w") do |file|
  # iterate over the array of students
    CSV.open(filename, "w") do |csv_object|
      @students.each do |student|
        student_data = [student[:name], student[:cohort]]
        csv_object << student_data
      end
    end 
  end
end

def load_students
  puts "What file do you want to load the students from?"
  filename = gets.chomp
  if filename.empty?
    filename = "students.csv"
  end
  file = CSV.foreach(filename, "r") do |row|
    name, cohort = row[0], row[1]
    add_students
  end
end

def try_load_students
  ARGV != nil ? filename = ARGV.first : filename = "students.csv"
  return if filename.nil?
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

try_load_students
interactive_menu
