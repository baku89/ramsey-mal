start = number

number = float

float = before:integer after:('.' integer)?
{
	if (after == null) {
		return before
	} else {
		return parseFloat(before + after.join(''))
	}
}

integer = num:(('0x')? [0-9a-f]+)
{
	return parseInt(num.join(''))
}