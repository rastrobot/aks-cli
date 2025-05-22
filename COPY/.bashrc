
# Função para kubectl com separadores visuais
k() {
  echo -e "\n================== kubectl $@ =================="
  kubectl "$@"
  echo -e "=================================================\n"
}
