class PivotalTracker
  include HTTParty
  base_uri 'https://www.pivotaltracker.com/services/v5'

  TOKEN = 'c6b398870916737042d7a8691dee2349'

  def initialize
  end

  def get_story(project_id, story_id)
    response = self.class.get("/projects/#{project_id}/stories/#{story_id}",
      headers: { 'X-TrackerToken' => TOKEN }
    )
    JSON[response.body]
  end

  def get_tasks(project_id, story_id)
    response = self.class.get("/projects/#{project_id}/stories/#{story_id}/tasks",
      headers: { 'X-TrackerToken' => TOKEN }
    )
    JSON[response.body]
  end

  def update_task(project_id, story_id, task_id, description, options = {})
    response = self.class.put("/projects/#{project_id}/stories/#{story_id}/tasks/#{task_id}",
      headers: { 'X-TrackerToken' => TOKEN, "Content-Type" => "application/json" },
      query: {
        description: description
      }.merge(options)
    )
    JSON[response.body]
  end

  def create_story(project_id, name, options = {})
    response = self.class.post("/projects/#{project_id}/stories",
      headers: { 'X-TrackerToken' => TOKEN, "Content-Type" => "application/json" },
      query: {
        name: name
      }.merge(options)
    )
    JSON[response.body]
  end
end
