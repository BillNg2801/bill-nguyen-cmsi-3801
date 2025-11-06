## 1. Java Keywords for Instance/Subclass Control

- **(a) No instances:** `abstract` — abstract classes cannot be instantiated  
- **(b) Only fixed number of instances:** `enum` — enums define a fixed set of instances  
- **(c) No subclasses:** `final` — final classes cannot be subclassed  
- **(d) Only fixed number of subclasses:** `sealed` — sealed classes restrict which classes can extend them

---

## 2. Four Main Differences Between Swift Class and Struct

1. **Reference vs Value Type** — Classes are reference types (passed by reference); structs are value types (copied on assignment).  
2. **Inheritance** — Classes can inherit from other classes; structs cannot.  
3. **Deinitializers** — Classes can define `deinit` for cleanup; structs cannot.  
4. **Identity** — Classes support identity checks (`===`); structs only have equality (`==`).

---

## 3. Swift and Null References

Swift **does not have null references.**  
It prevents the “billion-dollar mistake” by using **optionals** (`T?`), which explicitly represent the presence or absence of a value.

Example:
var name: String? = nil      // Optional String
var age: String = "John"     // Cannot be nil

// Must explicitly unwrap:
if let unwrapped = name {
    print(unwrapped)
}

Nullability is explicit in the type system — you must declare types as optional (`T?`) to hold `nil`, forcing developers to handle the nil case safely.

---

## 4. List<Dog> to List<Animal> Assignment

❌ **Not allowed.**  
This should not be permitted for **type safety** reasons.

If it were allowed:
List<Dog> dogs = new ArrayList<>();
List<Animal> animals = dogs;  // If this were allowed...
animals.add(new Cat());       // Now a Cat is inside a List<Dog>!

Mutable collections must be **invariant** to preserve type safety and avoid violating the **Liskov Substitution Principle**.

---

## 5. Swift’s Void Type

Swift’s `Void` is **weirdly named** because it’s actually a **unit type**, represented as an **empty tuple `()`**, not like C’s `void`.

Their “excuse”:  
typealias Void = ()

So while C’s `void` means “no value,” Swift’s `Void` *is* a value — the empty tuple.

---

## 6. Type of a Supplier in Swift

A supplier is a **function that takes no parameters and returns a value**:

() -> T

Example:
let supplier: () -> Int = { return 42 }

---

## 7. Yegor Bugayenko on Alan Kay

Alan Kay regretted using the term “object” because people focused on objects rather than **messaging**.  
Bugayenko argued Kay was wrong to regret it — since **true objects already encapsulate behavior and communicate only through messages**, which was Kay’s intended vision of OOP.

---

## 8. Class-based vs Prototype-based OOP

**Class-based OOP**
- Objects are instances of classes  
- Behavior defined in class blueprints  
- Inheritance through class hierarchies  
- Examples: Java, C++, Python

**Prototype-based OOP**
- No classes — objects inherit directly from other objects (prototypes)  
- Inheritance via delegation/cloning  
- More dynamic and flexible  
- Example: JavaScript

---

## 9. What Java Records Auto-Generate

Java `record`s automatically generate:
- Private `final` fields for all components  
- A **canonical constructor** (with all parameters)  
- **Getter** methods (named after fields, e.g. `a()`, `b()`)  
- **equals()** method (value-based equality)  
- **hashCode()** method (based on all fields)  
- **toString()** method (formatted string representation)  
- Implicitly **final** class (cannot be subclassed)

---

## 10. Java Companion Objects Equivalent

Java does **not** have companion objects like Kotlin.  
Instead, programmers use **static members and methods** inside classes to hold shared or type-level behavior.

Example:
class Person {
    private String name;
    public Person(String name) { this.name = name; }

    // "Companion-like" static factory method
    public static Person create(String name) {
        return new Person(name);
    }
}

// Usage:
Person p = Person.create("Alice");

Here, the `create()` static method plays the same role a Kotlin companion object would serve.

