helm repo add external-dns https://kubernetes-sigs.github.io/external-dns/

helm repo update

helm upgrade --install external-dns external-dns/external-dns \
  --set provider.name=aws \
  --set policy=upsert-only \
  --set registry=txt \
  --set txtOwnerId=eks-acg \
  --set serviceAccount.create=false \
  --set serviceAccount.name=${service_account_name} \
  --set env[0].name=AWS_DEFAULT_REGION \
  --set env[0].value=us-east-1





# helm repo add external-dns https://kubernetes-sigs.github.io/external-dns/
# helm upgrade --install external-dns external-dns/external-dns
