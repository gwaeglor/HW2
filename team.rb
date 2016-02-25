require_relative "developer"
require_relative "junior_developer"
require_relative "senior_developer"

class Team

  STAFF = {:senior => SeniorDeveloper,
           :developer => Developer,
           :junior => JuniorDeveloper}

  def initialize(&block)
    @team = []
    @notification = {}
    instance_eval &block
  end


  def  have_seniors(*names)
    send('have_staff', :senior, *names)
  end

  def  have_developers(*names)
    send('have_staff', :developer, *names)
  end

  def  have_juniors(*names)
    send('have_staff', :junior, *names)
  end

  def  priority(*priorities)
    @priority = priorities
  end

  def on_task(staff_level, &block)
    @notification[staff_level] = block  if block_given?
  end

  def add_task(task)
    begin
      staff_by_tasks = sort_by_tasks(sort_by_priority)
      available_staff = staff_by_tasks.select{|person| person.can_add_task?}
      raise ArgumentError if available_staff.empty?
    rescue ArgumentError
      'Все заняты!'
    else
      assignee = available_staff.first
      assignee.add_task(task)
      callback = @notification[assignee.group.to_s.chop.to_sym]
      callback.call(assignee, task)  if callback
    end
  end

  def seniors
    @team.select {|person| person.group['seniors']}
  end

  def developers
    @team.select {|person| person.group['developers']}
  end

  def juniors
    @team.select {|person| person.group['juniors']}
  end

  def all
    @team
  end

  def report
    sort_by_priority.map do|person|
      name = person.name
      group = person.group.to_s.chop
      tasks = person.task_list.join(", ")
      %Q{#{name} (#{group}): #{tasks} }
    end

  end

  private
  def have_staff(group, *names)
    @team += names.map {|name| STAFF[group].new(name)}
  end

  def sort_by_priority
    @priority.map.with_object([]) {|p, arr|  arr << send(p)}.flatten
  end

  def sort_by_tasks(staff)
    staff.sort{|a,b| b.task_list.count <=> a.task_list.count  }
  end
end
