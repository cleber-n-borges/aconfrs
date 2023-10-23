
    #############################################################
    #                                                           #
    #            Server para sessão de "Avaliador"              #
    #                                                           #
    #############################################################
    
    connTextAvalUI <- textConnection( varString_uiAvaliador )
    # Carrega a interface de "Avaliador"
    insertUI(
    
        selector = "#uiRequisitada",
        where = "afterEnd",
        ui = source( connTextAvalUI, local=TRUE )[[1]],
        immediate = TRUE
    
    )
    close( connTextAvalUI ); rm( connTextAvalUI )
    
    # Carrega as 'TIPS' da Interface do "Avaliador"
    connTextAvalTip <- textConnection( varString_serverAvaliadorTips )
    source( connTextAvalTip, local=TRUE )
    close( connTextAvalTip ); rm( connTextAvalTip )

    # Carrega as diversas funções do ambiente do "Avaliador"
    connTextAvalFun <- textConnection( varString_serverAvaliadorFun )
    source( connTextAvalFun, local=TRUE )
    close( connTextAvalFun ); rm( connTextAvalFun )
    
    #######################
    #    Config Iniciais  #
    #######################
    
    # ambiente para guardar as variáveis ao Avaliador
    envAval <- new.env( parent=globalenv() )
    
    # Var para conter o: "Resumo Selecionado" para a avaliação corrente
    assign( "resumoSelecionado", "", env=envAval )
    # mensagem (a ser exibida na tela) de selecao de resumo
    assign( "msgSel", "", env=envAval )

    # Msg/label para quando ainda não houver Resumo Selecionado na Tabela 1 (para Avaliadores)
    msgSemResumo <- "Resumo Selecionado para Avaliação: Ainda não há resumo selecionado!"
    msgSemResumo <- paste0( "<p class='text-danger'><b><font size='5'>&rarr;&nbsp;</font>", msgSemResumo, "</b></p>" )
    
    # JSON: Funcionalidades da datatable.js em portugues
    dtBR <- jsonlite::fromJSON('./data/datatableJS-pt-BR.json')
    
    # avisos sobre a ação da "Pausa de Edição do Participante"
    # ajuda o avaliador a não ficar perdido sobre o que esse panel faz...
    output$avisoPausa  <- renderText({"Edição do Participante: Liberado"})
    output$avisoPasso1 <- renderText({"Passo 1 - Seleção do Resumo: Liberado"})
    output$avisoPasso2 <- renderText({"Passo 3 - Download do Resumo: Pausado"})
    output$avisoPasso3 <- renderText({"Passo 4 - Questionário: Pausado"})
    
    # indices para as questões
    envAval$idxRespObj <- 1
    envAval$idxRespDis <- 1

    # Guarda a quantidade de questões
    envAval$maxObj <- nrow( opQuestoesObjetivas )
    envAval$maxDis <- nrow( opQuestoesDissertativas )
    
    output$regItemCurrent <- renderText({ "Informa sobre o Registro de Item Corrente... Aguardando..." })
    
    #output$infoObjResp <- renderText({ paste0("0 Questões Respondidas (de ", envAval$maxObj," Questões)") })
    #output$infoDisResp <- renderText({ paste0("0 Questões Respondidas (de ", envAval$maxDis," Questões)") })
    
    output$infoObjResp <- renderText({"Balanço de Questões: Respondidas e Não Respondidas"})
    output$infoDisResp <- renderText({"Balanço de Questões: Respondidas e Não Respondidas"})    

	output$tableViewRespObj <- renderTable({ "Discriminação do que foi respondido" }, colnames=F )
	output$tableViewRespDis <- renderTable({ "Discriminação do que foi respondido" }, colnames=F )

    # Começa respondendo questões dissertativas
    envAval$respondendo <- "dissertat"
    
    # Cria objetos de validação...
    ivA01 <- InputValidator$new()
    ivA01$add_rule( "respQuestDissert",  sv_required( message = " " ))
    ivA01$add_rule( "respQuestObjetiv",  sv_required( message = " " ))
    ivA01$add_rule( "radAval",           sv_required( message = " " ))
    ivA01$add_rule( "radRequisicao",     sv_required( message = " " ))
    ivA01$enable() 
    
    #############################
    #        Config Paineis     #
    #############################
    
    # Desabilita espaços que são apenas visualizão de informações
    # Usuário não deve editar em nenhum momento
    shinyjs::disable( "showQuestion" )
    shinyjs::disable( "showRegistro" )
    # Barra do Nome e Status devem estar desabilitada sempre
    shinyjs::disable( "nomeAvaliador" )
    shinyjs::disable( "statusAvaliador" )
    shinyjs::disable( "statusTravaEdResumo" )
    
    # Começa com download de PDF desabilitado
    shinyjs::disable( "avalVersPdfRes" )
    shinyjs::disable( "downPDFResAval" )
    
    # Começa com espaço das Perg/Resp desabilitadas
    shinyjs::disable( "itObjetivos" )
    shinyjs::disable( "itDissertat" )
    shinyjs::disable( "respQuestDissert" )
    shinyjs::disable( "respQuestObjetiv" )
    shinyjs::disable( "regResposta" )
    shinyjs::disable( "pergAnterior" )
    shinyjs::disable( "pergProxima" )

    # Começa com conclusão e requisição desabilitados
    shinyjs::disable( "radAval" )
    shinyjs::disable( "radRequisicao" )
    
    # Começa com botão de envio desabilitado
    shinyjs::disable( "butEnvioAval" )

    #########################
    #        Fim: Config    #
    #########################
    
    #############################################################
    #                                                           #
    #        Inicio da Lógica de Funcionamento do Ambiente      #
    #                                                           #
    #############################################################

    # Chama a função: "getDataDB2table" para Criação da Tabela 1
    assign( "dataShow", getDataDB2table(), env=envAval )
    
    # Manuseio de Download de Resumos
    output$downPDFResAval <- funcDownloadHandler()

    #############################################################
    #                                                           #
    #            Inicio dos "ObserveEvent"                      #
    #                                                           #
    #############################################################
    
    # Monitora o "click" nas linhas da Tabela 1
    observeEvent( input$table_rows_selected, {
    
        funcClickLinhaTabela()

    })

    # Ação de Atualização sobre Versões de Resumo para Download
    observeEvent( input$table_rows_selected, priority = -100, {
    
        # Executa somente de Pausa é FALSE
        req( !input$checkPausaEdParticip )
        
        # Pega localmente o Numero da Inscrição do Resumo Selecionado
        numInsc <- get( "resumoSelecionado", env=envAval )
    
        # Resgata a Tabela 1
        dataShow <- get( "dataShow", env=envAval )
        
        # Encontra Quais Versões há do Resumo Selecionado
        versao <- dataShow[ dataShow["numeroInsc"]==numInsc, ]$versaoResumo
        
        # Transforma em numerico
        versao <- as.numeric( versao )

        # Transforma numa string mais "visualmente informativa"
        escolhasPDFResumo <- paste0( "versão ", 1:versao )
        
        # Atualiza a Interface para mostrar na Tela
        updateSelectInput( inputId="avalVersPdfRes", choices=escolhasPDFResumo )
    
    })
    
    # Monitora o Botão que impõe Pausa de Edição ao Participante
    observeEvent( input$checkPausaEdParticip, {
    
        funcMonitoraBotaoPausaParticip()
    
    })

    # ações do botão: "Itens Objetivos"
    observeEvent( ignoreInit = TRUE,
        list( input$itObjetivos, input$table_rows_selected ), {
    
        funcBotaoItensObjetivos()

    })

    # ações do botão: "Itens Dissertativos"
    observeEvent( ignoreInit = TRUE,
        list( input$itDissertat, input$table_rows_selected ), {

        funcBotaoItensDissertativos()

    })

    # ações da Area de Texto    
    observeEvent( input$respQuestDissert, {
    
        ncharacter <- nchar( input$respQuestDissert )
        output$ncaract <- renderText({ fmTip( paste0( "Número de caracteres: ", ncharacter, " - Limite Máximo: 1000" ) ) })
    
    })
    
    # ações do botão: "Anterior"
    observeEvent( input$pergAnterior, {
    
        funcBotaoAnterior()
    
    })

    # ações do botão: "Próxima"    
    observeEvent( input$pergProxima, {
    
        funcBotaoProxima()
        
    })

    # ações do botão: "Registrar resposta ao item"
    observeEvent( input$regResposta, {
    
        funcBotaoRegistrarResposta()
        
    })

    # Ação do botão "Enviar Avaliação"
    observeEvent( input$butEnvioAval, {
    
        funcBotaoEnvioInfo()

    })

    # Monitoramento de Requisitos para Habilitar o Envio da Avaliação
    observeEvent( ignoreInit = TRUE,
        list( input$checkPausaEdParticip, input$table_rows_selected,
        input$radAval, input$radRequisicao ), {
        
        req( input$radAval )
        req( input$radRequisicao )
        req( input$checkPausaEdParticip )
        
        selecao <- get( "resumoSelecionado", env=envAval )

        req( selecao )
        
        shinyjs::enable( "butEnvioAval" )
    
    })

    #############################################################
    #                                                           #
    #    6 Monitores de LINKS de Paineis pelos "ObserveEvent"   #
    #                                                           #
    #############################################################    
    
    # ações do link: "Mostrar | Ocultar"
    observeEvent( input$linkHSDetalhesRes, {
    
        selecao <- get( "resumoSelecionado", env=envAval )
        req( as.numeric( selecao ) )
        
        maisDetalhes()
    
        r <- input$linkHSDetalhesRes
        r <- ( as.numeric( r ) %% 2 ) == 1
        
        if( r ){
        
            updateActionLink( inputId="linkHSDetalhesRes", label="- Menos Detalhes do Resumo" )
        
        } else {
        
            updateActionLink( inputId="linkHSDetalhesRes", label="+ Mais Detalhes do Resumo" )    
        
        }
        
        shinyjs::toggleElement("panelDetalhesRes")

    })
    
    # ações do link: "Mostrar | Ocultar"
    observeEvent( input$linkHSPausaEdParticip, {
        shinyjs::toggleElement("panelPausaEdParticipSub01")
    })

    # ações do link: "Mostrar | Ocultar"
    observeEvent( input$linkHSselecDownRes, {
        shinyjs::toggleElement("panelSelecDownResSub01")
    })
    
    # ações do link: "Mostrar | Ocultar"
    observeEvent( input$linkHSrespQuest, {
        #req( input$checkPausaEdParticip )
        shinyjs::toggleElement("panelRespQuestionarioSub01")
    })
    
    # ações do link: "Mostrar | Ocultar"
    observeEvent( input$linkHSconclusao, {
        shinyjs::toggleElement("panelConclusaoSub01")
    })
    
    # ações do link: "Mostrar | Ocultar"
    observeEvent( input$linkHStabRes, {
        shinyjs::toggleElement("panelTabVisInfoResSub01")
    })

