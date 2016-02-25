require_relative 'developer'
class SeniorDeveloper < Developer
  MAX_TASKS = 15
  GROUP = :seniors

  def work!
    begin
      raise ArgumentError if @task_list.empty?
    rescue ArgumentError
      'Нечего делать!'
    else
      [0, 2].sample == 2 ? ([super, super]) : ('Что-то лень')
    end
  end
end
