
# REGIA

## Style Guide
This guide outlines the formatting and commenting conventions for this project.

### Classes
For files that define a class, use the following conventions.

#### Declaration and Constructor
```lua
Example = {}
Example.__index = Example

-------------
-- EXAMPLE --
-------------
-- this is an example class
function Example:new(exampleParam)
    local example = {}
    setmetatable(example, Example)
    
    --------------------------
    -- INITIALIZE VARIABLES --
    --------------------------
    example.val = exampleParam
    
    return example
end
```
Lua classes are created using tables and namespaces. In the first two lines we create the table for the class and use `Example.__index = Example` to create the namespace. Then, a block comment with the class name and short description of the class. In the constructor method `new` we create a table for the class instance and use `setmetatable(example, Example)` to set the namespace. We then initialize the attributes for the class (yes, the comment is necessary) and finally, return the instance
