March 6th 2023

# Elixir in Action: Chapter 4 Data Abstractions

  

## 4.1.1 Basic Abstractions

***

  

### Task

  

_Create a data abstraction to represent a todo list and define the following functions: `TodoList.add_entry` and `TodoList.entries`. For `TodoList.entries`, if a date cannot be found return an empty List._

  

<br>

<br>

  

### Problem

_Build a todo list abstraction that can:_

- _Add a single todo item_

- _Get a single todo item_

  

_Requirements_

- _Abstraction must represent a list of entries_

- _Abstraction should built on top of an existing data type_

	- _List: include multiple types and uniqueness is not enforced_

	- _Tuples: intended as fixed size containers for multiple elements._

	- _Keyword Lists: atom keys, ordered keys, uniqueness of keys not enforced._

	- _Map: Keys of any type, no duplicate keys, unordered._

- _Working with date and title for each entry_

  

<br>

  

### Examples

```elixir

# Run the code...

todo_list = TodoList.new() |>
  TodoList.add_entry(~D[2023-03-09], "Data Abstractions Presentation") |>
  TodoList.add_entry(~D[2023-03-09], "RB119 Assessment Study Group") |>
  TodoList.add_entry(~D[2023-03-10], "RB109 Interview")


TodoList.entries(todo_list, ~D[2023-03-09])

TodoList.entries(todo_list, ~D[2023-01-01])

```

  

<br>

  

_Remember pipeline operator provides first argument to next function so..._

```elixir

TodoList.new() |>
TodoList.add_entry(~D[2023-03-09], "Data Abstractions Presentation")

```

  

_...is the same as this:_

  

```elixir

todo_list = TodoList.new()
TodoList.add_entry(todo_list, ~D[2023-03-09], "Data Abstractions Presentation")

```

  

<br>

  

_Notes_

- _`new()` returns a todo list, but we have to manually add all the todo items_

- _The arguments provided to the `add_entry` function are (todo abstraction, date, todo)_

- _The arguments provided to the `entries` function are: (abstraction, date)_

- _Date appears to be used a key to obtain value that is a List_

- _When a date that does not exist is provided as an argument, an empty List is returned_

  

<br>

  

### Data Structures

  

- _For the todo list we will use a Map `%{}`_

- _For the entries we will use a List `[]`_

  

<br>

  

### Algorithm

```elixir

# Define a module TodoList

  

# Define new/0

# Input: none

# Output: `%{}`

  

# Define add_entry/3

# Input: todo_list, date, title

# Output: updated todo_list

  
# Add entry to abstraction using date as a key and a List for value

# => Use `Map.update/4` with the arguments: map, key, initial_value, updater_lambda

# => if value exists updater_lambda should take existing value and returns new value added to top of current values

# => else if no value exists then Map.update/4 updates with initial value

  

# Define entries/2

# Input: todo_list, date

# Output: list of titles

# Use `Map.get/3` with the arguments: map, key, default_return

```

  

<br>

<br>

<br>

<br>

<br>

<br>

<br>

<br>

<br>

  

## 4.1.2 Composing Abstractions

***

  

### Task

_Move the generic functionality within the TodoList to another abstraction. Refactor the TodoList to make use of this newly created abstraction._

  

<br>

<br>

  

### Examples

```elixir

# Run the code...

TodoList.entries(todo_list, ~D[2023-03-09])
TodoList.entries(todo_list, ~D[2023-01-01])

```

  

### Updated Algorithm

```elixir

# Define a module TodoList

  

# Define new/0

# Input: none

# Output: MultiDictionary abstraction

  

# Define add_entry/3

# Input: todo_list, date, topic, names

# Output: updated todo_list


# Add new_entry to abstraction using date as a key and a List for value

# => Use `MultiDictionary.add/3` function withthe arguments: dictionary, key, value

  

# Define entries/2

# Input: todo_list, date

# Output: single todo-item


# Use `MultiDictionary.get/2` with the arguments: dictionary, key

```

  

<br>

<br>

<br>

<br>

<br>

<br>

<br>

<br>

<br>

  
  

## 4.1.3 Structuring data with maps

***

  

### Examples

```elixir

todo_list = TodoList.new() |>
  TodoList.add_entry(
    %{date: ~D[2023-03-09], title: "Data Abstractions Presentation"})

  TodoList.entries(todo_list, ~D[2023-03-09])

```

  

