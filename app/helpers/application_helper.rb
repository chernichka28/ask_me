module ApplicationHelper
  def inclination(count, form1, form2, form3)
    return form3 if (count % 100).between?(11, 14)

    case count % 10
    when 1 then form1
    when 2..4 then form2
    else
      form3
    end
  end
end
