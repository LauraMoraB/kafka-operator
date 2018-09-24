from django.shortcuts import render
from django.http import HttpResponse

import subprocess
import os

# Create your views here.
def topics(request):
	result = os.popen('sh /confluent-4.1.1/bin/kafka-topics --list --zookeeper zk02-discovery:2181').read()
	return HttpResponse(result)

