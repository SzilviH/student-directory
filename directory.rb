# let's put all students into an array
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create and empty array
  students = []
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
    students << {name: name, cohort: cohort.to_sym} # cohort string is converted to symbol
    if students.count == 1
      puts "Now we have #{students.count} student"
    else
      puts "Now we have #{students.count} students"
    end
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  students.each_with_index do |student, index|
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_by_cohort(students)
  cohorts = students.map {|student| student[:cohort]}.uniq
  cohorts.each do |cohort|
    puts "#{cohort} cohort: "
    students.each do |student|
      if student[:cohort] == cohort
        puts student[:name]
      end
    end
  end
end

def print_footer(names)
  if names.count > 1
    puts "Overall, we have #{names.count} great students"
  else
    puts "Overall, we have #{names.count} great student"
  end
end

students = input_students
# Nothing happens until we call the methods
print_header
#print(students)
print_by_cohort(students)
print_footer(students)
