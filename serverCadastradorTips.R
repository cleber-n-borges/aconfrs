
    #############################################################
    #                                                           #
    #                Declaração das TIPS    / Labels            #
    #                                                           #
    #############################################################
    
    ##    UI Cadastrador: Passo 1A - Informações Básicas do Integrante 

    labInfoCadInteg01 <- "Cadastramento: Permite cadastrar participações diversas no evento tais como:"
    output$labInfoCadInteg01 <- renderText({ fmTip( labInfoCadInteg01 ) })

    labInfoCadInteg02 <- "&rarr; Membros de Comissão, Avaliadores, Convidados e Outros Casos"
    output$labInfoCadInteg02 <- renderText({ fmTip( labInfoCadInteg02 ) })

    labInfoCadInteg03 <- "Seleção de Integrante: Utilize os Passos 3 e 4 para seleção"
    output$labInfoCadInteg03 <- renderText({ fmTip( labInfoCadInteg03 ) })
    
    labInfoCadInteg04 <- "Após seleção, Passo 1 também permite exclusões do selecionado"
    output$labInfoCadInteg04 <- renderText({ fmTip( labInfoCadInteg04 ) })

    labNomeInteg <- "Nome: Preenchimento obrigatório (máx.: 200 caracteres)"
    output$labNomeInteg <- renderText({ fmTip( labNomeInteg ) })

    labCpfInteg <- "CPF: Preenchimento obrigatório (11 números - Formato: xxx.xxx.xxx-xx)"
    output$labCpfInteg <- renderText({ fmTip( labCpfInteg ) })
    
    labMailInteg <- "e-mail: Preenchimento obrigatório (máx.: 200 caracteres)"
    output$labMailInteg <- renderText({ fmTip( labMailInteg ) })
    
    labCrachaInteg <- "Crachá: Preenchimento opcional (máx.: 200 caracteres)"
    output$labCrachaInteg <- renderText({ fmTip( labCrachaInteg ) })
    
    labInstitInteg <- "Instituição: Preenchimento opcional (máx.: 200 caracteres)"
    output$labInstitInteg <- renderText({ fmTip( labInstitInteg ) })
    
    ##    UI Cadastrador: Passo 2A - Particularidades do Integrante para o Evento

    labCadParticular01 <- "Define o cadastro das funções do Integrante"
    output$labCadParticular01 <- renderText({ fmTip( labCadParticular01 ) })

    labCadParticular02 <- "As opções das funções são independentes e podem ser cumulativas"
    output$labCadParticular02 <- renderText({ fmTip( labCadParticular02 ) })

    labCadParticular03 <- "Define em qual base de dados o Integrante deve constar"
    output$labCadParticular03 <- renderText({ fmTip( labCadParticular03 ) })
    
    #labCadParticular04 <- ""
    #output$labCadParticular04 <- renderText({ fmTip( labCadParticular04 ) })
    
    labFuncEvento01 <- "Declara uma função para o Integrante na Organização do Evento"
    output$labFuncEvento01 <- renderText({ fmTip( labFuncEvento01 ) })
    
    labFuncEvento02 <- "O Integrante constará na Base de Dados da Organização do Evento"
    output$labFuncEvento02 <- renderText({ fmTip( labFuncEvento02 ) })

    labAvaliadorEvento01 <- "Declara que o Integrante será um Avaliador de Resumos no Evento"
    output$labAvaliadorEvento01 <- renderText({ fmTip( labAvaliadorEvento01 ) })

    labAvaliadorEvento02 <- "O Integrante constará na Base de Dados dos Avaliadores"
    output$labAvaliadorEvento02 <- renderText({ fmTip( labAvaliadorEvento02 ) })

    labFunSoftInteg01 <- "Declara que o Integrante terá atribuições no software CMS"
    output$labFunSoftInteg01 <- renderText({ fmTip( labFunSoftInteg01 ) })
    
    labFunSoftInteg02 <- "Essas funções não constam em Base de Dados"
    output$labFunSoftInteg02 <- renderText({ fmTip( labFunSoftInteg02 ) })
    
    labFunSoftInteg03 <- "Administrador tem prerrogativa de cadastrar funções diversas na Organização"
    output$labFunSoftInteg03 <- renderText({ fmTip( labFunSoftInteg03 ) })

    labDataHoraInscInteg <- "Data e hora da Última Submissão: (Geração do Número de Inscrição)"
    output$labDataHoraInscInteg <- renderText({ fmTip( labDataHoraInscInteg ) })

    labModInscInteg01 <- "Define um Número de Inscrição ao Integrante"
    output$labModInscInteg01 <- renderText({ fmTip( labModInscInteg01 ) })

    labModInscInteg02 <- "Permite ao Integrante acessar a interface de Participante e editá-la"
    output$labModInscInteg02 <- renderText({ fmTip( labModInscInteg02 ) })

    labModInscInteg03 <- "O Integrante constará na Base de Dados dos Participantes"
    output$labModInscInteg03 <- renderText({ fmTip( labModInscInteg03 ) })

    labButCadInfo01 <- 'Cadastrar: O botão "Cadastrar Informações" terá plena funcionalidade quando houver ao menos 01 atributo declarado'
    output$labButCadInfo01 <- renderText({ fmTip( labButCadInfo01 ) })

    labButCadInfo02 <- 'Cadastrar: As informações constarão nos devidos Bancos de Dados'
    output$labButCadInfo02 <- renderText({ fmTip( labButCadInfo02 ) })

    ##    UI Cadastrador: Passo 1B - Particularidades do Integrante para o Evento

    labTableAval01 <- 'X X X'
    output$labTableAval01 <- renderText({ fmTip( labTableAval01 ) })

    labTableAval02 <- 'Y Y Y'
    output$labTableAval02 <- renderText({ fmTip( labTableAval02 ) })

    labTableAval03 <- 'W W W'
    output$labTableAval03 <- renderText({ fmTip( labTableAval03 ) })




















