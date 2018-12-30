# Sets the main folder
mainDir <- "C:\Users\zachk\Dropbox\PSCI338"

# Folder to save both the .Rmd and .hmtl files we create
dir.create(file.path(mainDir, "Code")) 
# Folder to save our data files
dir.create(file.path(mainDir, "Data")) 
# Folder to save graphs that we export
dir.create(file.path(mainDir, "Graph")) 
# Folder to save tables that we export
dir.create(file.path(mainDir, "Table")) 

# Sets the data folder
dataDir <- paste(mainDir, "/Data", sep = "")

# Subfolder to save our raw data files
dir.create(file.path(dataDir, "Raw")) 
# Subfolder to save our manipulated data files
dir.create(file.path(dataDir, "Processed")) 
