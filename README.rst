.. image:: https://travis-ci.org/ustu/lectures.www.svg
    :target: https://travis-ci.org/ustu/lectures.www

Инструкция как писать эту документацию
======================================

Документация написана при помощи языка разметки reStructuredText и генератора Sphinx.
Sphinx — это генератор документации, который преобразует файлы в формате reStructuredText
в HTML website и другие форматы (PDF, EPub и man).

* `<https://ru.wikipedia.org/wiki/Sphinx_(генератор_документации)>`_
* `Документация на русском <https://sphinx-ru.readthedocs.org/ru/latest/>`_

Установка
---------

Установка

.. code-block:: bash

  pip install -r requirements.txt

Клонирование репозитария

.. code-block:: bash

  git clone git@github.com:ustu/lectures.www.git
  cd lectures.www

Структура
---------

::

   .
   ├── docs             <----- Лекции в формате RST
   ├── examples         <----- Исходные коды с примерами из лекций
   ├── slides           <----- Презентации к лекциям в формате LaTeX
   ├── vagrant          <----- Docker контейнер для запуска примеров
   ├── make.bat
   ├── Makefile
   ├── README.rst
   ├── requirements.txt
   ├── rstlint.py
   ├── CONTRIBUTING.rst
   ├── test.sh          <----- Всякие линтеры и чекеры
   └── Vagrantfile      <----- Vagrant для автоматизации запуска Docker контейнеров

Сборка
------

Для Unix like

.. code-block:: bash

  make html

В Docker

.. code-block:: bash

   vagrant up --provider=docker

.. code-block:: bash

   vagrant reload

Для Windows

.. code-block:: bash

  make.bat html

Зависимости
-----------

Для команды ``make livehtml`` необходимо установить `sphinx-autobuild
<https://github.com/GaretJax/sphinx-autobuild>`_

Требования к оформлению
-----------------------

Смотри `CONTRIBUTING.rst <https://github.com/ustu/lectures.www/blob/master/CONTRIBUTING.rst>`_


.. image:: https://badges.gitter.im/Join%20Chat.svg
   :alt: Join the chat at https://gitter.im/ustu/lectures.www
   :target: https://gitter.im/ustu/lectures.www?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge
