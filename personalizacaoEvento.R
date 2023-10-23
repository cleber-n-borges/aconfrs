    
    #####################################################
    #                                                   #
    #                    Personalizações                #
    #                                                   #
    #####################################################
    
    opQuestoesObjetivas <- jsonlite::fromJSON( './data/opQuestoesObjetivas.json' )
	
	opQuestoesDissertativas <- jsonlite::fromJSON( './data/opQuestoesDissertativas.json' )
    
	opInscricao <- jsonlite::fromJSON( './data/opInscricao.json' )

    opPalestras <- jsonlite::fromJSON( './data/opPalestras.json' )

    opMinicursos <- jsonlite::fromJSON( './data/opMinicursos.json' )
	
    opTreinamentos <- jsonlite::fromJSON( './data/opTreinamentos.json' )
	
	opAreaTrab <- jsonlite::fromJSON( './data/opAreaTrabalhos.json' )
	
	opResultAvalResumo <- jsonlite::fromJSON( './data/opResultAvalResumo.json' )
	
	opRequisicaoAvalResumo <- jsonlite::fromJSON( './data/opRequisicaoAvalResumo.json' )
	
	prazos <- jsonlite::fromJSON( './data/prazos.json' )
	# datas de inicio e fim (prazo) para Inscrição
    dataIniInsc <- as.Date( prazos$dataIniInsc )# YYYY-MM-DD
    dataFimInsc <- as.Date( prazos$dataFimInsc )# YYYY-MM-DD
    
    # Tamanho de Arquivo
    tamanhoArquivoPermitido <- jsonlite::fromJSON( './data/tamanhoArquivoPermitido.json' ) *1024^2
    attributes( tamanhoArquivoPermitido[[1]] ) <- list("class"="object_size")
	
	paginaPropriedade <- jsonlite::fromJSON( './data/paginaPropriedade.json' ) 

