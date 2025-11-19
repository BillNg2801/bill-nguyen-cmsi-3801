## 1. Meaning of the C Declarations

- **`double *a[n];`** — `a` is an array of n pointers to double  
- **`double (*b)[n];`** — `b` is a pointer to an array of n doubles  
- **`double (*c[n])();`** — `c` is an array of n pointers to functions returning double  
- **`double (*d())[n];`** — `d` is a function returning a pointer to an array of n doubles

---

## 2. When Arrays Decay to Pointers in C

Arrays decay to pointers in almost all expressions.

They do **NOT** decay when:  
- operand of `sizeof`  
- operand of `_Alignof`  
- operand of unary `&`  
- used as an array initializer

Function parameters:  
`T a[]` and `T a[N]` automatically adjust to `T *a`.

---

## 3. Short C Memory-Safety Terms (≤ 10 words)

- **Memory leak** — Lost heap allocation; cannot be freed  
- **Dangling pointer** — Points to freed or invalid memory  
- **Double free** — Freeing same memory twice  
- **Buffer overflow** — Writing outside allocated bounds  
- **Stack overflow** — Stack space exhausted  
- **Wild pointer** — Uninitialized or invalid pointer

---

## 4. Why C++ Moves Only Work on R-Values

Moves steal resources and leave the source object empty-but-valid.  
Safe only for r-values (temporaries), not for l-values you still use.

---

## 5. Why C++ Has Moves

- Efficient ownership transfer  
- Avoid deep copies  
- Cheap returns of large objects  
- Enables efficient container growth  
- Keeps RAII + value semantics fast

---

## 6. Rule of 5 in C++

If a class manages resources, consider all:

1. Destructor  
2. Copy constructor  
3. Copy assignment  
4. Move constructor  
5. Move assignment  

Implement/delete/default them consistently.

---

## 7. Rust Ownership Rules

1. Each value has one owner  
2. Dropped when owner leaves scope  
3. Moves instead of implicit copies

---

## 8. Rust Borrowing Rules

1. Unlimited immutable borrows  
2. Only one mutable borrow at a time  
3. References must not outlive data

