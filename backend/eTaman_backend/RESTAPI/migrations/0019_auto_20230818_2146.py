# Generated by Django 3.2.5 on 2023-08-18 13:46

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('RESTAPI', '0018_chatmodel'),
    ]

    operations = [
        migrations.AddField(
            model_name='complaintpostcommentmodel',
            name='groupID',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='RESTAPI.neighborhoodgroupmodel'),
        ),
        migrations.AddField(
            model_name='complaintpostmodel',
            name='groupID',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='RESTAPI.neighborhoodgroupmodel'),
        ),
        migrations.AddField(
            model_name='crimepostcommentmodel',
            name='groupID',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='RESTAPI.neighborhoodgroupmodel'),
        ),
        migrations.AddField(
            model_name='crimepostmodel',
            name='groupID',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='RESTAPI.neighborhoodgroupmodel'),
        ),
        migrations.AddField(
            model_name='eventpostcommentmodel',
            name='groupID',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='RESTAPI.neighborhoodgroupmodel'),
        ),
        migrations.AddField(
            model_name='eventpostmodel',
            name='groupID',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='RESTAPI.neighborhoodgroupmodel'),
        ),
        migrations.AddField(
            model_name='generalpostcommentmodel',
            name='groupID',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='RESTAPI.neighborhoodgroupmodel'),
        ),
        migrations.AddField(
            model_name='generalpostmodel',
            name='groupID',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='RESTAPI.neighborhoodgroupmodel'),
        ),
    ]
