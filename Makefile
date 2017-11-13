PIP=`. venv/bin/activate; which pip`
TMP_PIP=`. temp_venv/bin/activate; which pip`
PYTHON=`. venv/bin/activate; which python`
REQUIREMENTS:=requirements/requirements.txt
REQUIREMENTS_BASE:=requirements/base.txt
REQUIREMENTS_TEST:=requirements/test.txt

.PHONY: requirements

clean:
	@find . -name *.pyc -delete
	@rm -rf venv

requirements:
	virtualenv -p python3.5 temp_venv
	$(TMP_PIP) install -U "pip"
	$(TMP_PIP) install -r $(REQUIREMENTS_BASE)
	$(TMP_PIP) freeze > requirements/requirements.txt
	@rm -rf temp_venv

virtualenv_base:
	test -d venv || virtualenv -p python3.5 venv
	$(PIP) install -U "pip"

virtualenv_prod: virtualenv_base
	$(PIP) install -r $(REQUIREMENTS)

virtualenv: virtualenv_base
	$(PIP) install -r $(REQUIREMENTS_TEST)

install: requirements virtualenv

isort: virtualenv
	isort -rc -y

test: virtualenv
	isort -rc -c
	flake8
	coverage run --source='.' manage.py test --settings=settings.dev
	coverage report

run: virtualenv
	$(PYTHON) manage.py runserver --settings=settings.dev

makemigrations: virtualenv
	$(PYTHON) manage.py makemigrations --settings=settings.dev

migrate: virtualenv
	$(PYTHON) manage.py migrate --settings=settings.dev