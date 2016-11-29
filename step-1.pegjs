start = Atom

//------------------------------------------------------
// Atom

Atom = Exp / Bool / String

Exp = Number / "(" operator:Operator " " a:Exp " " b:Exp ")" {
	return operator(a, b)
}

Bool = "true" { return true }
		 / "false" { return false }

String = '"' quote:[^\"]* '"' { return quote.join('') }

Number = Hex / Binary / Float / Integer

//------------------------------------------------------
// Operator

Operator
	= "+" { return (a, b) => a + b }
	/ "-" { return (a, b) => a - b }
	/ "*" { return (a, b) => a * b }
	/ "/" { return (a, b) => a / b }

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