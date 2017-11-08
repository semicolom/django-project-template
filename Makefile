PIP=`. venv/bin/activate; which pip`
PYTHON=`. venv/bin/activate; which python`
REQUIREMENTS:=requirements/base.txt

clean:
	@find . -name *.pyc -delete
	@rm -rf venv

virtualenv:
	test -d venv || virtualenv -p python3.5 venv
	$(PIP) install -U "pip"
	$(PIP) install -r $(REQUIREMENTS)

requirements.txt: virtualenv
	$(PIP) freeze > requirements/requirements.txt

test: virtualenv
	$(PYTHON) manage.py test
