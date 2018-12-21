@students = [] # an empty array accessible to all methods

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # get cohort
    puts "What cohort are they in? Please provide month."
    cohort = gets.chomp
    # if input is empty, default value will be November
    if cohort == ""
      cohort = "november"
    end
    # add the student and their cohort hash to the array
    @students << {name: name, cohort: cohort.to_sym} # cohort string is converted to symbol
    if @students.count == 1
      puts "Now we have #{@students.count} student"
    else
      puts "Now we have #{@students.count} students"
    end
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  @students
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you mean, try again"
  end
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
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

=begin
def print_by_cohort(students)
  cohorts = @students.map {|student| student[:cohort]}.uniq
  cohorts.each do |cohort|
    puts "#{cohort} cohort: "
    @students.each do |student|
      if student[:cohort] == cohort
        puts student[:name]
      end
    end
  end
end
=end 

def print_footer
  if @students.count > 1
    puts "Overall, we have #{@students.count} great students"
  else
    puts "Overall, we have #{@students.count} great student"
  end
end

interactive_menu
