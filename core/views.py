from django.shortcuts import render
from django.http import HttpResponse

import subprocess
import os

# Create your views here.
def topics(request):
	result = os.popen('sh /confluent-4.1.1/bin/kafka-topics --list --zookeeper zk02-discovery:2181').read()
#	os.system("sh /confluent-4.1.1/bin/kafka-topics --list --zookeeper zk02-discovery:2181")
	#p = subprocess.Popen(["sh scripts/kafka-topics", "--list", "--zookeeper", "zk02-discovery:2181"], stdout=subprocess.PIPE)
	#value = str(p.communicate())
	#p.kill()
	return HttpResponse(result)

