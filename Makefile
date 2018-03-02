PIP="venv/bin/pip"
TMP_PIP="temp_venv/bin/pip"
PYTHON="venv/bin/python"
ISORT="venv/bin/isort"
FLAKE8="venv/bin/flake8"
COVERAGE="venv/bin/coverage"

REQUIREMENTS:=requirements/requirements.txt
REQUIREMENTS_BASE:=requirements/base.txt
REQUIREMENTS_TEST:=requirements/test.txt

.PHONY: requirements

clean:
	@find . -name *.pyc -delete
	@rm -rf venv

requirements:
	virtualenv -p python3.6 temp_venv
	$(TMP_PIP) install -U "pip"
	$(TMP_PIP) install -r $(REQUIREMENTS_BASE)
	$(TMP_PIP) freeze > requirements/requirements.txt
	@rm -rf temp_venv

virtualenv_base:
	test -d venv || virtualenv -p python3.6 venv
	$(PIP) install -U "pip"

virtualenv_prod: virtualenv_base
	$(PIP) install -r $(REQUIREMENTS)

virtualenv: virtualenv_base
	$(PIP) install -r $(REQUIREMENTS_TEST)

install: requirements virtualenv

isort: virtualenv
	$(ISORT) -rc -y src/

test: virtualenv
	$(ISORT) -rc -c src/
	$(FLAKE8) src/
	$(COVERAGE) run --source='src/' src/manage.py test src/
	$(COVERAGE) report

run:
	$(PYTHON) src/manage.py runserver

makemigrations:
	$(PYTHON) src/manage.py makemigrations

migrate:
	$(PYTHON) src/manage.py migrate

collectstatic:
	$(PYTHON) src/manage.py collectstatic -l --noinput
