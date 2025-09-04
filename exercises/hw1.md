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

## 3. What is meant by the phrase “pragmatics of programming languages”?

**Definition**  
Pragmatics refers to the practical aspects of how programming languages are used in the real world. It goes beyond syntax (form) and semantics (meaning) to focus on how languages are actually applied.

**Key Points**  
- Efficiency of implementation  
- Tooling (compilers, IDEs, debuggers)  
- Ecosystem and libraries  
- Readability and maintainability  
- Suitability for particular domains  

**Summary**  
Pragmatics is about how well a language serves its users in practice, not just how it is formally defined.

## 4. Explain, in detail, this fragment of K: `{+/x[&x!2]^2}`

**Step by Step Explanation**  
- `x!2` → computes `x mod 2` for each element, distinguishing even and odd values.  
- `&x!2` → returns the indices where `x mod 2` is non-zero (the odd elements).  
- `x[&x!2]` → selects the odd elements from `x`.  
- `^2` → squares those odd numbers.  
- `+/` → sums the squared results.  

**Meaning**  
The function takes an array `x`, extracts the odd numbers, squares them, and returns their sum.

## 5. What does the term object-orientation mean today? What did it originally mean?

**Originally (Simula, 1960s)**  
Object-orientation was about modeling real-world entities using objects with state and behavior. It focused on:  
- Classes  
- Inheritance  
- Simulation of systems  

**Today**  
The meaning has broadened. Object-orientation now emphasizes:  
- Encapsulation  
- Inheritance and polymorphism  
- Interfaces and design patterns  
- Reuse and maintainability  

**Summary**  
Originally, OOP was primarily a way to model real-world systems. Today, it is a comprehensive approach to organizing code for flexibility, reuse, and long-term maintainability.

## 6. What characters comprise the following string: `ᐊᐃᓐᖓᐃ`?

**Characters (Inuktitut syllabics):**  
1. ᐊ — U+140A, CANADIAN SYLLABICS A  
2. ᐃ — U+1403, CANADIAN SYLLABICS I  
3. ᓐ — U+14D0, CANADIAN SYLLABICS N  
4. ᖓ — U+1593, CANADIAN SYLLABICS NNGAA  
5. ᐃ — U+1403, CANADIAN SYLLABICS I  

**Meaning**  
The string spells *“Ainngai”*, which in Inuktitut commonly means *“okay,” “alright,” or “fine.”*

## 7. What is the difference between control flow and concurrency?

**Control Flow**  
The order in which instructions are executed within a single thread of a program.  
Examples: sequencing, loops, conditionals, and function calls.

**Concurrency**  
The ability of a program to deal with multiple tasks at once, either by interleaving execution or running them in parallel.  
Examples: threads, asynchronous programming, distributed processes.

**Summary**  
- Control flow = "what happens next" in one line of execution.  
- Concurrency = "how to manage many things happening" at the same time.

## 8. How do machine and assembly languages differ? Give an example.

**Machine Language**  
The raw binary instructions that a CPU executes directly. Difficult for humans to read or write.

**Assembly Language**  
A human-readable representation of machine instructions using symbolic mnemonics. Easier for humans to work with, but still very close to the hardware.

**Example**

Machine code (binary):

```text
10110000 01100001
```

Assembly (x86):
```asm
mov al, 97   ; load the number 97 into register AL
```
**Summary**
Machine language is what the computer executes. Assembly language is a human-readable shorthand for those same instructions.

