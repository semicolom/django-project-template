# {{ project_name | title }}

## Installation

Run `make install`

Create a PostgreSQL database
```sh
sudo su - postgres
psql
CREATE DATABASE {{ project_name }};
CREATE USER {{ project_name }} WITH PASSWORD '{{ project_name }}';
GRANT ALL PRIVILEGES ON DATABASE {{ project_name }} TO {{ project_name }};
ALTER USER {{ project_name }} CREATEDB;
```

## Run tests

Run `make tests`. It will do isort-check, lint and django tests.

## Utils

Update packages: `make requirements`. Creates a requirements.txt file with the last versions of the packages inside requirements/base.txt. You can run it whenever you want to update your project. It will create a temporary virtualenv.

`make virtualenv_prod` Creates a new virtualenv using requirements.txt.

`make virtualenv` Creates a development virtualenv using requirements.txt and packages from requirements/test.txt.

`make clean` Removes the .pyc files and deletes the virtualenv folder.

`make isort` Checks your code and fixes the imports using isort.

`make run` Will execute a runserver with development settings.

`make makemigrations` Will execute a makemigrations with development settings.

`make migrate` Will execute a migrate with development settings.
