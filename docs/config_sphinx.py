#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2016 uralbash <root@uralbash.ru>
#
# Distributed under terms of the MIT license.

# standard library
import os
import sys
import subprocess
import xml.etree.ElementTree as ET
from datetime import datetime

# Docs
import docutils
from docutils.parsers.rst import directives
from sphinx.builders.html import StandaloneHTMLBuilder
from sphinx.builders.latex import LaTeXBuilder
from sphinx.directives.code import CodeBlock
from docutils.parsers.rst.roles import set_classes

sys.path.insert(0, os.path.abspath('.'))
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.abspath(os.path.join(HERE, '../_ext')))

# Submodules
CURDIR = os.path.abspath('../')
bashCommand = "git --git-dir={0}/.git --work-tree={0}".format(
    CURDIR
) + " submodule update --init --recursive"
process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
output, error = process.communicate()

# Install
bashCommand = '''python /home/docs/checkouts/readthedocs.org/user_builds/lectureswww/envs/master/bin/pip install --upgrade --cache-dir /home/docs/checkouts/readthedocs.org/user_builds/lectureswww/.cache/pip -r ../_lectures/requirements.txt'''
process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
output, error = process.communicate()

# Install
bashCommand = "ls -la"
process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
output, error = process.communicate()
print(output, error)

# Install
bashCommand = "pwd"
process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
output, error = process.communicate()
print(output, error)

from common import GLOBAL_LINKS  # noqa isort:skip

links_collection = GLOBAL_LINKS

directives.register_directive('no-code-block', CodeBlock)

# Submodules
CURDIR = os.path.abspath('../')
bashCommand = "git --git-dir={0}/.git --work-tree={0}".format(
    CURDIR
) + " submodule update --init --recursive"
process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
output, error = process.communicate()

# Install
bashCommand = "pip install -r _lectures/requirements.txt"
process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
output, error = process.communicate()

# IMAGES
image_types = ['image/png', 'image/svg+xml', 'image/gif', 'image/jpeg']

# Redefine supported_image_types for the HTML and LaTeX builder
LaTeXBuilder.supported_image_types = image_types
StandaloneHTMLBuilder.supported_image_types = image_types

# html_favicon = '../_lectures/_static/urfu-icon.png'
html_sidebars = {
    '**': ['globaltoc.html',
           'searchbox.html',
           'sourcelink.html',
           ],
    'using/windows': ['windowssidebar.html', 'searchbox.html'],
}

# If true, figures, tables and code-blocks are automatically numbered if they
# has caption. For now, it works only with the HTML builder. Default is False.
numfig = False
# A dictionary mapping 'figure', 'table' and 'code-block' to strings that are
# used for format of figure numbers. Default is to use 'Fig. %s' for 'figure',
# 'Table %s' for 'table' and 'Listing %s' for 'code-block'.
numfig_format = {
    "figure": u"Рис. %s",
    "table": u"Таблица %s",
    "code-block": u"Код %s"
}

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
# sys.path.insert(0, os.path.abspath('.'))

# -- General configuration ------------------------------------------------

# If your documentation needs a minimal Sphinx version, state it here.
# needs_sphinx = '1.0'

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
    'sphinx_links',
    'sphinx.ext.autodoc',
    'sphinx.ext.todo',
    'sphinx.ext.doctest',
    'sphinx.ext.intersphinx',
    'sphinx.ext.viewcode',
    'zzzeeksphinx',
    'edit_on_github'
]

# TODO
if 'NO_METRIKA' in os.environ:
    todo_include_todos = True

# The suffix of source filenames.
source_suffix = '.rst'

# The encoding of source files.
# source_encoding = 'utf-8-sig'

# The master toctree document.
master_doc = 'index'
current_year = str(datetime.now().year)
copyright = current_year + ',' + \
    u' Кафедра Интеллектуальных Информационных Технологий ИнФО УрФУ'
release_date = datetime.now().strftime("%Y-%m-%d")

# The language for content autogenerated by Sphinx. Refer to documentation
# for a list of supported languages.
language = 'ru'

# There are two options for replacing |today|: either, you set today to some
# non-false value, then it is used:
# today = ''
# Else, today_fmt is used as the format for a strftime call.
today_fmt = '%d-%m-%Y'
# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
exclude_patterns = ['contents.rst']

# The name of the Pygments (syntax highlighting) style to use.
pygments_style = 'sphinx'

# -- Options for HTML output ----------------------------------------------

