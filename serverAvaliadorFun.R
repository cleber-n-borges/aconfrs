
    #############################################################
    #                                                           #
    #                 Declaração de diversas Funções            #
    #                                                           #
    #############################################################

    #############################################################
    #                                                           #
    # Funções Auxiliares usadas dentro da função "maisDetalhes" #
    #                                                           #
    #############################################################
    
    fmtColNames <- function( detalhesRes ) paste0( "<p><b>", colnames( detalhesRes ), "</b></p>" )
    fmtConteudo <- function( detalhesRes ) paste0( "<p><em>", detalhesRes, "</em></p>" )
    fmtItem <- function( item ) paste0( '<div class="well">', item, '</div><br>' )
    
    #############################################################
    
    #############################################################
    #                                                           #
    #            Declaração da FUNÇÃO "maisDetalhes"            #
    #                                                           #
    #############################################################

    maisDetalhes <- function(){

        #req( input$table_rows_selected )
        selecao <- get( "resumoSelecionado", env=envAval )
        req( selecao )
        
        ###################################################################
        # Detalhes:  Pegar algumas outras variaveis que podem ser de interesse para os Avaliadores
        sql <- "SELECT palavChavTrab,textoTrab FROM mainTable WHERE numeroInsc = ?"
        detalhesRes <- dbGetQuery( conDB, sql, params=list( selecao ) )
        
        colnames( detalhesRes ) <- c("Palavras-Chaves", "Texto do Resumo")
    
        N <- ncol( detalhesRes )
        relDetalhes <- character( N )
        for( i in 1:N )
            relDetalhes[ i ] <- fmtItem( paste0( fmtColNames( detalhesRes[i] ), fmtConteudo( detalhesRes[i] ) ) )
        
        output$detalhesResumo <- renderText({ HTML( relDetalhes ) })
        
    }#<- fecha a função "maisDetalhes"
    
    #############################################################
    #                                                           #
    #         Declaração da FUNÇÃO "forcarBuscaDB"              #
    #                                                           #
    #############################################################
    
    forcarBuscaDB <- function() {
        
        numRes <- try( get( "resumoSelecionado", env=envAval ), silent=TRUE )
        
        req( as.numeric( numRes ) )
    
        #################################################################################
        # Resgata Quais são as Respostas para o Resumo Selecionado (se houver previamente)
        
        # resp Objetivas da DB
        sql <- "SELECT respObjetiv FROM mainTable WHERE numeroInsc = ?"
        res <- dbGetQuery( conDB, sql, params=list( numRes ) )
        if( is.na( res ) ){
            envAval$respObjTotal <- character( envAval$maxObj )
        } else {
            envAval$respObjTotal <- strsplit( res[1,1], split='&' )[[1]]
            ############################################################
            tmp1 <- strsplit( res[1,1], split='&' )[[1]]
            tmp1 <- as.numeric( gsub( '^([[:digit:]]{1,3})(.*)$', '\\1', trimws( tmp1 ) ) )
            tmp2 <- character( envAval$maxObj )
            tmp2[ na.exclude( tmp1 ) ] <- ( strsplit( res[1,1], split='&' )[[1]] )[ na.exclude( tmp1 ) ]
            envAval$respObjTotal <- tmp2
            ############################################################
        }
        
        # resp Dissertativas da DB
        sql <- "SELECT respDissert FROM mainTable WHERE numeroInsc = ?"
        res <- dbGetQuery( conDB, sql, params=list( numRes ) )
        if( is.na( res ) ){
            envAval$respDisTotal <- character( envAval$maxDis )
        } else {
            envAval$respDisTotal <- strsplit( res[1,1], split='&' )[[1]]
            ############################################################
            tmp1 <- strsplit( res[1,1], split='&' )[[1]]
            tmp1 <- as.numeric( gsub( '^([[:digit:]]{1,3})(.*)$', '\\1', trimws( tmp1 ) ) )
            tmp2 <- character( envAval$maxDis )
            tmp2[ na.exclude( tmp1 ) ] <- ( strsplit( res[1,1], split='&' )[[1]] )[ na.exclude( tmp1 ) ]
            envAval$respDisTotal <- tmp2
            ############################################################
        }
        
        # avaliação da DB
        sql <- "SELECT opResultAvalResumo FROM mainTable WHERE numeroInsc = ?"
        res <- dbGetQuery( conDB, sql, params=list( numRes ) )
        if( is.na( res ) ) res <- '{Não houve anterior}'
        labAvalAnterior <- paste0( '<em><font size="5">&rarr;</font>   A avaliação anterior era: ', res[[1]], "</em>" )
        output$avaliacaoAnterior <- renderText({ HTML( labAvalAnterior ) })
        
        # requisicao da DB
        sql <- "SELECT opRequisicaoAvalResumo FROM mainTable WHERE numeroInsc = ?"
        res <- dbGetQuery( conDB, sql, params=list( numRes ) )
        if( is.na( res ) ) res <- '{Não houve anterior}'
        labRequisicaoAnterior <- paste0( '<em><font size="5">&rarr;</font>   A requisição anterior era: ', res[[1]], "</em>" )
        output$requisicaoAnterior <- renderText({ HTML( labRequisicaoAnterior ) })
        
        # FIM: Resgata Quais são as Respostas para o Resumo Selecionado
        ##################################################################################
        
        # chama a função
        maisDetalhes()
        
        
    }
    
    #############################################################
    #                                                           #
    #     Declaração da FUNÇÃO "funcBotaoItensDissertativos"    #
    #                                                           #
    #############################################################
    
    funcBotaoItensDissertativos <- function(){
    
        numRes <- try( get( "resumoSelecionado", env=envAval ), silent=TRUE )

        req( as.numeric( numRes ) )

        shinyjs::hide("respQuestObjetiv")
        shinyjs::show("respQuestDissert")
        shinyjs::show("ncaract" )
        envAval$respondendo <- "dissertat"
        
        res <- paste0( "Questão ",  envAval$idxRespDis, " - Dissertativa" )
        
        # atualiza qual é a pergunta pra tela
        updateTextAreaInput( inputId="showQuestion", lab=res, value=opQuestoesDissertativas[ envAval$idxRespDis, 1 ] )
        
        # atualiza o visor sobre o que já foi respondido
        updateTextAreaInput( inputId="respQuestDissert", value=envAval$respDisTotal[ envAval$idxRespDis ] )
        
        output$regItemCurrent <- renderText({ "Aguardando..." })
        
        # atualiza a visão de registro com Todas as respostas Dissertativas
        updateTextInput( inputId="showRegistro", value=envAval$respDisTotal )
        
        # atualiza o tableViewRespDis
        viewRespDis <- character( length( envAval$respDisTotal ) )
        dim( viewRespDis ) <- c( 1, length( envAval$respDisTotal ) )
        colnames( viewRespDis ) <- 1:length( envAval$respDisTotal )
        viewRespDis[ envAval$respDisTotal != "" ] <- "&#10004;"
        output$tableViewRespDis <- renderTable({ viewRespDis }, sanitize.text.function = identity )
        
        # informa ao usuário a CONTABILIDADE de:
        res <- paste0("Respondidas: ", sum( envAval$respDisTotal != "" ), ", Faltantes: ", sum( envAval$respDisTotal == "" ) )
        output$infoDisResp <- renderText({ res })

    }
    
    #############################################################
    #                                                           #
    #                 Função: "funcBotaoItensObjetivos"         #
    #                                                           #
    #############################################################
    
    funcBotaoItensObjetivos <- function(){
    
        numRes <- try( get( "resumoSelecionado", env=envAval ), silent=TRUE )

        req( as.numeric( numRes ) )

        shinyjs::hide( "respQuestDissert" )
        shinyjs::hide( "ncaract" )
        shinyjs::show( "respQuestObjetiv" )
        envAval$respondendo <- "objetivas"
        
        res <- paste0( "Questão ",  envAval$idxRespObj, " - Objetiva" )
        
        # atualiza qual é a pergunta pra tela
        updateTextAreaInput( inputId="showQuestion", lab=res, value=opQuestoesObjetivas[ envAval$idxRespObj, 1 ] )

        # atualiza o visor sobre o que já foi respondido
        res1 <- sub( '^([[:digit:]]{1,2})([[:punct:]]+)(.*)$', '\\3', trimws( envAval$respObjTotal[ envAval$idxRespObj ] ) )
        
        # mostra opções das perguntas; diferentes de "vazio"
        quest <- as.character( opQuestoesObjetivas[ envAval$idxRespObj, -1 ] ) 
        quest <- quest[ quest != "" ]
        updateRadioButtons( inputId='respQuestObjetiv', selected=res1, choices=quest )

        output$regItemCurrent <- renderText({ "Aguardando..." })
        
        # atualiza a visão de registro com Todas as respostas Ojetivas
        updateTextInput( inputId="showRegistro", value=envAval$respObjTotal )
        
        # atualiza o tableViewRespObj
        viewRespObj <- character( length( envAval$respObjTotal ) )
        dim( viewRespObj ) <- c( 1, length( envAval$respObjTotal ) )
        colnames( viewRespObj ) <- 1:length( envAval$respObjTotal )
        viewRespObj[ envAval$respObjTotal != "" ] <- "&#10004;"
        output$tableViewRespObj <- renderTable({ viewRespObj }, sanitize.text.function = identity )
        
        # informa ao usuário a CONTABILIDADE de:
        res <- paste0("Respondidas: ", sum( envAval$respObjTotal != "" ), ", Faltantes: ", sum( envAval$respObjTotal == "" ) )
        output$infoObjResp <- renderText({ res })

        
    }
    
    #############################################################
    #                                                           #
    #            Declaração da FUNÇÃO "getDataDB2table"         #
    #                                                           #
    #############################################################

    getDataDB2table <- function(){

        #####################################################################
        #                                                                   #
        #                         Criação da Tabela 1                       #
        #                                                                   #
        #####################################################################
        
        # Tabela dos Resumos a serem avaliados:  Pegar somente as variaveis de interesse para os Avaliadores
        
        sql <- "SELECT numeroInsc,tituloTrab,subAreaTrab,situacaoAvalResumo,versaoResumo,travaEdicao FROM mainTable WHERE modalParticip = 'Com Resumo'"
        dataShow <- dbGetQuery( conDB, sql )
        
        dtBR$emptyTable <- 'Ainda não há Resumos Disponíveis para Avaliação. Favor Aguardar!'
    
        tableDataResumo <-  datatable( data = dataShow[,-c(5,6)],
        
            filter         = "top",
            options     = list( pageLength = 5, autoWidth = TRUE, language = dtBR ),
            style        = "bootstrap4",
            rownames    = FALSE,
            colnames    = c(" Inscrição "," Título "," Área "," Situação "),
            selection    = "single",
            caption = 'Tabela 1: Dados sobres os Resumos Submetidos.'
    
        )
    
        # Formata a Tabela 1 com melhor estilo
    
        # 4 Diferentes Cores para as 4 diferentes Situações no processo avaliativo:
        cores <- dataShow[,4]
        cores <- c( "Crimson", "MediumAquaMarine", "black", "orange" )[ as.factor( cores ) ]
        
        ###############################################################################################
        # bootstrap color: https://getbootstrap.com/docs/5.0/customize/color/
        # color_primary <- bslib::bs_get_variables( bslib::bs_theme(), varnames = 'primary' )
        # 
        # color_success <- bslib::bs_get_variables( bslib::bs_theme(), varnames = 'success' )
        # color_warning <- bslib::bs_get_variables( bslib::bs_theme(), varnames = 'warning' )
        # color_danger  <- bslib::bs_get_variables( bslib::bs_theme(), varnames = 'danger' )
        # 
        # color_teal400   <- bslib::bs_get_variables( bslib::bs_theme(), varnames = 'teal-400' )
        # color_orange400 <- bslib::bs_get_variables( bslib::bs_theme(), varnames = 'orange-400' )
        # color_red400    <- bslib::bs_get_variables( bslib::bs_theme(), varnames = 'red-400' )
        # color_gray400   <- bslib::bs_get_variables( bslib::bs_theme(), varnames = 'gray-400' )
        # 
        # color_contrast_primary <- bs_get_contrast(bs_theme(), "primary" )
        ###############################################################################################
        
        #cores <- c( color_danger, color_teal400, color_gray400, color_orange400 )[ as.factor( cores ) ]

        if( nrow( dataShow ) > 0 ){
        
            tableDataResumo <- formatStyle( tableDataResumo, target = "cell", columns=4, color = styleEqual( dataShow[,4], cores ) ) 
    
        }
        
        # Renderiza a Tabela 1 na tela
        output$table <- renderDataTable({ tableDataResumo })


        #####################################################################
        #                                                                   #
        #                         Regra de Avaliação                        #
        #                                                                   #
        #####################################################################

        # Quadro tb consta no Arquivo: serverParticipanteFun.R linha 689
        #####################################################################
        
        # 4 Diferentes Situações No processo Avaliativo:
        
        # ----- Condição --------------------- Ação -------------- Código
        
        # (1) Resumo Enviado            Esperando Avaliação       -> escrever na DB: "Esperando Avaliação"
        # (2) Resumo Aprovado            Nenhuma ação necessária   -> escrever na DB: "Resumo Aprovado"
        # (3) Resumo Reprovado            Nenhuma ação necessária   -> escrever na DB: "Resumo Reprovado"
        # (4) Correções Necessárias        Aguardando Correções      -> escrever na DB: "Esperando Correções"
        
        #####################################################################
        
        # Transforma a coluna "situacaoAvalResumo" em Fator (Variável Categórica)
		niveisAval <- c( "Esperando Avaliação", "Resumo Aprovado", "Resumo Reprovado", "Esperando Correções" )
        tableSituacao <- factor( dataShow[,"situacaoAvalResumo"], levels=niveisAval )

        # Cria uma Tabela de Contigência
        tableSituacao <- table( tableSituacao )
        
        #####################################################################
        #                                                                   #
        #                         informa ao Avaliador                      #
        #                                                                   #
        #####################################################################
        
        # Informa ao Avaliador se há algum Resumo a ser Avaliado
    
        if( isTRUE( tableSituacao["Esperando Avaliação"] > 0 ) ){
        
            runjs( paste0("$('#statusAvaliador').css({'color': '#DC143C'})") )
            updateTextInput( inputId="statusAvaliador", value='Situação para o Avaliador:   Há Resumos "Esperando Avaliações"' )
            
        } else {
        
            runjs( paste0("$('#statusAvaliador').css({'color': '#66CDAA'})") )
            updateTextInput( inputId="statusAvaliador", value="Situação para o Avaliador:   Não há Resumos a serem avaliados no momento!" )        

        }
        
        if( nrow( dataShow ) == 0 ) {
            
            shinyjs::disable( "checkPausaEdParticip" )
            
            runjs( paste0("$('#statusAvaliador').css({'color': '#66CDAA'})") )
            updateTextInput( inputId="statusAvaliador", value="Ainda não há resumos disponibilizados!" )
    
        }
    
        ###############################################################################
    
    
        # Coloca uma contabilidade geral sobre os Resumos no rodapé da Tabela 1
        
        labContabil <- paste0( "\t\tEsperando Avaliação: ", tableSituacao["Esperando Avaliação"],
                               "\t\tResumo Aprovado: ",     tableSituacao["Resumo Aprovado"],
                               "\t\tResumo Reprovado: ",    tableSituacao["Resumo Reprovado"],
                               "\t\tEsperando Correções: ", tableSituacao["Esperando Correções"]
        )
        
        output$infoContabil <- renderText( labContabil )
        
        ###############################################################################
        
        # Caso exista Resumo Previamente Marcado como "TRAVADO" na DB
        resumoTravaEd <- which( dataShow[["travaEdicao"]] == "TRUE" )
    
        #  Caso exista: len() é 1!  -->  TRUE
        if( length( resumoTravaEd ) ){
        
            resumoSelecionado <- dataShow[ resumoTravaEd,1 ]
            # Guarda localmente o Numero da Inscrição do Resumo Selecionado
            assign( "resumoSelecionado", resumoSelecionado, env=envAval )
            
            # Pega o Titulo PARCialmente
            tituloResParc <- substr( dataShow[ resumoTravaEd, 2 ], 1,70 )
            
            # Cria uma msg para preencher as labels informativas sobre Selecao
            envAval$msgSel <- paste0( "Resumo Selecionado para Avaliação: ", resumoSelecionado, " - ", tituloResParc, "..." )
            envAval$msgSel <- paste0( "<p class='text-success'><b><font size='5'>&rarr;&nbsp;</font>", envAval$msgSel, "</b></p>" )
            
            # avisos sobre a ação da "Pausa de Edição do Participante"
            # ajuda o avaliador a não ficar perdido sobre o que esse panel faz...
            output$labTable04            <- renderText({ envAval$msgSel })
            output$labDownload03         <- renderText({ envAval$msgSel })
            output$labQuestionarioAval07 <- renderText({ envAval$msgSel })
            output$labConclusAval00      <- renderText({ envAval$msgSel })
            output$labPausa05            <- renderText({ envAval$msgSel })
    
            # chama as funções
            forcarBuscaDB()
            funcBotaoItensDissertativos()
            funcBotaoItensObjetivos()
            
            # Atualiza o botão de checagem de Pausa de Edição do Participante
            updateCheckboxInput( inputId="checkPausaEdParticip", value=TRUE )
    
            
        } else {
    
            # avisos sobre a ação da "Pausa de Edição do Participante"
            # ajuda o avaliador a não ficar perdido sobre o que esse panel faz...
            #######################################################################
            # MSG de Que não há Resumo Selecionado
            envAval$msgSel <- msgSemResumo # "msgSemResumo" está em "global.R"
            output$labTable04            <- renderText({ envAval$msgSel })
            output$labDownload03         <- renderText({ envAval$msgSel })
            output$labQuestionarioAval07 <- renderText({ envAval$msgSel })
            output$labConclusAval00      <- renderText({ envAval$msgSel })
            output$labPausa05            <- renderText({ envAval$msgSel })
    
        }
    
        # a função retorna a Tabela 1
        return( dataShow )
    
    }
    
    #############################################################
    #                                                           #
    #            Declaração da FUNÇÃO "funcClickLinhaTabela"    #
    #                                                           #
    #############################################################
    
    funcClickLinhaTabela <- function(){

        # Caso o botão de Pausa estiver como "TRUE"
        if( input$checkPausaEdParticip ){
        
            #Exibe msg de que já existe Selecao do Resumo
            funcPausaSelecaoPreenchida()
            
            #Desabilita seleção de linha na Tabela 1
            tableProxy <- dataTableProxy( outputId="table" )
            selectRows( tableProxy, selected=NULL )

        }

        # Executa (trecho abaixo) somente se "Pausa de Edição" for "FALSE"
        req( !input$checkPausaEdParticip )
        
        # resgata a tabela 
        dataShow <- get( "dataShow", env=envAval )
    
        # determina qual Resumo foi Selecionado
        numRes <- dataShow[ as.integer( input$table_rows_selected ), 1 ]
        
        # Toma PARte do Titulo (para msg)
        tituloResParc <- substr( dataShow[ as.integer( input$table_rows_selected ), 2 ], 1,50 )
        
        # Cria MSG (mensagem) de aviso sobre Resumo Selecionado
        envAval$msgSel <- paste0( "Resumo Selecionado para Avaliação: ", numRes, " - ", tituloResParc, "..." )
        envAval$msgSel <- paste0( "<p class='text-success'><b><font size='5'>&rarr;&nbsp;</font>", envAval$msgSel, "</b></p>" )

        # Envia MSG da Selecao para cada Panel (informacao visual)
        output$labTable04            <- renderText({ envAval$msgSel })
        output$labDownload03         <- renderText({ envAval$msgSel })
        output$labQuestionarioAval07 <- renderText({ envAval$msgSel })
        output$labConclusAval00      <- renderText({ envAval$msgSel })
        output$labPausa05            <- renderText({ envAval$msgSel })
        
        # Guarda localmente o Numero da Inscrição do Resumo Selecionado
        assign( "resumoSelecionado", numRes, env=envAval )
        
        # chama as funções
        forcarBuscaDB()
        funcBotaoItensDissertativos()
        funcBotaoItensObjetivos()
        
    }

    #############################################################
    #                                                           #
    #    Declaração da FUNÇÃO "funcMonitoraBotaoPausaParticip"  #
    #                                                           #
    #############################################################

    funcMonitoraBotaoPausaParticip <- function() {

        selecao <- try( get( "resumoSelecionado", env=envAval ), silent=TRUE )
        #res1 <- length( grep( "^Error", selecao[[1]] ) )

        if( input$checkPausaEdParticip ){
        # Procedimento para "Pausar" a Edição do Participante
        # Avaliador procede em responder perguntas
        
            if( selecao == "" ){
            
                funcPausaSelecaoVazia()
                
            } else {
                
                # Trava a possibilidade das Edições do Participante
                sql <- "UPDATE mainTable SET travaEdicao = 'TRUE' WHERE numeroInsc = ?"
                dbExecute( conDB, sql, params=list( selecao ) )
                
                # avisos sobre a ação da "Pausa de Edição do Participante"
                # ajuda o avaliador a não ficar perdido sobre o que esse panel faz...
                output$avisoPausa <- renderText({"Edição do Participante: Pausada"})
                output$avisoPasso1 <- renderText({"Passo 1 - Seleção do Resumo: Pausado"})
                output$avisoPasso2 <- renderText({"Passo 3 - Download do Resumo: Liberado"})
                output$avisoPasso3 <- renderText({"Passo 4 - Questionário: Liberado"})
    
                # Habilita possibilidade de ver PDF
                shinyjs::enable( "avalVersPdfRes" )
                shinyjs::enable( "downPDFResAval" )
    
                # Desabilita Perg/Resp
                shinyjs::enable( "itObjetivos" )
                shinyjs::enable( "itDissertat" )
                shinyjs::enable( "respQuestDissert" )
                shinyjs::enable( 'respQuestObjetiv' )
                shinyjs::enable( "regResposta" )
                shinyjs::enable( "pergAnterior" )
                shinyjs::enable( "pergProxima" )
                shinyjs::enable( "radAval" )
                shinyjs::enable( "radRequisicao" )
                
                #tableProxy <- dataTableProxy( outputId="table" )
                #selectRows( tableProxy, selected=NULL )
                
                # atualiza interface sobre Trava de edição
                updateTextInput( inputId="statusTravaEdResumo", value="Acionada" )
                removeClass( "panelTravaEdResumo", class='bg-success' )
                addClass( "panelTravaEdResumo", class='bg-danger' )
            
            }
  
        } else {
        # Procedimento para "Liberar" a Edição do Participante
            
            # avisos sobre a ação da "Pausa de Edição do Participante"
            # ajuda o avaliador a não ficar perdido sobre o que esse panel faz...
            output$avisoPausa <- renderText({"Edição do Participante: Liberada"})
            output$avisoPasso1 <- renderText({"Passo 1 - Seleção do Resumo: Liberado"})
            output$avisoPasso2 <- renderText({"Passo 3 - Download do Resumo: Pausado"})
            output$avisoPasso3 <- renderText({"Passo 4 - Questionário: Pausado"})
        
            # Habilita possibilidade de ver PDF
            shinyjs::disable( "avalVersPdfRes")
            shinyjs::disable( "downPDFResAval")

            # Habilita Perg/Resp
            shinyjs::disable( "itObjetivos" )
            shinyjs::disable( "itDissertat" )
            shinyjs::disable( "respQuestDissert" )
            shinyjs::disable( "respQuestObjetiv" )
            shinyjs::disable( "regResposta" )
            shinyjs::disable( "pergAnterior" )
            shinyjs::disable( "pergProxima" )
            shinyjs::disable( "radAval" )
            shinyjs::disable( "radRequisicao" )

            req( selecao )
            
            # Destrava a possibilidade das Edições do Participante
            sql <- "UPDATE mainTable SET travaEdicao = 'FALSE' WHERE numeroInsc = ?"
            dbExecute( conDB, sql, params=list( selecao ) )
            
            dataShow <- get( "dataShow", env=envAval )
            
            res <- which( dataShow[["numeroInsc"]] == selecao )
            
            #tableProxy <- dataTableProxy( outputId="table" )
            
            #selectRows( tableProxy, selected=res )
            
            # atualiza interface sobre Trava de edição
            updateTextInput( inputId="statusTravaEdResumo", value="Liberada" )
            removeClass( "panelTravaEdResumo", class='bg-danger' )
            addClass( "panelTravaEdResumo", class='bg-success' )
            
        }
        
    }    

    #############################################################
    #                                                           #
    #    Declaração da FUNÇÃO "funcBotaoRegistrarResposta"      #
    #                                                           #
    #############################################################
    
    funcBotaoRegistrarResposta <- function(){
    
        if( envAval$respondendo == "objetivas" & envAval$idxRespObj >= 1 & envAval$idxRespObj <= envAval$maxObj ){
        
            if( !is.null( input$respQuestObjetiv ) ){
            
                # informa ao usuário do Sucesso da operação
                res0 <- paste0('Opção: ', input$respQuestObjetiv, ' - registrada com sucesso!'  )
                output$regItemCurrent <- renderText({ res0 })
            
                # atualiza vetor do que já foi respondido
                envAval$respObjTotal[ envAval$idxRespObj ] <- paste0( '  ', envAval$idxRespObj, '-', input$respQuestObjetiv )
                updateTextInput( inputId="showRegistro", value=envAval$respObjTotal )
                
                # atualiza o tableViewRespObj
                viewRespObj <- character( length( envAval$respObjTotal ) )
                dim( viewRespObj ) <- c( 1, length( envAval$respObjTotal ) )
                colnames( viewRespObj ) <- 1:length( envAval$respObjTotal )
                viewRespObj[ envAval$respObjTotal != "" ] <- "&#10004;"
                
                output$tableViewRespObj <- renderTable({ viewRespObj }, sanitize.text.function = identity )
                
                # informa ao usuário a CONTABILIDADE de:
                res <- paste0("Respondidas: ", sum( envAval$respObjTotal != "" ), ", Faltantes: ", sum( envAval$respObjTotal == "" ) )
                output$infoObjResp <- renderText({ res })
            
            } else {
            
                # informa ao usuário do INSucesso da operação
                output$regItemCurrent <- renderText({ 'Opção perdida - Sem registro para o item' })
                
            }

        }
        
        if( envAval$respondendo == "dissertat" & envAval$idxRespDis >= 1 & envAval$idxRespDis <= envAval$maxDis ){
        
            if( input$respQuestDissert != "" ){
        
                # informa ao usuário do sucesso da operação
                res0 <- substr( input$respQuestDissert, 1, 30 )
                res0 <- paste0('Resposta: "', res0,  '..."  | Foi registrada com sucesso!'  )
                output$regItemCurrent <- renderText({ res0 })
                
                # atualiza vetor do que já foi respondido
                envAval$respDisTotal[ envAval$idxRespDis ] <- paste0( '  ', envAval$idxRespDis, '-', input$respQuestDissert )

                #updateTextInput( inputId="showRegistro", value=envAval$respDisTotal[ envAval$idxRespDis ] )
                updateTextInput( inputId="showRegistro", value=envAval$respDisTotal )
                
                # atualiza o tableViewRespDis
                viewRespDis <- character( length( envAval$respDisTotal ) )
                dim( viewRespDis ) <- c( 1, length( envAval$respDisTotal ) )
                colnames( viewRespDis ) <- 1:length( envAval$respDisTotal )
                viewRespDis[ envAval$respDisTotal != "" ] <- "&#10004;"
                output$tableViewRespDis <- renderTable({ viewRespDis }, sanitize.text.function = identity )
                
                # informa ao usuário a CONTABILIDADE de:
                res <- paste0("Respondidas: ", sum( envAval$respDisTotal != "" ), ", Faltantes: ", sum( envAval$respDisTotal == "" ) )
                output$infoDisResp <- renderText({ res })
            
            } else {
            
                # informa ao usuário do INSucesso da operação
                output$regItemCurrent <- renderText({ 'Opção perdida - Sem registro para o item' })
            
            }
        
        }
        
    }

    #############################################################
    #                                                           #
    #        Declaração da FUNÇÃO "funcBotaoAnterior"           #
    #                                                           #
    #############################################################
    
    funcBotaoAnterior <- function(){
    
        if( envAval$respondendo == "objetivas" & envAval$idxRespObj > 1 ){
        
            # atualizando o visor das Questões
            envAval$idxRespObj <- envAval$idxRespObj - 1
            res <- paste0( "Questão ",  envAval$idxRespObj, " - Objetiva" )
            updateTextAreaInput( inputId="showQuestion", lab=res, value=opQuestoesObjetivas[ envAval$idxRespObj, 1 ] )
            output$regItemCurrent <- renderText({ "Aguardando..." })

            # atualiza o visor sobre o que já foi respondido
            res1 <- sub( '^([[:digit:]]{1,2})([[:punct:]]+)(.*)$', '\\3', trimws( envAval$respObjTotal[ envAval$idxRespObj ] ) )
            
            # mostra opções; diferentes de "vazio"
            quest <- as.character( opQuestoesObjetivas[ envAval$idxRespObj, -1 ] ) 
            quest <- quest[ quest != "" ]
            updateRadioButtons( inputId='respQuestObjetiv', selected=res1, choices=quest )
            
        }
        
        if( envAval$respondendo == "dissertat" & envAval$idxRespDis > 1 ){
        
            # atualizando o visor das Questões
            envAval$idxRespDis <- envAval$idxRespDis - 1
            res <- paste0( "Questão ",  envAval$idxRespDis, " - Dissertativa" )
            updateTextAreaInput( inputId="showQuestion", lab=res, value=opQuestoesDissertativas[ envAval$idxRespDis, 1 ] )
            output$regItemCurrent <- renderText({ "Aguardando..." })

            # atualiza o visor sobre o que já foi respondido    
            updateTextInput( inputId="showRegistro", value=envAval$respDisTotal )
            
            # deixa o espaço de escrita com o histórico
            updateTextAreaInput( inputId="respQuestDissert", value=envAval$respDisTotal[ envAval$idxRespDis ] )
            
        }
        
        
    }

    #############################################################
    #                                                           #
    #        Declaração da FUNÇÃO "funcBotaoProxima"            #
    #                                                           #
    #############################################################

    funcBotaoProxima <- function(){
    
        if( envAval$respondendo == "objetivas" & envAval$idxRespObj < envAval$maxObj ){
        
            # atualizando o visor das Questões
            envAval$idxRespObj <- envAval$idxRespObj + 1
            res <- paste0( "Questão ",  envAval$idxRespObj, " - Objetiva" )
            updateTextAreaInput( inputId="showQuestion", lab=res, value=opQuestoesObjetivas[ envAval$idxRespObj, 1 ] )
            output$regItemCurrent <- renderText({ "Aguardando..." })
            
            # atualiza o visor sobre o que já foi respondido
            res1 <- sub( '^([[:digit:]]{1,2})([[:punct:]]+)(.*)$', '\\3', trimws( envAval$respObjTotal[ envAval$idxRespObj ] ) )
            
            # mostra opções; diferentes de "vazio"
            quest <- as.character( opQuestoesObjetivas[ envAval$idxRespObj, -1 ] ) 
            quest <- quest[ quest != "" ]
            updateRadioButtons( inputId='respQuestObjetiv', selected=res1, choices=quest )
            
        }

        if( envAval$respondendo == "dissertat" & envAval$idxRespDis < envAval$maxDis ){
        
            # atualizando o visor das Questões
            envAval$idxRespDis <- envAval$idxRespDis + 1
            res <- paste0( "Questão ",  envAval$idxRespDis, " - Dissertativa" )
            updateTextAreaInput( inputId="showQuestion", lab=res, value=opQuestoesDissertativas[ envAval$idxRespDis, 1 ] )
            output$regItemCurrent <- renderText({ "Aguardando..." })
            
            # atualiza o visor sobre o que já foi respondido
            updateTextInput( inputId="showRegistro", value=envAval$respDisTotal )
            
            # deixa o espaço de escrita com o histórico
            updateTextAreaInput( inputId="respQuestDissert", value=envAval$respDisTotal[ envAval$idxRespDis ] )

        }
    
    }

    #############################################################
    #                                                           #
    #        Declaração da FUNÇÃO "funcBotaoEnvioInfo"          #
    #                                                           #
    #############################################################

    funcBotaoEnvioInfo <- function(){
    
        # requisita dados minimos para executar essa função
        req( input$checkPausaEdParticip )
        req( input$radAval )
        req( input$radRequisicao )
        selecao <- get( "resumoSelecionado", env=envAval )
        req( selecao )
        
        # +++++++++++++++++++++++++++++++++++++++++++++++
		
		print('Registra resp Objetivas na DB')
		print( envAval$respObjTotal )
		print( length( envAval$respObjTotal ) )
		respObj <<- envAval$respObjTotal
		
		if( !isTRUE( unique( respObj != "" ) ) ){
		
			print("Há Perguntas sem respostas")
			
		}
		
        # +++++++++++++++++++++++++++++++++++++++++++++++
		
		# Registra resp Objetivas na DB
        res <- paste( envAval$respObjTotal, collapse='&' )    
        sql <- paste0( "UPDATE mainTable SET respObjetiv = '", res, "' WHERE numeroInsc = ?" )
        dbExecute( conDB, sql, params=list( selecao ) )
        
        # Registra resp Dissertativas na DB
        res <- paste( envAval$respDisTotal, collapse='&' )
        sql <- paste0( "UPDATE mainTable SET respDissert = '", res, "' WHERE numeroInsc = ?" )
        dbExecute( conDB, sql, params=list( selecao ) )
        
        # Regista na DB: Informação de que o Participante precisa ou não de Nova Versão de resumo
        sql <- paste0( "UPDATE mainTable SET opRequisicaoAvalResumo = '", input$radRequisicao, "' WHERE numeroInsc = ?" )
        dbExecute( conDB, sql, , params=list( selecao ) )
        
        # Regista na DB: Número de Nova Versão de resumo a ser submitida
        res <- which( input$radRequisicao == opRequisicaoAvalResumo )
        if( res == 1 ){
        
            sql <- "SELECT versaoResumo FROM mainTable WHERE numeroInsc = ?"
            res <- dbGetQuery( conDB, sql, params=list( selecao ) )
            res <- as.numeric( res )
            sql <- paste0( "UPDATE mainTable SET versaoSolicitResumo = '", res+1, "' WHERE numeroInsc = ?" )
            dbExecute( conDB, sql, params=list( selecao ) )
            
        }
        
        # Regista na DB: Informação sobre Conclusão do Avaliação sobre o Resumo do Participante
        sql <- paste0( "UPDATE mainTable SET opResultAvalResumo = '", input$radAval, "' WHERE numeroInsc = ?" )
        dbExecute( conDB, sql, params=list( selecao ) )
        
        # Atualiza a situação do Resumo
        res <- which( opResultAvalResumo == input$radAval )
        if( res == 1 ) res <- "Resumo Aprovado"
        if( res == 2 ) res <- "Esperando Correções"
        if( res == 3 ) res <- "Resumo Reprovado"
        sql <- paste0( "UPDATE mainTable SET situacaoAvalResumo = '", res, "' WHERE numeroInsc = ?" )
        dbExecute( conDB, sql, params=list( selecao ) )
        
        # Registra a data (dia) na DB
        res <- format(Sys.time(), "%d/%m/%Y %H:%Mh")
        sql <- paste0( "UPDATE mainTable SET dataAvaliacao = '", res, "' WHERE numeroInsc = ?" )
        dbExecute( conDB, sql, params=list( selecao ) )
        
        # Destrava a possibilidade das Edições
        sql <- paste0( "UPDATE mainTable SET travaEdicao = 'FALSE' WHERE numeroInsc = ?" )
        dbExecute( conDB, sql, params=list( selecao ) )
		
		#envAval$mainTable
        
        showModal( modalDialog(
            tags$h4(
                tags$p("Informações Enviadas com Sucesso!"),
                br(),
                tags$p("Interface Atualizada para Nova Avaliação!")
            ),
            title = "Envio",
            footer=tagList( modalButton( "Ok" ) )
        ))
        
        # Atualizar interface toda para NOVA Avaliação

        assign( "resumoSelecionado", "", env=envAval )
        
        # Chama a função de Criação da Tabela 1
		envAval$dataShow <- getDataDB2table()
        #assign( "dataShow", getDataDB2table(), env=envAval )
        
        envAval$respObjTotal <- character( envAval$maxObj )
        envAval$respDisTotal <- character( envAval$maxDis )
        
        # desmarca a linha selecionada da tabela 1
        selectRows( dataTableProxy("table"), selected=NULL )

        # atualiza as labels
        envAval$msgSel <- msgSemResumo
        
        # atualiza a checagem de Pausa de Edição do Participante
        updateCheckboxInput( inputId="checkPausaEdParticip", value=FALSE )
		
		# atualiza interface sobre Trava de edição
        updateTextInput( inputId="statusTravaEdResumo", value="Liberada" )
        removeClass( "panelTravaEdResumo", class='bg-danger' )
        addClass( "panelTravaEdResumo", class='bg-success' )

        # desabilita acesso a PDF
        shinyjs::disable("avalVersPdfRes")
        shinyjs::disable("downPDFResAval")
        
        # desabilita quadro dePerguntas/Respostas
        shinyjs::disable("itObjetivos")
        shinyjs::disable("itDissertat")
        shinyjs::disable("respQuestDissert")
        shinyjs::disable("respQuestObjetiv")
        shinyjs::disable("regResposta")
        shinyjs::disable("pergAnterior")
        shinyjs::disable("pergProxima")
        shinyjs::disable("radAval")
        shinyjs::disable("radRequisicao")
        
        # oculta panels
        shinyjs::hide( "panelPausaEdParticipSub01" )
        shinyjs::hide( "panelSelecDownResSub01" )
        shinyjs::hide( "panelRespQuestionarioSub01" )
        shinyjs::hide( "panelConclusaoSub01" )

        # atualiza radioButtons da Conclusão
        updateRadioButtons( inputId="radAval", selected=character(0) )
        updateRadioButtons( inputId="radRequisicao", selected=character(0) )
        
        # desabilita o botão Enviar
        shinyjs::disable("butEnvioAval")
        
        # rola página de volta ao começo
        shinyjs::runjs("window.scrollTo(0, 0)")

    }

    #############################################################
    #                                                           #
    #        Declaração da FUNÇÃO "funcPausaSelecaoVazia"       #
    #                                                           #
    #############################################################
    
    funcPausaSelecaoVazia <- function(){
    
        showModal( modalDialog(
        tags$h4(
            tags$p("A marcação da Pausa de Edição somente terá efeito com"),
            tags$p("o Resumo Selecionado no Passo 1"),
            br(),
            tags$p("Por favor, refaça o procedimento nessa ordem!")
        ),
        title = "Informação",
        footer=tagList( modalButton( "Ok" ) )
        ))
        
        Sys.sleep(2)
        updateCheckboxInput( inputId="checkPausaEdParticip", value=FALSE )
    
    }
    
    #############################################################
    #                                                           #
    #        Declaração da FUNÇÃO "funcPausaSelecaoPreenchida"  #
    #                                                           #
    #############################################################
    
    funcPausaSelecaoPreenchida <- function(){
    
        showModal( modalDialog(
        tags$h4(
            tags$p("A marcação da Pausa de Edição está acionada no Passo 2"),
            tags$p("o Resumo já foi Selecionado previamente"),
            br(),
            tags$p("Se deseja reverter a ação, vá ao Passo 2 e desmarque a opção de Pausa!")
        ),
        title = "Informação",
        footer=tagList( modalButton( "Ok" ) )
        ))
    
    }
    
    #############################################################
    #                                                           #
    #        Declaração da FUNÇÃO "funcDownloadHandler"         #
    #                                                           #
    #############################################################
    
    funcDownloadHandler <- function(...){

        return( downloadHandler(

            filename = function() {

                numeroInsc <- try( get( "resumoSelecionado", env=envAval ), silent=TRUE )

                versao <- gsub( "^(versão )(.)$", "\\2", isolate( input$avalVersPdfRes ) )

                namePDF <- paste0( numeroInsc, "-vers-", versao, ".pdf" )

                return( namePDF )

            },

            content = function( file ) {

                numeroInsc <- try( get( "resumoSelecionado", env=envAval ), silent=TRUE )

                versao <- gsub( "^(versão )(.)$", "\\2", isolate( input$avalVersPdfRes ) )

                namePDF <- paste0( numeroInsc, "-vers-", versao )

                sql <- "SELECT pdfBlob FROM resumoTable WHERE nomeArq = ?"
                res <- dbGetQuery( conDB, sql, params=list( namePDF ) )

                writeBin( object = unlist( res,T,F ), con = file )

            },

            contentType = "application/pdf"

        ))
    
    }

