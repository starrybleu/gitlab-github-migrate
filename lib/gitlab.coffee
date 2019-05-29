require('dotenv').load()
request = require 'request-promise'
requestJSON = request.defaults(json: true)
process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0"

GitLab = module.exports =
  get: (path) ->
    { GITLAB_URL, GITLAB_TOKEN } = process.env
    url = "#{GITLAB_URL}/api/v4/#{path}?private_token=#{GITLAB_TOKEN}&per_page=1000&state=opened"
    requestJSON.get url

  getIssues: (projectId) ->
    GitLab.get "projects/#{projectId}/issues"

  getComments: (projectId, issueId) ->
    GitLab.get "projects/#{projectId}/issues/#{issueId}/notes"

  getMilestones: (projectId) ->
    GitLab.get "projects/#{projectId}/milestones"
