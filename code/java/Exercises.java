import java.util.List;
import java.util.Optional;
import java.util.function.Predicate;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Objects;

public class Exercises {

    public static <T> Optional<String> firstThenLowerCase(List<T> list, Predicate<T> predicate) {
        return list.stream()
                   .filter(predicate)
                   .findFirst()
                   .map(Object::toString)
                   .map(String::toLowerCase);
    }

    public static PhraseBuilder say() {
        return new PhraseBuilder("");
    }

    public static PhraseBuilder say(String word) {
        return new PhraseBuilder(word);
    }

    public static class PhraseBuilder {
        private final String phrase;

        private PhraseBuilder(String phrase) {
            this.phrase = phrase;
        }

        public PhraseBuilder and(String word) {
            return new PhraseBuilder(phrase + " " + word);
        }

        public String phrase() {
            return phrase;
        }
    }

    public static long meaningfulLineCount(String filename) throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            return reader.lines()
                         .filter(line -> {
                             String trimmed = line.trim();
                             return !trimmed.isEmpty() && !trimmed.startsWith("#");
                         })
                         .count();
        } catch (java.io.FileNotFoundException e) {
            throw new java.io.FileNotFoundException("No such file or directory: " + filename);
        }
    }
}

final class Quaternion {
    private final double a;
    private final double b;
    private final double c;
    private final double d;
    
    public static final Quaternion ZERO = new Quaternion(0, 0, 0, 0);
    public static final Quaternion I = new Quaternion(0, 1, 0, 0);
    public static final Quaternion J = new Quaternion(0, 0, 1, 0);
    public static final Quaternion K = new Quaternion(0, 0, 0, 1);

    public Quaternion(double a, double b, double c, double d) {
        if (Double.isNaN(a) || Double.isNaN(b) || Double.isNaN(c) || Double.isNaN(d)) {
            throw new IllegalArgumentException("Coefficients cannot be NaN");
        }
        this.a = a;
        this.b = b;
        this.c = c;
        this.d = d;
    }

    public double a() { return a; }
    public double b() { return b; }
    public double c() { return c; }
    public double d() { return d; }

    public List<Double> coefficients() {
        return java.util.Arrays.asList(a, b, c, d);
    }

    public Quaternion plus(Quaternion other) {
        return new Quaternion(
            this.a + other.a,
            this.b + other.b,
            this.c + other.c,
            this.d + other.d
        );
    }

    public Quaternion times(Quaternion other) {
        return new Quaternion(
            this.a * other.a - this.b * other.b - this.c * other.c - this.d * other.d,
            this.a * other.b + this.b * other.a + this.c * other.d - this.d * other.c,
            this.a * other.c - this.b * other.d + this.c * other.a + this.d * other.b,
            this.a * other.d + this.b * other.c - this.c * other.b + this.d * other.a
        );
    }

    public Quaternion conjugate() {
        return new Quaternion(a, -b, -c, -d);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (!(obj instanceof Quaternion)) return false;
        Quaternion other = (Quaternion) obj;
        return Double.compare(a, other.a) == 0 &&
               Double.compare(b, other.b) == 0 &&
               Double.compare(c, other.c) == 0 &&
               Double.compare(d, other.d) == 0;
    }

    @Override
    public int hashCode() {
        return Objects.hash(a, b, c, d);
    }

    @Override
    public String toString() {
        if (a == 0 && b == 0 && c == 0 && d == 0) {
            return "0";
        }

        StringBuilder result = new StringBuilder();
        boolean hasTerms = false;

        if (a != 0) {
            result.append(a);
            hasTerms = true;
        }

        if (b != 0) {
            if (b == 1) {
                if (hasTerms) result.append("+");
                result.append("i");
            } else if (b == -1) {
                result.append("-i");
            } else {
                if (hasTerms && b > 0) result.append("+");
                result.append(b).append("i");
            }
            hasTerms = true;
        }

        if (c != 0) {
            if (c == 1) {
                if (hasTerms) result.append("+");
                result.append("j");
            } else if (c == -1) {
                result.append("-j");
            } else {
                if (hasTerms && c > 0) result.append("+");
                result.append(c).append("j");
            }
            hasTerms = true;
        }

        if (d != 0) {
            if (d == 1) {
                if (hasTerms) result.append("+");
                result.append("k");
            } else if (d == -1) {
                result.append("-k");
            } else {
                if (hasTerms && d > 0) result.append("+");
                result.append(d).append("k");
            }
        }

        return result.toString();
    }
}

interface BinarySearchTree {
    int size();
    boolean contains(String value);
    BinarySearchTree insert(String value);
}

final class Empty implements BinarySearchTree {
    
    @Override
    public int size() {
        return 0;
    }

    @Override
    public boolean contains(String value) {
        return false;
    }

    @Override
    public BinarySearchTree insert(String value) {
        return new Node(value, this, this);
    }

    @Override
    public String toString() {
        return "()";
    }
}

final class Node implements BinarySearchTree {
    private final String value;
    private final BinarySearchTree left;
    private final BinarySearchTree right;

    Node(String value, BinarySearchTree left, BinarySearchTree right) {
        this.value = value;
        this.left = left;
        this.right = right;
    }

    @Override
    public int size() {
        return 1 + left.size() + right.size();
    }

    @Override
    public boolean contains(String value) {
        int cmp = value.compareTo(this.value);
        if (cmp < 0) {
            return left.contains(value);
        } else if (cmp > 0) {
            return right.contains(value);
        } else {
            return true;
        }
    }

    @Override
    public BinarySearchTree insert(String value) {
        int cmp = value.compareTo(this.value);
        if (cmp < 0) {
            return new Node(this.value, left.insert(value), right);
        } else if (cmp > 0) {
            return new Node(this.value, left, right.insert(value));
        } else {
            return this;
        }
    }

    @Override
    public String toString() {
        String leftStr = left.toString();
        String rightStr = right.toString();
        
        if (leftStr.equals("()") && rightStr.equals("()")) {
            return "(" + value + ")";
        } else if (rightStr.equals("()")) {
            return "(" + leftStr + value + ")";
        } else if (leftStr.equals("()")) {
            return "(" + value + rightStr + ")";
        } else {
            return "(" + leftStr + value + rightStr + ")";
        }
    }
}

class IO {
    public static void print(String message) {
        System.out.print(message);
    }

    public static void println(String message) {
        System.out.println(message);
    }
}
