ui <- function( req ){

	add_cookie_handlers(

    fluidPage( title = "aconfrs - Sistema de Gerenciamento de Conferência Acadêmica",
               theme = bslib::bs_theme( version = 3 ),
               lang = 'pt-BR',
        ########################
        
        useShinyjs(),
        
        useSever(),
        
        shinybrowser::detect(),
        
        # Definições
        tags$head( 
        
            # Tentativa do Browser não criar cache
            tags$meta( "http-equiv"="Cache-Control", "content"="no-cache, no-store, must-revalidade" ),
            tags$meta( "http-equiv"="Cache-Control", "content"="max-age=0" ),
            tags$meta( "http-equiv"="Pragma", "content"="no-cache" ),
            tags$meta( "http-equiv"="Expires", "content"="0" ),
            tags$meta( "http-equiv"="Expires", "content"="Sun, 02 Jul 2023 1:00:00 GMT" ),
    
            # Tags informativas
            tags$meta( "name"="author", "content"="Cleber Nogueira Borges" ),
            tags$meta( "name"="application-name", "content"="aconfrs" ),
            tags$meta( "name"="description", "content"="Gerenciamento de Congresso Científico feito em R/Shiny" ),
            tags$meta( "name"="keywords", "content"="R Package, Shiny App, Cientific Conference" ),
            tags$meta( "name"="robots", "content"="noindex, nofollow, noarchive" ),
            
            #tags$style( headerSUS ), #headerSUS está definido em "global.R"
            
            tags$link( rel="icon", href="www/aconfrs-logo.svg" ),
            
            tags$link( id="theme", rel="stylesheet", href="css/bootstrap.min.css" )
        
        ),
        
        ##################
        #mythemeSelector(),
        ##################
    
        fluidPage( column( width = 8, offset=2,
        
            HTML("<p style='font-family: Segoe UI'>aconfrs - Sistema de Gerenciamento de Conferência Acadêmica</p>"),
            
            wellPanel(
            
                tags$img( src = "www/aconfrs-logo.svg", heigth="150" ),
                
                br(),br(),

				column( width = 2, style="text-align:left; padding:0px;",

                    dropMenu(
                    
                        actionButton( "butMudarTarefa", "Função", icon( name="cog", lib="glyphicon" ), width='100%' ),
                        
                        br(),
                        
                        tags$div( id='panelTarefas', class='well',
                        
                            HTML( "<p class='text-primary'>Interfaces das Funcionalidades:</p>" ),
                            
                            actionButton("ToggleUIAdmin", "UI-Administrador",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", , width='250px' ),
                            
                            br(),br(),
                            
                            actionButton("ToggleUIAvaliador", "UI-Avaliador",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", width='250px' ),

                            br(),br(),
                            
                            actionButton("ToggleUIParticipante", "UI-Participante",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", width='250px' ),
                            
                            br(),br(),
                            
                            actionButton("ToggleUIAtribuidor", "UI-Atribuidor",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", , width='250px' ),
                            
                            br(),br(),
                            
                            actionButton("ToggleUICadastroAval", "UI-Cadastramento",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", , width='250px' ),
                            
                            br(),br(),
                            
                            actionButton("ToggleUIFinanca", "UI-Financeiro",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", , width='250px' ),
                    
                            br(),br(),
                            
                            actionButton("ToggleUISubevento", "UI-Subevento",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", , width='250px' ),
                            
                            br(),br(),
                            
                            actionButton("ToggleUIComunica", "UI-Comunicação",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", , width='250px' )
        
                        )#<- fecha tags$div

                    )#<- fecha dropMenu
                    
                ),#<- fecha column
				
				column( width = 2, style="text-align:left; padding:0px;",
    
                    actionButton( "butFAQ", "FAQ", icon( name="question-sign", lib="glyphicon" ), width='100%' )

                ),

				column( width = 2, style="text-align:left; padding:0px;",
    
                    actionButton( "butSobre", "Sobre", icon( name="info-sign", lib="glyphicon" ), width='100%' )

                ),
                
                column( width = 2, style="text-align:left; padding:0px;",
                
                    dropMenu( maxWidth="375px",
                
                        actionButton( "butTema", "Tema", icon( name="user", lib="glyphicon" ), width='100%' ),
                    
                        br(),
                    
                        tags$div( id='panelTemas', class='well', style="text-align:left;",
                        
                            HTML( "<p class='text-primary'>Mudar Estilo (Tema) da Página para:</p>" ),

                            actionButton("butTemaDefault", "Bootstrap",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", width='150px' ),                            
                            
                            actionButton("butTemaCerulean", "Cerulean",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", width='150px' ),
                            
                            br(),br(),
                            
                            actionButton("butTemaCosmo", "Cosmo",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", width='150px' ),

                            actionButton("butTemaCyborg", "Cyborg",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", width='150px' ),
                            
                            br(),br(),
                            
                            actionButton("butTemaDarkly", "Darkly",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", width='150px' ),
                            
                            actionButton("butTemaFlatly", "Flatly",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", width='150px' ),
                            
                            br(),br(),
                            
                            actionButton("butTemaJournal", "Journal",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", width='150px' ),
                            
                            actionButton("butTemaLumen", "Lumen",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", width='150px' ),
                        
                            br(),br(),
                            
                            actionButton("butTemaPaper", "Paper",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", width='150px' ),
                            
                            actionButton("butTemaReadable", "Readable",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", width='150px' ),

                            br(),br(),

                            actionButton("butTemaSandstone", "Sandstone",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", width='150px' ),
                            
                            actionButton("butTemaSimplex", "Simplex",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", width='150px' ),

                            br(),br(),
                            
                            actionButton("butTemaSlate", "Slate",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", width='150px' ),
                            
                            actionButton("butTemaSpacelab", "Spacelab",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", width='150px' ),

                            br(),br(),
                            
                            actionButton("butTemaSuperhero", "Superhero",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", width='150px' ),
                            
                            actionButton("butTemaUnited", "United",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", width='150px' ),

                            br(),br(),
                            
                            actionButton("butTemaYeti", "Yeti",  icon( name="refresh", lib="glyphicon" ), class="btn btn-primary", width='150px' ),
                            
                            tags$hr( height="1px", width="304px", align="center" ),
                            
                            htmlOutput( "labTemaEscolhido" )
                        
                        )#<- fecha tags$div
                        
                    )#<- fecha dropMenu

                ),#<- fecha column
				
				column( width = 2, style="text-align:left; padding:0px;",
    
                    actionButton( "butConferencia", "Conferência", icon( name="star", lib="glyphicon" ), width='100%' )

                ),

				column( width = 2, style="text-align:left; padding:0px;",
    
                    actionButton( "desconectSeg", "Desconectar", icon( name="remove-sign", lib="glyphicon" ), width='100%' )

                ),

                br()
                
            ),#<- fecha wellPanel
            
            # Cria uma linha tracejada
            tags$hr( size="1", style="border:1px dashed gray;", width="25%", align="center" )
        
        )),#<- fecha fluidPage e column
        
        #################################################################
        #                                                               #
        #    Cria o Ponto de Inserção das Diferentes Interfaces do APP  #
        #                                                               #
        #################################################################
        
        div( id="uiRequisitada", style="display: none;" ),
        
        div( id="uiSobre", style="display: none;" ),
		
        div( id="uiFAQ", style="display: none;" ),
        
        div( id="uiConferencia", style="display: none;" )
        
    )#<- fecha fluidPage
	
	)#<- fecha add_cookie_handlers
    
}
