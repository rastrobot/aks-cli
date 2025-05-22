ls
ls
exit
ls
docker run -it --rm   -v $HOME/.kube:/root/.kube   -v $HOME/.azure:/root/.azure   -v $HOME/Downloads/testes/kompose-convert/.:/root   aks-cli   bash -c "source /aks-cli/k-function.sh && bash"
docker run -it --rm   -v $HOME/.kube:/root/.kube   -v $HOME/.azure:/root/.azure   -v $HOME/Downloads/testes/kompose-convert/.:/root   aks-cli   bash -c "source /root/aks-cli/k-function.sh && bash"
exit
k get all -A
source k-function.sh
source aks-cli/k-function.sh
k get all -A
exit
k
ls aks-cli
exit
k get all -A
k
alias k='kubectl'
k get all -A
exit
