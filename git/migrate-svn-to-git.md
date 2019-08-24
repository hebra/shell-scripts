# Migrating a Subversion repository to GIT

This document describes an easy way to migrate a whole Subversion repository to GIT and also keeping all history, authors, tags and branches.

## Keeping code committers data

To keep and map all code committers for the entire history of a subversion repository we first need to extract all authors from the SVN history.

Hint: the URL to be used is the SVN repository project root folder. Usually the one which contains the folders `trunk`, `branches` and `tags`

```
svn log <https://example.com/svn-root/> --xml --quiet | grep author | sort -u | perl -pe 's/._>(._?)<.*/$1 = /' > committers.txt
```

- edit the file committers.txt and populate each line entering the related committer information like this:

  ```
  eexample = Eddy Example [eddy@example.com](mailto:eddy@example.com)
  ```

- use git svn to checkout and migrate the SVN repo

  git svn clone <https://my-project.googlecode.com/svn/> --authors-file=users.txt --no-metadata --no-minimize --prefix "" -s my_project

- migrate tag references to local repo

  for t in $(git for-each-ref --format='%(refname:short)' refs/remotes/tags); do git tag ${t/tags\//} $t && git branch -D -r $t; done

- migrate branch references to local repo

  for b in $(git for-each-ref --format='%(refname:short)' refs/remotes); do git branch $b refs/remotes/$b && git branch -D -r $b; done

- remove SVN-specific peg-revision as they are not required

  for p in $(git for-each-ref --format='%(refname:short)' | grep @); do git branch -D $p; done

- now all SVN branches are real GIT branches

- cleanup

- remove the dummy trunk branch as GIT uses master as default

  git branch -d trunk

- add new remote origin server

  git remote add origin git@my-git-server:myrepository.git

- push all branches and tags to the remote server

  git push origin --all git push origin --tags
