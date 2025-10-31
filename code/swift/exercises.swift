import Foundation
func firstThenLowerCase<T>(of array: [T], satisfying predicate: (T) -> Bool) -> String? {
    if let first = array.first(where: predicate) {
        return String(describing: first).lowercased()
    }
    return nil
}

func say(_ words: String...) -> PhraseBuilder {
    return PhraseBuilder(words: Array(words))
}

func say() -> PhraseBuilder {
    return PhraseBuilder(words: [])
}

class PhraseBuilder {
    private let words: [String]
    
    init(words: [String]) {
        self.words = words
    }
    
    func and(_ word: String) -> PhraseBuilder {
        return PhraseBuilder(words: words + [word])
    }
    
    var phrase: String {
        return words.joined(separator: " ")
    }
}

func meaningfulLineCount(_ filename: String) async -> Result<Int, Error> {
    let fileURL = URL(fileURLWithPath: filename)
    
    do {
        let fileHandle = try FileHandle(forReadingFrom: fileURL)
        defer { fileHandle.closeFile() }
        
        var count = 0
        for try await line in fileHandle.bytes.lines {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            if !trimmed.isEmpty && !trimmed.starts(with: "#") {
                count += 1
            }
        }
        
        return .success(count)
    } catch {
        return .failure(error)
    }
}

struct Quaternion: Equatable, CustomStringConvertible {
    let a: Double
    let b: Double
    let c: Double
    let d: Double
    
    init(a: Double = 0, b: Double = 0, c: Double = 0, d: Double = 0) {
        if a.isNaN || b.isNaN || c.isNaN || d.isNaN {
            fatalError("Coefficients cannot be NaN")
        }
        self.a = a
        self.b = b
        self.c = c
        self.d = d
    }
    
    static let ZERO = Quaternion()
    static let I = Quaternion(b: 1)
    static let J = Quaternion(c: 1)
    static let K = Quaternion(d: 1)
    
    var coefficients: [Double] {
        return [a, b, c, d]
    }
    
    var conjugate: Quaternion {
        return Quaternion(a: a, b: -b, c: -c, d: -d)
    }
    
    static func + (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        return Quaternion(
            a: lhs.a + rhs.a,
            b: lhs.b + rhs.b,
            c: lhs.c + rhs.c,
            d: lhs.d + rhs.d
        )
    }
    
    static func * (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        return Quaternion(
            a: lhs.a * rhs.a - lhs.b * rhs.b - lhs.c * rhs.c - lhs.d * rhs.d,
            b: lhs.a * rhs.b + lhs.b * rhs.a + lhs.c * rhs.d - lhs.d * rhs.c,
            c: lhs.a * rhs.c - lhs.b * rhs.d + lhs.c * rhs.a + lhs.d * rhs.b,
            d: lhs.a * rhs.d + lhs.b * rhs.c - lhs.c * rhs.b + lhs.d * rhs.a
        )
    }
    
    var description: String {
        var parts: [String] = []
        var hasExistingParts = false
        
        func formatImaginary(_ value: Double, _ suffix: String) -> String {
            if value == 1 {
                return hasExistingParts ? "+\(suffix)" : suffix
            } else if value == -1 {
                return "-\(suffix)"
            } else {
                let formatted = String(value)
                return hasExistingParts && value > 0 ? "+\(formatted)\(suffix)" : "\(formatted)\(suffix)"
            }
        }
        
        if a != 0 {
            let value = String(a)
            parts.append(value)
            hasExistingParts = true
        }
        
        if b != 0 {
            parts.append(formatImaginary(b, "i"))
            hasExistingParts = true
        }
        
        if c != 0 {
            parts.append(formatImaginary(c, "j"))
            hasExistingParts = true
        }
        
        if d != 0 {
            parts.append(formatImaginary(d, "k"))
            hasExistingParts = true
        }
        
        return parts.isEmpty ? "0" : parts.joined()
    }
}

indirect enum BinarySearchTree {
    case empty
    case node(String, BinarySearchTree, BinarySearchTree)
    
    func insert(_ value: String) -> BinarySearchTree {
        switch self {
        case .empty:
            return .node(value, .empty, .empty)
        case .node(let v, let left, let right):
            if value < v {
                return .node(v, left.insert(value), right)
            } else if value > v {
                return .node(v, left, right.insert(value))
            } else {
                return self
            }
        }
    }
    
    func contains(_ value: String) -> Bool {
        switch self {
        case .empty:
            return false
        case .node(let v, let left, let right):
            if value < v {
                return left.contains(value)
            } else if value > v {
                return right.contains(value)
            } else {
                return true
            }
        }
    }
    
    var size: Int {
        switch self {
        case .empty:
            return 0
        case .node(_, let left, let right):
            return 1 + left.size + right.size
        }
    }
    
    var description: String {
        switch self {
        case .empty:
            return "()"
        case .node(let v, let left, let right):
            let leftStr = left.description
            let rightStr = right.description
            
            if leftStr == "()" && rightStr == "()" {
                return "(\(v))"
            } else if rightStr == "()" {
                return "(\(leftStr)\(v))"
            } else if leftStr == "()" {
                return "(\(v)\(rightStr))"
            } else {
                return "(\(leftStr)\(v)\(rightStr))"
            }
        }
    }
}

extension BinarySearchTree: CustomStringConvertible {
    var customDescription: String {
        return description
    }
}


