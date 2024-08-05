# Configuration file for the Sphinx documentation builder.
#
# This file only contains a selection of the most common options. For a full
# list see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Path setup --------------------------------------------------------------

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#
# import os
# import sys
# sys.path.insert(0, os.path.abspath('.'))
from pathlib import Path

ROOT = Path(__file__).parent.parent.resolve()

# -- Project information -----------------------------------------------------

project = "Serious Scaffold Cpp"
copyright = "2022-2024 Serious Scaffold"
author = "msclock"

# -- General configuration ---------------------------------------------------

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
    "breathe",
    "myst_parser",
    "sphinx_copybutton",
    "sphinx.ext.autodoc",
    "sphinx.ext.intersphinx",
    "sphinx.ext.viewcode",
    "sphinx_inline_tabs",
]
source_suffix = {
    ".rst": "restructuredtext",
    ".md": "markdown",
}
# Add any paths that contain templates here, relative to this directory.
templates_path = ["_templates"]

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = ["_build", "Thumbs.db", ".DS_Store"]

# Tell sphinx what the primary language being documented is.
primary_domain = "cpp"

# Tell sphinx what the pygments highlight language should be.
highlight_language = "cpp"

cpp_id_attributes = [
    "COMPILE_EXPORT",
    "GIT_EXTERN_C_BEGIN",
]

# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-the-linkcheck-builder
linkcheck_ignore = [
   'https://wiki.sei.cmu.edu/confluence/',
]

# -- Extension configuration -------------------------------------------------
myst_enable_extensions = [
    "colon_fence",
    "substitution",
    "deflist",
]

# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of buhltin themes.
#
# default theme
# html_theme = 'alabaster'
#
# use furo
html_theme = "furo"

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
# html_static_path = ["_static"]

html_favicon = 'https://img.shields.io/badge/SSC-blue'

html_css_files = [
    "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/fontawesome.min.css",
    "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/solid.min.css",
    "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/brands.min.css",
]

html_theme_options = {
    "footer_icons": [
        {
            "name": "GitHub",
            "url": "https://github.com/serious-scaffold/ss-cpp",
            "html": "",
            "class": "fa-brands fa-solid fa-github fa-lg",
        },
    ],
}

# -- breath configuration ----------------------------------------------------
# See https://breathe.readthedocs.io/en/latest/ for more information.

breathe_projects = {"ss-cpp-doxygen": f"{ROOT}/docs/_build/doxygen/xml"}
breathe_default_project = "ss-cpp-doxygen"
breathe_debug_trace_directives = False
