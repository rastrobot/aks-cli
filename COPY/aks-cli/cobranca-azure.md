🔍 Comando para listar principais recursos com custo:
🔸 Mostra todos os recursos existentes, independente de gerarem custo ou não (inclui namespaces, roles, regras, locks, etc.).

az resource list --output table

✅ Itens que geram custo direto:
	1.	AKS (Cluster Kubernetes) – Enquanto ativo.
	2.	IP Público Estático – Cobra por hora enquanto existir, mesmo sem cluster.
	3.	Discos (PVC / Storage) – Cobra até serem deletados.
	4.	Load Balancer Público – Tem custo associado se estiver provisionado.
	5.	Snapshots de discos (se houver) – Cobra por GB.
	6.	Banco de Dados Gerenciado (se usar) – Cobra enquanto existir.
	7.	Storage Account (se houver) – Cobra pelo armazenamento usado.

🚩 Comandos para listar itens críticos:
•	Discos:
az disk list --output table
•	IPs Públicos:
az network public-ip list --output table
•	Load Balancers:
az network lb list --output table
•	Storage Accounts:
az storage account list --output table