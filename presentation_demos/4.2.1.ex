defmodule TodoList do
  defstruct auto_id: 1, entries: %{}

  def new(), do: %TodoList{}

  def add_entry(todo_list, entry) do
    # sets new entry id
    entry = Map.put(entry, :id, todo_list.auto_id)

    # adds new entry to the entries list
    new_entries = Map.put(
      todo_list.entries,
      todo_list.auto_id,
      entry
    )

    # updates the struct
    %TodoList{todo_list |
      entries: new_entries,
      auto_id: todo_list.auto_id + 1
    }
  end

  def entries(todo_list, date) do
    # transformation happens in a single pass
    todo_list.entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end
end

