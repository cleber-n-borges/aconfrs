
    #############################################################
    #                                                           #
    #                Declaração das TIPS    / Labels            #
    #                                                           #
    #############################################################
    
    ##    UI Avaliador:  Passo 1 - Visualização das Informações sobre os Resumos e Seleção 

    labTable01 <- "Para selecionar uma linha da tabela 1, pressione o botão esquerdo do mouse sobre a mesma"
    output$labTable01 <- renderText({ fmTip( labTable01 ) })
    
    labTable02 <- "Use as caixas de filtragem de caracteres localizadas abaixo do título de cada coluna da tabela 1"
    output$labTable02 <- renderText({ fmTip( labTable02 ) })
    
    labTable03 <- "As colunas são ordenáveis. Basta pressionar o botão esquerdo no título da coluna"
    output$labTable03 <- renderText({ fmTip( labTable03 ) })
    
    ## UI Avaliador: Passo 2 - Pausar Edições do Participante
    
    labPausa01 <- "O Avaliador pausa a possibilidade das edições do Participante quando marcar a opção abaixo"
    output$labPausa01 <- renderText({ fmTip( labPausa01 ) })
    
    labPausa02 <- "A ação também é requisito para liberação do donwload do resumo (Passo 3) e do questionário da avaliação (Passo 4)"
    output$labPausa02 <- renderText({ fmTip( labPausa02 ) })    

    labPausa03 <- "Essa pausa assegura que a avaliação não ficará descompassada com possívies atualizações do Participante"
    output$labPausa03 <- renderText({ fmTip( labPausa03 ) })

    labPausa04 <- "Esta opção será automaticamente revertida quando o avaliador enviar os resultados da avaliação"
    output$labPausa04 <- renderText({ fmTip( labPausa04 ) })
    
    ## UI Avaliador: Passo 3 - Download do Resumo Específico Selecionado
    
    labDownload01 <- "Escolha a versão disponível desejada (quando já houver Resumo Selecionado na tabela 1 previamente e marcação de Pausa no Passo 2)"
    output$labDownload01 <- renderText({ fmTip( labDownload01 ) })
    
    labDownload02 <- "Em seguida, realize o download da mesma"
    output$labDownload02 <- renderText({ fmTip( labDownload02 ) })
    
    ## UI Avaliador: Passo 4 - Questionario
    
    labQuestionarioAval01 <- "O Resumo já deve ter sido selecionado previamente, no Passo 1"
    output$labQuestionarioAval01 <- renderText({ fmTip( labQuestionarioAval01 ) })
    
    labQuestionarioAval02 <- "A marcação da Pausa, no Passo 2, habilita os botões do quadro de Perguntas e Respostas "
    output$labQuestionarioAval02 <- renderText({ fmTip( labQuestionarioAval02 ) })    
    
    labQuestionarioAval03 <- 'Para responder as Questões Objetivas pressione "Itens Objetivos" e escolha dentre as opções mostradas'
    output$labQuestionarioAval03 <- renderText({ fmTip( labQuestionarioAval03 ) })
    
    labQuestionarioAval04 <- 'Para responder as Questões Dissertativas pressione "Itens Dissertativos" e escreva na caixa de Respostas'
    output$labQuestionarioAval04 <- renderText({ fmTip( labQuestionarioAval04 ) })

    labQuestionarioAval05 <- 'Cada ação deve ser finalizada quando se pressiona o botão: "Registrar resposta ao item"'
    output$labQuestionarioAval05 <- renderText({ fmTip( labQuestionarioAval05 ) })
    
    labQuestionarioAval06 <- 'Use os botões "Anterior" e "Próxima" para mudar a apresentação da pergunta corrente'
    output$labQuestionarioAval06 <- renderText({ fmTip( labQuestionarioAval06 ) })
    
    ## UI Avaliador: Passo 5 - Conclusão e Envio dos Resultados
    
    labConclusAval01 <- 'O botão: "Enviar Resultados da Avaliação" ficará habilitado somente depois de:'
    output$labConclusAval01 <- renderText({ fmTip( labConclusAval01 ) })
    
    labConclusAval02 <- "1) O Resumo ter sido Selecionado no Passo 1"
    output$labConclusAval02 <- renderText({ fmTip( labConclusAval02 ) })
    
    labConclusAval03 <- "2) O Participante ter sido pausado em suas edições no Passo 2"
    output$labConclusAval03 <- renderText({ fmTip( labConclusAval03 ) })
    
    labConclusAval04 <- '3) Os 2 itens da Conclusão: "Avaliação" e "Requisição" estiverem marcados no Passo 5'
    output$labConclusAval04 <- renderText({ fmTip( labConclusAval04 ) })

