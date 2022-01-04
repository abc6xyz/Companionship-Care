# Generated by Django 4.0 on 2022-01-04 08:58

from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('care_groups', '0002_caregroup_members'),
    ]

    operations = [
        migrations.AddField(
            model_name='caregroup',
            name='coordinators',
            field=models.ManyToManyField(related_name='care_groups_coordinating', to=settings.AUTH_USER_MODEL),
        ),
    ]
