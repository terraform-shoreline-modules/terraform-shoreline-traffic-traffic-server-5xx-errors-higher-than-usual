

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