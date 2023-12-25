[![PyPI version](https://badge.fury.io/py/orphism.svg)](https://badge.fury.io/py/orphism)

# Orphism

A text-based implementation of horizon charts, mostly inspired by [Cubism.js](https://github.com/square/cubism). The name is based on an [offshoot of cubism](https://en.wikipedia.org/wiki/Orphism_(art)) focused on abstraction and color.

Horizon charts in a single line of text allow for an incredible amount of resolution in minimal space: making it easier to find outliers and understand general trends in
 numbers. Orphism is an implementation built using [Rich](https://github.com/Textualize/rich) for advanced rendering and [Unicode block characters](https://www.w3.org/TR/xml-entity-names/025.html).

For fun -- and the joy of programming -- Orphism is implemented in [Hy Lang](https://github.com/hylang/hy). Strategically placed `__init__.py` files that import hy should make this completely transparent to anyone relying on the library.


This is currently a **development build**: please expect the API and design to change dramatically as I iterate.

![Demo](https://github.com/kunalb/orphism/raw/main/images/orphism.svg)


## Installation

Available on [PyPI](https://pypi.org/project/orphism/)!

```
pip install orphism
```

This will install both a module and a CLI.

## Usage


### CLI

The development versions are incredibly simple: they can accept a list of numbers as arguments, or through stdin (generally a pipe).


#### Through stdin
```
echo 1 2 3 | orphism
```

#### As arguments
```
orphism $(echo 1 2 3)
```

### API

A `LineRenderable` class represents the rich element to render a horizon chart.

```
import rich
from orphism.line import LineRenderable

rich.print(LineRenderable([1, 2, 3, 4]))
```

## Updates

### 2023-12-15
- First public release; 0.0.1dev2 is somewhat functional.
