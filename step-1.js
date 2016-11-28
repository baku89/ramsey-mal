#!/usr/local/bin/node

const fs = require('fs')
const readline  = require('readline')
const colors 		= require('colors')
const pegjs 		= require('pegjs')

require.extensions['.pegjs'] = function (module, filename) {
	module.exports = fs.readFileSync(filename, 'utf8')
}

let parser = pegjs.generate(require('./step-1.pegjs'))

const rl = readline.createInterface({
	input: process.stdin,
	output: process.stdout,
	prompt: 'mal>'.blue + ' '
})

rl.prompt()

// produces an abstract syntax tree ast
function read(code) {
	return parser.parse(code)
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

	// console.log(output.join('').rainbow)
	console.log(output)

	rl.prompt()
})