# Generated by Django 3.2.5 on 2023-09-04 09:10

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('RESTAPI', '0019_auto_20230818_2146'),
    ]

    operations = [
        migrations.AddField(
            model_name='joinrequestmodel',
            name='status',
            field=models.CharField(default='Processing', max_length=100),
        ),
    ]
