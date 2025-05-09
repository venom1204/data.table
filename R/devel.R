# nocov start

dcf.lib = function(pkg, field, lib.loc=NULL){
  # get DESCRIPTION metadata field from local library
  stopifnot(is.character(pkg), is.character(field), length(pkg)==1L, length(field)==1L)
  dcf = system.file("DESCRIPTION", package=pkg, lib.loc=lib.loc, mustWork=TRUE)
  if (nzchar(dcf)) read.dcf(dcf, fields=field)[1L] else NA_character_
}

dcf.repo = function(pkg, repo, field, type) {
  # get DESCRIPTION metadata field from remote PACKAGES file
  stopifnot(is.character(pkg), is.character(field), length(pkg)==1L, length(field)==1L, is.character(repo), length(repo)==1L, field!="Package")
  idx = file(file.path(contrib.url(repo, type=type),"PACKAGES"))
  on.exit(close(idx))
  dcf = read.dcf(idx, fields=c("Package",field))
  if (!pkg %in% dcf[,"Package"]) stopf("There is no package %s in provided repository.", pkg)
  dcf[dcf[,"Package"]==pkg, field][[1L]]
}

update_dev_pkg = function(pkg="data.table", repo="https://Rdatatable.gitlab.io/data.table", field="Revision", type=getOption("pkgType"), lib=NULL, ...) {
  # this works for any package, not just data.table
  # perform package upgrade when new Revision present
  stopifnot(is.character(pkg), length(pkg)==1L, !is.na(pkg),
            is.character(repo), length(repo)==1L, !is.na(repo),
            is.character(field), length(field)==1L, !is.na(field),
            is.null(lib) || (is.character(lib) && length(lib)==1L && !is.na(lib)))
  # get Revision field from remote repository PACKAGES file
  una = is.na(ups<-dcf.repo(pkg, repo, field, type))
  if (una)
    catf("No revision information found in DESCRIPTION file for %s package. Make sure that '%s' is correct field in PACKAGES file in your package repository '%s'. Otherwise package will be re-installed every time, proceeding to installation.\n",
         pkg, field, contrib.url(repo, type=type))
  # see if Revision is different then currently installed Revision, note that installed package will have Revision info only when it was installed from remote devel repo
  upg = una || !identical(ups, dcf.lib(pkg, field, lib.loc=lib))
  # update_dev_pkg fails on windows R 4.0.0, we have to unload package namespace before installing new version #4403
  on.exit({
    if (upg) {
      unloadNamespace(pkg) ## hopefully will release dll lock on Windows
      utils::install.packages(pkg, repos=repo, type=type, lib=lib, ...)
      msg_fmt = gettext("R %s package has been updated to %s (%s)\n")
    } else {
      msg_fmt = gettext("R %s package is up-to-date at %s (%s)\n")
    }
    field_val = unname(read.dcf(system.file("DESCRIPTION", package=pkg, lib.loc=lib, mustWork=TRUE), fields=field)[, field])
    cat(sprintf(msg_fmt, pkg, field_val, utils::packageVersion(pkg, lib.loc=lib)))
  })
  invisible(upg)
}

# non-exported utility when using devel version #3272: data.table:::.git()
.git = function(quiet=FALSE, lib.loc=NULL) {
  ans = unname(read.dcf(system.file("DESCRIPTION", package="data.table", lib.loc=lib.loc, mustWork=TRUE), fields="Revision")[, "Revision"])
  if (!quiet && is.na(ans))
    catf("Git revision is not available. Most likely data.table was installed from CRAN or local archive.\nGit revision is available when installing from our repositories 'https://Rdatatable.gitlab.io/data.table' and 'https://Rdatatable.github.io/data.table'.\n")
  ans
}

# nocov end
