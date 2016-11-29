start = Exp / Atom

//------------------------------------------------------
// Atom

Atom = Number / Bool / String

Exp = Atom / "(" operator:Operator args:Arguments ")" {
	return operator.apply(this, args)
}

Arguments = match:(" " Exp)+ {
	let args = []
	match.forEach( (m) => args.push(m[1]) )
	return args
}

Bool = "true" { return true }
		 / "false" { return false }

String = '"' quote:[^\"]* '"' { return quote.join('') }

Number = Hex / Binary / Float / Integer

//------------------------------------------------------
// Operator

Operator = ArthmeticOperators / LogicalOperators

// Basic arthmetic operators

ArthmeticOperators = Add / Substract / Multiply / Divide

Add = "+" {
	return function() {
		let args = [...arguments]
		let val = 0
		args.forEach( (arg) => val += arg )
		return val
	}
}

Substract = "-" {
	return (a, b) => a - b
}

Multiply = "*" {
	return function() {
		let args = [...arguments]
		let val = 1
		args.forEach( (arg) => val *= arg )
		return val
	}
}

Divide = "/" {
	return (a, b) => a / b
}

// logical operators

LogicalOperators = If / Not / And / Or / EqualTo / LessThan / MoreThan

If = "if" {
	return (cond, a, b) => cond ? a : b
}

Not = "not" {
	return (a) => !a
}

And = "and" {
	return function() {
		let args = [...arguments]
		let val = true
		args.forEach( (arg) => val = val && arg )
		return val
	}
}

Or = "or" {
	return function() {
		let args = [...arguments]
		let val = false
		args.forEach( (arg) => val = val || arg )
		return val
	}
}

EqualTo = "=" {
	return (a, b) => a == b
}

LessThan = "<" {
	return (a, b) => a < b
}

MoreThan = ">" {
	return (a, b) => a > b
}

//------------------------------------------------------
// number

Float = before:[0-9]* "." after:[0-9]+ {
	return parseFloat(before.join('') + '.' + after.join(''))
}

Integer = digits:[0-9]+ {
	return parseInt(digits.join(''))
}

Hex = "0x" digits:[0-9a-f]+ {
	return parseInt(digits.join(''), 16)
}

Binary = "0b" digits:[01]+ {
	return parseInt(digits.join(''), 2)
}