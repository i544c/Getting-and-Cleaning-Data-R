# Autor: Isaac Gomes Veras
# Data de criação: 29 de setembro de 2023
# IDE: DataSpell 2023.2.2 Build #DS-232.9921.48, built on September 13, 2023
# Johns Hopikins University - Getting and Cleaning Data
# Atividade: Obtenção e limpeza de dados Projeto do curso

R.version.string; cat("\n") # Versão do R
getwd(); cat("\n") # Diretório de trabalho

# Instalação de pacotes:

if (!require("pacman")) install.packages("pacman")
pacman::p_load (pacman,		# gerenciador de pacotes;
                tidyverse,	# conjunto de ferramentas para Data Science;
)

#---- Banco de dados: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#---- Etapa 1: Mesclar os conjuntos de treinamento e teste para criar um conjunto de dados.
print("Etapa 1: Mesclar os conjuntos de treinamento e teste para criar um conjunto de dados:")

  # Extrair dados "train":
  s_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names= "subject")
  y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names= "activity")
  x_train <- read.table("UCI HAR Dataset/train/X_train.txt", comment.char="")
  d_train <- cbind(s_train, y_train, x_train)
    print(d_train)

  # Extrair dados "test":
  s_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names= "subject")
  y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names= "activity")
  x_test <- read.table("UCI HAR Dataset/test/X_test.txt", comment.char="")
  d_test <- cbind(s_test, y_test, x_test)
    print(d_test)

  # Mesclando os dados:
  df <- rbind(d_train, d_test)
    print(df)

  # Recursos de leitura:
  feature_names <- read.table("UCI HAR Dataset/features.txt", col.names=c("id", "name"))
  features <- c("subject", "activity", as.vector(feature_names[,"name"]))
    print(features)

#---- Etapa 2: Extrair somente as medidas sobre a media e o desvio padrao de cada medida:
print("Etapa 2: Extrair somente as medidas sobre a media e o desvio padrao de cada medida:")

filtered_feature_index <- grepl("mean|std|subject|activity", features) & !grepl("meanFreq", features)
filtered_data <- df[, filtered_feature_index]
  print(filtered_data)

#---- Etapa 3: Usar nomes descritivos de atividades para nomear as atividades no conjunto de dados:
print("Etapa 3: Usar nomes descritivos de atividades para nomear as atividades no conjunto de dados:")

activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("id", "name"))
for (i in seq_len(nrow(activities))) {
  filtered_data$activity[filtered_data$activity == activities[i, "id"]] <- as.character(activities[i, "name"])
}
  print(filtered_data$actity)

#---- Etapa 4: Rotular adequadamente o conjunto de dados com nomes descritivos de variaveis:
print("Etapa 4: Rotular adequadamente o conjunto de dados com nomes descritivos de variaveis:")

filtered_names <- features[filtered_feature_index]
filtered_names <- gsub("\\(\\)", "", filtered_names)
filtered_names <- gsub("Acc", "-acceleration", filtered_names)
filtered_names <- gsub("Mag", "-Magnitude", filtered_names)
filtered_names <- gsub("BodyBody", "Body", filtered_names)
filtered_names <- gsub("(Jerk|Gyro)", "-\\1", filtered_names)
filtered_names <- gsub("^t(.*)$", "\\1-time", filtered_names)
filtered_names <- gsub("^f(.*)$", "\\1-frequency", filtered_names)
filtered_names <- tolower(filtered_names)

  # Atribuir nomes filtrados aos recursos:
  names(filtered_data) <- filtered_names
  print(filtered_names)

#---- Etapa 5: A partir do conjunto de dados da etapa 4, crie um segundo conjunto de dados independente e organizado com a media de cada variavel para cada atividade e cada sujeito:
print("A partir do conjunto de dados da etapa 4, crie um segundo conjunto de dados independente e organizado com a media de cada variavel para cada atividade e cada sujeito:")

new_data <- tbl_df(filtered_data) %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean))
  print(new_data)

# Salvar "new_data" na pasta:
  write.table(new_data, file="new_data.txt", row.name=FALSE)
