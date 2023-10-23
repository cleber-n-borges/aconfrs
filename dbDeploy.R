
	##################################################
	#                                                #
	#     DB (database) para os Participantes        #
	#                                                #
	##################################################
	
    dbCreateTable( conDB, "mainTable", fields=c(
    
        # Informações Gerais:
        "numeroInsc"            = "TEXT", # numero da inscricao
        "dataInsc"              = "TEXT", # data da inscricao
        "senha"                 = "TEXT PRIMARY KEY", # senha
        
        # Informações sobre o Participante:
        "nome"                  = "TEXT", # nome completo
        "cpf"                   = "TEXT", # CPF
        "email"                 = "TEXT", # e-mail
        "modalInscric"          = "TEXT", # modalidade da inscricao
        "cracha"                = "TEXT", # nome para cracha
        "afiliaInstit"          = "TEXT", # afiliacao institucional
        
        # Informações sobre Atividades:
        "palestras"             = "TEXT", # palestras
        "minicursos"            = "TEXT", # minicursos
        "treinamentos"          = "TEXT", # treinamento
        
        # Informações sobre o Resumo:
        "modalParticip"         = "TEXT", # modalidade do Participante (com ou sem Resumo)
        "tituloTrab"            = "TEXT", # titulo
        "autoresTrab"           = "TEXT", # autores
        "palavChavTrab"         = "TEXT", # palavras-chaves
        "subAreaTrab"           = "TEXT", # subareas
        "textoTrab"             = "TEXT", # texto do resumo        
        "institAutTrab"         = "TEXT", # instituicoes dos autores
        "orgFomTrab"            = "TEXT", # orgaos de fomento
        "patrocTrab"            = "TEXT", # patrocinadores

        # Envio de Arquivos:
        "versaoComprovaPG"      = "TEXT", # versao do comprovante de PG
        "versaoSolicitCompPG"   = "TEXT", # versao solicitada
        "dataComprovaPG"        = "TEXT", # data de envio do comp.PG
        "situacaoAvalCompPG"    = "TEXT", # situacao da avaliacao do comp.PG
        
        "versaoResumo"          = "TEXT", # versao do resumo
        "versaoSolicitResumo"   = "TEXT", # versao solicitada do resumo
        "dataResumo"            = "TEXT", # data de envio do resumo
        "situacaoAvalResumo"    = "TEXT", # situacao da avaliacao do resumo
        
        # Submissão:
        "sugestoes"             = "TEXT", # sugestoes

        # Resultado da Avaliação:
        "dataAvaliacao"         = "TEXT", # data de envio dos resultados da avaliacao
        "respObjetiv"           = "TEXT", # respostas objetivas
        "respDissert"           = "TEXT", # respostas dissertativas
        "opResultAvalResumo"    = "TEXT", # resultado da avaliacao
        "opRequisicaoAvalResumo"= "TEXT", # requisicao de nova versao do resumo

        # Variaveis de Uso Geral:
        "travaEdicao"           = "TEXT", # travamento temporário de edição
        "mark"                  = "TEXT"  # mark
        
    ))

    dbCreateTable( conDB, "comprovaPgTable", fields=c(
    
        "pdfBlob"               = "BLOB", # conteudo BLOB do arquivo
        "nomeArq"               = "TEXT PRIMARY KEY"  # nome do arquivo
    
    ))
    
    dbCreateTable( conDB, "resumoTable", fields=c(
    
        "pdfBlob"               = "BLOB", # conteudo BLOB do arquivo
        "nomeArq"               = "TEXT PRIMARY KEY"  # nome do arquivo
    
    ))
	
	##################################################
	#                                                #
	#     DB (database) para os Avaliadores          #
	#                                                #
	##################################################
    
    dbCreateTable( conDB, "avaliadoresTable", fields=c(
    
        "nome"                  = "TEXT", # nome completo
        "cpf"                   = "TEXT", # CPF
        "senha"                 = "TEXT PRIMARY KEY", # senha
        "email"                 = "TEXT", # e-mail
        "cracha"                = "TEXT", # nome para cracha
        "afiliaInstit"          = "TEXT", # afiliacao institucional
        "subAreaAval"           = "TEXT", # sub area do avaliador
        "palavChavAreaAval"     = "TEXT"  # palavras-chaves
        
    ))
	
    ##################################################
	#                                                #
	#     DB (database) para a Organização           #
	#                                                #
	##################################################

    dbCreateTable( conDB, "organizacaoTable", fields=c(
    
        "nome"                  = "TEXT", # nome completo
        "cpf"                   = "TEXT", # CPF
        "senha"                 = "TEXT PRIMARY KEY", # senha
        "email"                 = "TEXT", # e-mail
        "cracha"                = "TEXT", # nome para cracha
        "afiliaInstit"          = "TEXT", # afiliacao institucional
        "funcaoOrganiz"         = "TEXT", # funcao desempenhada na Organização
		"funcaoSoftCMS"         = "TEXT"  # funcao desempenhada no Software CMS
        
    ))
    
