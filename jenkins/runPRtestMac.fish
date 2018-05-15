#!/usr/bin/env fish
source jenkins/helper.jenkins.fish ; prepareOskar

lockDirectory ; updateOskar ; clearResults

eval $EDITION ; eval $STORAGE_ENGINE ; eval $TEST_SUITE
parallelism 24

switchBranches $ARANGODB_BRANCH $ENTERPRISE_BRANCH
and oskar1

set -l s $status
cd "$HOME/$NODE_NAME/oskar" ; moveResultsToWorkspace ; unlockDirectory 
exit $s

