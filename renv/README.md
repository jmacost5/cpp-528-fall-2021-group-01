**"renv" is an R dependency manager. Use renv to make your projects more:**

- Isolated: Each project gets its own library of R packages, so you can feel free to upgrade and change package versions in one project without worrying about breaking your other projects.

- Portable: Because renv captures the state of your R packages within a lockfile, you can more easily share and collaborate on projects with others, and ensure that everyone is working from a common base.

- Reproducible: Use renv::snapshot() to save the state of your R library to the lockfile renv.lock. You can later use renv::restore() to restore your R library exactly as specified in the lockfile.

**The core essence of the renv workflow is fairly simple:**

- 1- Use renv::init() to initialize a project. renv will discover the R packages used in your project, and install those packages into a private project library.

Work in your project as usual, installing and upgrading R packages as required as your project evolves.

- 2- Use renv::snapshot() to save the state of your project library. The project state will be serialized into a file called renv.lock.

- 3- Use renv::restore() to restore your project library from the state of your previously-created lockfile renv.lock.

In short: use renv::init() to initialize your project library, and use renv::snapshot() / renv::restore() to save and load the state of your library.

After your project has been initialized, you can work within the project as before, but without fear that installing or upgrading packages could affect other projects on your system.
