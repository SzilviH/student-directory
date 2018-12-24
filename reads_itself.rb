puts __FILE__

file = File.open(__FILE__, "r")
file.readlines.each do |line|
  puts line
end
