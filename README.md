
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# High 5xx Errors on Traffic Server
---

This incident type occurs when the number of 5xx errors on Traffic Server is higher than usual. This can indicate issues with server performance or connectivity problems. It requires investigation to identify the root cause and resolve the issue.

### Parameters
```shell
# Environment Variables

export APP_LABEL="PLACEHOLDER"

export NAMESPACE="PLACEHOLDER"

export POD_NAME="PLACEHOLDER"

export NODE_NAME="PLACEHOLDER"

export DEPENDENT_SERVICE_NAME="PLACEHOLDER"

export DEPLOYMENT_NAME="PLACEHOLDER"

```

## Debug

### Check if the Traffic Server service is running
```shell
kubectl get pods -n ${NAMESPACE} -l app=${APP_LABEL} # Replace with actual values
```

### Check the logs of the Traffic Server pod for any errors
```shell
kubectl logs ${POD_NAME} -n ${NAMESPACE} # Replace with actual values
```

### Check the resource usage of the Traffic Server pod
```shell
kubectl top pod ${POD_NAME} -n ${NAMESPACE} # Replace with actual values
```

### Check if any other pods in the same node as the Traffic Server pod are consuming excessive resources
```shell
kubectl top pod -n ${NAMESPACE} --sort-by cpu | grep ${NODE_NAME} # Replace with actual values
```

### Check if there are any network issues between the Traffic Server pod and its dependant services
```shell
kubectl exec -it ${POD_NAME} -n ${NAMESPACE} -- traceroute ${DEPENDENT_SERVICE_NAME} # Replace with actual values
```

### Check the configuration of the Traffic Server deployment and its dependant services
```shell
kubectl describe deployment ${DEPLOYMENT_NAME} -n ${NAMESPACE} # Replace with actual values
```

### Check the health status of the Traffic Server pod and its dependant services
```shell
kubectl describe pod ${POD_NAME} -n ${NAMESPACE} # Replace with actual values
```

### Cyber attack or malicious activity targeting the Traffic Server.
```shell


#!/bin/bash



# Set the namespace and pod name for the Traffic Server

NAMESPACE=${NAMESPACE}

POD_NAME=${POD_NAME}



# Check the logs of the Traffic Server pod for any suspicious activity

kubectl logs $POD_NAME -n $NAMESPACE | grep -iE "attack|malicious|hack|exploit|vulnerability"



# Check the network traffic to and from the Traffic Server pod for any suspicious activity

kubectl exec -it $POD_NAME -n $NAMESPACE -- tcpdump -i eth0 -nn -s0 -w traffic.pcap &

TCPDUMP_PID=$!



sleep 10



kill -SIGINT $TCPDUMP_PID



# Analyze the captured network traffic for any suspicious activity

tcpdump -r traffic.pcap | grep -iE "attack|malicious|hack|exploit|vulnerability"



# Clean up the captured traffic file

rm -f traffic.pcap


```

### Traffic Server overloaded due to high traffic.
```shell


#!/bin/bash



# Set the namespace and pod name of the Traffic Server deployment

NAMESPACE=${NAMESPACE}

POD_NAME=$(kubectl get pods -n $NAMESPACE -l app=traffic-server -o jsonpath='{.items[0].metadata.name}')



# Check the CPU and memory usage of the Traffic Server pod

CPU_USAGE=$(kubectl top pod $POD_NAME -n $NAMESPACE --containers | awk '{print $2}' | tail -n 1 | sed 's/m$//')

MEMORY_USAGE=$(kubectl top pod $POD_NAME -n $NAMESPACE --containers | awk '{print $3}' | tail -n 1 | sed 's/Mi$//')



# Check the number of requests to the Traffic Server pod

REQUESTS=$(kubectl logs $POD_NAME -n $NAMESPACE | grep -c "HTTP/1.1\" 5")



# Check the number of open connections to the Traffic Server pod

OPEN_CONNECTIONS=$(kubectl exec -n $NAMESPACE $POD_NAME -- netstat -an | grep ESTABLISHED | grep -c ":80")



# Print the diagnostic information

echo "Traffic Server CPU usage: $CPU_USAGE m"

echo "Traffic Server memory usage: $MEMORY_USAGE Mi"

echo "Number of 5xx requests to Traffic Server: $REQUESTS"

echo "Number of open connections to Traffic Server: $OPEN_CONNECTIONS"


```

## Repair

### Implement HPA to handle increased traffic load.
```shell
# Set up HPA
CPU_THRESHOLD="PLACEHOLDER"
MIN_REPLICAS="PLACEHOLDER"
MAX_REPLICAS="PLACEHOLDER"

kubectl autoscale deployment $DEPLOYMENT_NAME --namespace $NAMESPACE --cpu-percent=$CPU_THRESHOLD --min=$MIN_REPLICAS --max=$MAX_REPLICAS


```