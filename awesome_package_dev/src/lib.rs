use std::collections::HashMap;
use pyo3::prelude::*;
use pyo3::wrap_pyfunction;

#[pyfunction]
fn hello_from_rust() {
    println!("Hello World from Rust!");
}

#[pyfunction]
fn count_words_rust(input_string: String) -> HashMap<String, u32> {
    let mut word_counts: HashMap<String, u32> = HashMap::new();
    for word in input_string.to_lowercase().split_whitespace() {
        *word_counts.entry(word.into()).or_insert(0u32) += 1u32;
    }
    word_counts
}

#[pymodule]
fn awesome_rust_extension(_py: Python<'_>, m: &PyModule) -> PyResult<()> {
    m.add_wrapped(wrap_pyfunction!(hello_from_rust))?;
    m.add_wrapped(wrap_pyfunction!(count_words_rust))?;
    Ok(())
}
