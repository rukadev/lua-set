# lua-set
A module for implementing a set data structure in lua

## API

### union

```lua
set:union(a: set, b: set): table
```
Returns the union of set a and set b

---

### intersection

```lua
set:intersection(a: set, b: set): table
```

Returns the intersection of set a and b

---

### add

```lua
set:add(key: any): nil
```

Add key to set

---

### remove

```lua
set:remove(key: any): nil
```

Remove key from set

---

### contains

```lua
set:contains(key: any): bool
```

Returns true if the set contains the key

---

### get

Returns the set items

```lua
set:get(): table
```

