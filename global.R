

    #####################################################
    #                                                   #
    #             Carregamento de pacotes               #
    #                                                   #
    #####################################################

    # if(!require("shiny"))         install.packages("shiny")
    # if(!require("shinyjs"))       install.packages("shinyjs")
    # if(!require("shinyvalidate")) install.packages("shinyvalidate")
    # if(!require("shinyWidgets"))  install.packages("shinyWidgets")
    # if(!require("sever"))         install.packages("sever")
    # if(!require("DT"))            install.packages("DT")
    # if(!require("DBI"))           install.packages("DBI")
    # if(!require("pdftools"))      install.packages("pdftools")
    # if(!require("shinythemes"))   install.packages("shinythemes")
    # if(!require("numbersBR"))     install.packages("numbersBR")
    # if(!require("blob"))          install.packages("blob")
    # if(!require("cookies"))       install.packages("cookies")
    # if(!require("markdown"))      install.packages("markdown")
    
    require( "shiny" ) 
    require( "shinyjs" ) 
    require( "shinyvalidate" ) 
    require( "shinyWidgets" ) 
    require( "sever" ) 
    require( "DT" ) 
    require( "DBI" ) 
    require( "pdftools" ) 
    require( "shinythemes" ) 
    require( "htmltools" ) 
    require( "numbersBR" ) 
    require( "blob" )
	require( "cookies" )
    require( "markdown" )
    
    #shinyOptions( shiny.port=1234 )
    
    # list.of.packages <- c("pool", "shinybrowser", "bslib", "RSQLite", "RMariaDB" )
    # new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]    
    # if(length(new.packages)) install.packages(new.packages)
	

    #########################################################################
    #                                                                       #
    #    adição de path para acesso do Shiny: diretorios auxiliares do APP  #
    #                                                                       #
    #########################################################################

    addResourcePath( 'www',  './www/'  )
    addResourcePath( 'data', './data/' )
	addResourcePath( 'book', './www/sitebook' )
    
    #resourcePaths() # Visualiza o que está no path do Shiny

    #####################################################
    #                                                   #
    #        Arquivo de Configurações Gerais do App     #
    #                                                   #
    #####################################################
 
	configDB <- jsonlite::fromJSON( './data/configDB.json' )
	
	
    #####################################################
    #                                                   #
    #        Definição sobre Banco de Dados - DB        #
    #                                                   #
    #####################################################

    if( configDB[["dbEngine"]] == "SQLite" ){
        
        # abertura da DB sob demanda: Gerenciada pelo pacote "pool"
        conDB <- pool::dbPool( RSQLite::SQLite(), dbname=configDB[["dbPathSQLite"]] )
    
    }
    
    if( configDB[["dbEngine"]] == "MariaDB" ){
        
        # abertura da DB sob demanda: Gerenciada pelo pacote "pool"    
        conDB <- pool::dbPool( RMariaDB::MariaDB(),
            dbname         =    configDB[["dbNameMariaDB"]],
            username    =    configDB[["dbUser"]],
            password     =    configDB[["dbPass"]]
        )
        
    }
    
    # cria a Base de Dados - DB
    # ---------------------------------------------------------------------------
    # MAS: a DB só será criada se não houver uma tabela "mainTable" dentro da DB
    # ---------------------------------------------------------------------------
    # Verificar a existência da "mainTable" na DB e cria a DB
    if( !( "mainTable" %in% dbListTables( conDB ) ) ) source( "./dbDeploy.R", local=TRUE, encoding="UTF-8" )
    
    # Pega os nomes dos campos da DB
    colNamesDB <- dbListFields( conDB, "mainTable" )
    
    # Cria um data.frame vazio (NA) com COLNAMES Clone da DB
    mainTableR <- as.data.frame( matrix( NA, nr=1, nc=length( colNamesDB ) ) )
    colnames( mainTableR ) <- colNamesDB
    rm( colNamesDB )

    #####################################################
    #                                                   #
    #    Definições GLOBAIS / Funcionalidade do APP     #
    #                                                   #
    #####################################################

    # carrega as funções globais
    source( "./globalFun.R", local=TRUE, encoding="UTF-8" )

    #####################################################
    #                                                   #
    #    Definições/Var Genéricas (Server)              #
    #                                                   #
    #####################################################

    varString_serverFun <- readLines( "./serverFun.R", encoding="UTF-8" )

    #####################################################
    #                                                   #
    #  Definições/Var usadas na Interface de Avaliador  #
    #                                                   #
    #####################################################

    # lê o Arquivo de TIPS: "serverAvaliadorTips.R"
    # para Variavel (a ser "sourceADA" dentro do ambiente)
    varString_serverAvaliadorTips <- readLines( "./serverAvaliadorTips.R", encoding="UTF-8" )

    # lê o Arquivo de funções: "serverAvaliadorFun.R"
    # para Variavel (a ser "sourceADA" dentro do ambiente)
    varString_serverAvaliadorFun <- readLines( "./serverAvaliadorFun.R", encoding="UTF-8" )

    # lê o Arquivo SERVER do Avaliador: "serverAvaliador.R"
    # para Variavel (a ser "sourceADA" dentro do ambiente)
    varString_serverAvaliador <- readLines( "./serverAvaliador.R", encoding="UTF-8" )

    # lê o Arquivo UI do Avaliador: "uiAvaliador.R"
    # para Variavel (a ser "sourceADA" dentro do ambiente)
    varString_uiAvaliador <- readLines( "./uiAvaliador.R", encoding="UTF-8" )

    ######################################################
    #                                                    #
    # Definições/Var usadas na Interface de Participante #
    #                                                    #
    ######################################################

    # lê o Arquivo de TIPS: "serverParticipanteTips.R"
    # para Variavel (a ser "sourceADA" dentro do ambiente)
    varString_serverParticipanteTips <- readLines( "./serverParticipanteTips.R", encoding="UTF-8" )

    # lê o Arquivo de funções: "serverParticipanteFun.R"
    # para Variavel (a ser "sourceADA" dentro do ambiente)
    varString_serverParticipFun <- readLines( "./serverParticipanteFun.R", encoding="UTF-8" )

    # lê o Arquivo SERVER do Participante: "serverParticipante.R"
    # para Variavel (a ser "sourceADA" dentro do ambiente)
    varString_serverParticipante <- readLines( "./serverParticipante.R", encoding="UTF-8" )

    # lê o Arquivo UI do Participante: "uiParticipante.R"
    # para Variavel (a ser "sourceADA" dentro do ambiente)
    varString_uiParticipante <- readLines( "./uiParticipante.R", encoding="UTF-8" )

    ######################################################
    #                                                    #
    # Definições/Var usadas na Interface de Atribuidor   #
    #                                                    #
    ######################################################
    
    # lê o Arquivo de TIPS do Atribuidor: "serverAtribuidorTips.R"
    # para Variavel (a ser "sourceADA" dentro do ambiente)
    varString_serverAtribuidorTips <- readLines( "./serverAtribuidorTips.R", encoding="UTF-8" )

    # lê o Arquivo de funções: "serverAtribuidorFun.R"
    # para Variavel (a ser "sourceADA" dentro do ambiente)
    varString_serverAtribuidorFun <- readLines( "./serverAtribuidorFun.R", encoding="UTF-8" )
    
    # lê o Arquivo SERVER do Atribuidor: "serverAtribuidor.R"
    # para Variavel (a ser "sourceADA" dentro do ambiente)
    varString_serverAtribuidor <- readLines( "./serverAtribuidor.R", encoding="UTF-8" )

    # lê o Arquivo UI do Atribuidor: "uiAtribuidor.R"
    # para Variavel (a ser "sourceADA" dentro do ambiente)
    varString_uiAtrib <- readLines( "./uiAtribuidor.R", encoding="UTF-8" )
    
    ######################################################
    #                                                    #
    # Definições/Var usadas na Interface de Cadastrador  #
    #                                                    #
    ######################################################
    
    # lê o Arquivo de TIPS do Cadastrador: "serverCadastradorTips.R"
    # para Variavel (a ser "sourceADA" dentro do ambiente)
    varString_serverCadastradorTips <- readLines( "./serverCadastradorTips.R", encoding="UTF-8" )

    # lê o Arquivo de funções: "serverCadastradorFun.R"
    # para Variavel (a ser "sourceADA" dentro do ambiente)
    varString_serverCadastradorFun <- readLines( "serverCadastradorFun.R", encoding="UTF-8" )
    
    # lê o Arquivo SERVER do Cadastrador: "serverCadastrador.R"
    # para Variavel (a ser "sourceADA" dentro do ambiente)
    varString_serverCadastrador <- readLines( "./serverCadastrador.R", encoding="UTF-8" )

    # lê o Arquivo UI do Atribuidor: "uiCadastrador.R"
    # para Variavel (a ser "sourceADA" dentro do ambiente)
    varString_uiCadastrador <- readLines( "./uiCadastrador.R", encoding="UTF-8" )

    #####################################################
    #                                                   #
    #                    Personalizações                #
    #                                                   #
    #####################################################

    # personalização do Evento
    source( "./personalizacaoEvento.R", local=TRUE, encoding="UTF-8" )














