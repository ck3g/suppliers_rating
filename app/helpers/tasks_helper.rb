module TasksHelper
  def task_supplier_and_service(task)
    "#{task.supplier_name} [#{task.service_name}]"
  end

  def task_full_title(task)
    [task.title, task.supplier_name, task.service_name, number_to_currency(task.cost, unit: t(:lei))].compact.join(" | ")
  end
end
