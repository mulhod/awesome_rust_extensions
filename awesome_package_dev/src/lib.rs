use pyo3::prelude::*;
use pyo3::wrap_pyfunction;

#[pyfunction]
fn hello_from_rust() {
    println!("Hello World from Rust!");
}

#[pymodule]
fn awesome_rust_extension(_py: Python<'_>, m: &PyModule) -> PyResult<()> {
    m.add_wrapped(wrap_pyfunction!(hello_from_rust))?;
    Ok(())
}
