helm repo add external-dns https://kubernetes-sigs.github.io/external-dns/

service_account_name="external-dns-service-account"

eksctl create iamserviceaccount --name ${service_account_name} \
    --cluster eks-acg \
    --attach-policy-arn arn:aws:iam::aws:policy/AmazonRoute53FullAccess --approve

# helm upgrade --install external-dns \
#     --set serviceAccount.create=false \
#     --set serviceAccount.name=${service_account_name} \
#     external-dns/external-dns
    
helm upgrade --install external-dns external-dns/external-dns \
  --set provider.name=aws \
  --set policy=upsert-only \
  --set registry=txt \
  --set txtOwnerId=eks-acg \
  --set serviceAccount.create=false \
  --set serviceAccount.name=${service_account_name} \
  --set env[0].name=AWS_DEFAULT_REGION \
  --set env[0].value=us-east-1
