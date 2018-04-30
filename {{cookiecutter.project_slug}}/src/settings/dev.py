from .base import *

DEBUG = True
SECRET_KEY = 'dev'

# Database
DATABASES['default'].update({
    'USER': '{{ cookiecutter.project_slug }}',
    'PASSWORD': '{{ cookiecutter.project_slug }}',
    'HOST': '127.0.0.1',
})

# Django debug toolbar settings
DEBUG_TOOLBAR = True
if DEBUG_TOOLBAR:
    INSTALLED_APPS += [
        'debug_toolbar',
    ]
    MIDDLEWARE += [
        'debug_toolbar.middleware.DebugToolbarMiddleware',
    ]
    INTERNAL_IPS = [
        '127.0.0.1',
    ]
