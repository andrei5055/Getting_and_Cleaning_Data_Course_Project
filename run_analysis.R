
# Function for loading of the data table 
loadDataTable <- function(fnTemplate, setID, colLabels)
{
    # Replace "setID" in the fileName by current value of setID and read table
    table <- read.table(gsub("setID", setID, fnTemplate))
    
    # Assign the column names
    names(table) <- colLabels
    table
}


# Function for loading the data set
loadDataSet <- function(setID)
{
    # Read person's IDs
    Person_IDs <- loadDataTable("setID/subject_setID.txt", setID, Person_ID_label)
    
    # Read activity IDs
    y <- loadDataTable("setID/y_setID.txt", setID, Activity_ID_label)
    
    # Load activity labels 
    y[,1] = activity_labels[y[,1]]

    # Load the measurements for extracted features
    X <- loadDataTable("setID/X_setID.txt", setID, features)[, extracted_features]

    # Bind by columns and return data
    cbind(Person_IDs, y, X)
}


# Main program

# Load libraries (install package, if they are not installed)
for(libName in c("data.table", "reshape2")) {
    i <- 0;
    while (!require(libName, character.only = TRUE) && (i <- i + 1) <= 1)
        install.packages(libName)
}


DataSet <- "UCI HAR Dataset"
if (!file.exists(DataSet)) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    temp <- tempfile()
    download.file(fileUrl, temp)
    unzip(temp)
    unlink(temp)
}

# Going to dataset directory
setwd(DataSet)

# Loading of the list of features
features <- read.table("features.txt")[,2]

# Extraction of the flags for the mean and standard deviation for each measurement
extracted_features <- grepl("mean\\(|std\\(", features, ignore.case=TRUE)

# Remove "()" from the column names
features <- gsub("\\(\\)", "", features)

# Loading of the list of activities in lower case characters
activity_labels <- tolower(read.table("activity_labels.txt")[,2])

# Labels for 2 first columns of the tidy data table
Person_ID_label   <- "Person_ID"
Activity_ID_label <- "Activity_Name"

# Loading of the test and train data sets  
test_data  <- loadDataSet("test")
train_data <- loadDataSet("train")

# Going back to working directory
setwd("..")

# Merging of the test and train data
tidy_data <- rbind(test_data, train_data)

# Constract melting data
id_labels <- c(Person_ID_label, Activity_ID_label)
melt_data <- melt(tidy_data, id = id_labels, measure.vars = setdiff(names(tidy_data), id_labels))

# Calculate the average of each variable for each activity for each person
tidy_data_mean <- dcast(melt_data, Person_ID + Activity_Name ~ variable, mean)

write.table(tidy_data_mean, file = "tidy_data_mean.txt", row.names = FALSE, quote = FALSE)
