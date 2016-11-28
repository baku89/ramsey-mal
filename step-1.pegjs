start = Atom

//------------------------------------------------------
// Atom

Atom = Exp / Bool / Text

Exp = Number / "(" operator:Operator " " a:Exp " " b:Exp ")" {
	return operator(a, b)
}

Bool = "true" { return true }
		 / "false" { return false }

Text = quote: ('"' .* '"') { return quote.join('') }

Number = Float / Integer

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

Hex = "0x" digits:[0-9]+ {
	return ParseInt(digits.join(''), 16)
}

//------------------------------------------------------
// symbols

QuotationMark = '"'