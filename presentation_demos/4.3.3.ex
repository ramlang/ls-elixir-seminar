defimpl Collectable, for: TodoList do
  # Returns appender lambda
  def into(original) do
    # Define a function to be called?
    collector_fun = fn
      todo_list_acc, {:cont, entry} ->
        TodoList.add_entry(todo_list_acc, entry)

      todo_list_acc, :done ->
        todo_list_acc

      _todo_list_acc, :halt ->
        :ok
    end
    
    # initialize the empty collection to accumulate into
    initial_acc = original

    # return a tuple with  accumulator and callback function
    {initial_acc, collector_fun}
  end 
end

# Equiavlent to above implementation of Collectable protocol
defimpl Collectable, for: TodoList do
  def into(original) do
    {original, &into_callback/2}
  end

  # Appender implementation
  defp into_callback(todo_list, {:cont, entry}) do
    TodoList.add_entry(todo_list, entry)
  end

  defp into_callback(todo_list, :done), do: todo_list
  defp into_callback(todo_list, :halt), do: :ok
end

# defimpl Collectable, for: MapSet do
#   def into(map_set) do
#     collector_fun = fn
#       map_set_acc, {:cont, elem} ->
#         MapSet.put(map_set_acc, elem)

#       map_set_acc, :done ->
#         map_set_acc

#       _map_set_acc, :halt ->
#         :ok
#     end

#   initial_acc = map_set

#   {initial_acc, collector_fun}
#   end
# end

# Enum.into([1, 2, 3], MapSet.new())