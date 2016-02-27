require_relative 'developer'
require_relative 'junior_developer'
require_relative 'senior_developer'

class Team
  STAFF = { senior: SeniorDeveloper,
            developer: Developer,
            junior: JuniorDeveloper }

  def initialize(&block)
    @team = []
    @notification = {}
    instance_eval &block
  end

  def have_seniors(*names)
    send('have_staff', :senior, *names)
  end

  def have_developers(*names)
    send('have_staff', :developer, *names)
  end

  def have_juniors(*names)
    send('have_staff', :junior, *names)
  end

  def priority(*priorities)
    @priority = priorities
  end

  def on_task(staff_level, &block)
    @notification[staff_level] = block if block_given?
  end

  def add_task(task)
    available_staff = @team.select(&:can_add_task?)
    begin
      fail ArgumentError if available_staff.empty?
    rescue ArgumentError
      puts 'Все заняты!'
    else
      available_staff.sort_by! { |person| [person.task_list.count, @priority.index(person.group)] }
      assignee = available_staff.first
      assignee.add_task(task)
      callback = @notification[assignee.group.to_s.chop.to_sym]
      callback.call(assignee, task) if callback
    end
  end

  def seniors
    @team.select { |person| person.group['seniors'] }
  end

  def developers
    @team.select { |person| person.group['developers'] }
  end

  def juniors
    @team.select { |person| person.group['juniors'] }
  end

  def all
    @team
  end

  def report
    @team.sort_by { |person| [person.task_list.count, @priority.index(person.group)] }.map do|person|
      name = person.name
      group = person.group.to_s.chop
      tasks = person.task_list.join(', ')
      %{#{name} (#{group}): #{tasks} }
    end
  end

  private

  def have_staff(group, *names)
    @team += names.map { |name| STAFF[group].new(name) }
  end
end
