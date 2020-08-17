from .awesome_rust_extension import hello_from_rust, count_words_rust

def hello_from_python():
    print("Hello world from Python!")

def count_words_python(input_path):
    with open(input_path) as input_file:
        word_counts = {}
        for word in input_file.read().lower().split():
            word_counts[word] = word_counts.get(word, 0) + 1
        return word_counts
