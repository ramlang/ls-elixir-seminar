defmodule MultiDictionary do
  def new(), do: %{}

  def add(dictionary, key, value) do
    Map.update(dictionary, key, [value], &[value | &1])
  end

  def get(dictionary, key) do
    Map.get(dictionary, key, [])
  end
end

defmodule TodoList do
  def new(), do: MultiDictionary.new()

  def add_entry(todo_list, date, title) do
    MultiDictionary.add(todo_list, date, title)
  end

  def entries(todo_list, date) do
    MultiDictionary.get(todo_list, date)
  end
end
