# Overview

Cobra is a compact, multipurpose programming language that combines the readability of Python with the low-level memory control features of C/C++. Designed for embedded systems, it prioritizes minimalism and flexibility, enabling effective development on resource-limited platforms.

Features include dynamic class definitions, object-oriented programming, optional strong typing, and direct pointer access. Cobra aims to simplify embedded development, providing a perfect blend of high-level ease and low-level functionality, all within a portable and efficiently sized binary.

Its syntax is designed to be straightforward for beginners while providing powerful capabilities for experienced developers.

Through this guide, you'll learn Cobra's syntax and features, equipped with examples to demonstrate its application in embedded system programming. Cobra aims to make embedded development more efficient and accessible.

# Lexical

## Tokens

### Lines

Physical lines are separated by a newline sequence `\n`.

### Indentation

Leading whitespace via tabs `\t` are used to compute indentation level grouping statements.

### Comments

Comments start with pound `#` ending at the end of the physical line.

## Identifiers

1. Identifiers must start with a letter
2. Identifiers cannot conflict with existing keywords

Specifically:

```
letter (letter | digit | '_')*
```

## Keywords

As mentioned above the following keywords cannot be used for user-defined variables, functions & classes.

- Functions: `class`, `def`
- Conditions: `if`, `else`, `elif`
- Loops: `while`
- Return: `return`
- Null: `None`
- Properties: `static`
- Modules: `import`

## Literals

There are no individual character literals, but, strings with one character in double quotes.

- Integer - whole number without decimals (e.g. `[0-9]+`)
- Float - number with values required on both ends of the decimal separator
- Boolean - truthy
- String - sequence of characters wrapped in double quotes
- Null - value denoting absence of a defined literal

## Operators

- Arithmetic - `+`, `-`, `/`, `*`, `%`
- Assignment - `=`
- Equivalence - `==`, `!=`, `<`, `<=`, `>`, `>=`
- Logical - `and`, `or`, `not`
- Memory - `&`, `*`, `new`, `delete`

# Types

## Primitives

- Integer - `int`, `int8`, `int16`, `int32`, `int64`
- Unsigned Integer - `uint`, `uint8`, `uint16`, `uint32`, `uint64`
- Float - `float`
- Array - e.g. `arr[]`
- String - `str`
- Tuple - e.g. `(var1, var2, var3)`
- Bool - e.g. `False`, `True`, `not False`, `not True`
- Null - e.g. `None`

## Custom

### Named

Named types allow for aliases that create bespoke complex types or simply renamed primitives.

```
type CustomInt = int
type CustomString = str
```

### Union

Union types allow single variables to hold a value of one of the provided types.

```
type StringInt = str | int
```

# Operators

## Logical

**and**: Evaluates to true if both operands are true; false otherwise
**or**: Evaluates to true if at least one of the operands is true; false otherwise
**not**: Inverts the truth value of its operand

## Equivalence

**== (Equal to)**: Compares two operands for equality
Returns true if they are equal, false otherwise
**!= (Not Equal to)**: Compares two operands for inequality
Returns true if they are not equal, false otherwise

## Arithmetic

**+**: Adds to operands
**-**: Subtracts the second operand from the first
**\***: Multiplies two operands
**/**: Divides the first operand by the second
**%**: Modulus returning the remainder of dividing the first operand by the second

## Assignment

**=**: Assignment operator assigning the value on the right to the variable on the left
**( + | - | / | * )=**: Compound assignment operator
Performs the arithmetic operation (addition, subtraction, multiplication, division) on and assigns the result to the variable

## Precedence

Operators are evaluated in the following order top-down.

- Arithmetic
- Comparison
- Logical
- Assignment


# Statements & Expressions

## Assignment

Cobra supports type inference in assignments, allowing the language to automatically deduce the type of the variable from the expression on the right side of the = operator. Explicit type declarations can also be used to specify the variable type:

```
# Declared and assigned
variable_name_str: str = "hello"
# Dynamically typed
variable_name = "hello"
```

Compound assignments are supported that include a binary operation with an assignment. Operators such as: += -= *= /= modify the value of the variable by the right-hand expression and assign the result into the variable.

```
counter: int = 0
counter += 1 # this results in counter = 1

# reassigning a value (thats previously typed)
counter = 2
count *= 2 # this results in counter = 4
count /= 4 # this results in counter = 1
count -= 1 # this results in counter = 0
```

All variables are bound to the local block scope. Specifically within

- Classes
- Functions (def,endef)
- Loops (while,next)
- If/Else (if,else,endif)

## If

The if statement executes a code block if a specified condition is true. If a specified condition is true, the block is executed otherwise an optional else block is executed.

`if`/`else` statements must be followed by an endif ensuring logical blocking.

```
if True:
	# ...
endif

if False:
	# ...
else:
	# ...
endif
```

## While

The while statement allows for repeated execution until the expression is False. As stated before, a break may allow for early termination.

`while` statements must be followed by a `next` ensuring logical blocking.

A non-terminating while loop will result in indefinitely running code.

```
def method():
	i = 0
	while True:
		i += 1
		if i == 5:
			return i
	next	
endef
```

## Break

Only allowed within while loops, break statements terminate the current loop and transfer execution to the statement immediately following the loop after `next`.

Unlike Break, Continue will skip the rest of the code inside the current loop iteration and proceed to the next loop iteration.

```
i = 0
while True:
	if i == 4:
		continue
	endif
	i += 1
	if i == 5:
			break
	endif
next
# i = 4
```

## Function Def / Return

Functions can return values using the return statement. If a function doesn't explicitly return a value, it implicitly returns None.

Returns may only occur in function definitions. It ends the current function execution and returns control to the calling function along with the result of the expression, if provided. If no value is returned, None is substituted.

`def` statements must be followed by a `endef` ensuring logical blocking.

```
def hello_world():
	return "Hello, World!"
endef
```
