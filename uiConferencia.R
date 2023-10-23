
    ########################################################
    div( id="interfaceConferencia", style="display: none;",
    ########################################################
    fluidPage( column( width = 8, offset = 2,
    
        div( id="panelConferencia",
    
            #####################################################################
            #                                                                   #
            #                                                                   #
            #####################################################################
		
			# https://community.rstudio.com/t/bookdown-inside-shiny-app/80958/2
			shiny::tags$iframe(
			
				frameborder="0",
				
				style="width: 100%; height: 100%dvh;", # height: 100vmax;", overflow: hidden;",
				
				src ="book/index.html",
            
				onload="this.style.height=(this.contentWindow.document.body.scrollHeight+20)+'px';"
				
			)
            
			
        )
        
    ))#<- fecha fluidPage
    
    )#<- fecha div id="interfaceConferencia"

