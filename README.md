# Projeto de análise de dados covid19

Resumo

Projeto em R para análise exploratória e visualização de dados de testagem de COVID-19.

O repositório contém um script principal (`analise.R`) e um conjunto de dados de testes (`covid_testing_data.csv`). O objetivo é fornecer um fluxo reproduzível para ler os dados, gerar análises e produzir gráficos/saídas que suportem interpretação dos padrões de testagem.

Principais funcionalidades

- Leitura e limpeza básica dos dados de testagem.
- Geração de gráficos temporais (testes por dia, taxa de positividade) e tabelas sumarizadas.
- Exportação de resultados em arquivos (gráficos/CSV) numa pasta `output/` (sugestão).

Requisitos

- R >= 4.0 (recomendado).
- Pacotes R usados (instalar se necessário):
  - tidyverse
  - readr
  - lubridate
  - ggplot2
  - scales

Instalação (R)

1. Abra um console R ou RStudio.
2. Instale os pacotes necessários (execute uma vez):

```r
install.packages(c("tidyverse", "readr", "lubridate", "ggplot2", "scales"))
```

Como executar

Opção A — Linha de comando (recomendado para scripts automatizados):

```bash
Rscript analise.R
```

Opção B — RStudio:

1. Abra `Projeto_de_análise_de_dados_covid19_R.Rproj` no RStudio.
2. Abra `analise.R` e clique em "Source" ou execute blocos/linhas conforme necessário.

Observações de execução

- O script espera encontrar `covid_testing_data.csv` no diretório do projeto por padrão.
- Recomenda-se que a pasta `output/` exista (ou que o script a crie) para salvar gráficos e tabelas geradas.
- Codificação sugerida: UTF-8.

Suposições úteis (se o script não tiver documentação explícita)

1. `analise.R` lê `covid_testing_data.csv` no diretório atual como entrada.
2. As colunas mínimas esperadas na tabela são algo como: `date` (YYYY-MM-DD), `tests` (número total de testes) e `positives` (número de casos positivos).
3. Saídas (gráficos/CSV) são gravadas em `output/`.

Estrutura do projeto

- `analise.R` — script principal de análise em R.
- `covid_testing_data.csv` — dados de teste usados na análise.
- `Projeto_de_análise_de_dados_covid19_R.Rproj` — projeto RStudio.

Contribuição

Contribuições são bem-vindas. Sugestões rápidas:

1. Abra uma issue para sugerir mudanças ou reportar problemas.
2. Faça um fork e envie um pull request claro com descrições das alterações.


