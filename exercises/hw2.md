## 1. Why is the null reference so hideous?


Because any reference might secretly be null, every access must be checked or else the program can crash.
This has caused decades of bugs, security holes, and confusion — which is why Tony Hoare later called it his “billion-dollar mistake.”


## 2. Why did Tony Hoare introduce the null reference, even though he felt like it was wrong and his friend Edsger Dijkstra said it was a bad idea?


In 1965, while designing ALGOL W, Hoare added null as a simple, efficient way to mean “no object”.

It was easy to implement, worked naturally with pointers, and made optional parameters/structures possible.
Hoare himself felt uneasy, and Edsger Dijkstra warned him it was unsafe.

Still, at the time, better alternatives (like Option/Maybe types) weren’t common, so null seemed like the practical choice.


## 3. In JavaScript 3**35 = 50031545098999710 but in Python 3**35 = 50031545098999707. Which one is right and which is wrong? Why? Explain exactly why the right value is right and the wrong value is that particular wrong value. 


The exact math result of 3**35 is:
50031545098999707

Python integers have arbitrary precision.
So 3**35 is computed exactly:
50031545098999707

JavaScript numbers are 64-bit floating-point (IEEE-754 doubles).
They can only exactly represent integers up to about 9e15.

3**35 is bigger than that, so it gets rounded to the nearest double. Accodring to JavaScript the answer is:
50031545098999710

## 4. What is the Python equivalent of JavaScript’s {x: 3, [y]: 5, z}?

**In Python, the closest equivalent is:**

```
d = {"x": 3, y: 5, "z": z}
```

- "x": 3 → same
- y: 5 → key from variable y
- "z": z → explicit key "z" with value from variable z

**Difference:**

Python doesn’t have object-literal shorthand (z → z: z) or [computed] keys inside {} like JS. You just write them out explicitly.

## 5. Why is it best to not call JavaScript’s == operator “equals” (even though people do it all the time)?

Because == doesn’t mean true equality — it does loose equality with type coercion.
That means JavaScript changes types behind the scenes before comparing, leading to odd results:

```
0 == "0"      // true
false == "0"  // true
null == undefined // true
NaN == NaN    // false
```

So calling it “equals” is misleading.
The proper name is “loose equality”, while === is “strict equality” (no coercion).

## 6. Write a Lua function called arithmeticsequence that accepts two arguments, start and delta, that returns a coroutine such that each time it is resumed it yields the next value in the arithmetic sequence starting with start and incrementing by delta.

```
function arithmeticsequence(start, delta)
  return coroutine.create(function()
    local value = start
    while true do
      coroutine.yield(value)
      value = value + delta
    end
  end)
end
```

## 7. 

**(a) Static (Lexical) Scoping**

Global x = 1
f() → returns x from the lexical environment (where f was defined).
- f is defined in the global scope, so it always returns global x = 1.
So:
- f() = 1
h():
- Inside h, local x = 9.
- Then it calls g().
g():
- Inside g, local x = 3.
- Then it calls f().
f() (under static scope):
-Still looks up global x = 1 (ignores h’s or g’s locals).
-So returns 1.
So g() = 1 → h() = 1.

Substitute:
```
f() * h() - x 
= 1 * 1 - 1 
= -1
```

**(b) Dynamic Scoping**

Dynamic scoping resolves variables using the call stack, not the lexical definition.

Global x = 1
f() when called directly:
- No local x in f.
- Looks at caller = global scope → finds x = 1.
- So f() = 1.
h():
- Creates local x = 9.
- Calls g().
g():
- Creates local x = 3.
- Calls f().
f() (under dynamic scoping):
- No local x inside f.
- Looks at caller = g(), and there x = 3.
- So f() returns 3 this time.
So g() = 3 → h() = 3.

Substitute:
```
f() * h() - x
= (1) * (3) - 1
= 2
```
