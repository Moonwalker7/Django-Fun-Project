from django.test import TestCase
from django.contrib.auth import get_user_model

EMAIL = 'test@test.com'
PASSWORD = 'test123'


class ModelTests(TestCase):

    def test_create_user_with_email_successful(self):
        """Test creating a new user with an email is successful"""

        user = get_user_model().objects.create_user(
            email=EMAIL,
            password=PASSWORD
        )

        self.assertEqual(user.email, EMAIL)
        self.assertTrue(user.check_password(PASSWORD))

    def test_new_user_email_normailized(self):
        """Test the email for the new user to be normalized"""

        email = 'test@TEST.COM'

        user = get_user_model().objects.create_user(
            email=email,
            password='test123'
        )

        self.assertEqual(user.email, email.lower())

    def test_new_user_invalid_email(self):
        """Test creating a user with no email raises an error"""

        with self.assertRaises(ValueError):
            get_user_model().objects.create_user(None, PASSWORD)

    def test_create_supseruser(self):
        """Test creating a superuser"""

        user = get_user_model().objects.create_superuser(
            email=EMAIL,
            password=PASSWORD
        )

        self.assertTrue(user.is_superuser)
        self.assertTrue(user.is_staff)
