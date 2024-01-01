from setuptools import setup, find_packages

from pathlib import Path
this_directory = Path(__file__).parent
long_description = (this_directory / "README.md").read_text()

setup(
    name="orphism",
    version="0.0.1.dev4",
    packages=find_packages(include=["orphism"]),
    package_data={
        "orphism": ["*.hy"],
    },
    install_requires=[
        "hy>=0.27.0",
        "hyrule>=0.4.0",
        "rich>=12.6.0",
    ],
    entry_points={
        "console_scripts": [
            "orphism = orphism.__main__:main",
        ]
    },
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/kunalb/orphism",
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
        "Development Status :: 3 - Alpha",
    ],
    python_requires=">=3.8",
)
