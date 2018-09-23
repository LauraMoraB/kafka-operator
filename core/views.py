from django.shortcuts import render
from django.http import HttpResponse

import subprocess

# Create your views here.
def topics(request):
	p = subprocess.Popen(["sh /confluent-4.1.1/bin/kafka-topics", "--list", "--zookeeper", "zk02-discovery:2181"], stdout=subprocess.PIPE)
	value = str(p.communicate())
	p.kill()
	return HttpResponse(value)

