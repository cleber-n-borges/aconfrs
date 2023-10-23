
    #############################################################
    #                                                           #
    #            Server para sessão de "Atribuidor"             #
    #                                                           #
    #############################################################
    
    connTextAtribUI <- textConnection( varString_uiAtrib )
    # Carrega a interface de "Atribuidor"
    insertUI(
    
        selector = "#uiRequisitada",
        where = "afterEnd",
        ui = source( connTextAtribUI, local=TRUE )[[1]],
        immediate = TRUE
    
    )
    close( connTextAtribUI ); rm( connTextAtribUI )

    # Carrega as 'TIPS' da Interface do "Atribuidor"
    connTextAtribTip <- textConnection( varString_serverAtribuidorTips )
    source( connTextAtribTip, local=TRUE )
    close( connTextAtribTip ); rm( connTextAtribTip )

    # # Carrega as diversas funções do ambiente do "Atribuidor"
    # connTextAtribFun <- textConnection( varString_serverAtribuidorFun )
    # source( connTextAtribFun, local=TRUE )
    # close( connTextAtribFun ); rm( connTextAtribFun )

    #######################
    #    Config Iniciais  #
    #######################
    
    # ambiente para guardar as variáveis ao Atribuidor
    envAtrib <- new.env( parent=globalenv() )
    
    # Desabilita espaços que são apenas visualizão de informações
    # Usuário não deve editar em nenhum momento
    shinyjs::disable( "tituloCand" )
    shinyjs::disable( "autoresCand" )
    shinyjs::disable( "palavChaveCand" )

    # Barra do Nome e Status devem estar desabilitada sempre
    shinyjs::disable( "nomeAtribuidor" )
    shinyjs::disable( "statusAtribuidor" )
    
    # Opção desabilitada para Atribuidor Nível 1
    shinyjs::disable( "areaDeclaradaCand" )
    # Habilitar para Atribuidor Nível 2
    

    #########################
    #        Fim: Config        #
    #########################

    #############################################################
    #                                                           #
    #        Inicio da Lógica de Funcionamento do Ambiente      #
    #                                                           #
    #############################################################
    
    funcItLab <- function( lab ) HTML("<em>", lab, "</em>" )

    labDetalheParticipAtrib <- "Instituição/Departamento; Texto"
    output$detalhesParticipAtrib <- renderText({ funcItLab( labDetalheParticipAtrib ) })
    
    labDetalheAvaliadorAtrib <- "Instituição/Departamento; Palavras-Chave Fornecidas pelo Avaliador"
    output$detalhesAvaliadorAtrib <- renderText({ funcItLab( labDetalheAvaliadorAtrib ) })
    
    #############################################################
    #                                                           #
    #            Inicio dos "ObserveEvent"                      #
    #                                                           #
    #############################################################
    


    #############################################################
    #                                                           #
    #    4 Monitores de LINKS de Paineis pelos "ObserveEvent"   #
    #                                                           #
    #############################################################
    
    # ações do link: "Mostrar | Ocultar"
    observeEvent( input$linkHSAtribuicaoResumo, {
    
        shinyjs::toggle( "panelAtribuicaoResumoSub01" )
        
    })
    
    # ações do link: "Mostrar | Ocultar"
    observeEvent( input$linkHSDadosAtribResumo, {
    
        shinyjs::toggle( "panelDadosAtribResumoSub01"  )
    
    })

    # ações do link: "Mostrar | Ocultar"
    observeEvent( input$linkHSdetalhesResAtrib, {

        shinyjs::toggle( "detalhes-Particip-Avaliador" )
           
    })

    # ações do link: "Mostrar | Ocultar"   
    observeEvent( input$linkHSOpcaoAvaliad, {

        shinyjs::toggle( "panelOpcaoAvaliadSub01"  )
           
    })

    # ações do link: "Mostrar | Ocultar"
    observeEvent( input$linkHSAcaoAtrib, {

        shinyjs::toggle( "panelAcaoAtribSub01" )
           
    })

    ############################################
    # botão: butHSadversa
    observeEvent( input$butHSadversa, {

        shinyjs::toggle( "panelAreaAdversa" )
           
    })
    ############################################
    


