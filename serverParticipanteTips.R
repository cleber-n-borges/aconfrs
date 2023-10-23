
    #############################################################
    #                                                           #
    #                Declaração das TIPS    / Labels            #
    #                                                           #
    #############################################################
    
    ##    UI Participante:  Fazer Inscrição e Recuperar Informação Cadastrada
    
    labPrimInsc01 <- "Use essa opção para realizar sua inscrição"
    output$labPrimInsc01 <- renderText({ fmTip( labPrimInsc01 ) })
    
    labPrimInsc02 <- 'Sendo sua primeira ação, utilize o botão: "Inscrever-se"'
    output$labPrimInsc02 <- renderText({ fmTip( labPrimInsc02 ) })    
    
    labRecupInfo01 <- "Para participantes já previamente inscritos, use seu e-mail e senha para conectar-se ao sistema"
    output$labRecupInfo01 <- renderText({ fmTip( labRecupInfo01 ) })
    
    labRecupInfo02 <- "Opção para Acompanhar e Reeditar informações pertinentes ao Evento"
    output$labRecupInfo02 <- renderText({ fmTip( labRecupInfo02 ) })
    
    labReenvioSenha01 <- "Opção para recuperação da senha do sistema"
    output$labReenvioSenha01 <- renderText({ fmTip( labReenvioSenha01 ) })
    
    labReenvioSenha02 <- "Necessário fornecer o e-mail cadastrado previamente"
    output$labReenvioSenha02 <- renderText({ fmTip( labReenvioSenha02 ) })
    
    labReenvioSenha03 <- 'Utilize o botão: "Reenviar Senha do Sistema"'
    output$labReenvioSenha03 <- renderText({ fmTip( labReenvioSenha03 ) })    
    
    ##    UI Participante:  Passo 1 - Informações sobre o Participante     
    
    labRecupInfo03 <- 'Utilize o botão: "Conectar-se ao Sistema"'
    output$labRecupInfo03 <- renderText({ fmTip( labRecupInfo03 ) })
    
    labNome <- "Nome: Preenchimento obrigatório (máx.: 200 caracteres)"
    output$labNome <- renderText({ fmTip( labNome ) })
    
    labCPF <- "CPF: Preenchimento obrigatório (11 números - Formato: xxx.xxx.xxx-xx)"
    output$labCPF <- renderText({ fmTip( labCPF ) })
    
    labMail <- "e-mail: Preenchimento obrigatório (máx.: 200 caracteres)"
    output$labMail <- renderText({ fmTip( labMail ) })
    
    labModInscricao <- "Modalidade da Inscrição: Marcação obrigatória"
    output$labModInscricao <- renderText({ fmTip( labModInscricao ) })
    
    labCracha <- "Crachá: Preenchimento opcional (máx.: 200 caracteres)"
    output$labCracha <- renderText({ fmTip( labCracha ) })
    
    labInstituicao <- "Instituição: Preenchimento opcional (máx.: 200 caracteres)"
    output$labInstituicao <- renderText({ fmTip( labInstituicao ) })
    
    labPalestras01 <- "Palestras: Preenchimento opcional. Pressione o botão esquerdo do mouse sobre a caixa de diálogo para escolher dentre as opções"
    output$labPalestras01 <- renderText({ fmTip( labPalestras01 ) })
    
    labPalestras02 <- "Palestras: É possível a participação em 2 palestras"
    output$labPalestras02 <- renderText({ fmTip( labPalestras02 ) })
    
    labPalestras03 <- "Palestras: Observe os horários dos mesmos na programação e evite conflito"
    output$labPalestras03 <- renderText({ fmTip( labPalestras03 ) })
    
    labMinicursos01 <- "Minicursos: Preenchimento opcional. Pressione o botão esquerdo do mouse sobre a caixa de diálogo para escolher dentre as opções"
    output$labMinicursos01 <- renderText({ fmTip( labMinicursos01 ) })
    
    labMinicursos02 <- "Minicursos: É possível a participação em 2 minicursos"
    output$labMinicursos02 <- renderText({ fmTip( labMinicursos02 ) })
    
    labMinicursos03 <- "Minicurso: Observe os horários dos mesmos na programação e evite conflito"
    output$labMinicursos03 <- renderText({ fmTip( labMinicursos03 ) })
    
    labTreinamentos01 <- "Treinamento:"
    output$labTreinamentos01 <- renderText({ fmTip( labTreinamentos01 ) })
    
    labTreinamentos02 <- "Treinamento:"
    output$labTreinamentos02 <- renderText({ fmTip( labTreinamentos02 ) })

    labTreinamentos03 <- "Treinamento:"
    output$labTreinamentos03 <- renderText({ fmTip( labTreinamentos03 ) })
    
    labComprovaPG01 <- "PDF do Comprovante: Obrigatório para a efetivação da inscrição. Atente-se aos prazos!"
    output$labComprovaPG01 <- renderText({ fmTip( labComprovaPG01 ) })

    labComprovaPG02 <- paste0("Tamanho máximo permitido: ", format( tamanhoArquivoPermitido, units='auto'))
    output$labComprovaPG02 <- renderText({ fmTip( labComprovaPG02 ) })

    labComprovaPG03 <- "Use o botão 'Enviar Arquivo'"
    output$labComprovaPG03 <- renderText({ fmTip( labComprovaPG03 ) })
    
    labVisComprovaPG <- "Visualização do Comprovante destina-se apenas para simples checagem do que foi enviado"
    output$labVisComprovaPG <- renderText({ fmTip( labVisComprovaPG ) })
    
    ##    UI Participante:  Passo 3 - Informações sobre o Resumo 

    labModalParticip01 <- "Marque a opção somente se deseja participar do evento com submissão de resumo"
    output$labModalParticip01 <- renderText({ fmTip( labModalParticip01 ) })
    
    labModalParticip02 <- "Deixe a marcação acima permamente para que as informações declaradas sejam consideradas"
    output$labModalParticip02 <- renderText({ fmTip( labModalParticip02 ) })
    
    labModalParticip03 <- "-> Marcação obrigatória para o quem deseja submeter o Arquivo PDF do Resumo (Passo 4)"
    output$labModalParticip03 <- renderText({ fmTip( labModalParticip03 ) })
    
    ###################################################################
    
    labTituloTrab <- "Título: Preenchimento obrigatório (máx.: 200 caracteres)"
    output$labTituloTrab <- renderText({ fmTip( labTituloTrab ) })

    labAutoresTrab <- "Autores: Preenchimento obrigatório (máx.: 200 caracteres)"
    output$labAutoresTrab <- renderText({ fmTip( labAutoresTrab ) })
    
    labPalavChavTrab <- "Palavras-Chave: Preenchimento obrigatório (máx.: 200 caracteres)"
    output$labPalavChavTrab <- renderText({ fmTip( labPalavChavTrab ) })

    labSubAreaTrab01 <- "Subárea: Marcação obrigatório"
    output$labSubAreaTrab01 <- renderText({ fmTip( labSubAreaTrab01 ) })
    
    labSubAreaTrab02 <- "Subárea: Marque a opção de Subárea a qual seu trabalho tem maior aderência"
    output$labSubAreaTrab02 <- renderText({ fmTip( labSubAreaTrab02 ) })
    
    labInstitAutTrab01 <- "Instituições: Preenchimento opcional (máx.: 200 caracteres)"
    output$labInstitAutTrab01 <- renderText({ fmTip( labInstitAutTrab01 ) })

    labInstitAutTrab02 <- "Instituições: Declare uma por autor mesmo que haja repetição"
    output$labInstitAutTrab02 <- renderText({ fmTip( labInstitAutTrab02 ) })    
    
    labOrgFomTrab01 <- "Orgão de fomento: Preenchimento opcional (máx.: 200 caracteres)"
    output$labOrgFomTrab01 <- renderText({ fmTip( labOrgFomTrab01 ) })

    labOrgFomTrab02 <- "Orgão de fomento: Indique quais orgãos se pertinente"
    output$labOrgFomTrab02 <- renderText({ fmTip( labOrgFomTrab02 ) })

    labPatrocTrab01 <- "Patrocinadores: Preenchimento opcional (máx.: 200 caracteres)"
    output$labPatrocTrab01 <- renderText({ fmTip( labPatrocTrab01 ) })

    labPatrocTrab02 <- "Patrocinadores: Indique quais patrocinadores se pertinente"
    output$labPatrocTrab02 <- renderText({ fmTip( labPatrocTrab02 ) })

    labTextoTrab01 <- "Texto: Preenchimento obrigatório (máx.: 2000 caracteres)"
    output$labTextoTrab01 <- renderText({ fmTip( labTextoTrab01 ) })
    
    labTextoTrab02 <- "Texto: Versão Textual do Resumo (somente texto sem formatação)"
    output$labTextoTrab02 <- renderText({ fmTip( labTextoTrab02 ) })
    
    valueIniTextoTrab <- "Área destinada para a informação textual do trabalho. Coloque as partes sugeridas como:\n\n[Introdução]\n\n[Metodologia]\n\n[Resultados]\n\n[Conclusão]\n\n[Referências]"
    updateTextAreaInput( inputId="textoTrab", placeholder=valueIniTextoTrab ) 
    
    labPdfResumoTrab01 <- "PDF do Resumo: Obrigatório para participação com submissão de resumo. Atente-se aos prazos!"
    output$labPdfResumoTrab01 <- renderText({ fmTip( labPdfResumoTrab01 ) })

    labPdfResumoTrab02 <- paste0("Tamanho máximo permitido: ", format( tamanhoArquivoPermitido, units='auto'))
    output$labPdfResumoTrab02 <- renderText({ fmTip( labPdfResumoTrab02 ) })

    labPdfResumoTrab03 <- paste0( "01 Página do Tipo ", paginaPropriedade$tipo )
    output$labPdfResumoTrab03 <- renderText({ fmTip( labPdfResumoTrab03 ) })
    
    labPdfResumoTrab04 <- "Use essa mesma opção para as atualizações se o Avaliador solicitar Novas Versões"
    output$labPdfResumoTrab04 <- renderText({ fmTip( labPdfResumoTrab04 ) })

    labVisPdfResumoTrab <- "Visualização das Versões do Resumo destina-se apenas para simples checagem do que foi enviado"
    output$labVisPdfResumoTrab <- renderText({ fmTip( labVisPdfResumoTrab ) })
    
    ############################################################################
    
    ##    UI Participante:  Passo 4 - Envio de Arquivos

    labEnvioCompPG01 <- "Habilita o espaço de Escolha do Arquivo PDF do Comprovante de Pagamento"
    output$labEnvioCompPG01 <- renderText({ fmTip( labEnvioCompPG01 ) })
    
    labEnvioCompPG02 <- "Habilita a visualização de arquivos enviados"
    output$labEnvioCompPG02 <- renderText({ fmTip( labEnvioCompPG02 ) })
    
    labEnvioCompPG03 <- 'O envio do arquivo é feito pelo Botão: "Enviar Informações (no Passo 5)"'
    output$labEnvioCompPG03 <- renderText({ fmTip( labEnvioCompPG03 ) })

    labEnvioResumo01 <- '-> Dependendente da opção: "Participação com Submissão de Resumo" (Passo 3)'
    output$labEnvioResumo01 <- renderText({ fmTip( labEnvioResumo01 ) })

    labEnvioResumo02 <- "Habilita o espaço de escolha do Arquivo PDF do Resumo"
    output$labEnvioResumo02 <- renderText({ fmTip( labEnvioResumo02 ) })
    
    labEnvioResumo03 <- "Habilita a visualização de arquivos enviados"
    output$labEnvioResumo03 <- renderText({ fmTip( labEnvioResumo03 ) })
    
    labEnvioResumo04 <- 'O envio do arquivo é feito pelo Botão: "Enviar Informações (no Passo 5)"'
    output$labEnvioResumo04 <- renderText({ fmTip( labEnvioResumo04 ) })

    # Exibe os Termos de Responsabilidade
    output$termos <- renderText({ 
        HTML(
            "<pre> As informações declaradas poderão ser utilizadas pela Comissão Organizadora.\n",
            "Informações pessoais não serão utilizadas. Informações gerais poderão ser mencionadas.\n",
            "Informações específicias, se necessárias, deverão ser solicitadas explicitamente para os autores.</pre>"
        )

    })
    
    labSugestao01 <- "Sugestão: Preenchimento opcional (máx.: 2000 caracteres)"
    output$labSugestao01 <- renderText({ fmTip( labSugestao01 ) })
    
    labSugestao02 <- "Caso queira enviar sugestões para a comissão do evento, marque a opção e escreva suas observações"
    output$labSugestao02 <- renderText({ fmTip( labSugestao02 ) })

    labConcord01 <- "Concordância: Marcação obrigatória (após preenchimento de todos campos requeridos)"
    output$labConcord01 <- renderText({ fmTip( labConcord01 ) })
    
    labConcord02 <- "Concordância: Declaração de ter lido, compreendido e aceitado os termos de responsabilidade declarados para realização do evento."
    output$labConcord02 <- renderText({ fmTip( labConcord02 ) })

    labButSubmis01 <- 'Submissão: O botão "Enviar Informações" terá plena funcionalidade quando houver preenchimento dos itens obrigatórios'
    output$labButSubmis01 <- renderText({ fmTip( labButSubmis01 ) })
    
    labButSubmis02 <- "Submissão: Finalizado todo procedimento, será enviado o Número de Inscrição pelo e-mail declarado"
    output$labButSubmis02 <- renderText({ fmTip( labButSubmis02 ) })
    
    labButSubmis03 <- "Submissão: Utilize essa interface se houver necessidade de edições, para atualização e acompanhamento da avaliação do resumo"
    output$labButSubmis03 <- renderText({ fmTip( labButSubmis03 ) })
    
    labQuestionario01 <- "Avaliação: Acompanhamento dos Resultados fornecidos pelo Avaliador"
    output$labQuestionario01 <- renderText({ fmTip ( labQuestionario01 ) })

    labQuestionario02 <- "Avaliação: Direcionado aos Participantes com Submissão de Resumo"
    output$labQuestionario02 <- renderText({ fmTip ( labQuestionario02 ) })    
    
    labQuestionario03 <- "Avaliação: Edição somente pelo Avaliador. Visualização pelo Participante"
    output$labQuestionario03 <- renderText({ fmTip ( labQuestionario03 ) })

    labDesistencia01 <- "Desistência: Utilizar somente para caso desistir definitivamente de participar do evento"
    output$labDesistencia01 <- renderText({ fmTip ( labDesistencia01 ) })

    labDesistencia02 <- "Desistência: Não haverá possibilidade de recuperação das informações após desistência"
    output$labDesistencia02 <- renderText({ fmTip ( labDesistencia02 ) })

    labDesistencia03 <- 'Desistência: Para efetuar edições, use o Botão de "Submissão"!'
    output$labDesistencia03 <- renderText({ fmTip ( labDesistencia03 ) })
