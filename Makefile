PIP=`. venv/bin/activate; which pip`
PYTHON=`. venv/bin/activate; which python`
REQUIREMENTS:=requirements/base.txt
REQUIREMENTS_TEST:=requirements/test.txt

clean:
	@find . -name *.pyc -delete
	@rm -rf venv

virtualenv_base:
	test -d venv || virtualenv -p python3.5 venv
	$(PIP) install -U "pip"

virtualenv:
	$(PIP) install -r $(REQUIREMENTS)

virtualenv_test:
	$(PIP) install -r $(REQUIREMENTS_TEST)

requirements.txt: virtualenv
	$(PIP) freeze > requirements/requirements.txt

test: virtualenv_test
	$(PYTHON) manage.py test

lint: virtualenv_test
	flake8

isort: virtualenv_test
	isort
