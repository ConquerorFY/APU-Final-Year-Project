# Generated by Django 3.2.5 on 2023-06-25 05:08

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('RESTAPI', '0004_joinrequestmodel'),
    ]

    operations = [
        migrations.AddField(
            model_name='neighborhoodgroupmodel',
            name='rules',
            field=models.CharField(default=None, max_length=10000),
        ),
    ]