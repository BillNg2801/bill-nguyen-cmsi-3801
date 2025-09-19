## 1. Why is the null reference so hideous?␣␣


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
