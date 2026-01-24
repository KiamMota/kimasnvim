# Vim C++ Abbreviations

A collection of simple Vim abbreviations to speed up C++ coding by quickly expanding common types and patterns.

## Current Abbreviations

| Trigger  | Expansion             | Description                             |
| -------- | --------------------- | --------------------------------------- |
| `_cstrr` | `const std::string& ` | Expands to a constant string reference. |
| `_cstr`  | `const std::string& ` | Same as `_cstrr`, for convenience.      |

## Suggested Additional Abbreviations

| Trigger  | Expansion                   | Description                     |
| -------- | --------------------------- | ------------------------------- |
| `_veci`  | `std::vector<int> `         | Creates a vector of integers.   |
| `_vecs`  | `std::vector<std::string> ` | Creates a vector of strings.    |
| `_ptr`   | `std::unique_ptr<>\`        | Start writing a unique pointer. |
| `_shptr` | `std::shared_ptr<>`         | Start writing a shared pointer. |
| `_fref`  | `float& `                   | Expands to a float reference.   |
| `_dref`  | `double& `                  | Expands to a double reference.  |
| `_auto`  | `auto `                     | Expands to `auto`.              |

## Usage

Add the following lines to your `init.vim` or `vimrc` file to enable the abbreviations:

```vim
vim.keymap.set('ca', '_cstrr', 'const std::string& ')
vim.keymap.set('ca', '_cstr', 'const std::string& ')
vim.keymap.set('ca', '_veci', 'std::vector<int> ')
vim.keymap.set('ca', '_vecs', 'std::vector<std::string> ')
vim.keymap.set('ca', '_ptr', 'std::unique_ptr<>')
vim.keymap.set('ca', '_shptr', 'std::shared_ptr<>')
vim.keymap.set('ca', '_fref', 'float& ')
vim.keymap.set('ca', '_dref', 'double& ')
vim.keymap.set('ca', '_auto', 'auto ')
```

## Example

Typing `_cstr` in insert mode will expand to:

```cpp
const std::string& name;
```

Typing `_veci` will expand to:

```cpp
std::vector<int> numbers;
```

