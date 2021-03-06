precedencegroup ParserMapPrecedenceGroup {
    associativity: left
    lowerThan: AdditionPrecedence, BitwiseShiftPrecedence, NilCoalescingPrecedence, DefaultPrecedence
}

/// ~ and ~>
precedencegroup ParserConjunctionGroup {
    associativity: left
    lowerThan: NilCoalescingPrecedence
    higherThan: ParserMapPrecedenceGroup, DefaultPrecedence
}

/// <~
precedencegroup ParserConjuctionRightGroup {
    associativity: left
    lowerThan: NilCoalescingPrecedence
    higherThan: ParserConjunctionGroup
}

infix operator ~: ParserConjunctionGroup
infix operator <~: ParserConjuctionRightGroup

/// Sequential conjunction of two parsers while ignoring the result of lhs
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns the result of rhs
public func ~> <Source, R1, R2>(lhs: Parser<Source, R1>, rhs: Parser<Source, R2>) -> Parser<Source, R2> {
    Parser { input, index in
        try lhs.parse(input, index).flatMap { _, input, r1Index in
            try rhs.parse(input, r1Index)
        }
    }
}

/// Sequential conjunction of two parsers while ignoring the result of rhs
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns the result of lhs
public func <~ <Source, R1, R2>(lhs: Parser<Source, R1>, rhs: Parser<Source, R2>) -> Parser<Source, R1> {
    Parser { input, index in
        try lhs.parse(input, index).flatMap { r1, input, r1Index in
            try rhs.parse(input, r1Index).map { _, _, _ in
                r1
            }
        }
    }
}

/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~ <Source, R1, R2>(lhs: Parser<Source, R1>, rhs: Parser<Source, R2>) -> Parser<Source, (R1, R2)> {
    Parser { input, index in
        try lhs.parse(input, index).flatMap { r1, _, r1Index in
            try rhs.parse(input, r1Index).map { r2, _, _ in (r1, r2) }
        }
    }
}

/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~ <Source, A, B, C>(lhs: Parser<Source, (A, B)>, rhs: Parser<Source, C>) -> Parser<Source, (A, B, C)> {
    Parser { input, index in
        try lhs.parse(input, index).flatMap { r1, _, r1Index in
            try rhs.parse(input, r1Index).map { r2, _, _ in (r1.0, r1.1, r2) }
        }
    }
}

/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~ <Source, A, B, C>(lhs: Parser<Source, C>, rhs: Parser<Source, (A, B)>) -> Parser<Source, (C, A, B)> {
    Parser { input, index in
        try lhs.parse(input, index).flatMap { r1, _, r1Index in
            try rhs.parse(input, r1Index).map { r2, _, _ in (r1, r2.0, r2.1) }
        }
    }
}

/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~ <Source, A, B, C, D>(lhs: Parser<Source, (A, B, C)>, rhs: Parser<Source, D>) -> Parser<Source, (A, B, C, D)> {
    Parser { input, index in
        try lhs.parse(input, index).flatMap { r1, _, r1Index in
            try rhs.parse(input, r1Index).map { r2, _, _ in (r1.0, r1.1, r1.2, r2) }
        }
    }
}

/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~ <Source, A, B, C, D>(lhs: Parser<Source, D>, rhs: Parser<Source, (A, B, C)>) -> Parser<Source, (D, A, B, C)> {
    Parser { input, index in
        try lhs.parse(input, index).flatMap { r1, _, r1Index in
            try rhs.parse(input, r1Index).map { r2, _, _ in (r1, r2.0, r2.1, r2.2) }
        }
    }
}

/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~ <Source, A, B, C, D, E>(lhs: Parser<Source, (A, B, C, D)>, rhs: Parser<Source, E>) -> Parser<Source, (A, B, C, D, E)> {
    Parser { input, index in
        try lhs.parse(input, index).flatMap { r1, _, r1Index in
            try rhs.parse(input, r1Index).map { r2, _, _ in (r1.0, r1.1, r1.2, r1.3, r2) }
        }
    }
}

/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~ <Source, A, B, C, D, E>(lhs: Parser<Source, E>, rhs: Parser<Source, (A, B, C, D)>) -> Parser<Source, (E, A, B, C, D)> {
    Parser { input, index in
        try lhs.parse(input, index).flatMap { r1, _, r1Index in
            try rhs.parse(input, r1Index).map { r2, _, _ in (r1, r2.0, r2.1, r2.2, r2.3) }
        }
    }
}

/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~ <Source, A, B, C, D, E, F>(lhs: Parser<Source, (A, B, C, D, E)>, rhs: Parser<Source, F>) -> Parser<Source, (A, B, C, D, E, F)> {
    Parser { input, index in
        try lhs.parse(input, index).flatMap { r1, _, r1Index in
            try rhs.parse(input, r1Index).map { r2, _, _ in (r1.0, r1.1, r1.2, r1.3, r1.4, r2) }
        }
    }
}

/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~ <Source, A, B, C, D, E, F>(lhs: Parser<Source, F>, rhs: Parser<Source, (A, B, C, D, E)>) -> Parser<Source, (F, A, B, C, D, E)> {
    Parser { input, index in
        try lhs.parse(input, index).flatMap { r1, _, r1Index in
            try rhs.parse(input, r1Index).map { r2, _, _ in (r1, r2.0, r2.1, r2.2, r2.3, r2.4) }
        }
    }
}

