class TodoList
  attr_accessor :auto_id, :entries

  def initialize(new_entries=[])
    @auto_id = 1
    @entries = {}
    add_entries(new_entries)
  end

  def add_entries(new_entries)
    new_entries.each do |entry|
      add_entry(entry)
    end
  end

  def add_entry(entry)
    entries[auto_id] = entry
    self.auto_id += 1
    entries
  end

  def entries_by_date(date)
    entries.select { |id, entry| entry[:date] == date }
  end

  def update_entry(new_entry)
     return ":error" unless new_entry.class == Hash

     update_entry_2(new_entry[:id], new_entry)
  end

  def update_entry_2(entry_id, new_entry)
    if entries[entry_id]
      entries[entry_id] = new_entry
    else
      entries
    end
  end

  def delete_entry(entry_id)
    entries.delete(entry_id)
  end

  def to_s
    entries.each do |id, entry|
      puts "\n" + ("*" * 80) + "\n"
      puts "#{entry[:topic]}".center(80)
      puts "#{entry[:date]}".center(80)
      puts "Presented by #{entry[:names].join(" and ")}".center(80)
    end
  end
end

schedule = [
  {
    date: "2023-02-16",
    topic: "First Steps", 
    names: ["Felicia", "Tyler"]
  },
  {
    date: "2023-02-23",
    topic: "Building Blocks",
    names: ["Mai", "Mary"]
  },
  {
    date: "2023-03-02",
    topic: "Control Flow",
    names: ["Giuseppe", "Patrick"]
  },
  {
    date: "2023-03-09",
    topic: "Data Abstractions",
    names: ["Sarah", "Rachele"]
  },
  {
    date: "2023-03-16",
    topic: "Concurrency Primitives",
    names: ["David", "Tim"]
  },
  {
    date: "2023-03-23",
    topic: "Generic Server Processes",
    names: ["Felicia", "Tyler"]
  },
  {
    date: "2023-03-30",
    topic: "Building a Concurrent System",
    names: ["James", "Stephen"]
  },
  {
    date: "2023-04-06",
    topic: "Fault-Tolerance Basics",
    names: ["Joshua", "Troy"]
  },
]

elixir_seminar_todos = TodoList.new(schedule)
event = elixir_seminar_todos.entries_by_date("2023-03-09")

p event
p elixir_seminar_todos.add_entry(event[4])
puts elixir_seminar_todos