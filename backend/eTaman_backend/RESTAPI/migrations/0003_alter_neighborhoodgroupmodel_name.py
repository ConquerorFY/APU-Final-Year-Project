# Generated by Django 3.2.5 on 2023-06-23 15:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('RESTAPI', '0002_neighborhoodgroupmodel_residentmodel'),
    ]

    operations = [
        migrations.AlterField(
            model_name='neighborhoodgroupmodel',
            name='name',
            field=models.CharField(max_length=100, unique=True),
        ),
    ]
