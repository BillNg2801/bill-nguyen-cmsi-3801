## 1. Show how to constructively define the type of trees of elements of type *t*

We can define trees recursively:

```
data Tree t = Leaf t | Node (Tree t) (Tree t)
```

A tree is either a single element (`Leaf`) or two subtrees combined (`Node`).

---

## 2. Give a definition by cases for the exponentiation of natural numbers

By cases on the exponent:

- a^0 = 1  
- a^(n+1) = a^n * a

---

## 3. (a) Which are the inhabitants of Bool + Unit?  
(b) Which are the inhabitants of Bool | Unit?

**(a)** `Bool + Unit` → `inl True`, `inl False`, `inr ()`  
**(b)** `Bool | Unit` → `True`, `False`, `()`

---

## 4. (a) Which are the inhabitants of Bool × Unit?  
(b) Which are the inhabitants of Bool → Unit?

**(a)** `Bool × Unit` → `(True, ())`, `(False, ())`  
**(b)** `Bool → Unit` → only one function: everything maps to `()`

---

## 5. What are the major arguments put forward in *The String Type is Broken?*

- “String” mixes bytes and text, which leads to encoding bugs.  
- Most languages treat strings like byte arrays, not actual text.  
- This causes issues with Unicode, slicing, and invalid states.  
- It’s better to have separate `Bytes` and `Text` types with explicit encodings.  
- That makes programs safer, cleaner, and less error-prone.

---

## 6. Can you give a type to `(λx. (x x))(λx. (x x))`?  
If so, what is it? If not, why not?

That expression is the classic Ω — it loops forever.

In the simply-typed lambda calculus, it **cannot** be typed because it would require a type `T` such that `T = T → T`.

If recursive types are allowed, it can have:  
`T = μt. t → t`

---

## 7. Represent `x ∉ A` in function notation

If a set is treated as a predicate function `A(x)`, then:

```
x ∉ A  ≡  ¬A(x)
```

or equivalently `A(x) = False`.

---

## 8. What is a pure function? Why do we care about these things?

A pure function always gives the same result for the same input and doesn’t change anything outside itself.

We care because pure functions are predictable, easy to test, and safe to reuse or parallelize.

---

## 9. How does Haskell isolate pure and impure code?

Haskell uses its **type system** to keep effects separate.  
Pure functions stay pure, while impure operations (like I/O) are wrapped in types like `IO a` or `ST s a`.

That way, you can see which functions are pure just by looking at their types.

---

## 10. In TypeScript, which of `|` or `&` is closer to subclassing or inheritance from Python? Why?

`&` (intersection) is more like inheritance — it combines multiple types into one that includes everything from each.

`|` (union) means “either one or the other,” not both.

Example:

```
type A = { a: number };
type B = { b: string };
type AB = A & B;  // like subclassing, has both a and b
```