### Data Structures

- _For the todo list we will use a MultiDictionary (Map) `%{}`_

- _For the entries we will use a structured Map..._

```elixir

%{date: ~D[2023-01-01], title: "example"}

```

  

<br>

  

### Updated Algorithm

```elixir
# ...

  
# Define add_entry/2

# Input: todo_list, entry

# Output: updated todo_list


# Add entry to abstraction using entry.date as a key and an entry as value

# => Use `MultiDictionary.add/3` function withthe arguments: dictionary> # key, value

  
# ...
```

  

<br>

<br>

<br>

<br>

<br>

<br>

<br>

<br>

<br>

  
  

## 4.2.1 Working with hierarchical data

***

### Task

_We want to provide update and delete functions for the todo list abstraction. In order to do so we must make sure each entry can be uniquely identified._

  

<br>

<br>

  

### Problem

  

_Update our todo list so we can:_

- _Uniquely identify each entry_

  

_Requirements_

- _Use a key to target a single entry to update or delete_

- _Remove implementation of MultiDictionary since each key will now only be associated with one value verses having our date key for multiple entries_

- _The unique id should be assigned and incremented for each entry added_

- _Every TodoList abstraction should now have two pieces of info: id and entries_

  

<br>

  

### Examples

```elixir

# Run the code...

todo_list = TodoList.new() |>
  TodoList.add_entry(
  %{date: ~D[2023-03-09], title: "Data Abstractions Presentation"}) |>
  TodoList.add_entry(
  %{date: ~D[2023-03-09], title: "RB119 Assessment Study Group"}) |>
  TodoList.add_entry(
  %{date: ~D[2023-03-10], title: "RB109 Interview"})

TodoList.entries(todo_list, ~D[2023-03-09])

```

  

<br>

  

### Data Structures

- _Todo list will be changed into a struct..._

```elixir

%TodoList{auto_id: 1, entries: %{}}

```

  

<br>

  

### Algorithm

```elixir

# Define a struct with id and entries fields

# assign both default values

  

# Update new/0

# Input: none

# Output: `%ToddoList{}`

  

# Update add_entry/2

# Input: todo_list, entry

# Output: updated struct

  

# Add an id field to entry and assign id value

# => Use `Map.put/3` with arguments map, key, and value

  

# Using the id as a key add new entry to entries

# => Use `Map.put/3` again

  

# Update struct with updated entries

  

# Update struct id by incrementing value for the next added entry

  

# Update entries/2

# Input: todo_list, date

# Output: list of entries

  

# Iterate through entries of todo list

  

# => Use `Stream.filter/2` with arguments enum and fn to select elements according to fn

  

# - Check if the entry date matches the argument date

  

# - Return filtered map with tuple key/value pairs since each element is {key, value} during iteration

  

# => Use `Enum.map/2` with arguments enum and fn to transform map into list of entry values only

```

  

<br>

<br>

<br>

<br>

<br>

<br>

<br>

<br>

<br>

  

## 4.2.2 Updating entries

***

### Task

_Add functions that will allow us to update or delete a single entry. An error does not need to be raised if the entry does not exist._

  

<br>

<br>

### Problem
_Update our todo list so we can:_

- _Update an existing todo item_

- _Delete an existing todo item_

  

### Examples

```elixir

# Run the code...

todo_list = TodoList.new() |>
  TodoList.add_entry(
  %{date: ~D[2023-03-09], title: "Data Abstractions Presentation"}) |>
  TodoList.add_entry(
  %{date: ~D[2023-03-09], title: "RB119 Assessment Study Group"}) |>
  TodoList.add_entry(
  %{date: ~D[2023-03-10], title: "RB109 Interview"})



TodoList.delete_entry(todo_list, 1)

TodoList.update_entry(
  todo_list,
  3,
  &Map.put(&1, :title, "Work on LS215 exercises")
)

TodoList.update_entry(
  todo_list,
  %{date: ~D[2023-03-10], id: 3, title: "Read Elixir in Action Chapter 5"}
)

  

```

  

### Algorithm

