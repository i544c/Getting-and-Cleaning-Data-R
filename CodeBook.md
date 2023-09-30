**Variáveis:**

1. `x_data`: Este é um conjunto de dados que armazena todas as medidas extraídas dos arquivos de treinamento e teste. Ele inclui apenas as colunas correspondentes às médias e desvios padrão de cada medida.

2. `y_data`: Este é um conjunto de dados que armazena as informações das atividades correspondentes aos dados em `x_data`.

3. `activity_labels`: Um conjunto de dados que armazena os rótulos descritivos das atividades correspondentes aos IDs das atividades.

4. `subject_data`: Este conjunto de dados contém informações sobre os sujeitos associados a cada observação.

5. `final_data`: Este é o conjunto de dados final que armazena a média de cada variável para cada atividade e sujeito.

**Dados:**

Os dados de entrada consistem em vários arquivos:

- `X_train.txt` e `X_test.txt`: Esses arquivos contêm as medidas das características das amostras de treinamento e teste, respectivamente.

- `y_train.txt` e `y_test.txt`: Esses arquivos contêm os IDs das atividades correspondentes às amostras de treinamento e teste, respectivamente.

- `features.txt`: Este arquivo contém informações sobre todas as medidas das características, incluindo seus nomes.

- `activity_labels.txt`: Este arquivo mapeia os IDs das atividades para rótulos descritivos.

- `subject_train.txt` e `subject_test.txt`: Esses arquivos contêm os IDs dos sujeitos associados às amostras de treinamento e teste, respectivamente.

**Transformações Realizadas:**

1. **Mesclar Conjuntos de Treinamento e Teste (Etapa 1):** Os conjuntos de treinamento e teste são lidos a partir de seus respectivos arquivos e combinados em `x_data` e `y_data`.

2. **Extrair Medidas de Média e Desvio Padrão (Etapa 2):** A partir do arquivo `features.txt`, as características que representam média e desvio padrão são identificadas e selecionadas no conjunto de dados `x_data`.

3. **Nomear Atividades Descritivamente (Etapa 3):** Os IDs das atividades em `y_data` são substituídos pelos rótulos descritivos das atividades a partir do arquivo `activity_labels.txt`.

4. **Rotular Variáveis Adequadamente (Etapa 4):** As colunas em `x_data` são nomeadas com os nomes descritivos das características selecionadas na Etapa 2.

5. **Calcular Média por Atividade e Sujeito (Etapa 5):** Os dados são agrupados por sujeito e atividade, e em seguida, é calculada a média de cada variável para cada grupo usando a função `summarise_all` do pacote `dplyr`. O resultado é armazenado em `final_data`.

Essas etapas visam limpar e organizar os dados de forma que eles estejam prontos para análise posterior, com nomes descritivos, atividades identificadas e resumidos com médias por atividade e sujeito.
