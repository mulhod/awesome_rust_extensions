# awesome_rust_extensions

## Description
- Create some trivial Rust extensions for Python included in the Python package [awesome-package](awesome_package_dev/awesome_package)
- Rust extensions include `hello_from_rust` and `count_words_rust`.
- The Rust extensions reside under [src/lib.rs](awesome_package_dev/src/lib.rs)
- Corresponding Python versions: `hello_from_python` and `count_words_python`.

## Installation
- Run `make` to build a Conda environment and install the Python package (thereby building the Rust extensions).
- This will create a Conda environment in the current directory named `.env`

## Use
- After installation, activate the Conda environment via e.g. `conda activate ./.env`.
- Run `ipython` to start an IPython session and import from `awesome_package`:
```python
from awesome_package import (hello_from_rust, count_words_rust,
                             hello_from_python, count_words_python)
```
