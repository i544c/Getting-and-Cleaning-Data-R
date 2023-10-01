**Variáveis:**

1. `s_train`, `y_train`, `x_train`: Variáveis que armazenam os dados de treinamento, incluindo os sujeitos (identificação do sujeito), atividades (identificação da atividade) e características (medidas).

2. `s_test`, `y_test`, `x_test`: Variáveis que armazenam os dados de teste, semelhantes às variáveis de treinamento.

3. `df`: Variável que armazena o conjunto de dados combinado, onde os dados de treinamento e teste são mesclados.

4. `feature_names` e `features`: Variáveis que armazenam os nomes das características, lidos a partir do arquivo "features.txt", e uma lista de nomes que inclui "subject" (sujeito), "activity" (atividade) e as características de média e desvio padrão selecionadas.

5. `filtered_feature_index`: Uma variável lógica que indica quais colunas do conjunto de dados `df` devem ser mantidas, com base na presença das palavras "mean", "std", "subject" e "activity" nos nomes das colunas.

6. `filtered_data`: Variável que armazena o conjunto de dados resultante após a aplicação do filtro nas colunas do conjunto de dados original.

7. `activities`: Variável que armazena os nomes descritivos das atividades, lidos a partir do arquivo "activity_labels.txt".

8. `filtered_names`: Variável que armazena os nomes descritivos das colunas após a limpeza e renomeação.

9. `tidy_dataset`: Variável que armazena o conjunto de dados final, com a média de cada variável para cada atividade e sujeito.

**Dados e Transformações:**

1. **Etapa 1 (Mesclar os conjuntos de treinamento e teste):** O código carrega os dados de treinamento e teste para sujeitos, atividades e características. Em seguida, mescla esses dados em um único conjunto de dados chamado `df`.

2. **Etapa 2 (Extrair medidas de média e desvio padrão):** O código identifica as colunas relevantes no conjunto de dados `df` com base nas palavras-chave "mean", "std", "subject" e "activity". Ele cria uma nova variável chamada `filtered_data` contendo apenas as colunas relevantes.

3. **Etapa 3 (Usar nomes descritivos de atividades):** Os IDs das atividades no conjunto de dados são substituídos pelos nomes descritivos das atividades lidos a partir do arquivo "activity_labels.txt". Isso é feito para tornar as atividades mais compreensíveis.

4. **Etapa 4 (Rotular adequadamente o conjunto de dados com nomes descritivos de variáveis):** Os nomes das colunas são ajustados e limpos para torná-los mais descritivos e legíveis. Isso envolve a remoção de parênteses, substituição de abreviações por palavras completas e conversão para letras minúsculas.

5. **Etapa 5 (Criar um segundo conjunto de dados com a média de cada variável para cada atividade e cada sujeito):** O código utiliza a biblioteca `dplyr` para agrupar o conjunto de dados `filtered_data` por sujeito e atividade e, em seguida, calcula a média de cada variável para cada grupo. O resultado é armazenado na variável `new_data`.

6. **Etapa 6 (Salvar o conjunto de dados final):** O conjunto de dados final `new_data` é salvo em um arquivo de texto chamado "new_data.txt" no diretório de trabalho atual.

O código executa essas etapas para limpar e organizar os dados, resultando em um conjunto de dados final que está pronto para análise posterior, com nomes descritivos, atividades identificadas e medidas resumidas com médias por atividade e sujeito.
