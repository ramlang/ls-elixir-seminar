# Peer-led Elixir Seminar: Week 4 Data Abstractions
### March 5th 2023

### How does the way Elixir implements abstractions differ from object oriented langauges like Ruby?
- Elixir has...
    - pure _stateless_ modules (stateless as in there are no attributes)
    - explicit calls to module functions and data is passed _in_.
    - "decoupling" or separation of the data from the code
    - deals with immuatble data (must be saved to variables, but can always roll back to original like Mary talked about in Week 2)
- Ruby has...
    - classes and objects (objects have states/behaviors)
    - classes instaniate objects then these objects have methods called _on_ them (behaviors)
    - we can access state and behaviors can be used to access data so code and data are intertwined
    - data is not (always) immutable so we can call a method on an object without having to save the result to a new var

### What are the main takeaways of data abstraction in Elixir?
1. MODULES abstract data (remember modules are stateless with pure fns)
2. INSTANCE OF DATA ABSTRACTION is _usually_ the first ARGUMENT for a module fn (explicit call)
3. MODIFIER FNUNCTIONS transform data and return same data type modified
4. QUERY FUNCTIONS return deets on the abstraction (doesn't have to be same data type ex: length of Map)

### For my own understanding: What is the difference between an instance of an abstraction (module) and instance of a class in OOP?
- Elixir has a `new()` function and Ruby has a `#new` method so I'm confused???
- Elixir has instance of abstractions, but really these instances are, in this example, empty data types (empty Map)
- Elixir must have the instance of the abstraction passed into the modules functions, even though it's an instance of that module (in constrast to Ruby where we just call methods on the object itself since it has state)
- We don't access "properties" of the abstraction (like objects in JS) or attributes by calling methods on the instance of the abstraction (like objects in Ruby)
- I think it's correct to say the instance of the abstraction have "state" since they contain data, but modules do not have state since the instance (or data) must be provided to the module function???
- DATA MUST BE PROVIDED TO THE MODULE FUNCTION BECAUSE MODULE IS STATELESS
- You don't pass an object as an argument into a method call on itself in Ruby.

### What are structs? Why are they useful?
- Good way to distinguish between custom abstraction and other data types at runtime (when we want to assert it's a struct this occurs at runtime)
- Structs are basically maps, so adding (or binding) a struct to a module provides a way to customize abstraction from the start (like in Ruby we pass in arguments to `#new` to give an object initial values)
- **new** only fields defined in `defstruct` can exist in the strcut (no new fields can be added)
- A moudle can only define one struct and structs must be inside a module
- Speical struct syntax allows you to differeniate between struct and other types with pattern matching `%Module_name{}`
- In summary structs provide distinction to custom types and lets us list fields with default values

### What's the difference between structs and Maps?
- Something that is not different is the performance and memory usage (it's the same for both)
- For both you can also use dot notation to access values
- Structs will only behave according to the module definition they are contained within
- We can't call a function on structs if those functions aren't defined in the module
- We can't call `Enum` functions but we can call `Map` functions (since structs are basically `Map`s)
**Q:** _Does Map have access to Enum? I guess maybe there is no inheritance. If map is enumerable, but a struct is a map (special map) I wonder why it can't call Enum functions???_
**A:** "Notice that we referred to structs as bare maps because none of the protocols implemented for maps are available for structs." - Elixir Docs
- `__struct__: module_name` key value pairs are included in every struct for free

### What's the deal with records?
- It's an Erland thing

### How transparent is your data in Elixir? Is this a good thing or a bad thing?
- Very transparent since you can always obtain information from a strcut or instance abstraction
- Encapsulation is different in Elixir (modules are stateless so the data has no where to hide)
- Remember the 2nd main takeaway is the first argument is usually the instance of the abstraction, so it's always accessible.
- Additionally the functions themselves if like the 3rd takeaway are modifier functions, they are going to return the modified instance of the abstraction so the data is accessible there too.
- Good since being able to look into the data is useful for debugging purposes
- Bad if you don't know what you are doing, but think you do and then you ruin it
- Better to rely on functions to modify the data for you since that's what they are for

### Working with hierarchical data in Elixir even though data is immutable is easy, right?
- WRONG
- If you want to change data in hierarchical structure (what is hierarchical? Collection? Nested?) you have to go about it in different stages
- Each modification must be saves to a new variable since we are working with immutable data
- We must make modifications, transform what we wish, trasnform ancestors, and return a transformed copy
- Actually not so bad if you break it up into smaller functions
- My mental model: Like wrapping presents, but remembering you forgot to include an item, so you have to unwrap the entire gift, and then wrap it back up all over again to get the same (but now slighlty different) gift as before.

### The defintion of polymorphism threw me off. I thought it had to do with inheritance and ducks?
- The way it's phrased in the book is equivalent to "What shall I, the all powerful BEAM runtime, execute based on this data that was given to me just now?"
- When you think about it in Ruby when we have polymorphism various data types can call the same method, but it's at runtime when Ruby take a journey on the method look up path to pick a method to execute.
- Protocols are used to do something really similar.

### What are protocols? What is the OOP equivalent?
- A protocol is a module `defprotocol Protocol_name`
- A protocol contains function declarations, but eerily without any implementation details
- The generic logic is found in the functions declarations within the protocol?
- Then for each data type you can provide protocol implemenation using  `defimpl Protocol_name` and `for:`
- The argument passed to the generic logici in the protocol determines which implementaiton to execute
- My mental model: A function gets called, Elixir soldiers call a "code String" or "code Map" ("code red"), Elixir soliders need to follow protocol on how to deal with current circumstances, they can only deal with the type of code if the protocol is implemented with that data type, or else they panic and raise an error.
- Protocol implementations can be anywhere in your program

### Does Elixir come with built-in protocols, or do I have to do everything myself?
- `String.Chars`, `List.Chars`, `Enumerable`, `Collectable`, and much more I'm sure.
- `Enumerable` is cool since it gives access to both `Enum` and `Stream` functions.
