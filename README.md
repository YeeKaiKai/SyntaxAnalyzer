# Compiler Project 2

## Generate the Parser

- Compile the Flex and Bison source files into an executable:

```bash=
flex cactus.l
bison -d cactus.y
gcc -o parser lex.yy.c cactus.tab.c
```

## Running the Parser

### Error Handling

- If detects a syntax error, the parser will print a `Syntax error` message with the line number to `stderr`
  - `Syntax error: line ##`

### Basic Usage

- To run the parser directly without printing grammar rules to `stdout`:

```bash
./parser < input
```

### With `-p` option

- To run the parser with `-p` option, it will print grammar rules to `stdout`:

```bash
./parser -p < input
```
