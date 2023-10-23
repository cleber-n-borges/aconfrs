
source( "global.R", local=TRUE, encoding = "UTF-8" )
source( "server.R", local=TRUE, encoding = "UTF-8" )
source( "ui.R",     local=TRUE, encoding = "UTF-8" )
#shinyOptions( shiny.port=1234 )
#app <- shinyApp( ui, server, options=list( host="0.0.0.0", port=1234, launch.browser=TRUE ) )
app <- shinyApp( ui, server, options=list( host="0.0.0.0", port=12 ) )
runApp( app )

