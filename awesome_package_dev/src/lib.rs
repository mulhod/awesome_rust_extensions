use pyo3::prelude::*;
use pyo3::wrap_pyfunction;

#[pyfunction]
fn hello_from_rust() {
    println!("Hello World from Rust!");
}

#[pyclass]
struct Word {
    #[pyo3(get, set)]
    word: String,
    #[pyo3(get, set)]
    lemma: String
}

#[pymethods]
impl Word {
    #[new]
    fn new(word: String, lemma: String) -> Self {
        Word { word, lemma }
    }
}

#[pymodule]
fn awesome_rust_extension(_py: Python<'_>, m: &PyModule) -> PyResult<()> {
    m.add_wrapped(wrap_pyfunction!(hello_from_rust))?;
    m.add_class::<Word>()?;
    Ok(())
}
