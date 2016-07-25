.. image:: https://travis-ci.org/ustu/lectures.svg
    :target: https://travis-ci.org/ustu/lectures

Инструкция как писать эту документацию
======================================

Документация написана при помощи языка разметки reStructuredText и
генератора Sphinx. Sphinx — это генератор документации, который
преобразует файлы в формате reStructuredText в HTML website и другие
форматы (PDF, EPub и man).

* `<https://ru.wikipedia.org/wiki/Sphinx_(генератор_документации)>`_
* `Документация на русском
  <https://sphinx-ru.readthedocs.org/ru/latest/>`_

Установка
---------

Установка

.. code-block:: bash

   $ pip install -r requirements.txt

Клонирование репозитария

.. code-block:: bash

   $ git clone git@github.com:ustu/lectures.git
   $ cd lectures

Инициализация подмодулей (сами лекции)

.. code-block:: bash

    $ git submodule update --init --recursive --remote

Структура
---------

.. code-block:: text

   .
   ├── docs             <----- Файлы настроек для лекций в формате RST
   ├── vagrant          <----- Docker контейнер для запуска примеров
   ├── make.bat
   ├── Makefile
   ├── README.rst
   ├── requirements.txt
   ├── rstlint.py
   ├── CONTRIBUTING.rst
   ├── test.sh          <----- Всякие линтеры и чекеры
   └── Vagrantfile      <----- Vagrant для автоматизации запуска
                               Docker контейнеров

Сборка
------

Для Unix like

.. code-block:: bash

   $ LECTURES=www make html

В Docker

.. code-block:: bash

   $ LECTURES=www vagrant up --provider=docker

.. code-block:: bash

   $ LECTURES=www vagrant reload

Требования к оформлению
-----------------------

Смотри `CONTRIBUTING.rst
<https://github.com/ustu/lectures/blob/master/CONTRIBUTING.rst>`_


.. image:: https://badges.gitter.im/Join%20Chat.svg
   :alt: Join the chat at https://gitter.im/ustu/lectures
   :target: https://gitter.im/ustu/lectures?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge
