from .awesome_rust_extension import (search,
                                     search_sequential,
                                     search_sequential_allow_threads,
                                     hello)

def search_py(contents, needle):
    total = 0
    for line in contents.split():
        words = line.split(" ")
        for word in words:
            if word == needle:
                total += 1
    return total