# Add any paths that contain templates here, relative to this directory.
dir_path = os.path.dirname(os.path.realpath(__file__))
templates_path = [os.path.join(dir_path, '_templates')]

# Add any paths that contain custom themes here, relative to this directory.
# html_theme_path = [
#     os.path.join(HERE, 'themes'),
#     os.path.join(HERE, 'themes/zzzekphinx')
# ]

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
html_theme = 'zzzeeksphinx'

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = [
    '_static',
    '../_lectures/_static'
]

# Output file base name for HTML help builder.
htmlhelp_basename = '-doc'

# -- Options for LaTeX output ---------------------------------------------
ADDITIONAL_PREAMBLE = """
\\setcounter{tocdepth}{3}
"""

latex_elements = {
    # The paper size ('letterpaper' or 'a4paper').
    'papersize': 'a4papper',
    'wrapperclass': 'scrbook',
    # The font size ('10pt', '11pt' or '12pt').
    'pointsize': '12pt',
    # 'fontpkg': '\\usepackage[sfdefault]{cabin}',
    # Additional stuff for the LaTeX preamble.
    'preamble': ADDITIONAL_PREAMBLE,
    'figure_align': 'ht',  # htbp
}

# The name of an image file (relative to this directory) to place at the top of
# the title page.
# latex_logo = html_logo

# -- Options for Epub output ----------------------------------------------

# Bibliographic Dublin Core info.
epub_author = u'uralbash'
epub_publisher = u'uralbash'
epub_copyright = current_year + ', uralbash'

# A list of files that should not be packed into the epub file.
epub_exclude_files = ['search.html']

# Example configuration for intersphinx: refer to the Python standard library.
intersphinx_mapping = {
    'https://docs.python.org/2': None,
    'https://docs.python.org/3': None,
    'http://docs.sqlalchemy.org/en/latest/': None,
    'http://initd.org/psycopg/docs/': None,

    # lectures
    'http://lecturesdb.readthedocs.io/': None,
    'http://lectureskpd.readthedocs.io/': None,
    'http://lecturesnet.readthedocs.io/': None,
}


# TODO: сделать через директиву, типа .. note::
def sourcecode(role, rawtext, text, lineno, inliner,
               options={}, content=[]):
    """
    Example:

        See code there :src:`6.www.sync/2.codding/blog/0.paster`.
    """
    # Base URL mainly used by inliner.rfc_reference, so this is correct:
    source_url =\
        'https://github.com/ustu/lectures.www/tree/master/sourcecode/'
    ref = source_url + text
    set_classes(options)
    node = docutils.nodes.reference(
        rawtext,
        source_url + docutils.utils.unescape(text),
        refuri=ref, **options)
    return [node], []


def add_html_link(app, pagename, templatename, context, doctree):
    """As each page is built, collect page names for the sitemap"""
    _prefix = 'LECTURES_BASE_URL'
    base_url = os.environ.get(_prefix)
    if base_url:
        app.sitemap_links.append(base_url + pagename + ".html")


def create_sitemap(app, exception):
    """Generates the sitemap.xml from the collected HTML page links"""
    if (exception is not None or not app.sitemap_links):
        return

    filename = app.outdir + "/sitemap.xml"
    print("Generating sitemap.xml in %s" % filename)

    root = ET.Element("urlset")
    root.set("xmlns", "http://www.sitemaps.org/schemas/sitemap/0.9")

    for link in app.sitemap_links:
        url = ET.SubElement(root, "url")
        ET.SubElement(url, "loc").text = link

    ET.ElementTree(root).write(filename)


def set_base_url(url):
    _prefix = 'LECTURES_BASE_URL'
    if os.environ.get(_prefix):
        return
    os.environ[_prefix] = url


def setup(app):
    """Install the plugin.

    :param app: Sphinx application context.
    """
    if 'NO_METRIKA' not in os.environ:
        app.add_javascript('js/metrika.js')
        app.add_javascript('js/partner.js')

    # CSS styles
    app.add_stylesheet('css/todo.css')
    app.add_stylesheet('css/custom.css')

    # Add roles
    app.add_role('src', sourcecode)

    # sitemap
    """Setup conntects events to the sitemap builder"""
    app.connect('html-page-context', add_html_link)
    app.connect('build-finished', create_sitemap)
    _prefix = 'LECTURES_BASE_URL'
    base_url = os.environ.get(_prefix)
    app.sitemap_links = [
        "{}index.html".format(base_url),
        "{}genindex.html".format(base_url),
    ]
