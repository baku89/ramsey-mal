#!/usr/local/bin/node

const readline  = require('readline')
const colors = require('colors')

const rl = readline.createInterface({
	input: process.stdin,
	output: process.stdout,
	prompt: 'mal>'.green
})

rl.prompt()

// produces an abstract syntax tree ast
function read(code) {
	return code
}

// produces a value
function evaluate(ast, env) {
	return ast
}

// produces a string
function print(value) {
	return value
}

rl.on('line', (code) => {

	let ast = read(code)
	let value = evaluate(ast, {})
	let output = print(value)

	console.log(output.blue)

	rl.prompt()
})