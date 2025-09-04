**1. What is meant by filtering a list? Give an example that uses a built-in filter function in the language of your choice.**

**Definition**  
Filtering a list means selecting only those elements from the list that satisfy a given condition (called a *predicate*). The result is a new list containing only the desired elements, while discarding the rest.

**Example in Python**  
```python
numbers = [1, 2, 3, 4, 5, 6]

# Keep only even numbers
evens = list(filter(lambda x: x % 2 == 0, numbers))

print(evens)  # Output: [2, 4, 6]
```

**2. Give a compact Julia expression for the array just like the array called numbers except that every value is cubed. Use broadcasting.**

```julia
numbers .^ 3
```
