* Define the main working directory
global root  = "C:\Users\d57917il\Documents\GitHub\social_stigma" // Please specify the working directory using the folder that was created in your computer. 
cd "$root"

* Run the do files

do "data_cleaning.do"	
cd "$root"

do "margins.do"	
cd "$root"


