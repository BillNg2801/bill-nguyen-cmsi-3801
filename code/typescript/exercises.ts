import { open } from "node:fs/promises";

export function firstThenApply<A, B>(
  array: A[],
  predicate: (value: A) => boolean,
  transform: (value: A) => B
): B | undefined {
  const first: A | undefined = array.find(predicate);
  return first !== undefined ? transform(first) : undefined;
}


export function* powersGenerator(base: bigint): Generator<bigint, never, unknown> {
  let power: bigint = 1n;
  while (true) {
    yield power;
    power *= base;
  }
}


export async function meaningfulLineCount(filename: string): Promise<number> {
  let count: number = 0;
  const file = await open(filename, "r");
  try {
    for await (const line of file.readLines()) {
      const trimmed: string = line.trim();
      if (trimmed !== "" && !trimmed.startsWith("#")) {
        count++;
      }
    }
  } finally {
    await file.close();
  }
  return count;
}


export type Shape =
  | { kind: "Sphere"; radius: number }
  | { kind: "Box"; width: number; length: number; depth: number };

export function volume(shape: Shape): number {
  switch (shape.kind) {
    case "Sphere":
      return (4 / 3) * Math.PI * Math.pow(shape.radius, 3);
    case "Box":
      return shape.width * shape.length * shape.depth;
  }
}

export function surfaceArea(shape: Shape): number {
  switch (shape.kind) {
    case "Sphere":
      return 4 * Math.PI * Math.pow(shape.radius, 2);
    case "Box":
      return (
        2 * (shape.width * shape.length + shape.width * shape.depth + shape.length * shape.depth)
      );
  }
}


export interface BinarySearchTree<T> {
  size(): number;
  contains(value: T): boolean;
  insert(value: T): BinarySearchTree<T>;
  inorder(): Generator<T, void, unknown>;
  toString(): string;
}

export class Empty<T> implements BinarySearchTree<T> {
  size(): number {
    return 0;
  }

  contains(value: T): boolean {
    return false;
  }

  insert(value: T): BinarySearchTree<T> {
    return new Node(value, new Empty<T>(), new Empty<T>());
  }

  *inorder(): Generator<T, void, unknown> {
    // Empty tree yields nothing
  }

  toString(): string {
    return "()";
  }
}

class Node<T> implements BinarySearchTree<T> {
  constructor(
    private readonly value: T,
    private readonly left: BinarySearchTree<T>,
    private readonly right: BinarySearchTree<T>
  ) {}

  size(): number {
    return 1 + this.left.size() + this.right.size();
  }

  contains(value: T): boolean {
    if (value === this.value) {
      return true;
    } else if (value < this.value) {
      return this.left.contains(value);
    } else {
      return this.right.contains(value);
    }
  }

  insert(value: T): BinarySearchTree<T> {
    if (value === this.value) {
      return this;
    } else if (value < this.value) {
      return new Node(this.value, this.left.insert(value), this.right);
    } else {
      return new Node(this.value, this.left, this.right.insert(value));
    }
  }

  *inorder(): Generator<T, void, unknown> {
    yield* this.left.inorder();
    yield this.value;
    yield* this.right.inorder();
  }

  toString(): string {
    const leftStr: string = this.left.toString();
    const rightStr: string = this.right.toString();
    const valueStr: string = String(this.value);
    
    if (leftStr === "()" && rightStr === "()") {
      return `(${valueStr})`;
    } else if (leftStr === "()") {
      return `(${valueStr}${rightStr})`;
    } else if (rightStr === "()") {
      return `(${leftStr}${valueStr})`;
    } else {
      return `(${leftStr}${valueStr}${rightStr})`;
    }
  }
}

