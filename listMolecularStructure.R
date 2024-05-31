#Ensure R file and Excel file are in same folder 
#Session > Set Working Directory > Choose file Location 

library(roperators) #Import all libraries needed 
library(readxl) 
library(writexl)


data <- read_excel("input.xlsx") #Get excel file 

list1 <- list()

for (v in data) {
  
  for (s in v) {
    
    list1 <- append(list1, s) #Get data from excel file and append it to list1 
    
  }
  
} 



reactions = list() #List of Reactions possible  

for (x in list1) {
  
  for (y in list1) {
    
    for (z in list1) {
      
      appendToInitialReaction <- list() #Possible reaction combination list 
      
      appendToInitialReaction <- append(appendToInitialReaction, x) 
      appendToInitialReaction <- append(appendToInitialReaction, y) 
      appendToInitialReaction <- append(appendToInitialReaction, z) 
      
      reactions <- append(reactions, list(appendToInitialReaction)) #Append reaction combination to reactions 
      
      
    }
    
  }
  
} 



for (u in reactions) {                  
  
  for (x in reactions) {
    
    if (identical(sort(unlist(u)), sort(unlist(x))) == TRUE) { #Check if u and x are the same, generally (where u and x are items in the list reactions)
      
      if (identical(u, x) == FALSE) { #Check if they are the exact same, 
        
        reactions[match(list(u), reactions)] <- NULL #If identical elements found in list, remove 1 of them 
        
      }
    }
    
  }
  
} 



sameInall <- "O=P" #String present in all SMILES 

listOfSMILESMolecules <- c() #List containing all SMILES 

for (p in reactions) { 
 
  newMolecule <- paste(sameInall, p[1], p[2], p[3], sep = "") #Get all the components of the molecule, combine to create SMILES 
 
  if (newMolecule %ni% listOfSMILESMolecules) {
 
    listOfSMILESMolecules <- append(listOfSMILESMolecules, newMolecule) #If the SMILE is not already in the list (listOfSMILESMolecules), add it to the list 
  
   }
 }


data2 <- data.frame(Results = c(listOfSMILESMolecules)) 

write_xlsx(data2, "output.xlsx") #Using the list, (listOfSMILESMolecules), put everything into output excel file 
