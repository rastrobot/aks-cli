# Códigos de cor ANSI mais comuns:
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color (reset)


unalias k 2>/dev/null

  # echo "========================================"
  # echo "========================================\n"
k() {
  echo -e "\n${BLUE}$(date '+%H:%M:%S') kubectl $@${NC}"
  # ubectl "$@" | tee >(xclip -selection clipboard)
  # ubectl "$@" | tee >(pbcopy)
  kubectl "$@"
  echo " "
}

# COMO RODAR: source k-function.sh