from django.views.generic.list import ListView

from .models import Caregiver

class CaregiverListView(ListView):
    model = Caregiver
