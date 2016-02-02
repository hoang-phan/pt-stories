class SubStoriesController < ApplicationController
  def create
    tasks = tracker.get_tasks(project_id, parent_id)
    tasks.each do |task|
      description = task['description']
      story = tracker.create_story(project_id, description, description: child_description)
      tracker.update_task(project_id, parent_id, task['id'], "#{description} - #{story['url']}")
    end
    render json: { success: true }
  end

  private

  def parent
    @parent ||= tracker.get_story(project_id, parent_id)
  end

  def project_id
    @project_id ||= params[:project_id]
  end

  def parent_id
    @parent_id ||= params[:parent][1..-1]
  end

  def child_description
    @child_description ||= "Parent story: #{parent['url']}"
  end

  def tracker
    @tracker ||= PivotalTracker.new
  end
end
