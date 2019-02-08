"""Custom storage backends for static and media files."""
from django.utils.encoding import filepath_to_uri

from storages.backends.s3boto3 import S3Boto3Storage

class StaticStorage(S3Boto3Storage):
    """Storage backend for static files."""

    location = 'static'
    default_acl = 'public-read'

    def url(self, name, parameters=None, expire=None):
        """Return url address on the same domain."""
        name = self._normalize_name(self._clean_name(name))
        return "/{}".format(filepath_to_uri(name))


class MediaStorage(S3Boto3Storage):
    """Storage backend for media files."""

    location = 'media'
    default_acl = 'private'
    file_overwrite = False

    def url(self, name, parameters=None, expire=None):
        """Return url address on the same domain."""
        name = self._normalize_name(self._clean_name(name))
        return "/{}".format(filepath_to_uri(name))