/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~ <Source, A, B, C, D, E, F, G>(lhs: Parser<Source, (A, B, C, D, E, F)>, rhs: Parser<Source, G>) -> Parser<Source, (A, B, C, D, E, F, G)> {
    Parser { input, index in
        try lhs.parse(input, index).flatMap { r1, _, r1Index in
            try rhs.parse(input, r1Index).map { r2, _, _ in (r1.0, r1.1, r1.2, r1.3, r1.4, r1.5, r2) }
        }
    }
}

/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~ <Source, A, B, C, D, E, F, G>(lhs: Parser<Source, G>, rhs: Parser<Source, (A, B, C, D, E, F)>) -> Parser<Source, (G, A, B, C, D, E, F)> {
    Parser { input, index in
        try lhs.parse(input, index).flatMap { r1, _, r1Index in
            try rhs.parse(input, r1Index).map { r2, _, _ in (r1, r2.0, r2.1, r2.2, r2.3, r2.4, r2.5) }
        }
    }
}

/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~ <Source, A, B, C, D, E, F, G, H>(lhs: Parser<Source, (A, B, C, D, E, F, G)>, rhs: Parser<Source, H>) -> Parser<Source, (A, B, C, D, E, F, G, H)> {
    Parser { input, index in
        try lhs.parse(input, index).flatMap { r1, _, r1Index in
            try rhs.parse(input, r1Index).map { r2, _, _ in (r1.0, r1.1, r1.2, r1.3, r1.4, r1.5, r1.6, r2) }
        }
    }
}

/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~ <Source, A, B, C, D, E, F, G, H>(lhs: Parser<Source, H>, rhs: Parser<Source, (A, B, C, D, E, F, G)>) -> Parser<Source, (H, A, B, C, D, E, F, G)> {
    Parser { input, index in
        try lhs.parse(input, index).flatMap { r1, _, r1Index in
            try rhs.parse(input, r1Index).map { r2, _, _ in (r1, r2.0, r2.1, r2.2, r2.3, r2.4, r2.5, r2.6) }
        }
    }
}

/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~ <Source, A, B, C, D, E, F, G, H, I>(lhs: Parser<Source, (A, B, C, D, E, F, G, H)>, rhs: Parser<Source, I>) -> Parser<Source, (A, B, C, D, E, F, G, H, I)> {
    Parser { input, index in
        try lhs.parse(input, index).flatMap { r1, _, r1Index in
            try rhs.parse(input, r1Index).map { r2, _, _ in (r1.0, r1.1, r1.2, r1.3, r1.4, r1.5, r1.6, r1.7, r2) }
        }
    }
}

/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~ <Source, A, B, C, D, E, F, G, H, I>(lhs: Parser<Source, I>, rhs: Parser<Source, (A, B, C, D, E, F, G, H)>) -> Parser<Source, (I, A, B, C, D, E, F, G, H)> {
    Parser { input, index in
        try lhs.parse(input, index).flatMap { r1, _, r1Index in
            try rhs.parse(input, r1Index).map { r2, _, _ in (r1, r2.0, r2.1, r2.2, r2.3, r2.4, r2.5, r2.6, r2.7) }
        }
    }
}

/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~ <Source, A, B, C, D, E, F, G, H, I, J>(lhs: Parser<Source, (A, B, C, D, E, F, G, H, I)>, rhs: Parser<Source, J>) -> Parser<Source, (A, B, C, D, E, F, G, H, I, J)> {
    Parser { input, index in
        try lhs.parse(input, index).flatMap { r1, _, r1Index in
            try rhs.parse(input, r1Index).map { r2, _, _ in (r1.0, r1.1, r1.2, r1.3, r1.4, r1.5, r1.6, r1.7, r1.8, r2) }
        }
    }
}

/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~ <Source, A, B, C, D, E, F, G, H, I, J>(lhs: Parser<Source, J>, rhs: Parser<Source, (A, B, C, D, E, F, G, H, I)>) -> Parser<Source, (J, A, B, C, D, E, F, G, H, I)> {
    Parser { input, index in
        try lhs.parse(input, index).flatMap { r1, _, r1Index in
            try rhs.parse(input, r1Index).map { r2, _, _ in (r1, r2.0, r2.1, r2.2, r2.3, r2.4, r2.5, r2.6, r2.7, r2.8) }
        }
    }
}

/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~ <Source, A, B, C, D, E, F, G, H, I, J, K>(lhs: Parser<Source, (A, B, C, D, E, F, G, H, I, J)>, rhs: Parser<Source, K>) -> Parser<Source, (A, B, C, D, E, F, G, H, I, J, K)> {
    Parser { input, index in
        try lhs.parse(input, index).flatMap { r1, _, r1Index in
            try rhs.parse(input, r1Index).map { r2, _, _ in (r1.0, r1.1, r1.2, r1.3, r1.4, r1.5, r1.6, r1.7, r1.8, r1.9, r2) }
        }
    }
}

/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~ <Source, A, B, C, D, E, F, G, H, I, J, K>(lhs: Parser<Source, K>, rhs: Parser<Source, (A, B, C, D, E, F, G, H, I, J)>) -> Parser<Source, (K, A, B, C, D, E, F, G, H, I, J)> {
    Parser { input, index in
        try lhs.parse(input, index).flatMap { r1, _, r1Index in
            try rhs.parse(input, r1Index).map { r2, _, _ in (r1, r2.0, r2.1, r2.2, r2.3, r2.4, r2.5, r2.6, r2.7, r2.8, r2.9) }
        }
    }
}
