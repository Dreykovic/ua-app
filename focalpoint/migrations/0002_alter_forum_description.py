# Generated by Django 4.2.5 on 2023-10-17 17:26

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('focalpoint', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='forum',
            name='description',
            field=models.TextField(blank=True, null=True),
        ),
    ]
