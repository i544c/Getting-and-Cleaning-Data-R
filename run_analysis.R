# Autor: Isaac Gomes Veras
# Data de criação: 29 de setembro de 2023
# IDE: DataSpell 2023.2.2 Build #DS-232.9921.48, built on September 13, 2023

R.version.string; cat("\n") # Versão do R
getwd(); cat("\n") # Diretório de trabalho

# Instalação de pacotes:

if (!require("pacman")) install.packages("pacman")
pacman::p_load (pacman,		# gerenciador de pacotes;
                party,		# construir e manipular árvores de decisões;
                psych,		# procedimentos estatísticos;
                rio,		# importar dados;
                tidyverse,	# conjunto de ferramentas para Data Science;
                janitor		# ferramentas para examinar e limpar dados;
)

# Etapa 1: Mesclar os conjuntos de treinamento e teste
X_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
X_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")

# Etapa 2: Extrair medidas sobre a média e desvio padrão
features <- read.table("features.txt")
mean_std_features <- grep("mean\\(\\)|std\\(\\)", features$V2)
X_train <- X_train[, mean_std_features]
X_test <- X_test[, mean_std_features]

# Etapa 3: Usar nomes descritivos de atividades
activity_labels <- read.table("activity_labels.txt")
y_train$V1 <- factor(y_train$V1, levels = activity_labels$V1, labels = activity_labels$V2)
y_test$V1 <- factor(y_test$V1, levels = activity_labels$V1, labels = activity_labels$V2)

# Etapa 4: Rotular adequadamente o conjunto de dados
colnames(X_train) <- features$V2[mean_std_features]
colnames(X_test) <- features$V2[mean_std_features]

# Etapa 5: Criar um segundo conjunto de dados com a média
library(dplyr)

train_subject <- read.table("subject_train.txt")
test_subject <- read.table("subject_test.txt")

# Mesclar os sujeitos com as atividades e medidas
train_data <- cbind(train_subject, y_train, X_train)
test_data <- cbind(test_subject, y_test, X_test)

# Combinar conjuntos de treinamento e teste
merged_data <- rbind(train_data, test_data)

# Calcular a média para cada variável para cada atividade e sujeito
tidy_data <- merged_data %>%
  group_by(train_subject) %>%
  group_by(y_train, .add = TRUE) %>%
  summarize_all(mean)

# Salvar o conjunto de dados final em um arquivo
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)
