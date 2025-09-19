import { readFile } from "node:fs/promises";

/**
 * Returns the result of applying a function to the first element of a sequence
 * that satisfies a predicate, or undefined if no such element exists.
 */
export function firstThenApply(strings, predicate, function_) {
  for (const s of strings) {
    if (predicate(s)) {
      return function_(s);
    }
  }
  return undefined;
}

/**
 * A chainable function that accumulates words and returns them separated by spaces
 * when called without arguments.
 */
export function say(word) {
  if (word === undefined) {
    return "";
  }
  
  return function(nextWord) {
    if (nextWord === undefined) {
      return word;
    } else {
      const accumulated = word + " " + nextWord;
      return say(accumulated);
    }
  };
}

/**
 * Generator that yields successive powers of base up to but not exceeding limit.
 * Uses destructuring for the argument object.
 */
export function* powersGenerator({ ofBase, upTo }) {
  let power = 1;
  while (power <= upTo) {
    yield power;
    power *= ofBase;
  }
}

/**
 * Returns the number of meaningful lines in a file (non-empty, non-whitespace,
 * and not starting with #).
 */
export async function meaningfulLineCount(filename) {
  try {
    const content = await readFile(filename, 'utf-8');
    const lines = content.split('\n');
    let count = 0;
    
    for (const line of lines) {
      const trimmed = line.trim();
      if (trimmed && !trimmed.startsWith('#')) {
        count++;
      }
    }
    
    return count;
  } catch (error) {
    throw new Error(`Error reading file: ${error.message}`);
  }
}

/**
 * Quaternion class with frozen instances and all required operations.
 */
export class Quaternion {
  constructor(a = 0, b = 0, c = 0, d = 0) {
    this.a = a;
    this.b = b;
    this.c = c;
    this.d = d;
    
    // Freeze the object to make it immutable
    Object.freeze(this);
  }
  
  /**
   * Returns the coefficients as an array.
   */
  get coefficients() {
    return [this.a, this.b, this.c, this.d];
  }
  
  /**
   * Returns the conjugate of this quaternion.
   */
  get conjugate() {
    return new Quaternion(this.a, -this.b, -this.c, -this.d);
  }
  
  /**
   * Adds another quaternion to this one.
   */
  plus(other) {
    return new Quaternion(
      this.a + other.a,
      this.b + other.b,
      this.c + other.c,
      this.d + other.d
    );
  }
  
  /**
   * Multiplies this quaternion by another quaternion.
   */
  times(other) {
    return new Quaternion(
      this.a * other.a - this.b * other.b - this.c * other.c - this.d * other.d,
      this.a * other.b + this.b * other.a + this.c * other.d - this.d * other.c,
      this.a * other.c - this.b * other.d + this.c * other.a + this.d * other.b,
      this.a * other.d + this.b * other.c - this.c * other.b + this.d * other.a
    );
  }
  
  /**
   * String representation of the quaternion.
   */
  toString() {
    const terms = [];
    
    // Handle the real part (a)
    if (this.a !== 0) {
      terms.push(`${this.a}`);
    }
    
    // Handle the i component (b)
    if (this.b !== 0) {
      if (this.b === 1) {
        terms.push("i");
      } else if (this.b === -1) {
        terms.push("-i");
      } else {
        terms.push(`${this.b}i`);
      }
    }
    
    // Handle the j component (c)
    if (this.c !== 0) {
      if (this.c === 1) {
        terms.push("j");
      } else if (this.c === -1) {
        terms.push("-j");
      } else {
        terms.push(`${this.c}j`);
      }
    }
    
    // Handle the k component (d)
    if (this.d !== 0) {
      if (this.d === 1) {
        terms.push("k");
      } else if (this.d === -1) {
        terms.push("-k");
      } else {
        terms.push(`${this.d}k`);
      }
    }
    
    if (terms.length === 0) {
      return "0";
    }
    
    let result = terms[0];
    for (let i = 1; i < terms.length; i++) {
      if (terms[i].startsWith('-')) {
        result += terms[i];
      } else {
        result += '+' + terms[i];
      }
    }
    
    return result;
  }
}
