# Generated by Django 4.2.5 on 2024-04-04 22:00

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='member',
            name='photo',
            field=models.TextField(null=True),
        ),
    ]
