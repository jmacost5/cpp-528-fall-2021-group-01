#### Raw Files

All of the raw data files will go in the raw folder. By “raw” we mean the data as it arrived from whatever site we retrieved it from, or the file exactly how it was exported from a custom data collection tool like an online survey program.

Anything that documents the data collection process lives here. This folder also contain scripts used to download data from APIs or scripts that scrape data from websites. Also include any documentation of source data files like data dictionaries or guides to use.

If you are using data from third-party sources make sure you document retrieval dates, URLs, and to the extent possible any parameters that were used when downloading the data. Scripts are preferable because the arguments are then documented and the behavior can be replicated. If you have to manually enter a bunch of parameters in a data download GUI on the website then if there are questions about the raw data it is never possible to fully replicate the process. It will be unclear whether the provide updated the database and the data files changed, or whether the user incorrectly entered some parameters.

Common errors at the download step include things like making an error on a Census variable name (easy to do since the raw names are things like *B19013*). Or alternatively, incorrectly applying a filter like geography or time-period during a download.

Depending on how many unique data sources you use, you may want to include subdirectories for each unique source.

Data Files is used in this Project can be found below links to be downloaded and exctracted :

[Harmonized Census Data Part-01](https://watts-college.github.io/cpp-528-fall-2021/data/LTDB_Std_All_Sample.zip)

[Harmonized Census Data Part-02](https://watts-college.github.io/cpp-528-fall-2021/data/LTDB_Std_All_fullcount.zip)

[Codebook](https://watts-college.github.io/cpp-528-fall-2021/data/LTDB-codebook.pdf)

**If you see the following, you know the raw data is in the correct format:**

- No program was used to analyze the data.

- None of the data values were changed.

- There was no data removed from the data set.

- You made no attempt to summarize the data.

If you changed the raw data in any way, it is no longer in its original state. Reporting changed data as raw data is a popular strategy to slow down the analysis process.
