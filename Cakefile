Git = require './lib/git'
GitLab = require './lib/gitlab'
GitHub = require './lib/github'

option '-i', '--gitlab_id [ID]', 'GitLab project id'
option '-l', '--gitlab_name [NAME]', 'GitLab repo name'
option '-h', '--github_name [NAME]', 'GitHub repo name'

task 'migrate:repo', 'migrate repository', (options) ->
  Git.migrateRepo(options)

task 'migrate:wiki', 'migrate wiki', (options) ->
  Git.migrateWiki(options)

task 'migrate:issues', 'migrate issues', (options) ->
  { gitlab_id, github_name } = options
  GitLab.getIssues(gitlab_id)
    .then (issues) ->
      console.debug('issues : ', issues)
      for issue in issues
        do (issue) ->
          console.debug('current issue.iid : ', issue.iid)
          GitLab.getComments(gitlab_id, issue.iid)
            .then (comments) ->
              console.debug('fetched comments : ', comments)
              GitHub.createIssue(github_name, issue, comments)
            .catch (error) ->
              console.error(error)

task 'migrate:milestones', 'migrate milestones', (options) ->
  { gitlab_id, github_name } = options
  GitHub.deleteMilestones(github_name)
  GitLab.getMilestones(gitlab_id)
    .then (milestones) ->
      for milestone in milestones
        do (milestone) ->
          GitHub.createMilestone(github_name, milestone)
