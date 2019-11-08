module Asaner
  class Client
    ENDPOINT    = 'https://app.asana.com/'
    API_VERSION = '1.0'

    def initialize(access_token)
      @client = Faraday.new(url: "#{ENDPOINT}") do |faraday|
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
        faraday.authorization :Bearer,access_token
      end
    end

    def me
      response = @client.get do |request|
        request.url "api/#{API_VERSION}/users/me"
      end
      parse(response)
    end

    def workspaces(option_fields=[])
      response = @client.get do |request|
        request.url "api/#{API_VERSION}/workspaces"
        request.params['opt_fields'] = option_fields.join(',')
      end
      parse(response)
    end

    def workspace(workspace_id)
      response = @client.get do |request|
        request.url "api/#{API_VERSION}/workspaces/#{workspace_id}"
      end
      parse(response)
    end

    def projects_from_workspace(workspace_id, option_fields=[])
      response = @client.get do |request|
        request.url "api/#{API_VERSION}/projects"
        request.params['workspace'] = workspace_id
        request.params['opt_fields'] = option_fields.join(',')
      end
      parse(response)
    end

    def project(project_id)
      response = @client.get do |request|
        request.url "api/#{API_VERSION}/projects/#{project_id}"
      end
      parse(response)
    end

    def project_status(project_status_id)
      response = @client.get do |request|
        request.url "api/#{API_VERSION}//project_statuses/#{project_status_id}"
      end
      parse(response)
    end

    def project_statuses_from_project(project_id, option_fields=[])
      response = @client.get do |request|
        request.url "api/#{API_VERSION}/projects/#{project_id}/project_statuses"
        request.params['opt_fields'] = option_fields.join(',')
      end
      parse(response)
    end

    def sections_from_project(project_id, option_fields=[])
      response = @client.get do |request|
        request.url "api/#{API_VERSION}/projects/#{project_id}/sections"
        request.params['opt_fields'] = option_fields.join(',')
      end
      parse(response)
    end

    def section(section_id)
      response = @client.get do |request|
        request.url "api/#{API_VERSION}/sections/#{section_id}"
      end
      parse(response)
    end

    def tasks_from_section(section_id, option_fields=[])
      response = @client.get do |request|
        request.url "api/#{API_VERSION}/sections/#{section_id}/tasks"
        request.params['opt_fields'] = option_fields.join(',')
      end
      parse(response)
    end

    def task(task_id, option_fields=[])
      response = @client.get do |request|
        request.url "api/#{API_VERSION}/tasks/#{task_id}"
      end
      parse(response)
    end

    def subtasks_from_task(task_id, option_fields=[])
      response = @client.get do |request|
        request.url "api/#{API_VERSION}/tasks/#{task_id}/subtasks"
      end
      parse(response)
    end

    def stories_from_task(task_id)
      response = @client.get do |request|
        request.url "api/#{API_VERSION}/tasks/#{task_id}/stories"
      end
      parse(response)
    end

    private

    def parse(response)
      {
        status: response.status,
        headers: response.headers,
        reason_phrase: response.reason_phrase,
        body: JSON.parse(response.body),
      }
    end
  end
end
