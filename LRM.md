# Cobra Language Reference

Vidur Gupta (Manager), Vineeth Vajipey (Language Guru), Sumya Hoque (System Architect), Baily Troyer (Tester)

# 1 Intro {#1-intro}

Cobra is a compact, multipurpose programming language that combines the readability of Python with the low-level memory control features of C/C++. Designed for embedded systems, it prioritizes minimalism and flexibility, enabling effective development on resource-limited platforms. Features include dynamic class definitions, object-oriented programming, optional strong typing, and direct pointer access. Cobra aims to simplify embedded development, providing a perfect blend of high-level ease and low-level functionality, all within a portable and efficiently sized binary.

Its syntax is designed to be straightforward for beginners while providing powerful capabilities for experienced developers. Through this guide, you'll learn Cobra's syntax and features, equipped with examples to demonstrate its application in embedded system programming. Cobra aims to make embedded development more efficient and accessible.

The following document is heavily inspired by the LRMs for [Rusty](https://www.cs.columbia.edu/~sedwards/classes/2016/4115-fall/lrms/rusty.pdf) and [Python](https://docs.python.org/3/reference/index.html).


# 2 Lexical {#2-lexical}

_This section describes how the lexical analyzer breaks a file into tokens._


## 2.1 Tokens {#2-1-tokens}


### 2.1.1 Lines (logical, physical) {#2-1-1-lines-logical-physical}

The end of a line** **is represented by a new line whereas space between tokens includes all space-delimited values such as whitespace, tab, and carriage return.

A **line** is a sequence of characters separated by the newline sequence.


### 2.1.2 Indentation {#2-1-2-indentation}

Leading whitespace (tabs) at the beginning of a **line **is used to compute the indentation level that groups statements.

Indentation is rejected if a file mixes a different number of tabs in an indentation level. This results in an <span style="text-decoration:underline;">IndentationMismatchError</span>.


### 2.1.3 Comments {#2-1-3-comments}

A comment starts with a pound character (#) not part of a string literal ending at the end of the physical line. Comments are ignored by the syntax.

Cobra does NOT include multiline comments such as Typescript with **/* comment */**.

Whitespace

Except within string literals, whitespace characters can be used interchangeably between tokens. White Space is required between two tokens if and only if their concatenation could be interpreted differently.

Example: foobar as one token and foo bar as two separate tokens


## 2.2 Identifiers {#2-2-identifiers}

Identifiers are described by the following definitions.



1. Identifiers are unlimited in length
2. Identifiers must start with a letter
3. Identifiers cannot collide with existing keywords
    1. Otherwise, this results in a <span style="text-decoration:underline;">KeywordCollision</span>


## 2.3 Keywords {#2-3-keywords}

Unlike identifiers, keywords cannot be used as names for variables or functions.

Additional logical and mathematical tokens are specified below under Operators.


## 2.4 Literals {#2-4-literals}

Literals represent fixed values directly in code. They are fundamental to defining mutable and immutable values and are categorized into several types. There is no individual Character literal, but merely a string with one character wrapped in double quotes.



* Integer - whole numbers without decimal point
    * `[0-9]+`
* Float - real numbers & decimal points. Values required on both ends of the point
    * `digit+ ['.'] digit+`
* Boolean - truth values
    * `True False`
* String - a sequence of characters wrapped in double quotes
    * `'"' (char | whitespace)* '"'`
* Null - a value denoting the absence of any value or object
    * `None`
* Nan - a special literal denoting an undefined/unrepresentable value in floating point
    * `NaN`
    * Errors or undefined results in numeric computations result in NaN
        * This includes division by zero and the square root of negative numbers


## 2.5 Operators {#2-5-operators}

The following tokens are operators:

The following have special meaning and/or are not supported tokens resulting in an **<span style="text-decoration:underline;">UnknownCharacter</span>**.


```
' " $ ?
```



# 3 Types {#3-types}

_This section describes the variety of data types supported by the language, including primitive types (e.g., integers, floating-point numbers, booleans, and characters), complex structures (e.g., arrays, lists, tuples, and dictionaries), and user-defined types (e.g., classes)._


## 3.1 Primitive Types {#3-1-primitive-types}

Similar to Python numeric values (float and integer) are stored in 32 bits. Cobra enforces dynamic, strong types which are optionally deduced. When used syntactically, the soundness of types are enforced otherwise resulting in an <span style="text-decoration:underline;">InvalidType</span>.

A lack of types at variable assignment will result in runtime-driven type enforcement, with the same error being thrown at runtime.


## 3.2 Custom Types {#3-2-custom-types}


### 3.2.1 Named Types {#3-2-1-named-types}

Named types allow for new types based on existing ones, giving a clearer context and enhancing code readability. These types are particularly useful for distinguishing between different uses of standard data types, such as using integers for different measurement units.


```
type MyString = str
```


This feature lets you create aliases for complex types or simply rename types to reflect their purpose within your application better. Custom-named types maintain the properties and methods of the base type, making them a seamless extension of existing data types with added clarity.


### 3.2.2 Union {#3-2-2-union}

Unlike the below data types, the union provides a way to declare a variable that can hold values of different types, enhancing flexibility and expressiveness in type management. A variable of a union type can store a value of any of the specified types, making them ideal for functions that may return or operate on values of more than one type.


```
type StringInt = str | int
```


Union types let a single variable hold a value of one type among several specified, without specifying the exact type in advance or the order of types. Essentially, tuples are for grouping multiple values, while unions are for a single value of multiple types.


## 3.3 Advanced Data Types {#3-3-advanced-data-types}


### 3.3.1 Array {#3-3-1-array}

Arrays are homogeneous collections that store multiple values of the same type. They are declared by specifying the type of elements they will hold, followed by square brackets []. The size of an array can be fixed or dynamic, providing flexibility in managing collections of data.


```
points: int[] = [1,2,3]
```



### 3.3.2 Class {#3-3-2-class}

Classes are the blueprint from which objects are created, encapsulating data for the object and methods to manipulate that data. They support the principles of object-oriented programming, including inheritance, encapsulation, and polymorphism.


# 4 Operators {#4-operators}

_This section describes the arithmetic operators, logical operators, comparison operators and assignment operators along with their corresponding precedence._


## 4.1 Logical {#4-1-logical}



* **and**: Logical AND operator
    * Evaluates to true if both operands are true; false otherwise
* **or:** Logical OR operator
    * Evaluates to true if at least one of the operands is true; false otherwise
* **not**: Logical NOT operator
    * Inverts the truth value of its operand


## 4.2 Equivalence  {#4-2-equivalence}



* **==** (Equal to): Compares two operands for equality
    * Returns true if they are equal, false otherwise
* **!= **(Not Equal to): Compares two operands for inequality
    * Returns true if they are not equal, false otherwise


## 4.3 Arithmetic {#4-3-arithmetic}



* **+**:** **Adds to operands
* **-**: Subtracts the second operand from the first
* *****:** **Multiplies two operands
* **/**: Divides the first operand by the second
* **%**:** **Modulus returning the remainder of dividing the first operand by the second


## 4.4 Assignment {#4-4-assignment}



* **=**: Assignment** **operator assigning the value on the right to the variable on the left
* (** + **|** -** |** / **| *** **)**=**: Compound assignment operator
    * Performs the arithmetic operation (addition, subtraction, multiplication, division) on and assigns the result to the variable


## 4.5 Memory Reference & Mgmt {#4-5-memory-reference-&-mgmt}



* **&** (Address of): Returns the memory address of its operand
* *** **(Dereference): Accesses the value at the address specified by its operand
* a = new int, b = new int[5], delete a, delete[] b
    * We request new heap memory for our objects using ‘new’ command. We have the brackets syntax for requesting an array of that object.
    * Similarly, we can free the memory using delete or delete[] depending on if the instance is a plain object or an array.
* makeManual: turns a stack variable into heap and start with a retain count of 1
* release: decrement the retain count of an object. When an object's retain count reaches zero, the object is deallocated, and its memory is freed
* retain: increment the retain count of an object. When you create or copy an object, its retain count is set to one. Each call to retain must be balanced with a call to release or autorelease to avoid memory leaks


## 4.6 Precedence {#4-6-precedence}



1. Arithmetic
2. Comparison
3. Logical
4. Assignment


# 5 Statements & Expressions {#5-statements-&-expressions}

_This section describes the supported body of operations and instructions in the language. Expressions consist of multiple statements that cover variable assignment, branching, looping, object creation, and exception handling._


## 5.1 Assignment {#5-1-assignment}

Cobra supports type inference in assignments, allowing the language to automatically deduce the type of the variable from the expression on the right side of the = operator. Explicit type declarations can also be used to specify the variable type:

Compound assignments are supported that include a binary operation with an assignment. Operators such as: `+= -= *= /= `modify the value of the variable by the right-hand expression and assign the result into the variable.

All variables are bound to the local block scope. Specifically within



* Classes
* Functions

Assignments can occur for all primitives and advanced data types. With advanced data types such as classes, if a name is already bound and is reassigned the name is rebound which may incur a deallocation/destructor call on the previous target class instance. 

Variables cannot conflict with reserved words (e.g. int) otherwise resulting in <span style="text-decoration:underline;">NameConflict**.**</span>


## 5.2 Break / Continue {#5-2-break-continue}

Only allowed within while loops, break statements terminate the current loop and transfer execution to the statement immediately following the loop.

Unlike Break, Continue will skip the rest of the code inside the current loop iteration and proceed to the next loop iteration.


## 5.3 If {#5-3-if}

The if statement executes a code block if a specified condition is true. Trailing elif statements are supported along with else. If a specified condition is true, the block is executed. If all if/elif blocks are false the optional trailing else is executed.


## 5.4 While {#5-4-while}

The while statement allows for repeated execution until the expression is False. As stated before, a break may allow for early termination.

A non-terminating while loop will result in indefinitely running code.


## 5.5 Function Definition / Return {#5-5-function-definition-return}

Functions can return values using the return statement. If a function doesn't explicitly return a value, it implicitly returns null. They are defined using the `def` keyword, followed by the function name and parentheses containing any parameters. The body of the function starts on the next line, indented.

Returns may only occur nested in function definitions. It ends the current function execution and returns control to the calling function, along with the result of the expression, if provided. If no value is returned, None is substituted.


## 5.6 Class Definition {#5-6-class-definition}

Class definitions are executable statements that optionally include one inheritance hierarchy, outlining the base class for the extension. The optionally defined item in this inheritance must be class objects that permit subclassing.

By default, classes without an inheritance list derive from the standard base class object, enabling a framework for both elemental and elaborate class architectures.

Variables declared within the class scope are class attributes, shared across all instances. Instance attributes are specified within methods using self. Access to both types is through self with instance attributes taking precedence over class attributes of the same name.
