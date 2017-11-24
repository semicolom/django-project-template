from .base import *

DEBUG = True

# Database
DATABASES['default'].update({
    'USER': '{{ project_name }}',
    'PASSWORD': '{{ project_name }}',
    'HOST': '127.0.0.1',
})

# Django debug toolbar settings
INSTALLED_APPS += [
    'debug_toolbar',
]
MIDDLEWARE += [
    'debug_toolbar.middleware.DebugToolbarMiddleware',
]
INTERNAL_IPS = [
    '127.0.0.1',
]
