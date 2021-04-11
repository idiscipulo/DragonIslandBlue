
# REGIA

## File Layout
For files defining a class, use the template outlined below.

#### Initialize
Initialize the class in the first two lines.

```lua
Example = {}
Example.__index = Example
```

#### Header Comment
Comment the class name and a short description

```lua
-------------
-- EXAMPLE --
-------------
-- this is an example class
```

#### Constructor
Create the class instance and set it's namespace
```lua
function Example:new(exampleParam)
    example = {}
    setmetatable(example, Example)
```

Define attributes, then return the instance.

```lua
    --------------------------
    -- INITIALIZE VARIABLES --
    --------------------------
    example.val = exampleParam
    
    return example
end
```
    
### Completed File

```lua
Example = {}
Example.__index = Example

-------------
-- EXAMPLE --
-------------
-- this is an example class
function Example:new(exampleParam)
    example = {}
    setmetatable(example, Example)
    
    --------------------------
    -- INITIALIZE VARIABLES --
    --------------------------
    example.val = exampleParam
    
    return example
end
```
