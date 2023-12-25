from setuptools import setup, find_packages

setup(
    name="orphism",
    version="0.0.1.dev1",
    packages=find_packages(include=["orphism"]),
    install_requires=[
        "hy>=0.27.0",
        "hyrule>=0.4.0",
        "rich>=12.6.0",
    ],
    entry_points={
        'console_scripts': [
            'orphism = orphism.__main__:main',
        ]
    }
)
