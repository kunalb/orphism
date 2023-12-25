from setuptools import setup, find_packages

setup(
    name="fauvism",
    version="0.0.1",
    packages=find_packages(include=["fauvism"]),
    install_requires=[
        "hy>=0.27.0",
        "hyrule>=0.4.0",
        "rich>=12.6.0",
    ]
)
