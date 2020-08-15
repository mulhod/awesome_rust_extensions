from setuptools import setup
from setuptools_rust import Binding, RustExtension

setup(
    name="awesome-package",
    version="0.0.1",
    rust_extensions=[RustExtension("awesome_package.awesome_rust_extension", binding=Binding.PyO3)],
    packages=["awesome_package"],
    # rust extensions are not zip safe, just like C-extensions.
    zip_safe=False,
)
