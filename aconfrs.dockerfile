FROM rocker/shiny
RUN sudo rm -r /srv/shiny-server/*
RUN sudo apt-get update
RUN sudo apt-get install -y libpoppler-cpp-dev
#############################################################
RUN sudo Rscript -e 'tmpf <- tempfile();\
filezip <- "https://github.com/cleber-n-borges/aconfrs/archive/refs/heads/main.zip";\
download.file(filezip, tmpf, quiet=TRUE);\
unzip(tmpf, exdir="/srv/shiny-server/");unlink(tmpf);'
RUN sudo Rscript -e 'install.packages("shinyjs", quiet=TRUE)'
RUN sudo Rscript -e 'install.packages("shinyvalidate", quiet=TRUE)'
RUN sudo Rscript -e 'install.packages("shinyWidgets", quiet=TRUE)'
RUN sudo Rscript -e 'install.packages("shinythemes", quiet=TRUE)'
RUN sudo Rscript -e 'install.packages("shinybrowser", quiet=TRUE)'
RUN sudo Rscript -e 'install.packages("bslib", quiet=TRUE)'
RUN sudo Rscript -e 'install.packages("sever", quiet=TRUE)'
RUN sudo Rscript -e 'install.packages("DT", quiet=TRUE)'
RUN sudo Rscript -e 'install.packages("numbersBR", quiet=TRUE)'
RUN sudo Rscript -e 'install.packages("RSQLite", quiet=TRUE)'
RUN sudo Rscript -e 'install.packages("DBI", quiet=TRUE)'
RUN sudo Rscript -e 'install.packages("blob", quiet=TRUE)'
RUN sudo Rscript -e 'install.packages("pool", quiet=TRUE)'
RUN sudo Rscript -e 'install.packages("pdftools", quiet=TRUE)'
RUN sudo Rscript -e 'install.packages("cookies", quiet=TRUE)'
RUN sudo Rscript -e 'install.packages("markdown", quiet=TRUE)'
### Verifica se houve a correta compilação de todos pacotes
RUN sudo Rscript -e 'list.of.packages <- c("shinyjs","shinyvalidate","shinyWidgets","sever","DT","DBI","numbersBR",\
"pdftools","shinythemes","blob","shinybrowser","bslib","RSQLite","pool","shinybrowser","bslib","RSQLite","cookies",\
"markdown"); lost.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])];\
cat(paste0("\n\n\n*** Pacotes perdidos: ", length(lost.packages), " : ", lost.packages,  " ***\n\n\n"))'
#############################################################
RUN sudo chown -R shiny:shiny /srv/shiny-server/aconfrs-main/
VOLUME /srv/shiny-server/aconfrs-main/data
#############################################################