class Task
  attr_reader :id, :description, :done
  attr_accessor :title
  def initialize(attr={})
    @id = attr[:id] || attr["id"]
    @title = attr[:title] || attr["title"]
    @description = attr[:description] || attr["description"]
    @done = attr[:done] || attr["done"] || (0 ? false : true)
  end

  def self.find(id)
    result = DB.execute("SELECT * FROM tasks WHERE id =?", id)
    return nil if result.empty?
    result = result[0]
    Task.new(result)
  end

  def save
    id ? update : create
  end

  def self.all
    results = DB.execute("SELECT * FROM tasks")
    return [] if results.empty?
    results.map { |task_hash| Task.new(task_hash) }
  end

  def destroy
    DB.execute("DELETE FROM tasks WHERE id = ?", id)
  end

private

  def create
    DB.execute("INSERT INTO tasks (title, description, done)
      VALUES (?,?,?)", title, description, done ? 1 : 0)
      @id = DB.last_insert_row_id
  end

  def update
    DB.execute("UPDATE tasks SET title = ?, description = ?, done = ? WHERE id = ?", title, description, done ? 1 : 0, id)
  end

end
