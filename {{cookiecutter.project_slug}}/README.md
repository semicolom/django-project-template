# {{ cookiecutter.project_name }}

{{ cookiecutter.description }}

## Installation

Make sure you have installed in your OS
```
make
python3.6
virtualenv
postgresql
```

Create a PostgreSQL database
```
sudo su - postgres
psql
CREATE DATABASE {{ cookiecutter.project_slug }};
CREATE USER {{ cookiecutter.project_slug }} WITH PASSWORD '{{ cookiecutter.project_slug }}';
GRANT ALL PRIVILEGES ON DATABASE {{ cookiecutter.project_slug }} TO {{ cookiecutter.project_slug }};
ALTER USER {{ cookiecutter.project_slug }} CREATEDB;
```

Then run:
```
make requirements
make virtualenv
source venv/bin/activate
cd src/
./manage.py migrate
```

## Run tests

Run `make tests`. It will do isort-check, lint and django tests.

## Utils

Update packages: `make requirements`. Creates a requirements.txt file with the last versions of the packages inside requirements/base.txt. You can run it whenever you want to update your project. It will create a temporary virtualenv.

`make virtualenv` Creates a new virtualenv using requirements.txt.

`make virtualenv_test` Creates a development virtualenv using requirements.txt and packages from requirements/test.txt.

`make clean` Removes the .pyc files and deletes the virtualenv folder.

`make isort` Checks your code and fixes the imports using isort.

`make run` Will execute a runserver with development settings.

`make makemigrations` Will execute a makemigrations with development settings.

`make migrate` Will execute a migrate with development settings.
