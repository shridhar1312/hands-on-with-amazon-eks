./scripts-by-chapter/chapter-1.sh
./scripts-by-chapter/chapter-2.sh
./scripts-by-chapter/chapter-3.sh

echo "***************************************************"
echo "********* CHAPTER 4 - STARTED AT $(date) **********"
echo "***************************************************"
echo "--- This could take around 10 minutes"

    # Create Spot Instances
    ( cd Infrastructure/eksctl/02-spot-instances && eksctl create nodegroup -f cluster.yaml )
    eksctl get nodegroups --cluster eks-acg

    # Delete previous nodegroup
    eksctl delete nodegroup --cluster eks-acg eks-node-group

    # Termination Handler
    helm repo add eks https://aws.github.io/eks-charts
    helm install aws-node-termination-handler \
                --namespace kube-system \
                eks/aws-node-termination-handler

    # # Create Managed Node Groups
    # ( cd Infrastructure/eksctl/03-managed-nodes && eksctl create nodegroup -f cluster.yaml )
    # eksctl get nodegroups --cluster eks-acg

    # # Delete previous nodegroup
    # eksctl delete nodegroup --cluster eks-acg eks-node-group-spot-instances

    # # Create Fargate Profile

    # ( cd Infrastructure/eksctl/04-fargate && eksctl create fargateprofile -f cluster.yaml )

# 04-fargate $ kubectl get pods -n development -o wide - all pods should be on managed nodes
# NAME                                                         READY   STATUS    RESTARTS   AGE
# clients-api-development-acg-clients-api-76489756f-bp8px      1/1     Running   0          8m7s
# front-end-development-acg-front-end-5cb8f58854-gsqh7         1/1     Running   0          8m7s
# front-end-development-acg-front-end-proxy-86cfc87595-gz94w   1/1     Running   0          9m10s
# inventory-api-service-7f4549b565-92q27                       1/1     Running   0          9m10s
# renting-api-development-acg-renting-api-79bf7b4cd7-f7rvz     1/1     Running   0          8m50s
# resource-api-development-acg-resource-api-c8ccb494f-tw57v    1/1     Running   0          8m7s

# 04-fargate $ kubectl delete pods -n development clients-api-development-acg-clients-api-76489756f-bp8px front-end-development-acg-front-end-5cb8f58854-gsqh7   front-end-development-acg-front-end-proxy-86cfc87595-gz94w inventory-api-service-7f4549b565-92q27   renting-api-development-acg-renting-api-79bf7b4cd7-f7rvz resource-api-development-acg-resource-api-c8ccb494f-tw57v 
# pod "clients-api-development-acg-clients-api-76489756f-bp8px" deleted
# pod "front-end-development-acg-front-end-5cb8f58854-gsqh7" deleted
# pod "front-end-development-acg-front-end-proxy-86cfc87595-gz94w" deleted
# pod "inventory-api-service-7f4549b565-92q27" deleted
# pod "renting-api-development-acg-renting-api-79bf7b4cd7-f7rvz" deleted
# pod "resource-api-development-acg-resource-api-c8ccb494f-tw57v" deleted

# 04-fargate $ kubectl get pods -n development -o wide
# NAME                                                         READY   STATUS              RESTARTS   AGE   IP            NODE                                   NOMINATED NODE                                READINESS GATES
# clients-api-development-acg-clients-api-76489756f-4q96m      1/1     Running             0          42s   10.0.150.51   fargate-ip-10-0-150-51.ec2.internal    <none>                                        <none>
# front-end-development-acg-front-end-5cb8f58854-kjrk2         0/1     Pending             0          42s   <none>        <none>                                 3fb894306d-48359dadfd694c1fa78922467c8161b0   <none>
# front-end-development-acg-front-end-proxy-86cfc87595-fddps   0/1     Pending             0          42s   <none>        <none>                                 3fb894306d-461846b0d54440ca812251e6e62d3eab   <none>
# inventory-api-service-7f4549b565-tfj2r                       0/1     ContainerCreating   0          42s   <none>        fargate-ip-10-0-139-115.ec2.internal   <none>                                        <none>
# renting-api-development-acg-renting-api-79bf7b4cd7-qnf6h     0/1     Pending             0          42s   <none>        <none>                                 101c168fca-eeeb849b743e416a9811b76c69181b05   <none>
# resource-api-development-acg-resource-api-c8ccb494f-lpgh8    0/1     Pending             0          42s   <none>        fargate-ip-10-0-117-213.ec2.internal   101c168fca-5fa122935b9b42c6a1b79828012364c2   <none>

# 04-fargate $ kubectl get pods -n development -o wide - all pods are now on fargate(serverless)

# NAME                                                         READY   STATUS    RESTARTS   AGE   IP             NODE                                   NOMINATED NODE   READINESS GATES
# clients-api-development-acg-clients-api-76489756f-4q96m      1/1     Running   0          74s   10.0.150.51    fargate-ip-10-0-150-51.ec2.internal    <none>           <none>
# front-end-development-acg-front-end-5cb8f58854-kjrk2         1/1     Running   0          74s   10.0.166.133   fargate-ip-10-0-166-133.ec2.internal   <none>           <none>
# front-end-development-acg-front-end-proxy-86cfc87595-fddps   1/1     Running   0          74s   10.0.183.60    fargate-ip-10-0-183-60.ec2.internal    <none>           <none>
# inventory-api-service-7f4549b565-tfj2r                       1/1     Running   0          74s   10.0.139.115   fargate-ip-10-0-139-115.ec2.internal   <none>           <none>
# renting-api-development-acg-renting-api-79bf7b4cd7-qnf6h     1/1     Running   0          74s   10.0.127.59    fargate-ip-10-0-127-59.ec2.internal    <none>           <none>
# resource-api-development-acg-resource-api-c8ccb494f-lpgh8    1/1     Running   0          74s   10.0.117.213   fargate-ip-10-0-117-213.ec2.internal   <none>           <none>


echo "*************************************************************"
echo "********* READY FOR CHAPTER 5 - FINISHED AT $(date) *********"
echo "*************************************************************"
