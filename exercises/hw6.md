## 1. What is the difference between concurrency and parallelism?

**Answer:**  
Concurrency means multiple tasks are in progress conceptually (may interleave on a single core).  
Parallelism means tasks actually run at the same time on different CPU cores.  
Concurrency = program structure; parallelism = real simultaneous execution.

---

## 2. What is the difference between a thread and a task in Java? Give an example.

**Answer:**  
A **thread** is an OS/JVM execution unit (`Thread`).  
A **task** is a unit of work (`Runnable`/`Callable`) that can run on any thread in an executor.

**Example:**
```java
ExecutorService ex = Executors.newFixedThreadPool(4);
ex.submit(() -> System.out.println("task")); // task runs on pool thread

Thread t = new Thread(() -> System.out.println("thread"));
t.start(); // actual thread
```

---

## 3. What happens if you invoke a method on a thread that has terminated in Java? If you call an entry on a task that has terminated in Ada?

**Answer:**  
**Java:**  
- Calling `start()` again → `IllegalThreadStateException`.  
- Methods like `isAlive()` and `join()` work normally and reflect that the thread has terminated.

**Ada:**  
- Calling an entry on a terminated task is a bounded error; usually raises `Tasking_Error`.

---

## 4. Explain, for Ada, Java, and Go, when, exactly, a program terminates.

**Answer:**  
- **Java:** The program terminates when all **non-daemon threads** finish.  
- **Go:** The program terminates when the **main goroutine returns**; other goroutines are not waited for.  
- **Ada:** The program terminates when the **environment task** and all **dependent tasks** terminate.

---

## 5. In Go, what is the difference between a buffered and unbuffered channel? Provide an example of when you would use each.

**Answer:**  
- **Unbuffered channel:** send/receive block until the other side is ready.  
  - Use for synchronous handoff.

- **Buffered channel:** can hold N values; send blocks only when full.  
  - Use when producer and consumer work at different speeds.

---

## 6. Explain the difference between a mutex and a read-write mutex (RWMutex) in Go. When would you choose one over the other?

**Answer:**  
- **Mutex:** exclusive lock; one goroutine at a time.  
- **RWMutex:** many readers allowed, writers exclusive.

Use **Mutex** when writes are frequent.  
Use **RWMutex** when reads dominate.

---

## 7. What happens if you try to read from or write to a closed channel in Go? How can you detect if a channel is closed?

**Answer:**  
- **Read from closed channel:** returns zero value + `ok=false`.  
- **Write to closed channel:** panic (`send on closed channel`).

**Detect closed channel:**
```go
v, ok := <-ch
if !ok {
    // channel is closed
}
```

---

## 8. Describe the select statement in Go and how it differs from a switch statement. What happens when multiple channels in a select are ready simultaneously?

**Answer:**  
- `select` chooses among channel operations; `switch` chooses among expressions.  
- `select` blocks until one case is ready (unless `default` exists).  
- If multiple cases are ready, Go chooses **one at random**.
