import java.io.BufferedReader
import java.io.FileReader
import java.io.IOException

fun <T> firstThenLowerCase(list: List<T>, predicate: (T) -> Boolean): String? {
    return list.firstOrNull(predicate)?.toString()?.lowercase()
}

fun say(word: String = ""): PhraseBuilder {
    return PhraseBuilder(word)
}

class PhraseBuilder(private val words: String) {
    fun and(word: String): PhraseBuilder {
        return PhraseBuilder("$words $word")
    }
    
    val phrase: String
        get() = words
}

fun meaningfulLineCount(filename: String): Long {
    try {
        return BufferedReader(FileReader(filename)).use { reader ->
            reader.lineSequence()
                .filter { line ->
                    val trimmed = line.trim()
                    trimmed.isNotEmpty() && !trimmed.startsWith("#")
                }
                .count()
                .toLong()
        }
    } catch (e: java.io.FileNotFoundException) {
        throw java.io.IOException("No such file or directory: $filename", e)
    }
}

data class Quaternion(val a: Double, val b: Double, val c: Double, val d: Double) {
    
    companion object {
        val ZERO = Quaternion(0.0, 0.0, 0.0, 0.0)
        val I = Quaternion(0.0, 1.0, 0.0, 0.0)
        val J = Quaternion(0.0, 0.0, 1.0, 0.0)
        val K = Quaternion(0.0, 0.0, 0.0, 1.0)
    }

    init {
        require(!a.isNaN() && !b.isNaN() && !c.isNaN() && !d.isNaN()) {
            "Coefficients cannot be NaN"
        }
    }

    fun coefficients(): List<Double> = listOf(a, b, c, d)

    operator fun plus(other: Quaternion): Quaternion {
        return Quaternion(
            this.a + other.a,
            this.b + other.b,
            this.c + other.c,
            this.d + other.d
        )
    }

    operator fun times(other: Quaternion): Quaternion {
        return Quaternion(
            this.a * other.a - this.b * other.b - this.c * other.c - this.d * other.d,
            this.a * other.b + this.b * other.a + this.c * other.d - this.d * other.c,
            this.a * other.c - this.b * other.d + this.c * other.a + this.d * other.b,
            this.a * other.d + this.b * other.c - this.c * other.b + this.d * other.a
        )
    }

    fun conjugate(): Quaternion {
        return Quaternion(a, -b, -c, -d)
    }

    override fun toString(): String {
        if (a == 0.0 && b == 0.0 && c == 0.0 && d == 0.0) {
            return "0"
        }

        val result = StringBuilder()
        var hasTerms = false

        if (a != 0.0) {
            result.append(a)
            hasTerms = true
        }

        if (b != 0.0) {
            when {
                b == 1.0 -> {
                    if (hasTerms) result.append("+")
                    result.append("i")
                }
                b == -1.0 -> result.append("-i")
                else -> {
                    if (hasTerms && b > 0) result.append("+")
                    result.append(b).append("i")
                }
            }
            hasTerms = true
        }

        if (c != 0.0) {
            when {
                c == 1.0 -> {
                    if (hasTerms) result.append("+")
                    result.append("j")
                }
                c == -1.0 -> result.append("-j")
                else -> {
                    if (hasTerms && c > 0) result.append("+")
                    result.append(c).append("j")
                }
            }
            hasTerms = true
        }

        if (d != 0.0) {
            when {
                d == 1.0 -> {
                    if (hasTerms) result.append("+")
                    result.append("k")
                }
                d == -1.0 -> result.append("-k")
                else -> {
                    if (hasTerms && d > 0) result.append("+")
                    result.append(d).append("k")
                }
            }
        }

        return result.toString()
    }
}

sealed interface BinarySearchTree {
    fun size(): Int
    fun contains(value: String): Boolean
    fun insert(value: String): BinarySearchTree

    object Empty : BinarySearchTree {
        override fun size() = 0
        
        override fun contains(value: String) = false
        
        override fun insert(value: String): BinarySearchTree {
            return Node(value, Empty, Empty)
        }
        
        override fun toString() = "()"
    }

    data class Node(
        val value: String,
        val left: BinarySearchTree,
        val right: BinarySearchTree
    ) : BinarySearchTree {
        
        override fun size(): Int = 1 + left.size() + right.size()
        
        override fun contains(value: String): Boolean {
            return when {
                value < this.value -> left.contains(value)
                value > this.value -> right.contains(value)
                else -> true
            }
        }
        
        override fun insert(value: String): BinarySearchTree {
            return when {
                value < this.value -> Node(this.value, left.insert(value), right)
                value > this.value -> Node(this.value, left, right.insert(value))
                else -> this
            }
        }
        
        override fun toString(): String {
            val leftStr = left.toString()
            val rightStr = right.toString()
            
            return when {
                leftStr == "()" && rightStr == "()" -> "($value)"
                rightStr == "()" -> "($leftStr$value)"
                leftStr == "()" -> "($value$rightStr)"
                else -> "($leftStr$value$rightStr)"
            }
        }
    }
}
