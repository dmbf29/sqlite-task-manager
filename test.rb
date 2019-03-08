require "sqlite3"
DB = SQLite3::Database.new("tasks.db")
DB.results_as_hash = true
require_relative "task"

# TODO: CRUD some tasks
task = Task.find(1)
puts "#{task.title} - #{task.description}"

new_task = Task.new(title: "find a apart", description: "huge")
new_task.save
puts new_task.id
new_task.title = "drink wine"
new_task.save
puts new_task.title

Task.find(1).destroy
Task.find(2).destroy
Task.find(3).destroy
Task.find(4).destroy
Task.find(5).destroy


Task.all.each do |task|
  puts "[#{task.done == 1 ? "X" : " "}] #{task.title} - #{task.description}"
end


