
# Tan Language Compiler Expansion

![DALL·E 2023-12-01 22 22 12 - Create a sleek and abstract 3D animation-style cover photo for a compiler project for the custom programming language 'Tan', inspired by the complexit](https://github.com/ssanjan123/Creating-a-Compiler/assets/84153519/aba0aff1-c41c-4361-8352-d153dde6468a)

## Introduction
**Tan Language Compiler Expansion** is an advanced project focused on enhancing a custom programming language named Tan. Developed using Java and Assembly Language, this project extends the capabilities of a base compiler, introducing more complex functionalities and demonstrating a deep understanding of formal languages, automata, data structures, and algorithms. The project aligns with the principles of compiler design taught in SFU CMPT 379 (Compilers) and showcases a systematic approach to expanding language features and compiler functionalities.



## Features

- **Language Design and Syntax**: Tan-3, an extension of Tan-2, introduces advanced features while maintaining backward compatibility. It includes new syntactical constructs for function definitions, control flow statements, and expressions.
- **Compiler Components**: The project enhances various compiler phases like tokenizing, parsing, and transforming source programs into Assembly Language.
- **Incremental Feature Implementation**: Each feature of Tan-3 is implemented and tested incrementally to ensure seamless integration and efficiency.
- **Advanced Concepts**: Implementation showcases proficiency in concepts like scope management, memory allocation, and handling of function invocations.

## Project Structure

The project is structured as follows:

- `src/`: Contains all source files for the compiler.
  - `lexer/`: Tokenizing source code of Tan language.
  - `parser/`: Syntax analysis and parse tree generation.
  - `semantic/`: Semantic checks and symbol table management.
  - `codegen/`: Code generation into Assembly Language.
- `docs/`: Documentation and design notes.
- `test/`: Test cases and scripts for validating each feature.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

**Prerequisites:**

- Java Development Kit (JDK) - version 11 or higher.
- Assembly Language simulator or environment (specific to the Assembly Language used in the project).

**Installation:**

1. Clone the repository:
   ```bash
   git clone https://github.com/ssanjan123/Creating-a-Compiler
   ```
2. Navigate to the project directory:
   ```bash
   cd tan-S
   ```
3. Compile the source code:
   ```bash
   javac src/*.java
   ```

## Usage Guide

This section explains how to use the compiler to compile Tan programs.

1. **Writing a Tan Program**: Create a `.tan` file with the source code of your Tan program.
2. **Compiling the Program**: Run the compiler with the following command:
   ```bash
   java Main <path_to_tan_file>
   ```
3. **Running the Assembly Code**: The compiler will generate Assembly Language code, which can be run using an Assembly Language simulator which is located inside the tan-S folder.


NOTE: For a detailed understanding on the tasks that were done to create and expand on this compiler please refer to the Milestone 1,2 and 3 pdf files.