```elixir

# Define update_entry/3

# Input: todo_list, id, update_lambda

# Output: updated todo_list

  
# if `Map.fetch/2` with arguments map and key does not find entry

# => return unchanged list

# else if key exists

# => check that old entry id matches the new entry id with pattern matching

# => save entry to variable to pass to updater function if it is a map
  
# => create new entry by calling udpated function

# => create new entries using `Map.put/3` with arguments map, key, value

# => Return updated todo struct

# Define delete_entry/2

# Use the `Map.delete/2` function to remove an element from a Map

```

  

### Refactor

```elixir

# Define update_entry/2

# Input: todo list, new_entry (pattern match to Map)

# Output: updated struct

  
# Use `TodoList.update_entry/3` function with arguments todo_list, id, updater_lambda

# The id arg can be obtained from new_entry

# Updater function returns new_entry

```

  

<br>

<br>

<br>

<br>

<br>

<br>

<br>

<br>

<br>

  

## 4.2.3 Immutable hierarchical updates

***

```elixir

todo_list = %{
  1  => %{date: ~D[2023-03-09], title: "Data Abstractions Presentation"},
  2  => %{date: ~D[2023-03-09], title: "RB119 Assessment Study Group"},
  3  => %{date: ~D[2023-03-10], title: "RB109 Interview"}
}

  

# put_in accepts a path and value as an argument
put_in(todo_list[3].title, "Work on LS215 exercises")

```

<br>

<br>

<br>

<br>

<br>

<br>

<br>

<br>

<br>

  

## 4.2.4 Iterative updates

***

### Task

_Update your TodoLlist abstraction so it can perform iterative updates. The new function should now accept a List as an argument and add each element of the list to entries. If no argument is given then no entries are added to the todo list._

  

<br>

<br>

  

### Examples

```elixir

# Run the code...

entries = [
  %{date: ~D[2023-03-09], title: "Data Abstractions Presentation"},
  %{date: ~D[2023-03-09], title: "RB119 Assessment Study Group"},
  %{date: ~D[2023-03-10], title: "RB109 Interview"}
]

TodoList.new(entries)

```

  
  

### Algorithm

```elixir

# Define new/1

# Input: list

# Output: todo list struct

  
# If no argument is provided the default should be an empty list

# Use `Enum.reduce/3` with arguments enumerable, acc, fn to build TodoList entries

# => Define fn with arguments entry and acc

# => Use `add_entry/2` with arguments todo_list and entry for each iteration

# => Every entry will be added to the accumulator which will be returned

```

  

<br>

<br>

<br>

<br>

<br>

<br>

<br>

<br>

<br>

  

## Collectable TodoList

***

  

### Task

_Make the todo list collectable. In other words, we would like to be able to provide a list of entries and add them to an empty todo list abstraction using comprehensions like `for` or `Enum.into/2` directly._

  

<br>

<br>

  

### Problem

_Update our todo list so it's collectable..._

  

_What does it mean to be collectable?_

- _Take a collection and put elements in a specified collection._

  

_What do we need the `Collectable` protocol for?_

- _By implementing the `Collectable` protocol for TodoList we can use the function `Enum.into/2` and use our TodoList with comprehensions that rely on the `Collectable.into/1` protocol that we must define._

  

_How is `Collectable` different from `Enumerable`?_

- _Enumerable is more about taking values out of a collection, and Collectable is about collecting them. For example, `Enum.reduce/3` is basically the opposite of `Collectable.into/1`._

  

### Examples

```elixir

# Run the code...

entries = [
  %{date: ~D[2023-03-09], title: "Data Abstractions Presentation"},
  %{date: ~D[2023-03-09], title: "RB119 Assessment Study Group"},
  %{date: ~D[2023-03-10], title: "RB109 Interview"}
]


for entry <- entries, into: TodoList.new(), do: entry

```

  

### Algorithm

```elixir

# Implement Collectable protocol for our TodoList struct abstraction

  

# Define implementation of into/1

# Input: list of entries

# Output: tuple with entries and fn


# this fn gets invoked by generic code

# return appender lambda (collector fn)


# Define private into_callback/2

# Input: todo list, tuple

# Output: updated todo list (todo list acc)

  
# Use the `TodoList.add_entry/2` function to add the entry for each element

  

# Define private into_callback/2'

# Input: todo list, hint (:done)

# Output: todo list

  

# Define into_callback/2

# Input: todo list, hint (:halt)

# Ouput: todo list as is

```
