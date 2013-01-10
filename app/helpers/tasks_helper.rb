module TasksHelper
  def task_supplier_and_service(task)
    "#{task.supplier_name} [#{task.service_name}]"
  end

  def task_full_title(task)
    [task.title, task.supplier_name_with_rating, task.service_name, number_to_currency(task.cost)].compact.join(" | ")
  end

  def task_paid_text(task)
    I18n.t("task_paid.#{task.paid? ? "yes" : "no"}")
  end
end
