#include <stdexcept>
#include <string>
#include <memory>

#define MAX_CAPACITY 32768
#define INITIAL_CAPACITY 16

template <typename T>
class Stack {
  std::unique_ptr<T[]> elements;
  int capacity;
  int top;

  Stack(const Stack&) = delete;
  Stack& operator=(const Stack&) = delete;
  Stack(Stack&&) = delete;
  Stack& operator=(Stack&&) = delete;

public:
  Stack() : capacity(INITIAL_CAPACITY), top(-1) {
    elements = std::make_unique<T[]>(INITIAL_CAPACITY);
  }

  int size() const {
    return top + 1;
  }

  bool is_empty() const {
    return top == -1;
  }

  bool is_full() const {
    return size() >= MAX_CAPACITY;
  }

  void push(const T& item) {
    if (is_full()) {
      throw std::overflow_error("Stack has reached maximum capacity");
    }

    if (size() >= capacity) {
      int new_capacity = capacity * 2;
      if (new_capacity > MAX_CAPACITY) {
        new_capacity = MAX_CAPACITY;
      }
      reallocate(new_capacity);
    }

    top++;
    elements[top] = item;
  }

  T pop() {
    if (is_empty()) {
      throw std::underflow_error("cannot pop from empty stack");
    }

    T result = elements[top];
    top--;

    if (capacity > INITIAL_CAPACITY && size() < capacity / 4) {
      int new_capacity = capacity / 2;
      if (new_capacity < INITIAL_CAPACITY) {
        new_capacity = INITIAL_CAPACITY;
      }
      reallocate(new_capacity);
    }

    return result;
  }

private:
  void reallocate(int new_capacity) {
    if (new_capacity > MAX_CAPACITY) {
      throw std::overflow_error("Stack has reached maximum capacity");
    }

    std::unique_ptr<T[]> new_elements = std::make_unique<T[]>(new_capacity);
    
    int current_size = size();
    for (int i = 0; i < current_size; i++) {
      new_elements[i] = elements[i];
    }

    elements = std::move(new_elements);
    capacity = new_capacity;
  }
};

