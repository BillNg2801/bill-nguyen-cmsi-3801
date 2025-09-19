from typing import List, Callable, Any, Generator, Optional, Union, Tuple


def first_then_apply(strings: List[str], predicate: Callable[[str], bool], function: Callable[[str], Any]) -> Optional[Any]:
    for s in strings:
        if predicate(s):
            return function(s)
    return None


_SENTINEL = object()

def say(word=_SENTINEL) -> Union[str, Callable[[str], Union[str, Callable]]]:
    if word is _SENTINEL:
        return ""
    
    def say_inner(next_word=_SENTINEL) -> Union[str, Callable]:
        if next_word is _SENTINEL:
            return word
        else:
            accumulated = word + " " + next_word
            return say(accumulated)
    
    return say_inner


def powers_generator(*, base: int, limit: int) -> Generator[int, None, None]:
    power = 1
    while power <= limit:
        yield power
        power *= base


def meaningful_line_count(filename: str) -> int:
    count = 0
    with open(filename, 'r') as file:
        for line in file:
            stripped = line.strip()
            if stripped and not stripped.startswith('#'):
                count += 1
    return count


class Quaternion:
    def __init__(self, a: float = 0.0, b: float = 0.0, c: float = 0.0, d: float = 0.0):
        self.a = float(a)
        self.b = float(b)
        self.c = float(c)
        self.d = float(d)
        # Make the object immutable
        object.__setattr__(self, '__frozen', True)
    
    def __setattr__(self, name, value):
        if hasattr(self, '__frozen'):
            raise AttributeError(f"Can't modify attribute {name} of frozen Quaternion")
        super().__setattr__(name, value)
    
    @property
    def coefficients(self) -> Tuple[float, float, float, float]:
        return (self.a, self.b, self.c, self.d)
    
    @property
    def conjugate(self) -> 'Quaternion':
        return Quaternion(self.a, -self.b, -self.c, -self.d)
    
    def __add__(self, other: 'Quaternion') -> 'Quaternion':
        return Quaternion(
            self.a + other.a,
            self.b + other.b,
            self.c + other.c,
            self.d + other.d
        )
    
    def __mul__(self, other: 'Quaternion') -> 'Quaternion':
        return Quaternion(
            self.a * other.a - self.b * other.b - self.c * other.c - self.d * other.d,
            self.a * other.b + self.b * other.a + self.c * other.d - self.d * other.c,
            self.a * other.c - self.b * other.d + self.c * other.a + self.d * other.b,
            self.a * other.d + self.b * other.c - self.c * other.b + self.d * other.a
        )
    
    def __eq__(self, other: object) -> bool:
        if not isinstance(other, Quaternion):
            return False
        return (self.a == other.a and 
                self.b == other.b and 
                self.c == other.c and 
                self.d == other.d)
    
    def __str__(self) -> str:
        terms = []
        
        # Handle the real part (a)
        if self.a != 0:
            terms.append(f"{self.a}")
        
        # Handle the i component (b)
        if self.b != 0:
            if self.b == 1:
                terms.append("i")
            elif self.b == -1:
                terms.append("-i")
            else:
                terms.append(f"{self.b}i")
        
        # Handle the j component (c)
        if self.c != 0:
            if self.c == 1:
                terms.append("j")
            elif self.c == -1:
                terms.append("-j")
            else:
                terms.append(f"{self.c}j")
        
        # Handle the k component (d)
        if self.d != 0:
            if self.d == 1:
                terms.append("k")
            elif self.d == -1:
                terms.append("-k")
            else:
                terms.append(f"{self.d}k")
        
        if not terms:
            return "0"
        
        result = terms[0]
        for term in terms[1:]:
            if term.startswith('-'):
                result += term
            else:
                result += '+' + term
        
        return result
